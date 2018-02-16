package com.ftninformatika.bisis.postaimport;

import com.gint.app.bisis4.records.*;
import com.gint.app.bisis4.records.serializers.FullFormatSerializer;
import org.apache.commons.cli.*;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Row;

import java.io.*;
import java.util.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class ImportApp {

  public static void main(String[] args) throws Exception {
    setupPatterns();
    Options options = new Options();
    options.addOption("i", true, "Ulazni fajl");
    options.addOption("o", true, "Izlazni fajl");
    options.addOption("p", true, "Preview fajl");
    CommandLineParser parser = new DefaultParser();
    CommandLine cmdLine = parser.parse(options, args);
    if (!(cmdLine.hasOption("i") && cmdLine.hasOption("o") && cmdLine.hasOption("p"))) {
      HelpFormatter formatter = new HelpFormatter();
      formatter.printHelp("ImportApp", options);
      return;
    }

    String inputFileName = cmdLine.getOptionValue("i");
    String outputFileName = cmdLine.getOptionValue("o");
    String previewFileName = cmdLine.getOptionValue("p");

    BufferedInputStream input = new BufferedInputStream(new FileInputStream(inputFileName));
    HSSFWorkbook workbook = new HSSFWorkbook(input);
    HSSFSheet sheet = workbook.getSheetAt(0);
    int rowCount = 0;

    Iterator<Row> rowIter = sheet.iterator();
    List<Record> originals = new ArrayList<>();
    Map<String, Record> recordMap = new HashMap<>();
    while (rowIter.hasNext()) {
      Row row = rowIter.next();
      if (++rowCount < 5)
        continue;
      String invbr = ConvUtils.getStringValue(row, 0);
      if (invbr.trim().length() == 0)
        break;
      String datum = ConvUtils.getStringValue(row, 1);
      String tekst = ConvUtils.getStringValue(row, 2);
      String povez = ConvUtils.getStringValue(row, 5);
      String dimenzije = ConvUtils.getStringValue(row, 6);
      String obavezni = ConvUtils.getStringValue(row, 7);
      String kupovina = ConvUtils.getStringValue(row, 8);
      String razmena = ConvUtils.getStringValue(row, 9);
      String poklon = ConvUtils.getStringValue(row, 10);
      String cena = ConvUtils.getStringValue(row, 11);
      String signatura = ConvUtils.getStringValue(row, 12);
      String napomena = ConvUtils.getStringValue(row, 13);
      Record rec = makeMonographRecord(invbr, datum, tekst, povez, dimenzije, obavezni, kupovina, razmena, poklon, cena,
          signatura, napomena, rowCount);
      originals.add(rec);
      String key = tekst.trim().toUpperCase().replaceAll("\\s*\\p{Punct}+\\s*$", "") + ":" + dimenzije;
      Record previousRecord = recordMap.get(key);
      if (previousRecord != null) {
        previousRecord.getPrimerci().add(rec.getPrimerci().get(0));
      } else {
        recordMap.put(key, rec);
      }
    }
    input.close();

    Collection<Record> values = recordMap.values();
    List<Record> sortedList = new ArrayList<>();
    sortedList.addAll(values);
    Collections.sort(sortedList, new RecordComparator());

    int RN = 1;
    for (Record record: sortedList) {
      processRecord(record, RN++);
      record.sort();
    }


    PrintWriter output = new PrintWriter(new BufferedWriter(new OutputStreamWriter(new FileOutputStream(outputFileName),
        "UTF8")));
    for (Record record: sortedList) {
      output.println(getSql(record));
    }
    output.close();

    PrintWriter preview = new PrintWriter(new BufferedWriter(new OutputStreamWriter(new FileOutputStream(previewFileName),
        "UTF8")));
    for (Record record: sortedList) {
      preview.println("---- " + record.getRecordID() + " ----");
      preview.println(FullFormatSerializer.toFullFormat(record, false));
    }
    preview.close();

  }

  public static Record makeMonographRecord(String invbr, String datum, String tekst, String povez, String dimenzije,
                                  String obavezni, String kupovina, String razmena, String poklon, String cena,
                                  String signatura, String napomena, int rowCount) {
    Record rec = new Record();
    rec.setRecordID(rowCount-4);
    rec.setCreator(new Author("import", "bibliotekaPTTmuzeja.posta.rs"));
    rec.setModifier(new Author("import", "bibliotekaPTTmuzeja.posta.rs"));
    rec.setCreationDate(new Date());
    rec.setLastModifiedDate(new Date());
    rec.setPubType(1);

    ConvUtils.addSubfield(rec, "001a", "i");
    ConvUtils.addSubfield(rec, "001b", "a");
    ConvUtils.addSubfield(rec, "001c", "m");
    ConvUtils.addSubfield(rec, "001d", "0");

    ConvUtils.addSubfield(rec, "200a", tekst);
    rec.getField("200").setInd1('1');

    ConvUtils.addSubfield(rec, "215d", dimenzije);
    ConvUtils.addSubfield(rec, "675a", signatura);

    rec.sort();
    rec.pack();

    Primerak p = new Primerak();
    p.setInvBroj(ConvUtils.getInvBroj(invbr, rowCount, "0000"));
    p.setPovez(ConvUtils.getPovez(povez));
    p.setNacinNabavke(ConvUtils.getNacinNabavke(obavezni, kupovina, razmena, poklon));
    p.setSigIntOznaka(napomena);
    p.setSigUDK(signatura);
    p.setCena(ConvUtils.getCena(cena));
    p.setPovez(ConvUtils.getPovez(povez));
    p.setDatumInventarisanja(ConvUtils.getDatum(datum));
    rec.getPrimerci().add(p);

    return rec;
  }

  private static void processRecord(Record rec, Integer RN) {
    ConvUtils.addSubfield(rec, "001e", RN.toString());

    String tekst = rec.getSubfieldContent("200a");
    if (tekst == null || tekst.length() == 0)
      return;

    Matcher mCity = pCity.matcher(tekst);
    if (mCity.find())
      ConvUtils.addSubfield(rec, "210a", mCity.group(1));

    Matcher mYear = pYear.matcher(tekst);
    if (mYear.find()) {
      ConvUtils.addSubfield(rec, "100c", mYear.group(1));
      ConvUtils.addSubfield(rec, "210d", mYear.group(1));
    }

    Matcher mPublisher = pPublisher.matcher(tekst);
    if (mPublisher.find())
      ConvUtils.addSubfield(rec, "210c", mPublisher.group(2));
  }

  private static String getSql(Record r) {
    StringBuilder sb = new StringBuilder();
    String rec = RecordFactory.toBISIS35(1, r).replace('\r',' ').replace('\n',' ');
    String sql1 = "SELECT counter_value INTO @recid FROM Counters WHERE counter_name='recordid';\n";
    String sql2 = "UPDATE Counters SET counter_value=counter_value+1 WHERE counter_name='recordid';\n";
    String sql3 = "INSERT INTO Records "
        + "(record_id, pub_type, creator, modifier, date_created, date_modified, archived, in_use_by, content) VALUES "
        + "(@recid+1, 1, '"+r.getCreator().getCompact()+"', NULL, '"+ConvUtils.sqlDateFormat.format(r.getCreationDate())+"', NULL, 0, NULL, " + ConvUtils.sql(rec) + ");\n";
    sb.append(sql1);
    sb.append(sql2);
    sb.append(sql3);
    for (Primerak p: r.getPrimerci()) {
      String sql4 = "SELECT counter_value INTO @primid FROM Counters WHERE counter_name='primerakid';\n";
      String sql5 = "UPDATE Counters SET counter_value=counter_value+1 WHERE counter_name='primerakid';\n";
      String sql5a = "INSERT IGNORE INTO Interna_oznaka (IntOzn_id, IntOzn_opis) VALUES ('" + p.getSigIntOznaka() + "', 'Polica " + p.getSigIntOznaka() + "');\n";
      String sql6 = "INSERT INTO Primerci (" +
          "primerak_id, record_id, sigformat_id, podlokacija_id, " +
          "intozn_id, odeljenje_id, nacin_id, povez_id, status_id, datum_statusa, " +
          "inv_broj, datum_racuna, broj_racuna, dobavljac, cena, " +
          "finansijer, usmeravanje, sig_dublet, sig_numerus_curens, sig_udk, " +
          "datum_inventarisanja, version, napomene, dostupnost_id, stanje, inventator) VALUES (" +
          "@primid+1, " +
          "@recid+1, " +
          ConvUtils.sql(p.getSigFormat()) + ", " +
          ConvUtils.sql(p.getSigPodlokacija()) + ", " +
          ConvUtils.sql(p.getSigIntOznaka()) + ", " +
          ConvUtils.sql(p.getOdeljenje()) + ", " +
          ConvUtils.sql(p.getNacinNabavke()) + ", " +
          ConvUtils.sql(p.getPovez()) + ", " +
          ConvUtils.sql(p.getStatus()) + ", " +
          ConvUtils.sql(p.getDatumStatusa()) + ", " +
          ConvUtils.sql(p.getInvBroj()) + ", " +
          ConvUtils.sql(p.getDatumRacuna()) + ", " +
          ConvUtils.sql(p.getBrojRacuna()) + ", " +
          ConvUtils.sql(p.getDobavljac()) + ", " +
          ConvUtils.sql(p.getCena()) + ", " +
          ConvUtils.sql(p.getFinansijer()) + ", " +
          ConvUtils.sql(p.getUsmeravanje()) + ", " +
          ConvUtils.sql(p.getSigDublet()) + ", " +
          ConvUtils.sql(p.getSigNumerusCurens()) + ", " +
          ConvUtils.sql(p.getSigUDK()) + ", " +
          ConvUtils.sql(p.getDatumInventarisanja()) + ", " +
          p.getVersion() + ", " +
          ConvUtils.sql(p.getNapomene()) + ", " +
          ConvUtils.sql(p.getDostupnost()) + ", " +
          p.getStanje() + ", " +
          ConvUtils.sql(p.getInventator()) + ");\n";
      sb.append(sql4);
      sb.append(sql5);
      sb.append(sql5a);
      sb.append(sql6);
    }
    sb.append("\n");
    return sb.toString();
  }

    private static void setupPatterns() {
      gradovi = "Beograd|Zagreb|Cetinje|Београд|Цетиње|Загреб|Ljubljana|Vukovar|Atina|Атина|Pula|Niš|Ниш";
      gradovi += "|Охрид|Varaždin|Смедерево|Zadar|Vranje|Врање|Osijek|Novo Mesto|Novi Sad|Нови Сад|Sarajevo|Сарајево";
      gradovi += "|Tuzla|Тузла|Sremska Mitrovica|Сремска Митровица|Valjevo|Ваљево|Vršac|Вршац|Split|Vinkovci";
      gradovi += "|Sombor|Сомбор|Pančevo|Панчево|Zemun|Земун|Skoplje|Skopje|Скопље|Скопје|Subotica|Суботица|Rijeka";
      gradovi += "|Rio de Janeiro|Moskva|Москва|Sofia|Софиа|Cambridge|Leskovac|Лесковац|Titograd|Титоград";
      gradovi += "|Berlin|Berne|Bern|London|Londres|Washington|Leipzig|Budapest|Wien|Vienna|Prag|Praze|Praha|Geneve";
      gradovi += "|Paris|Madrid|Bruxelles|Stockholm|Copenhagen|Copenhague|Munchen|Timisoara|Caracas|Jerusalim|Peking";
      gradovi += "|Бањалука|Banjaluka|Kotor|Котор|Čačak|Чачак|Šabac|Шабац|Požarevac|Пожаревац";
      pYear = Pattern.compile(".*(\\d{4}).*");
      pCity = Pattern.compile(".*(" + gradovi + ").*");
      pPublisher = Pattern.compile(".*(?i)(" + gradovi + ")\\p{Punct} (\\p{IsAlphabetic}[\\p{IsAlphabetic}\\p{Digit} ]*).*");
    }

  private static String gradovi;
  private static Pattern pYear;
  private static Pattern pCity;
  private static Pattern pPublisher;
}
