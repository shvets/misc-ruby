package test;

import java.io.*;


public class Test {

  public static void main(String[] argv) throws Throwable {
    if(argv.length == 0) {
      System.err.println("Hello!!!");
    }
    else {
      System.err.println("Hello: " + argv[0]);
    }
  }

}