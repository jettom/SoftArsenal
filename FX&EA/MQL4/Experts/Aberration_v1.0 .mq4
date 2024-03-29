//+------------------------------------------------------------------+
//|                                                   Aberration.mq4 |
//|                        Copyright 2022, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2022, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property description   "v1.00"
#property strict

input double lot=0.1;//交易手数
input int    InpBandsPeriod=88;      // Bands Period
input int    InpBandsShift=0;        // Bands Shift
input double InpBandsDeviations=2.0; // Bands Deviations

input ENUM_MA_METHOD metd=1;//移动平均

int magic=9916;
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
//---

//---
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
//---

  }
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
  {
//---
   int b=0;
   int s=0;
   int bg=0;
   int sg=0;
   double band1=NormalizeDouble(iBands(NULL,0,InpBandsPeriod,InpBandsDeviations,InpBandsShift,PRICE_CLOSE,MODE_UPPER,1),Digits);
   double band2=NormalizeDouble(iBands(NULL,0,InpBandsPeriod,InpBandsDeviations,InpBandsShift,PRICE_CLOSE,MODE_LOWER,1),Digits);
   double main=NormalizeDouble(iMA(NULL,0,InpBandsPeriod,0,metd,PRICE_CLOSE,1),Digits);
   for(int i=0; i<OrdersTotal(); i++)
     {
      if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES)==false)
         break;
      if(OrderSymbol()==Symbol() && OrderMagicNumber()==magic)
        {
         if(OrderType()==OP_BUY)
           {
            b++;
            if(DoubleToStr(OrderStopLoss(),Digits)!=DoubleToStr(main,Digits))
              {
               bool res=OrderModify(OrderTicket(),OrderOpenPrice(),main,0,0);
              }
           }
         if(OrderType()==OP_BUYSTOP)
           {
            bg++;
            if(DoubleToStr(OrderOpenPrice(),Digits)!=DoubleToStr(band1,Digits))
              {
               bool res=OrderModify(OrderTicket(),band1,0,0,0);
              }
           }
         if(OrderType()==OP_SELL)
           {
            s++;
            if(DoubleToStr(OrderStopLoss(),Digits)!=DoubleToStr(main,Digits))
              {
               bool res=OrderModify(OrderTicket(),OrderOpenPrice(),main,0,0);
              }
           }
         if(OrderType()==OP_SELLSTOP)
           {
            sg++;
            if(DoubleToStr(OrderOpenPrice(),Digits)!=DoubleToStr(band2,Digits))
              {
               bool res=OrderModify(OrderTicket(),band2,0,0,0);
              }
           }
        }
     }
//---一边挂单成交了，就删除另一个挂单---
   if(b+s>0 && bg+sg>0)
     {
      for(int i=0; i<OrdersTotal(); i++)
        {
         if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES)==false)
            break;
         if(OrderSymbol()==Symbol() && OrderMagicNumber()==magic)
           {
            if(OrderType()==OP_BUYSTOP || OrderType()==OP_SELLSTOP)
              {
               bool res=OrderDelete(OrderTicket());
              }
           }
        }
     }
//---
   if(b+s==0)
     {
      if(bg==0 && Ask<band1 && Bid>band2)
        {
         int res=OrderSend(NULL,OP_BUYSTOP,lot,band1,0,0,0,NULL,magic);
        }
      if(sg==0 && Ask<band1 && Bid>band2)
        {
         int res=OrderSend(NULL,OP_SELLSTOP,lot,band2,0,0,0,NULL,magic);
        }
     }
  }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
