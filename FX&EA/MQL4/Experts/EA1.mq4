//+-----------------------------------------------+
//|                                               |
//|                                               |
//|                                               |
//+-----------------------------------------------+
#property copyright "JT"
#property link "http://jiangtao.work"
#define MAGICMA 20211206
//+-----------------------------------------------+
//|                                               |
//+-----------------------------------------------+
extern int whichmethod = 1; // 下单方式 1.仅开仓，2.有止损无止盈，3.有止盈，无止损，4.有止盈也有止损
extern double TakeProfit = 100; // 止盈点数
extern double StopLoss = 20; // 止损点数
extern double MaximumRisk = 0.1; // 资金控制：下单量
extern double TrailingStop = 25; // 跟踪止盈点数设置
extern int MaxOpen = 3; //最多开仓次数
extern int MaxLots = 3; //最多持仓次数
extern int bb = 0; //大于0允许跟踪止盈
extern double MATrendPeriod = 26; // 均线，开仓条件参数

int i,p2,xxx,p1,res;
double Lots;
datetime lasttime;      //时间控制，仅当一个时间周期完成才检查条件

//+-----------------------------------------------+
//|   OK                                          |
//+-----------------------------------------------+
int init()   // 初始化
{
    Lots = 1;
    lasttime = NULL;
    return(0);
}

//+-----------------------------------------------+
//| Nothing                                       |
//+-----------------------------------------------+
int deinit()
{
    return(0);
}

//+-----------------------------------------------+
//|  OK                                             |
//+-----------------------------------------------+
int start()
{
    CheckForOpen(); //开仓，平仓，条件检查，
    if(bb>0) CTP(); //跟踪止盈
    return(0);
}

//+-----------------------------------------------+
//| 确定下单量，开仓调用，资金控制                   |
//+-----------------------------------------------+
double LotsOptimized()
{
    double lot = Lots;
    int orders = HistoryTotal();
    int losses = 0;
    //MarkerInfo(Symbol().MODE_MINLOT);
    //MarketInfo(Symbol().MODE_MAXLOT);
    //MarketInfo(Symbol().MODE_LOTSTEP);
    lot=NormalizeDouble(MaximumRisk * AccounBalance()/AccountLeverage(),1); //开仓量计算
    if(lot<0.1) lot = 0.1;
    if(lot>maxLots) lot = maxLots;
    returen (lot);

}

// 平仓持有的买单
//+-----------------------------------------------+
//|  TODO                                             |
//+-----------------------------------------------+
void CloseBuy()
{
    
}

// 平仓持有的卖单
//+-----------------------------------------------+
//| TODO                                              |
//+-----------------------------------------------+
void CloseSell()
{

}

//+-----------------------------------------------+
//|   TODO                                            |
// 判断是否买卖或者平仓
// 因子：MACD，MA
// return: 0：不交易，1：买，-1：卖
//+-----------------------------------------------+
int buyOrSell()
{
    if(1)
        return(1);
    if(-1)
        return(-1);

    return(0);
}

int nowbuyorsell = 0;
//+-----------------------------------------------+
//|  TODO                                             |
//+-----------------------------------------------+
void CheckForOpen()
{

}

//+-----------------------------------------------+
//|  TODO                                              |
//+-----------------------------------------------+
void TradeOK()
{
    if(nowbuyorsell == 1) // 买
    {

    }
    if(nowbuyorsell == -1) // 卖
    {
        
    }
}


//+-----------------------------------------------+
//|   跟踪止盈                                     |
//+-----------------------------------------------+
void CTP()
{
    bool bs = false；
    for(int i=0; i<OrdersTotal(); i++)
    {
        if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES)==false) 
            break;
        if(OrderType() == OP_BUY)
        {
            if((Bid - OrderOpenPrice()) > (TrailingStop * MarketInfo(OrderSymbol(), MODE_POINT)))
            {
                // 开仓价格，当前止损和当前价格比较判断是否要修改跟踪止盈设置
                if(OrderStopLoss() < Bid - TrailingStop *  MarketInfo(OrderSymbol(), MODE_POINT))
                {
                    bs = OrderModify(OrderTicker(),
                                     OrderOpenPrice(), 
                                     Bid - TrailingStop *  MarketInfo(OrderSymbol(), MODE_POINT),
                                     OrderTakeProfit(),
                                     0,
                                     Green);
                }
            }

        }
        else if(OrderType() == OP_SELL)
        {
            if((OrderOpenPrice() - Ask) > (TrailingStop * MarketInfo(OrderSymbol(), MODE_POINT)))
            {
                // 开仓价格，当前止损和当前价格比较判断是否要修改跟踪止盈设置
                if(OrderStopLoss() > (Ask + TrailingStop *  MarketInfo(OrderSymbol(), MODE_POINT)))
                {
                    bs = OrderModify(OrderTicker(),
                                     OrderOpenPrice(), 
                                     Ask + TrailingStop *  MarketInfo(OrderSymbol(), MODE_POINT),
                                     OrderTakeProfit(),
                                     0,
                                     Tan);
                }
            }
        }
    }
}