#property copyright "Copyright 2014, MetaQuotes Software Corp."
#property link      "http://www.mql5.com"
#property version   "1.00"
#property strict
#property show_inputs
void OnStart()
  {
    int total=SignalBaseTotal();
    for(int i=0;i<total;i++)
      {
        if(SignalBaseSelect(i)==true)
          {
            int id=SignalBaseGetInteger(SIGNAL_BASE_ID);
            string name=SignalBaseGetString(SIGNAL_BASE_NAME);
            double price=SignalBaseGetDouble(SIGNAL_BASE_PRICE);
            int trade=SignalBaseGetInteger(SIGNAL_BASE_TRADES);
            if(price==0 && trade>0)
             {
               printf(id+"|"+name);
               SignalInfoSetInteger(SIGNAL_INFO_TERMS_AGREE,1);
               SignalInfoSetInteger(SIGNAL_INFO_SUBSCRIPTION_ENABLED,1);
               SignalInfoSetInteger(SIGNAL_INFO_COPY_SLTP,1);
               SignalInfoSetInteger(SIGNAL_INFO_CONFIRMATIONS_DISABLED,1);
               SignalInfoSetInteger(SIGNAL_INFO_DEPOSIT_PERCENT,20);
               SignalInfoSetDouble(SIGNAL_INFO_EQUITY_LIMIT,4500);
               SignalInfoSetDouble(SIGNAL_INFO_SLIPPAGE,1.5);
               if(SignalSubscribe(id)==false)
                {
                  printf(GetLastError());
                }
               break;
             }
          }
      }
  }
