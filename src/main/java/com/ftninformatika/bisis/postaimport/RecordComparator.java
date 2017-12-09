package com.ftninformatika.bisis.postaimport;

import com.gint.app.bisis4.records.Record;

import java.util.Comparator;

public class RecordComparator implements Comparator<Record> {
  @Override
  public int compare(Record r1, Record r2) {
    if (r1.getRecordID() < r2.getRecordID())
      return -1;
    if (r1.getRecordID() > r2.getRecordID())
      return 1;
    return 0;
  }
}
