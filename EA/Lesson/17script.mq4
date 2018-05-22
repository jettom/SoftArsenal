#property copyright "Copyright 2014, MetaQuotes Software Corp."
#property link      "http://www.mql5.com"
#property version   "1.00"
#property strict
extern string huobi="USDJPY";
void OnStart()
  {
    //buy(0.1,200,300,Symbol()+"buy",123456);
    //OrderSend(Symbol(),OP_BUY,0.1,Ask,50,Ask-200*Point,Ask+300*Point,"",0,0,White);
    //OrderSend(Symbol(),OP_BUY,0.2,Ask,50,Ask-200*Point,Ask+300*Point,"",0,0,White);
    //closeall();
    //modify(300,300);
    //Alert(DoubleToStr(Point,5));
    closeallprofit();
  }
void modify(int slpoint,int tppoint)
  {
       int t=OrdersTotal();
       for(int i=t-1;i>=0;i--)
         {
           if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES)==true)
             {
               double p=MarketInfo(OrderSymbol(),MODE_POINT);
               if(OrderType()==0)
                 {
                   OrderModify(OrderTicket(),OrderOpenPrice(),OrderOpenPrice()-slpoint*p,OrderOpenPrice()+tppoint*p,Green);
                 }
               if(OrderType()==1)
                 {
                   OrderModify(OrderTicket(),OrderOpenPrice(),OrderOpenPrice()+slpoint*p,OrderOpenPrice()-tppoint*p,Green);
                 }
             }
         }
  }
void closeallprofit()
  {
    while(danshuprofit()>0)
     {
       int t=OrdersTotal();
       for(int i=t-1;i>=0;i--)
         {
           if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES)==true)
             {
               if(OrderType()<=1 && OrderProfit()>0)
                 {
                   OrderClose(OrderTicket(),OrderLots(),OrderClosePrice(),Green);
                 }
               else
                 {
                   OrderDelete(OrderTicket());
                 }
             }
         }
     }
  }
void closeall()
  {
    while(danshu()>0)
     {
       int t=OrdersTotal();
       for(int i=t-1;i>=0;i--)
         {
           if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES)==true)
             {
               if(OrderType()<=1)
                 {
                   OrderClose(OrderTicket(),OrderLots(),OrderClosePrice(),Green);
                 }
               else
                 {
                   OrderDelete(OrderTicket());
                 }
             }
         }
     }
  }
int danshu()
  {
     int a=0;
     for(int i=0;i<OrdersTotal();i++)
      {
        if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES)==true)
          {
            //if(OrderType()<=1)
              {
                a++;
              }
          }
      }
    return(a);
  }
int danshuprofit()
  {
     int a=0;
     for(int i=0;i<OrdersTotal();i++)
      {
        if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES)==true)
          {
             if(OrderProfit()>0);
              {
                a++;
              }
          }
      }
    return(a);
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
           a=OrderSend(Symbol(),OP_SELL,lots,Bid,50,0,Bid-tp*Point,com,sellmagic,0,White);
         }
        if(sl!=0 && tp==0)
         {
           a=OrderSend(Symbol(),OP_SELL,lots,Bid,50,Bid+sl*Point,0,com,sellmagic,0,White);
         }
        if(sl==0 && tp==0)
         {
           a=OrderSend(Symbol(),OP_SELL,lots,Bid,50,0,0,com,sellmagic,0,White);
         }
        if(sl!=0 && tp!=0)
         {
           a=OrderSend(Symbol(),OP_SELL,lots,Bid,50,Bid+sl*Point,Bid-tp*Point,com,sellmagic,0,White);
         }
      }
    return(a);
  }

