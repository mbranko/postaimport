package com.ftninformatika.bisis.postaimport;

import com.gint.app.bisis4.records.Record;
import org.apache.commons.cli.*;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Row;

import java.io.*;
import java.util.*;

public class FixIntOznMonograph {

    public static void main(String[] args) throws Exception {
        Options options = new Options();
        options.addOption("i", true, "Ulazni fajl");
        options.addOption("o", true, "Izlazni fajl");
        CommandLineParser parser = new DefaultParser();
        CommandLine cmdLine = parser.parse(options, args);
        if (!(cmdLine.hasOption("i") && cmdLine.hasOption("o"))) {
            HelpFormatter formatter = new HelpFormatter();
            formatter.printHelp("FixIntOznMonograph", options);
            return;
        }

        String inputFileName = cmdLine.getOptionValue("i");
        String outputFileName = cmdLine.getOptionValue("o");

        BufferedInputStream input = new BufferedInputStream(new FileInputStream(inputFileName));
        HSSFWorkbook workbook = new HSSFWorkbook(input);
        HSSFSheet sheet = workbook.getSheetAt(0);
        int rowCount = 0;

        PrintWriter output = new PrintWriter(new BufferedWriter(new OutputStreamWriter(
                new FileOutputStream(outputFileName), "UTF8")));

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
            boolean changed = false;
            int kuc = napomena.indexOf("(\u043a\u0443\u0446)");
            if (kuc != -1) {
                napomena = napomena.substring(0, kuc).trim();
                changed = true;
            }
            if (napomena.startsWith("\u0421\u0422\u0420")) {
                napomena = "\u0421" + napomena.substring(3).trim();
                changed = true;
            }
            if (changed) {
                invbr = ConvUtils.getInvBroj(invbr, rowCount, "0000");
                String insert = "INSERT IGNORE INTO Interna_oznaka (IntOzn_id, IntOzn_opis) VALUES ('"+ napomena +"', 'Polica "+ napomena+"');";
                String update = "UPDATE Primerci SET IntOzn_id='"+ napomena + "'";
                if (kuc != -1) {
                    update += ", napomene='(\u043a\u0443\u0446)'";
                }
                update += " WHERE inv_broj='" + invbr + "';";
                output.println(insert);
                output.println(update);
            }
        }
        input.close();
        output.close();

    }
}
