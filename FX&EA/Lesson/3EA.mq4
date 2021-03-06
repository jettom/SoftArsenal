//+------------------------------------------------------------------+
//|                                                          3EA.mq4 |
//|                        Copyright 2014, MetaQuotes Software Corp. |
//|                                              http://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2014, MetaQuotes Software Corp."
#property link      "http://www.mql5.com"
#property version   "1.00"
#property strict
#define KEY_NUMPAD_5       12
#define KEY_LEFT           37
#define KEY_UP             38
#define KEY_RIGHT          39
#define KEY_DOWN           40
#define KEY_NUMLOCK_DOWN   98
#define KEY_NUMLOCK_LEFT  100
#define KEY_NUMLOCK_5     101
#define KEY_NUMLOCK_RIGHT 102
#define KEY_NUMLOCK_UP    104

//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()//初始化的时候运行一次
  {
//--- create timer
   EventSetTimer(5);
   ChartSetInteger(ChartID(),CHART_EVENT_OBJECT_CREATE,true);
//--- enable object delete events
   ChartSetInteger(ChartID(),CHART_EVENT_OBJECT_DELETE,true);
   
//---
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
   Print(__FUNCTION__,"_UninitReason = ",getUninitReasonText(_UninitReason));
   EventKillTimer();
      
  }
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
  {
//---
   
  }
//+------------------------------------------------------------------+
//| Timer function                                                   |
//+------------------------------------------------------------------+
void OnTimer()
  {
    Print(TimeLocal());
  }
//+------------------------------------------------------------------+
//| ChartEvent function                                              |
//+------------------------------------------------------------------+
void OnChartEvent(const int id,
                  const long &lparam,
                  const double &dparam,
                  const string &sparam)
  {
    if(id==CHARTEVENT_KEYDOWN)
     {
       if(lparam=='J' || lparam=='j')
         {
           suoxiao();
         }
     }
    if(id==CHARTEVENT_CLICK)
     {
      Print("The coordinates of the mouse click on the chart are: x = ",lparam,"  y = ",dparam);
     }
//--- the mouse has been clicked on the graphic object
   if(id==CHARTEVENT_OBJECT_CLICK)
     {
      Print("The mouse has been clicked on the object with name '"+sparam+"'");
     }
//--- the key has been pressed
   if(id==CHARTEVENT_KEYDOWN)
     {
      switch(int(lparam))
        {
         case KEY_NUMLOCK_LEFT:  Print("The KEY_NUMLOCK_LEFT has been pressed");   break;
         case KEY_LEFT:          Print("The KEY_LEFT has been pressed");           break;
         case KEY_NUMLOCK_UP:    Print("The KEY_NUMLOCK_UP has been pressed");     break;
         case KEY_UP:            Print("The KEY_UP has been pressed");             break;
         case KEY_NUMLOCK_RIGHT: Print("The KEY_NUMLOCK_RIGHT has been pressed");  break;
         case KEY_RIGHT:         Print("The KEY_RIGHT has been pressed");          break;
         case KEY_NUMLOCK_DOWN:  Print("The KEY_NUMLOCK_DOWN has been pressed");   break;
         case KEY_DOWN:          Print("The KEY_DOWN has been pressed");           break;
         case KEY_NUMPAD_5:      Print("The KEY_NUMPAD_5 has been pressed");       break;
         case KEY_NUMLOCK_5:     Print("The KEY_NUMLOCK_5 has been pressed");      break;
         default:                Print("Some not listed key has been pressed");
        }
      ChartRedraw();
     }
//--- the object has been deleted
   if(id==CHARTEVENT_OBJECT_DELETE)
     {
      Print("The object with name ",sparam," has been deleted");
     }
//--- the object has been created
   if(id==CHARTEVENT_OBJECT_CREATE)
     {
      Print("The object with name ",sparam," has been created");
     }
//--- the object has been moved or its anchor point coordinates has been changed
   if(id==CHARTEVENT_OBJECT_DRAG)
     {
      Print("The anchor point coordinates of the object with name ",sparam," has been changed");
     }
//--- the text in the Edit of object has been changed
   if(id==CHARTEVENT_OBJECT_ENDEDIT)
     {
      Print("The text in the Edit field of the object with name ",sparam," has been changed");
     }

  }
void suoxiao()//缩小K线图周期函数
  {
     ENUM_TIMEFRAMES new_timeframe = PERIOD_CURRENT;
      switch (Period()) 
      {
      case PERIOD_M5:   new_timeframe = PERIOD_M1; break;
      case PERIOD_M15:  new_timeframe = PERIOD_M5; break;
      case PERIOD_M30:  new_timeframe = PERIOD_M15; break;
      case PERIOD_H1:   new_timeframe = PERIOD_M30; break;
      case PERIOD_H4:   new_timeframe = PERIOD_H1; break;
      case PERIOD_D1:   new_timeframe = PERIOD_H4; break;
      case PERIOD_W1:   new_timeframe = PERIOD_D1; break;
      case PERIOD_MN1:  new_timeframe = PERIOD_W1; break;
      }
      if (new_timeframe != PERIOD_CURRENT) 
      {
         ChartSetSymbolPeriod(0, NULL, new_timeframe);
      }
  }
string getUninitReasonText(int reasonCode)
  {
   string text="";
//---
   switch(reasonCode)
     {
      case REASON_ACCOUNT:
         text="Account was changed";break;
      case REASON_CHARTCHANGE:
         text="Symbol or timeframe was changed";break;
      case REASON_CHARTCLOSE:
         text="Chart was closed";break;
      case REASON_PARAMETERS:
         text="Input-parameter was changed";break;
      case REASON_RECOMPILE:
         text="Program "+__FILE__+" was recompiled";break;
      case REASON_REMOVE:
         text="Program "+__FILE__+" was removed from chart";break;
      case REASON_TEMPLATE:
         text="New template was applied to chart";break;
      default:text="Another reason";
     }
//---
   return text;
  }

