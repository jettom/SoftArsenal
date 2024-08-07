//易行_订单变量
//--- 持仓单信息
struct  TradesOrders
{
    int         ticket;         //订单号
    string      symbol;         //商品名称
    datetime    opentime;       //建仓时间
    int         type;           //订单类型
    double      lots;           //建仓量
    double      openprice;      //建仓价
    double      stoploss;       //止损价
    double      takeprofit;     //止盈价
    double      profit;         //利润
    double      commission;     //佣金
    double      swap;           //掉期
    string      comment;        //注释
    int         magicnumber;    //程序识别码
    double      cost;           //成本
};

//--- 持仓单统计
struct  TradesStatistical
{
    string      symbol;                 //商品名称
    
    int         buy_orders;             //Buy单数量总计
    int         buylimit_orders;        //BuyLimit单数量总计
    int         buystop_orders;         //BuyStop单数量总计
    double      buy_grp_lots;           //Buy组成交持仓单建仓量总计
    double      buy_grp_profit;         //Buy组成交持仓单利润总计
    double      buy_grp_avg;            //Buy组均价
    double      buy_grp_margin;         //Buy组保证金占用
    double      buy_grp_risk;           //Buy组风险值
    double      buy_grp_cost;           //Buy组成本

    int         sell_orders;            //Sell单数量总计
    int         selllimit_orders;       //SellLimit单数量总计
    int         sellstop_orders;        //SellStop单数量总计
    double      sell_grp_lots;          //Sell组成交持仓单建仓量总计
    double      sell_grp_profit;        //Sell组成交持仓单利润总计
    double      sell_grp_avg;           //Sell组均价
    double      sell_grp_margin;        //Sell组保证金占用
    double      sell_grp_risk;          //Sell组风险值
    double      sell_grp_cost;          //Sell组成本

    double      max_floating_profit;    //最大浮盈
    double      max_floating_loss;      //最大浮亏
    double      max_margin;             //最大保证金占用
    double      account_increment;      //余额增量
    double      current_profit;         //本轮净利
    double      max_lots;               //最大可建仓量

    //单边持仓风险用4个节点划分5个阶段
    double      risk_level_value_1;     //1级风险节点
    double      risk_level_value_2;     //2级风险节点
    double      risk_level_value_3;     //3级风险节点
    double      risk_level_value_4;     //4级风险节点
    double      risk_level_value_5;     //5级风险节点

    color       risk_level_clr_1;       //1级风险颜色
    color       risk_level_clr_2;       //2级风险颜色
    color       risk_level_clr_3;       //3级风险颜色
    color       risk_level_clr_4;       //4级风险颜色
    color       risk_level_clr_5;       //5级风险颜色
    TradesStatistical()
    {
        //预定义风险节点
        risk_level_value_1=0.0;
        risk_level_value_2=0.0;
        risk_level_value_3=0.0;
        risk_level_value_4=0.0;
        risk_level_value_5=0.0;
        //预定义风险级别颜色
        risk_level_clr_1=clrBlue;
        risk_level_clr_2=clrGreen;
        risk_level_clr_3=clrOrangeRed;
        risk_level_clr_4=clrRed;
        risk_level_clr_5=clrBlack;
    }
};

//--- 历史单信息
struct  HistoryOrders
{
    int         ticket;         //订单号
    string      symbol;         //商品名称
    int         type;           //订单类型
    double      lots;           //建仓量
    datetime    opentime;       //建仓时间
    double      openprice;      //建仓价
    datetime    closetime;      //平仓时间
    double      closeprice;     //平仓价
    double      stoploss;       //止损价
    double      takeprofit;     //止盈价
    double      profit;         //利润
    double      commission;     //佣金
    double      swap;           //利息
    string      comment;        //注释
    int         magicnumber;    //程序识别码
    double      cost;           //成本
};

//--- 历史单统计
struct  HistoryStatistical
{
    int         buy_win_orders;     //Buy盈利单数量总计
    int         buy_loss_orders;    //Buy亏损单数量总计
    int         buy_orders;         //Buy单数量总计
    double      buy_win_profit;     //Buy盈利单利润总计
    double      buy_loss_profit;    //Buy亏损单利润总计
    double      buy_profit;         //Buy单成交利润总计
    double      buy_lots;           //Buy单成交量总计
    int         buy_limit_orders;   //BuyLimit单数量总计
    int         buy_stop_orders;    //BuyStop单数量总计
    
    int         sell_win_orders;    //Sell盈利单数量总计
    int         sell_loss_orders;   //Sell亏损单数量总计
    int         sell_orders;        //Sell单数量总计
    double      sell_win_profit;    //Sell盈利单利润总计
    double      sell_loss_profit;   //Sell亏损单利润总计
    double      sell_profit;        //Sell单成交利润总计
    double      sell_lots;          //Sell单成交量总计
    int         sell_limit_orders;  //SellLimit单数量总计
    int         sell_stop_orders;   //SellStop单数量总计
    
    double      win_ratio;          //胜率
    double      loss_ratio;         //败率
    double      odds;               //赔率
    double      kelly;              //凯利
};
