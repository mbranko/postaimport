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

public class SerialApp {
  public static void main(String[] args) throws Exception {
    setupPatterns();
    Options options = new Options();
    options.addOption("i", true, "Ulazni fajl");
    options.addOption("o", true, "Izlazni fajl");
    options.addOption("p", true, "Preview fajl");
    options.addOption("r", true, "Startni RN");
    CommandLineParser parser = new DefaultParser();
    CommandLine cmdLine = parser.parse(options, args);
    if (!(cmdLine.hasOption("i") && cmdLine.hasOption("o") && cmdLine.hasOption("p") && cmdLine.hasOption("r"))) {
      HelpFormatter formatter = new HelpFormatter();
      formatter.printHelp("SerialApp", options);
      return;
    }

    String inputFileName = cmdLine.getOptionValue("i");
    String outputFileName = cmdLine.getOptionValue("o");
    String previewFileName = cmdLine.getOptionValue("p");
    String startniRN = cmdLine.getOptionValue("r");

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
      String godiste = ConvUtils.getStringValue(row, 3);
      String brojSvezaka = ConvUtils.getStringValue(row, 4);
      String dimenzije = ConvUtils.getStringValue(row, 5);
      String povezano = ConvUtils.getStringValue(row, 6);
      String nepovezano = ConvUtils.getStringValue(row, 7);
      String kupovina = ConvUtils.getStringValue(row, 8);
      String razmena = ConvUtils.getStringValue(row, 9);
      String poklon = ConvUtils.getStringValue(row, 10);
      String cena = ConvUtils.getStringValue(row, 11);
      String signatura = ConvUtils.getStringValue(row, 12);
      String napomena = ConvUtils.getStringValue(row, 13);

      Record rec = makeSerialRecord(invbr, datum, tekst, godiste, brojSvezaka, dimenzije, povezano, nepovezano,
          kupovina, razmena, poklon, cena, signatura, napomena, rowCount);
      originals.add(rec);
      String key = tekst.trim().toUpperCase();
      Record previousRecord = recordMap.get(key);
      if (previousRecord != null) {
        previousRecord.getGodine().add(rec.getGodine().get(0));
      } else {
        recordMap.put(key, rec);
      }
    }
    input.close();

    Collection<Record> values = recordMap.values();
    List<Record> sortedList = new ArrayList<>();
    sortedList.addAll(values);
    Collections.sort(sortedList, new RecordComparator());

    int RN = Integer.parseInt(startniRN);
    for (Record record: sortedList) {
      processRecord(record, RN++);
      record.sort();
    }

    PrintWriter output = new PrintWriter(new BufferedWriter(new OutputStreamWriter(new FileOutputStream(outputFileName),
        "UTF8")));
    for (Record record: sortedList) {
      output.println(getSql(record));
    }
    output.println("UPDATE Counters SET counter_value=" + RN + " WHERE counter_name='RN';\n");
    output.close();

