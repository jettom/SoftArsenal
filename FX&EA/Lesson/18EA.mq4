#property copyright "Copyright 2014, MetaQuotes Software Corp."
#property link      "http://www.mql5.com"
#property version   "1.00"
#property strict
extern double 下单量=0.1;
extern int 止损点数=0;
extern int 止盈点数=0;
extern int 移动止损点数=100;
extern int 大周期均线=20;
extern int 小周期均线=10;
extern int magic=52142;
datetime buytime=0;
datetime selltime=0;
int OnInit()
  {

   return(INIT_SUCCEEDED);
  }
void OnDeinit(const int reason)
  {
   
  }
void OnTick()
  {
     double da0=iMA(NULL,0,大周期均线,0,MODE_SMA,PRICE_CLOSE,0);
     double da1=iMA(NULL,0,大周期均线,0,MODE_SMA,PRICE_CLOSE,1);
     double da2=iMA(NULL,0,大周期均线,0,MODE_SMA,PRICE_CLOSE,2);
     double xiao0=iMA(NULL,0,小周期均线,0,MODE_SMA,PRICE_CLOSE,0);
     double xiao1=iMA(NULL,0,小周期均线,0,MODE_SMA,PRICE_CLOSE,1);
     double xiao2=iMA(NULL,0,小周期均线,0,MODE_SMA,PRICE_CLOSE,2);
     double zhu0=iMACD(NULL,0,12,26,9,PRICE_CLOSE,MODE_MAIN,0);
     double xian0=iMACD(NULL,0,12,26,9,PRICE_CLOSE,MODE_SIGNAL,0);
     double shang0=iBands(NULL,0,20,2,0,PRICE_CLOSE,MODE_UPPER,0);
     double xia0=iBands(NULL,0,20,2,0,PRICE_CLOSE,MODE_LOWER,0);
     double zhong0=iBands(NULL,0,20,2,0,PRICE_CLOSE,MODE_MAIN,0);
     double op0=iCustom(NULL,0,"Heiken Ashi",2,0);
     double cp0=iCustom(NULL,0,"Heiken Ashi",3,0);
     if(xiao0>da0 && xiao1<da1 && zhu0>xian0 && Close[0]<zhong0 && cp0>op0)//发生了金叉
       {
         closesell(Symbol()+"sell",magic);
         if(buytime!=Time[0])
          {
            if(buy(下单量,止损点数,止盈点数,Symbol()+"buy",magic)>0)
             {
               buytime=Time[0];
             }
          }
       }
     if(xiao0<da0 && xiao1>da1 && zhu0<xian0 && Close[0]>zhong0 && cp0<op0)//发生了死叉
       {
         closebuy(Symbol()+"buy",magic);
         if(selltime!=Time[0])
          {
            if(sell(下单量,止损点数,止盈点数,Symbol()+"sell",magic)>0)
              {
                selltime=Time[0];
              }
          }
       }
     yidong();
  }
void yidong()
  {
     for(int i=0;i<OrdersTotal();i++)//移动止损通用代码,次代码会自动检测buy和sell单并对其移动止损
         {
            if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES)==true)
              {
                if(OrderType()==0 && OrderSymbol()==Symbol() && OrderMagicNumber()==magic)
                  {
                     if((Bid-OrderOpenPrice())>=Point*移动止损点数)
                      {
                         if(OrderStopLoss()<(Bid-Point*移动止损点数) || (OrderStopLoss()==0))
                           {
                              OrderModify(OrderTicket(),OrderOpenPrice(),Bid-Point*移动止损点数,OrderTakeProfit(),0,Green);
                           }
                      }      
                  }
                if(OrderType()==1 && OrderSymbol()==Symbol() && OrderMagicNumber()==magic)
                  {
                    if((OrderOpenPrice()-Ask)>=(Point*移动止损点数))
                      {
                         if((OrderStopLoss()>(Ask+Point*移动止损点数)) || (OrderStopLoss()==0))
                           {
                              OrderModify(OrderTicket(),OrderOpenPrice(),Ask+Point*移动止损点数,OrderTakeProfit(),0,Green);
                           }
                      }
                  }
              }
         }
   }

void closebuy(string com,int magic)
  {
     int t=OrdersTotal();
     for(int i=t-1;i>=0;i--)
      {
        if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES)==true)
          {
            if(OrderSymbol()==Symbol() && OrderType()==OP_BUY && OrderComment()==com && OrderMagicNumber()==magic)
              {
                OrderClose(OrderTicket(),OrderLots(),OrderClosePrice(),300,Green);
              }
          }
      }
  }
void closesell(string com,int magic)
  {
     int t=OrdersTotal();
     for(int i=t-1;i>=0;i--)
      {
        if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES)==true)
          {
            if(OrderSymbol()==Symbol() && OrderType()==OP_SELL && OrderComment()==com && OrderMagicNumber()==magic)
              {
                OrderClose(OrderTicket(),OrderLots(),OrderClosePrice(),300,Green);
              }
          }
      }
  }
int buy(double lots,double sl,double tp,string com,int buymagic)
  {
    int a=0;
    bool zhaodan=false;
     for(int i=0;i<OrdersTotal();i++)
      {
        if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES)==true)
          {
            string zhushi=OrderComment();
            int ma=OrderMagicNumber();
            if(OrderSymbol()==Symbol() && OrderType()==OP_BUY && zhushi==com && ma==buymagic)
              {
                zhaodan=true;
                break;
              }
          }
      }
    if(zhaodan==false)
      {
        if(sl!=0 && tp==0)
         {
          a=OrderSend(Symbol(),OP_BUY,lots,Ask,50,Ask-sl*Point,0,com,buymagic,0,White);
         }
        if(sl==0 && tp!=0)
         {
          a=OrderSend(Symbol(),OP_BUY,lots,Ask,50,0,Ask+tp*Point,com,buymagic,0,White);
         }
        if(sl==0 && tp==0)
         {
          a=OrderSend(Symbol(),OP_BUY,lots,Ask,50,0,0,com,buymagic,0,White);
         }
        if(sl!=0 && tp!=0)
         {
          a=OrderSend(Symbol(),OP_BUY,lots,Ask,50,Ask-sl*Point,Ask+tp*Point,com,buymagic,0,White);
         } 
      }
    return(a);
  }
int sell(double lots,double sl,double tp,string com,int sellmagic)
  {
    int a=0;
    bool zhaodan=false;
     for(int i=0;i<OrdersTotal();i++)
      {
        if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES)==true)
          {
            string zhushi=OrderComment();
            int ma=OrderMagicNumber();
            if(OrderSymbol()==Symbol() && OrderType()==OP_SELL && zhushi==com && ma==sellmagic)
              {
                zhaodan=true;
                break;
              }
          }
      }
    if(zhaodan==false)
      {
        if(sl==0 && tp!=0)
         {
           a=OrderSend(Symbol(),OP_SELL,lots,Bid,50,0,Bid-tp*Point,com,sellmagic,0,Red);
         }
        if(sl!=0 && tp==0)
         {
           a=OrderSend(Symbol(),OP_SELL,lots,Bid,50,Bid+sl*Point,0,com,sellmagic,0,Red);
         }
        if(sl==0 && tp==0)
         {
           a=OrderSend(Symbol(),OP_SELL,lots,Bid,50,0,0,com,sellmagic,0,Red);
         }
        if(sl!=0 && tp!=0)
         {
           a=OrderSend(Symbol(),OP_SELL,lots,Bid,50,Bid+sl*Point,Bid-tp*Point,com,sellmagic,0,Red);
         }
      }
    return(a);
  }