#property copyright "Copyright 2014, MetaQuotes Software Corp."
#property link      "http://www.mql5.com"
#property version   "1.00"
#property strict
void OnStart()
  {
    //ChartApplyTemplate(0,"Layers");
    /*
    if(ChartSaveTemplate(0,"hao1.tpl")==false)
      {
        printf(GetLastError());
      }
    */
    /*
    ChartSetInteger(0,CHART_COLOR_BACKGROUND,clrBlack);
    ChartSetInteger(0,CHART_AUTOSCROLL,1);
    ChartSetInteger(0,CHART_SHIFT,1);
    ChartSetInteger(0,CHART_SHIFT,1);
    ChartSetSymbolPeriod(0,Symbol(),PERIOD_M30);
    ChartSetInteger(0,CHART_SCALEFIX,1);
    ChartSetDouble(0,CHART_FIXED_MIN,1.280);
    */
    //ChartSetString(0,CHART_COMMENT,"nihao");
    //ChartOpen("GBPUSD",1);
    //ChartOpen("USDJPY",15);
    /*
    long qian=ChartFirst();
    for(int i=1;i<100;i++)
      {
        ChartSetString(qian,CHART_COMMENT,qian);
        //ChartClose(qian);
        if(ChartSymbol(qian)=="EURUSD" && ChartPeriod(qian)==15)
         {
           ChartSetInteger(qian,CHART_COLOR_BACKGROUND,clrBlack);
         }
        double min=ChartGetDouble(qian,CHART_PRICE_MIN);
        ChartSetString(qian,CHART_COMMENT,DoubleToStr(min,5));
        long next=ChartNext(qian);
        qian=next;
        if(next<0) break;
      }
     ChartScreenShot(0,Symbol()+".jpg",800,600,ALIGN_RIGHT);
     */
     /*
     int total=ChartIndicatorsTotal(0,0);
     for(int i=0;i<total;i++)
       {
         printf(ChartIndicatorName(0,0,i));
         ChartIndicatorDelete(0,0,ChartIndicatorName(0,0,i));
       }
     */ 
     int wtotal=WindowsTotal();
     for(int i=0;i<wtotal;i++)
       {
         printf(i+"|"+WindowExpertName());
       }
     printf(wtotal);

  }