    PrintWriter preview = new PrintWriter(new BufferedWriter(new OutputStreamWriter(new FileOutputStream(previewFileName),
        "UTF8")));
    for (Record record: sortedList) {
      preview.println("---- " + record.getRecordID() + " ----");
      preview.println(FullFormatSerializer.toFullFormat(record, false));
    }
    preview.close();

  }

  public static Record makeSerialRecord(String invbr, String datum, String tekst, String godiste, String brojSvezaka,
                                        String dimenzije, String povezano, String nepovezano, String kupovina,
                                        String razmena, String poklon, String cena, String signatura, String napomena,
                                        int rowCount) {
    Record rec = new Record();
    rec.setRecordID(rowCount-4);
    rec.setCreator(new Author("import", "bibliotekaPTTmuzeja.posta.rs"));
    rec.setModifier(new Author("import", "bibliotekaPTTmuzeja.posta.rs"));
    rec.setCreationDate(new Date());
    rec.setLastModifiedDate(new Date());
    rec.setPubType(2);

    ConvUtils.addSubfield(rec, "001a", "i");
    ConvUtils.addSubfield(rec, "001b", "a");
    ConvUtils.addSubfield(rec, "001c", "s");
    ConvUtils.addSubfield(rec, "001d", "1");

    ConvUtils.addSubfield(rec, "200a", tekst);
    rec.getField("200").setInd1('1');

    ConvUtils.addSubfield(rec, "215d", dimenzije);
    ConvUtils.addSubfield(rec, "675a", signatura);

    rec.sort();
    rec.pack();

    Godina g = new Godina();
    g.setInvBroj(ConvUtils.getInvBroj(invbr, rowCount, "0001"));
    g.setDatumInventarisanja(ConvUtils.getDatum(datum));
    g.setNacinNabavke(ConvUtils.getNacinNabavke("", kupovina, razmena, poklon));
    g.setCena(ConvUtils.getCena(cena));
    g.setSigUDK(signatura);
    g.setNapomene(napomena.trim());
    g.setPovez(ConvUtils.getPovez(povezano, nepovezano));
    g.setGodiste(getGodiste(godiste));
    g.setGodina(getGodina(godiste));
    g.setBroj(getSveske(godiste));
    rec.getGodine().add(g);

    int odBroja = 0;
    int doBroja = 0;
    int brSvezaka = 0;
    try {
      brSvezaka = Integer.parseInt(brojSvezaka.trim());
    } catch (Exception ex) {
      System.err.println("Neispravan broj svezaka: " + brojSvezaka);
    }
    if (g.getBroj() == null || g.getBroj().length() == 0) {
      odBroja = 1;
      doBroja = 1 + brSvezaka;
    } else {
      Matcher m1 = odDo.matcher(g.getBroj());
      Matcher m2 = od.matcher(g.getBroj());
      if (m1.find()) {
        odBroja = Integer.parseInt(m1.group(1));
        doBroja = Integer.parseInt(m1.group(2));
      } else if (m2.find()) {
        int x = Integer.parseInt(m2.group(1));
        odBroja = x;
        doBroja = x;
      } else {
        odBroja = 1;
        doBroja = 1 + brSvezaka;
      }
    }

    Sveska s = new Sveska();
    s.setParent(g);
    g.getSveske().add(s);
    s.setInvBroj("0099" + g.getInvBroj().substring(4));
    s.setSignatura(g.getSigUDK());
    s.setKnjiga(g.getGodiste());
    s.setBrojSveske("" + odBroja + "-" + doBroja + " (" + brojSvezaka + ")");
    /*
    for (int i = odBroja; i <= doBroja; i++) {
      Sveska s = new Sveska();
      s.setParent(g);
      g.getSveske().add(s);
      s.setInvBroj(ConvUtils.getInvBroj(Integer.toString(++sveskeCounter), 0, "0099"));
      s.setKnjiga(g.getGodiste());
      s.setBrojSveske(Integer.toString(i));
      s.setSignatura(g.getSigUDK());
    }
    */
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
    }

  private static String getGodiste(String content) {
    return match(godiste, content, 1);
  }

  private static String getGodina(String content) {
    return match(godina, content, 1);
  }

  private static String getSveske(String content) {
    return match(sveske, content, 1);
  }

  private static String match(Pattern pattern, String content, int piece) {
    if (content == null || content.trim().length() == 0)
      return null;
    Matcher m = pattern.matcher(content.trim());
    if (m.find())
      return m.group(piece);
    else
      return null;
  }

  private static String getSql(Record r) {
    StringBuilder sb = new StringBuilder();
    String rec = RecordFactory.toBISIS35(1, r).replace('\r',' ').replace('\n',' ');
    String sql1 = "SELECT counter_value INTO @recid FROM Counters WHERE counter_name='recordid';\n";
    String sql2 = "UPDATE Counters SET counter_value=counter_value+1 WHERE counter_name='recordid';\n";
    String sql3 = "INSERT INTO Records "
        + "(record_id, pub_type, creator, modifier, date_created, date_modified, archived, in_use_by, content) VALUES "
        + "(@recid+1, 2, '"+r.getCreator().getCompact()+"', NULL, '"+ConvUtils.sqlDateFormat.format(r.getCreationDate())+"', NULL, 0, NULL, " + ConvUtils.sql(rec) + ");\n";
    sb.append(sql1);
    sb.append(sql2);
    sb.append(sql3);
    for (Godina g: r.getGodine()) {
      String sql4 = "SELECT counter_value INTO @godid FROM Counters WHERE counter_name='godinaid';\n";
      String sql5 = "UPDATE Counters SET counter_value=counter_value+1 WHERE counter_name='godinaid';\n";
      String sql6 = "INSERT INTO Godine (" +
          "godina_id, record_id, sigformat_id, podlokacija_id, " +
          "intozn_id, odeljenje_id, nacin_id, povez_id, " +
          "inv_broj, datum_racuna, broj_racuna, dobavljac, cena, " +
          "finansijer, sig_dublet, sig_numerus_curens, sig_udk, " +
          "datum_inventarisanja, napomene, dostupnost_id, inventator, godiste, godina, broj) VALUES (" +
          "@godid+1, " +
          "@recid+1, " +
          ConvUtils.sql(g.getSigFormat()) + ", " +
          ConvUtils.sql(g.getSigPodlokacija()) + ", " +
          ConvUtils.sql(g.getSigIntOznaka()) + ", " +
          ConvUtils.sql(g.getOdeljenje()) + ", " +
          ConvUtils.sql(g.getNacinNabavke()) + ", " +
          ConvUtils.sql(g.getPovez()) + ", " +
          ConvUtils.sql(g.getInvBroj()) + ", " +
          ConvUtils.sql(g.getDatumRacuna()) + ", " +
          ConvUtils.sql(g.getBrojRacuna()) + ", " +
          ConvUtils.sql(g.getDobavljac()) + ", " +
          ConvUtils.sql(g.getCena()) + ", " +
          ConvUtils.sql(g.getFinansijer()) + ", " +
          ConvUtils.sql(g.getSigDublet()) + ", " +
          ConvUtils.sql(g.getSigNumerusCurens()) + ", " +
          ConvUtils.sql(g.getSigUDK()) + ", " +
          ConvUtils.sql(g.getDatumInventarisanja()) + ", " +
          ConvUtils.sql(g.getNapomene()) + ", " +
          ConvUtils.sql(g.getDostupnost()) + ", " +
          ConvUtils.sql(g.getInventator()) + ", " +
          ConvUtils.sql(g.getGodiste()) + ", " +
          ConvUtils.sql(g.getGodina()) + ", " +
          ConvUtils.sql(g.getBroj()) + ");\n";
      sb.append(sql4);
      sb.append(sql5);
      sb.append(sql6);
      for (Sveska s: g.getSveske()) {
        String sql7 = "SELECT counter_value INTO @sveskaid FROM Counters WHERE counter_name='sveskaid';\n";
        String sql8 = "UPDATE Counters SET counter_value=counter_value+1 WHERE counter_name='sveskaid';\n";
        String sql9 = "INSERT INTO Sveske (" +
            "sveska_id, godina_id, signatura, inv_br, " +
            "broj_sveske, knjiga, version) VALUES (" +
            "@sveskaid+1, " +
            "@godid+1, " +
            ConvUtils.sql(s.getSignatura()) + ", " +
            ConvUtils.sql(s.getInvBroj()) + ", " +
            ConvUtils.sql(s.getBrojSveske()) + ", " +
            ConvUtils.sql(s.getKnjiga()) + ", " +
            s.getVersion() + ");\n";
        sb.append(sql7);
        sb.append(sql8);
        sb.append(sql9);
      }
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
    godiste = Pattern.compile("(\\d{1,3}[\\-\\d]*)\\p{Punct}");
    godina = Pattern.compile("(\\d{4}(/|-|\\d)*)");
    sveske = Pattern.compile("([\\d-]+)$");
    odDo = Pattern.compile("(\\d+)-(\\d+)");
    od = Pattern.compile("(\\d+)");
  }

  private static String gradovi;
  private static Pattern pYear;
  private static Pattern pCity;
  private static Pattern pPublisher;
  private static Pattern godiste;
  private static Pattern godina;
  private static Pattern sveske;
  private static Pattern odDo;
  private static Pattern od;
  private static int sveskeCounter = 0;
}
