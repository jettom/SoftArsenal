#property copyright "Copyright 2014, MetaQuotes Software Corp."
#property link      "http://www.mql5.com"
#property version   "1.00"
#property strict
#property indicator_separate_window
#property indicator_buffers 8
double VAR1[];
double VAR2[];
double VAR3[];
double VAR4[];
double VAR5[];
double VAR6[];
double VAR7[];
double VAR8[];
int OnInit()
  {
   SetIndexStyle(0,DRAW_NONE);
   SetIndexBuffer(0,VAR1);
   SetIndexStyle(1,DRAW_NONE);
   SetIndexBuffer(1,VAR2);
   SetIndexStyle(2,DRAW_NONE);
   SetIndexBuffer(2,VAR3);
   SetIndexStyle(3,DRAW_LINE,STYLE_SOLID,2,White);
   SetIndexBuffer(3,VAR4);
   SetIndexStyle(4,DRAW_NONE);
   SetIndexBuffer(4,VAR5);
   SetIndexStyle(5,DRAW_LINE,STYLE_SOLID,2,Yellow);
   SetIndexBuffer(5,VAR6);
   SetIndexStyle(6,DRAW_ARROW,EMPTY,1,Red);
   SetIndexArrow(6,225);
   SetIndexBuffer(6,VAR7);
    SetIndexStyle(7,DRAW_ARROW,EMPTY,1,Blue);
   SetIndexArrow(7,226);
   SetIndexBuffer(7,VAR8);
   return(INIT_SUCCEEDED);
  }
int OnCalculate(const int rates_total,
                const int prev_calculated,
                const datetime &time[],
                const double &open[],
                const double &high[],
                const double &low[],
                const double &close[],
                const long &tick_volume[],
                const long &volume[],
                const int &spread[])
  {
    if(rates_total<11)
    {
      return(0);
    }
   int i,limit;
   limit=rates_total-prev_calculated;
   if(prev_calculated>0)limit++;
   
   for(i=0;i<limit;i++)
     {
      if((High[iHighest(NULL,0,MODE_HIGH,10,i)]-Low[iLowest(NULL,0,MODE_LOW,10,i)])>0)
        {
          VAR1[i]=(Close[i]-Low[iLowest(NULL,0,MODE_LOW,10,i)])/(High[iHighest(NULL,0,MODE_HIGH,10,i)]-Low[iLowest(NULL,0,MODE_LOW,10,i)]);
        }
     }
    for(i=0;i<limit;i++)
     {
       VAR2[i]=iMAOnArray(VAR1,0,8,0,MODE_SMA,i);
     }
    for(i=0;i<limit;i++)
     {
       VAR3[i]=iMAOnArray(VAR2,0,5,0,MODE_SMA,i);
     }
    for(i=0;i<limit;i++)
     {
       VAR4[i]=iMAOnArray(VAR3,0,5,0,MODE_SMA,i);
       //(CLOSE-LLV(LOW,11))/(HHV(HIGH,11)-LLV(LOW,11));
       VAR5[i]=(Close[i]-Low[iLowest(NULL,0,MODE_LOW,11,i)])/(High[iHighest(NULL,0,MODE_HIGH,11,i)]-Low[iLowest(NULL,0,MODE_LOW,11,i)]);
     }
    for(i=0;i<limit;i++)
     {
       VAR6[i]=iMAOnArray(VAR5,0,5,0,MODE_SMA,i);
     }
    for(i=0;i<limit;i++)
     {
       if(VAR6[i]>VAR4[i] && VAR6[i+1]<VAR4[i+1])
        {
          VAR7[i]=VAR4[i];
        }
       if(VAR6[i]<VAR4[i] && VAR6[i+1]>VAR4[i+1])
        {
          VAR8[i]=VAR4[i];
        }
     }
   return(rates_total);
  }
