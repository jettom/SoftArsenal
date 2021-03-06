#property copyright "Copyright 2014, MetaQuotes Software Corp."
#property link      "http://www.mql5.com"
#property version   "1.00"
#property strict
void OnStart()
  {
    ObjectCreate("1",OBJ_VLINE,0,Time[1],Open[1]);
    ObjectCreate("2",OBJ_HLINE,0,Time[1],Open[1]);
    ObjectSet("2",OBJPROP_COLOR,clrDarkViolet);
    ObjectSet("2",OBJPROP_WIDTH,3);
    double shuiping0=ObjectGet("2",OBJPROP_PRICE1);
    color yanse=ObjectGet("2",OBJPROP_COLOR);
    Alert("水平线的颜色:"+ColorToString(yanse));
    Alert("水平线的价格:"+shuiping0);
    ObjectCreate("3",OBJ_TREND,0,Time[10],Open[10],Time[0],Low[0]);
    ObjectSet("3",OBJPROP_COLOR,clrWhite);
    ObjectSet("3",OBJPROP_RAY,True);
    double jiage0=ObjectGetValueByShift("3",0);
    Alert("0号k线上趋势线的值:"+jiage0);
    ObjectCreate("4",OBJ_TRENDBYANGLE,0,Time[10],Open[10],Time[0],Low[0]);
    ObjectSet("4",OBJPROP_ANGLE,45);
    ObjectSet("4",OBJPROP_COLOR,clrYellow);
    int jiadu=ObjectGet("4",OBJPROP_ANGLE);
    Alert("角度:"+jiadu);
    ObjectCreate("5",OBJ_FIBO,0,Time[11],Low[11],Time[0],High[0]);
    
    ObjectCreate("6",OBJ_TEXT,0,Time[11],Low[11]);
    ObjectSetText("6","谢谢",10,"宋体",Yellow);
    
    ObjectCreate("7",OBJ_LABEL,0,10,10);
    ObjectSet("7",OBJPROP_XDISTANCE,150);
    ObjectSet("7",OBJPROP_YDISTANCE,15);
    ObjectSet("7",OBJPROP_CORNER,CORNER_RIGHT_LOWER);
    ObjectSetText("7","你好",10,"宋体",Yellow);
    int tot=ObjectsTotal();
    for(int i=tot;i>=0;i--)
     {
       string obname=ObjectName(i);
       printf(i+" |"+obname);
       ObjectDelete(obname);
     }
    
  }
