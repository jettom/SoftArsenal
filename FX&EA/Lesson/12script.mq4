#property copyright "Copyright 2014, MetaQuotes Software Corp."
#property link      "http://www.mql5.com"
#property version   "1.00"
#property strict
void OnStart()
  {
    /*
     ObjectCreate(0,"8",OBJ_FIBO,0,Time[53],Low[53],Time[19],High[19]);
     ObjectSetInteger(0,"8",OBJPROP_LEVELS,5);
     ObjectSetDouble(0,"8",OBJPROP_LEVELVALUE,0,0);
     ObjectSetString(0,"8",OBJPROP_LEVELTEXT,0,"0");
     ObjectSetDouble(0,"8",OBJPROP_LEVELVALUE,1,0.23);
     ObjectSetString(0,"8",OBJPROP_LEVELTEXT,1,"23");
     ObjectSetDouble(0,"8",OBJPROP_LEVELVALUE,2,0.5);
     ObjectSetString(0,"8",OBJPROP_LEVELTEXT,2,"50");
     ObjectSetDouble(0,"8",OBJPROP_LEVELVALUE,3,0.618);
     ObjectSetString(0,"8",OBJPROP_LEVELTEXT,3,"61.8");
     ObjectSetDouble(0,"8",OBJPROP_LEVELVALUE,4,1);
     ObjectSetString(0,"8",OBJPROP_LEVELTEXT,4,"100");
     */
     //ObjectCreate(0,"9",OBJ_CHANNEL,0,Time[53],Low[53],Time[19],High[19],Time[1],Low[1]);
     //ObjectCreate(0,"10",OBJ_REGRESSION,0,Time[20],0,Time[0],0);
     //ObjectSetInteger(0,"10",OBJPROP_RAY_RIGHT,True);
     //ObjectCreate(0,"11",OBJ_STDDEVCHANNEL,0,Time[20],0,Time[0],0);
     // ObjectSetDouble(0,"11",OBJPROP_DEVIATION,1.8);
     //ObjectCreate(0,"12",OBJ_FIBOCHANNEL,0,Time[53],Low[53],Time[19],High[19],Time[1],Low[1]);
     // ObjectCreate(0,"13",OBJ_GANNFAN,0,Time[20],Low[20],Time[0],0);
     //ObjectSetDouble(0,"13",OBJPROP_SCALE,19.8);
     /*
      ObjectCreate(0,"14",OBJ_FIBOFAN,0,Time[53],Low[53],Time[19],High[19]); 
      ObjectSetInteger(0,"14",OBJPROP_LEVELS,5);
      ObjectSetDouble(0,"14",OBJPROP_LEVELVALUE,0,0);
      ObjectSetString(0,"14",OBJPROP_LEVELTEXT,0,"0");
      ObjectSetDouble(0,"14",OBJPROP_LEVELVALUE,1,0.23);
      ObjectSetString(0,"14",OBJPROP_LEVELTEXT,1,"23");
      ObjectSetDouble(0,"14",OBJPROP_LEVELVALUE,2,0.5);
      ObjectSetString(0,"14",OBJPROP_LEVELTEXT,2,"50");
      ObjectSetDouble(0,"14",OBJPROP_LEVELVALUE,3,0.618);
      ObjectSetString(0,"14",OBJPROP_LEVELTEXT,3,"61.8");
      ObjectSetDouble(0,"14",OBJPROP_LEVELVALUE,4,1);
      ObjectSetString(0,"14",OBJPROP_LEVELTEXT,4,"100"); 
     */
     //ObjectCreate(0,"15",OBJ_EXPANSION,0,Time[53],Low[53],Time[19],High[19],Time[1],Low[1]);
     //ObjectCreate(0,"16",OBJ_PITCHFORK,0,Time[53],Low[53],Time[19],High[19],Time[1],Low[1]); 
      // ObjectCreate(0,"16",OBJ_FIBOTIMES,0,Time[53],Low[53],Time[19],High[19]);
     // ObjectCreate(0,"17",OBJ_ELLIPSE,0,Time[53],Low[53],Time[19],High[19]);
     // ObjectSetDouble(0,"17",OBJPROP_SCALE,0.05);
     // ObjectCreate(0,"18",OBJ_RECTANGLE,0,Time[53],Low[53],Time[19],High[19]);
      if(GlobalVariableCheck("s")==false)
        {
          GlobalVariableSet("s",1);
        }
      if(ObjectFind("16")>=0)
        {
          ObjectSetDouble(0,"16",OBJPROP_SCALE,GlobalVariableGet("s")-0.2);
          GlobalVariableSet("s",GlobalVariableGet("s")-0.2);
        }
      else
        {
          ObjectCreate(0,"16",OBJ_ELLIPSE,0,Time[53],Low[53],Time[19],High[19]); 
          ObjectSetInteger(0,"16",OBJPROP_COLOR,Red);
        }
      ObjectDelete("16");
      ObjectsDeleteAll(0,OBJ_VLINE);
 }