package com.adject.dynamicform;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

public class Test {
  public static void main(String[] args) {
	  DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd-MM-yyyy");
	  LocalDate date = LocalDate.parse("30-11-2021", formatter);
	  System.out.println(date);
}
}
