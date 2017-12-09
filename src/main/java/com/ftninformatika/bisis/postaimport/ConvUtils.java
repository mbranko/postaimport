package com.ftninformatika.bisis.postaimport;

import com.gint.app.bisis4.records.Field;
import com.gint.app.bisis4.records.Record;
import com.gint.app.bisis4.records.Subfield;
import com.gint.util.string.StringUtils;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;

import java.math.BigDecimal;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

public class ConvUtils {

  public static Record addSubfield(Record rec, String subfield, String content) {
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

  public static String getStringValue(Row row, int index) {
    Cell cell = row.getCell(index);
    if (cell == null)
      return "";
    switch (cell.getCellTypeEnum()) {
      case STRING:
        return cell.getStringCellValue();
      case NUMERIC:
        Double d = cell.getNumericCellValue();
        if (d % 1 == 0)
          return Long.toString(Math.round(d));
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

  public static String getInvBroj(String content, int fallback, String prefix) {
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
    return prefix + StringUtils.padZeros(broj, 7);
  }

  public static String getPovez(String content) {
    if (content == null || content.length() == 0)
      return null;
    String test = content.trim().toUpperCase();
    if (test.startsWith("T") || test.startsWith("\u0422"))
      return "t";
    if (test.startsWith("M") || test.startsWith("\u041C"))
      return "m";
    return "x";
  }

  public static String getPovez(String povezano, String nepovezano) {
    if (povezano == null || povezano.length() == 0) {
      if (nepovezano == null || nepovezano.length() == 0) {
        return null;
      } else {
        return "n";
      }
    } else {
      return "p";
    }
  }

  public static String getNacinNabavke(String obavezni, String kupovina, String razmena, String poklon) {
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

  public static BigDecimal getCena(String content) {
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

  public static Date getDatum(String content) {
    if (content == null || content.trim().length() == 0)
      return null;
    Date retVal = null;
    String sDate = content.trim();
    for (DateFormat df: dateFormats) {
      try {
        retVal = df.parse(sDate);
        break;
      } catch (Exception ex) {
      }
    }
    return retVal;
  }

  public static String sql(String s) {
    if (s == null)
      return "NULL";
    return "'" + StringUtils.replace(s, "'", "\\'") + "'";
  }

  public static String sql(Date d) {
    if (d == null)
      return "NULL";
    return "'" + sqlDateFormat.format(d) + "'";
  }

  public static String sql(BigDecimal bd) {
    if (bd == null)
      return "NULL";
    return "'" + bd.toPlainString() + "'";
  }

  private static DateFormat dateFormat1 = new SimpleDateFormat("dd.MM. yyyy.");
  private static DateFormat dateFormat2 = new SimpleDateFormat("dd.MM.yyyy.");
  private static DateFormat dateFormat3 = new SimpleDateFormat("dd.MM .yyyy.");
  private static DateFormat dateFormat4 = new SimpleDateFormat("dd.MM yyyy.");
  private static DateFormat[] dateFormats = { dateFormat1, dateFormat2, dateFormat3, dateFormat4 };
  public static SimpleDateFormat sqlDateFormat = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");

}
