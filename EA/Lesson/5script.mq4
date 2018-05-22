#property copyright "Copyright 2014, MetaQuotes Software Corp."
#property link      "http://www.mql5.com"
#property version   "1.00"
#property strict
void OnStart()
  {
    double a=Ask;
    double b=Bid;
    double c=MarketInfo("USDJPY",MODE_ASK);
    double d=MarketInfo("USDJPY",MODE_BID);
    printf("c"+c);
    printf("d"+d);
    double op=Open[3];
    double hp=High[3];
    double lp=Low[3];
    double cp=Close[3];
    double op15m=iOpen(NULL,15,2);
    double cp15m=iClose(NULL,15,2);
    //printf("cp15m:"+cp15m);
    double gbpusdhp1m=iHigh("GBPUSD",1,3);
    //printf("gbpusdhp1m"+gbpusdhp1m);
    int highbar=iHighest(NULL,0,MODE_HIGH,10,0);
   // printf(highbar);
    int lowbar=iLowest(NULL,0,MODE_LOW,10,0);
    //printf("lowbar"+lowbar);
    double lowp=Low[lowbar];
    //printf("lowp"+lowp);
    double ma0=iMA(NULL,0,14,0,MODE_SMA,PRICE_CLOSE,0);
    //printf("ma0:"+ma0);
    double cci0=iCCI(NULL,0,14,PRICE_CLOSE,0);
   // printf("cci0:"+cci0);
    double hong0=iCustom(NULL,0,"MACD2line",12,26,9,0,0);
    printf("hong0:"+hong0);
    double huang0=iCustom(NULL,0,"MACD2line",12,26,9,1,0);
    printf("hunag0:"+huang0);
  }