//+------------------------------------------------------------------+
//|                                                      8script.mq4 |
//|                        Copyright 2014, MetaQuotes Software Corp. |
//|                                              http://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2014, MetaQuotes Software Corp."
#property link      "http://www.mql5.com"
#property version   "1.00"
#property strict
//+------------------------------------------------------------------+
//| Script program start function                                    |
//+------------------------------------------------------------------+
void OnStart()
  {
   datetime gmt=TimeGMT();
   Print(gmt);
   int a=TimeGMTOffset()/(60*60);
   int b=0;
  }
//+------------------------------------------------------------------+
