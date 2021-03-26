//+------------------------------------------------------------------+
//|                                   Double smoothed stochastic.mq5 |
//|                                                 Copyright mladen |
//|                                               mladenfx@gmail.com |
//+------------------------------------------------------------------+
#property copyright "mladen"
#property link      "mladenfx@gmail.com"
#property version   "1.00"


#property indicator_separate_window
#property indicator_buffers   4
#property indicator_plots     2
#property indicator_minimum  -1
#property indicator_maximum 101


//
//
//
//
//

#property indicator_label1  "Stochastic levels"
#property indicator_type1   DRAW_FILLING
#property indicator_color1  Green,Red
#property indicator_label2  "Stochastic"
#property indicator_type2   DRAW_LINE
#property indicator_color2  DimGray
#property indicator_width2  2

//
//
//
//
//

input int    StochasticPeriod = 55; // Stochastic period
input int    EMAPeriod        = 15; // Smoothing period
input double UpLevel          = 80; // Overbought level
input double DnLevel          = 20; // Oversold level

//
//
//
//
//

double StochasticBuffer[];
double LevelsBuffer[];
double StochasticLine[];
double calcBuffer[];

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
//
//
//
//

int OnInit()
{
   SetIndexBuffer(0,StochasticBuffer,INDICATOR_DATA);         ArraySetAsSeries(StochasticBuffer,true);
   SetIndexBuffer(1,LevelsBuffer    ,INDICATOR_DATA);         ArraySetAsSeries(LevelsBuffer    ,true);
   SetIndexBuffer(2,StochasticLine  ,INDICATOR_DATA);         ArraySetAsSeries(StochasticLine  ,true);
   SetIndexBuffer(3,calcBuffer      ,INDICATOR_CALCULATIONS); ArraySetAsSeries(calcBuffer      ,true);
  
   IndicatorSetInteger(INDICATOR_LEVELS,2);
   IndicatorSetDouble(INDICATOR_LEVELVALUE,0,UpLevel);
   IndicatorSetDouble(INDICATOR_LEVELVALUE,1,DnLevel);
   IndicatorSetInteger(INDICATOR_LEVELCOLOR,DimGray);
   
   IndicatorSetString(INDICATOR_SHORTNAME,"Double smoothe stochastic ("+(string)StochasticPeriod+","+(string)EMAPeriod+")");
   
   return(0);
}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
//
//
//
//

int OnCalculate(const int rates_total,
                const int prev_calculated,
                const datetime& time[],
                const double& open[],
                const double& high[],
                const double& low[],
                const double& close[],
                const long& tick_volume[],
                const long& volume[],
                const int& spread[])
{

   //
   //
   //
   //
   //
   
      if (!ArrayGetAsSeries(close)) ArraySetAsSeries(close,true);
      if (!ArrayGetAsSeries(high))  ArraySetAsSeries(high ,true);
      if (!ArrayGetAsSeries(low))   ArraySetAsSeries(low  ,true);

   //
   //
   //
   //
   //
   
      double max;
      double min;
      double sto;
      double alpha = 2.0/(1.0+EMAPeriod);
      int    limit = rates_total-prev_calculated;;
         
            if (prev_calculated > 0) limit++;
            if (prev_calculated ==0)
            {
               limit -= StochasticPeriod;
                  for (int i=1; i<=StochasticPeriod; i++) StochasticBuffer[rates_total-i] = 0;
            }
   //
   //
   //
   //
   //
   
   for (int i=limit; i>=0; i--)
   {
         max = high[i]; for(int k=1; k<StochasticPeriod; k++) max = MathMax(max,high[i+k]);
         min =  low[i]; for(int k=1; k<StochasticPeriod; k++) min = MathMin(min, low[i+k]);
         if (max!=min)
               sto = (close[i]-min)/(max-min)*100.00;
         else  sto = 0;            
         calcBuffer[i] = calcBuffer[i+1]+alpha*(sto-calcBuffer[i+1]);
      
         //
         //
         //
         //
         //
      
         max = calcBuffer[i]; for(int k=1; k<StochasticPeriod; k++) max = MathMax(max,calcBuffer[i+k]);
         min = calcBuffer[i]; for(int k=1; k<StochasticPeriod; k++) min = MathMin(min,calcBuffer[i+k]);
         if (max!=min)
               sto = (calcBuffer[i]-min)/(max-min)*100.00;
         else  sto = 0;            
         StochasticBuffer[i] = StochasticBuffer[i+1]+alpha*(sto-StochasticBuffer[i+1]);
         StochasticLine[i]   = StochasticBuffer[i];
         LevelsBuffer[i]     = StochasticBuffer[i];
         
         if (StochasticBuffer[i]>UpLevel) LevelsBuffer[i] = UpLevel;
         if (StochasticBuffer[i]<DnLevel) LevelsBuffer[i] = DnLevel;
   }
   
   //
   //
   //
   //
   //
   
   return(rates_total);
}
