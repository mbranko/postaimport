package com.ftninformatika.bisis.postaimport;

import com.gint.app.bisis4.records.*;
import com.gint.app.bisis4.records.serializers.FullFormatSerializer;
import com.gint.util.string.StringUtils;
import org.apache.commons.cli.*;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;

import java.io.*;
import java.math.BigDecimal;
import java.util.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class ImportApp {

  public static void main(String[] args) throws Exception {
    Options options = new Options();
    options.addOption("i", true, "Ulazni fajl");
    options.addOption("o", true, "Izlazni fajl");
    CommandLineParser parser = new DefaultParser();
    CommandLine cmdLine = parser.parse(options, args);
    if (!(cmdLine.hasOption("i") && cmdLine.hasOption("o"))) {
      HelpFormatter formatter = new HelpFormatter();
      formatter.printHelp("ImportApp", options);
      return;
    }

    String inputFileName = cmdLine.getOptionValue("i");
    String outputFileName = cmdLine.getOptionValue("o");

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
      String invbr = getStringValue(row, 0);
      String datum = getStringValue(row, 1);
      String tekst = getStringValue(row, 2);
      String povez = getStringValue(row, 5);
      String dimenzije = getStringValue(row, 6);
      String obavezni = getStringValue(row, 7);
      String kupovina = getStringValue(row, 8);
      String razmena = getStringValue(row, 9);
      String poklon = getStringValue(row, 10);
      String cena = getStringValue(row, 11);
      String signatura = getStringValue(row, 12);
      String napomena = getStringValue(row, 13);
      Record rec = makeMonographRecord(invbr, datum, tekst, povez, dimenzije, obavezni, kupovina, razmena, poklon, cena,
          signatura, napomena, rowCount);
      originals.add(rec);
      String key = tekst.trim().toUpperCase();
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
    Collections.sort(sortedList, (r1, r2) -> {
        if (r1.getRecordID() < r2.getRecordID())
          return -1;
        if (r1.getRecordID() > r2.getRecordID())
          return 1;
        return 0;
      }
    );

    for (Record record: sortedList) {
      processRecord(record);
      record.sort();  
    }


    PrintWriter output = new PrintWriter(new BufferedWriter(new OutputStreamWriter(new FileOutputStream(outputFileName),
        "UTF8")));
    for (Record record: sortedList) {
      output.println("---- " + record.getRecordID() + " ----");
      output.println(FullFormatSerializer.toFullFormat(record, false));
    }

    output.close();
  }

  public static Record makeMonographRecord(String invbr, String datum, String tekst, String povez, String dimenzije,
                                  String obavezni, String kupovina, String razmena, String poklon, String cena,
                                  String signatura, String napomena, int rowCount) {
    Record rec = new Record();
    rec.setRecordID(rowCount-4);
    rec.setCreator(new Author("import", "pttmuzej.rs"));
    rec.setModifier(new Author("import", "pttmuzej.rs"));
    rec.setCreationDate(new Date());
    rec.setLastModifiedDate(new Date());
    rec.setPubType(1);

    addSubfield(rec, "001a", "i");
    addSubfield(rec, "001c", "m");
    addSubfield(rec, "001d", "0");

    addSubfield(rec, "200a", tekst);
    rec.getField("200").setInd1('1');

    //addSubfield(rec, "210a", "Beograd");
    //addSubfield(rec, "210d", "2000");

    addSubfield(rec, "215d", dimenzije);
    addSubfield(rec, "675a", signatura);

    rec.sort();
    rec.pack();

    Primerak p = new Primerak();
    p.setInvBroj(getInvBroj(invbr, rowCount, "01"));
    p.setPovez(getPovez(povez));
    p.setNacinNabavke(getNacinNabavke(obavezni, kupovina, razmena, poklon));
    p.setNapomene(napomena);
    p.setSigUDK(signatura);
    p.setCena(getCena(cena));
    p.setPovez(getPovez(povez));
    rec.getPrimerci().add(p);

    return rec;
  }

  private static Record addSubfield(Record rec, String subfield, String content) {
    if (subfield.length() != 4)
      return rec;
    String fieldName = subfield.substring(0, 3);
    char subfieldName = subfield.charAt(3);
    Field f = rec.getField(fieldName);
    if (f == null) {
      f = new Field(fieldName);
      rec.add(f);
    }
    Subfield sf = f.getSubfield(subfieldName);
    if (sf == null) {
      sf = new Subfield(subfieldName);
      f.add(sf);
    }
    sf.setContent(content);
    return rec;
  }

  private static String getStringValue(Row row, int index) {
    Cell cell = row.getCell(index);
    switch (cell.getCellTypeEnum()) {
      case STRING:
        return cell.getStringCellValue();
      case NUMERIC:
        Double d = cell.getNumericCellValue();
        return d.toString();
      case BLANK:
        return "";
      case BOOLEAN:
        return Boolean.toString(cell.getBooleanCellValue());
      default:
        System.err.println("Nepoznat tip celije: " + cell.getStringCellValue());
        return cell.getStringCellValue();
    }
  }

  private static String getInvBroj(String content, int fallback, String prefix) {
    if (content == null || content.length() == 0)
      return prefix + StringUtils.padZeros(fallback-4, 9);
    if (content.indexOf('.') != -1)
      content = content.substring(0, content.indexOf('.'));
    int broj = fallback - 4;
    try {
      broj = Integer.parseInt(content.trim());
    } catch (Exception ex) {
      System.err.println("Neispravan inventarni broj: " + content);
    }
    return prefix + StringUtils.padZeros(broj, 9);
  }

  private static String getPovez(String content) {
    if (content == null || content.length() == 0)
      return null;
    String test = content.trim().toUpperCase();
    if (test.startsWith("T") || test.startsWith("\u0422"))
      return "t";
    if (test.startsWith("M") || test.startsWith("\u041C"))
      return "m";
    return "x";
  }

  private static String getNacinNabavke(String obavezni, String kupovina, String razmena, String poklon) {
    if (obavezni != null && obavezni.trim().length() > 0)
      return "o";
    if (kupovina != null && kupovina.trim().length() > 0)
      return "k";
    if (razmena != null && razmena.trim().length() > 0)
      return "r";
    if (poklon != null && poklon.trim().length() > 0)
      return "p";
    return null;
  }

  private static BigDecimal getCena(String content) {
    if (content == null || content.length() == 0)
      return null;
    BigDecimal retVal = null;
    try {
      retVal = new BigDecimal(content);
    } catch (Exception ex) {
      System.err.println("Neispravna cena: " + content);
    }
    return retVal;
  }

  private static void processRecord(Record rec) {
    String tekst = rec.getSubfieldContent("200a");
    if (tekst == null || tekst.length() == 0)
      return;

    Matcher mCity = pCity.matcher(tekst);
    if (mCity.find())
      addSubfield(rec, "210a", mCity.group(1));

    Matcher mYear = pYear.matcher(tekst);
    if (mYear.find())
      addSubfield(rec, "210d", mYear.group(1));

  }

  private static final Pattern pYear = Pattern.compile(".*(\\d{4}).*");
  private static final Pattern pCity = Pattern.compile(".*(?i)(Beograd|Zagreb|Cetinje|Београд|Цетиње|Загреб).*");
}
