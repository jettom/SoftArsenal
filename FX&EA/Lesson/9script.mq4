#property copyright "Copyright 2014, MetaQuotes Software Corp."
#property link      "http://www.mql5.com"
#property version   "1.00"
#property strict
void OnStart()
  {
    /*
    if(AccountNumber()!=123456)
      {
        Alert("你的账户不等于123456");
        return;
      }
    */
    if(StringFind(AccountCompany(),"IronFx",0)>=0)
     {
       Alert("交易商不同");
     }
    printf("账户号码:"+AccountNumber());
    printf("账户名字:"+AccountName());
    printf("交易商名字:"+AccountCompany());
    if(IsDemo()==true)
     {
       Alert("模拟账户");
     }
    else
     {
       Alert("真是账户");
     }
     printf("余额:"+AccountBalance());
     printf("净值:"+AccountEquity());
     printf("已用保证金:"+AccountMargin());
     printf("可用保证金:"+AccountFreeMargin());
     printf("杠杆:"+AccountLeverage());
     printf("总盈亏:"+AccountProfit());
     printf("日最低价:"+MarketInfo("EURUSD",MODE_LOW));
     
     printf("最后价格跳动时间:"+TimeToString(MarketInfo("EURUSD",MODE_TIME),TIME_DATE|TIME_SECONDS));
     printf("一个点价格:"+DoubleToStr(MarketInfo("USDJPY",MODE_POINT),10));
     printf("小数位数:"+MarketInfo("USDJPY",MODE_DIGITS));
     printf("点差:"+MarketInfo("USDJPY",MODE_SPREAD));
     printf("止损离市价多少个点:"+MarketInfo("USDJPY",MODE_STOPLEVEL));
     printf("一手代表的金额:"+MarketInfo("USDJPY",MODE_LOTSIZE));
     printf("USDJPY1手波动1点的盈亏值:"+MarketInfo("USDJPY",MODE_TICKVALUE));
     printf("EURGBP1手波动1点的盈亏值:"+MarketInfo("EURGBP",MODE_TICKVALUE));
     printf("多单隔一夜利息:"+MarketInfo("EURUSD",MODE_SWAPLONG));
     printf("空单隔一夜利息:"+MarketInfo("EURUSD",MODE_SWAPSHORT));
     printf("此货币对是否可交易:"+MarketInfo("EURUSD",MODE_TRADEALLOWED));
     printf("最小下单量:"+MarketInfo("EURUSD",MODE_MINLOT));
     printf("最小递增下单量:"+MarketInfo("EURUSD",MODE_LOTSTEP));
     printf("最大下单量:"+MarketInfo("EURUSD",MODE_MAXLOT));
     if(MarketInfo(Symbol(),MODE_PROFITCALCMODE)==0)
       {
         printf("此商品是外汇品种");
       }
     if(MarketInfo(Symbol(),MODE_PROFITCALCMODE)==1)
       {
         printf("此商品是CFD");
       }
     if(MarketInfo(Symbol(),MODE_PROFITCALCMODE)==2)
       {
         printf("此商品是期货");
       }
      printf("下1手需要的保证金:"+MarketInfo("EURUSD",MODE_MARGINREQUIRED));
  }