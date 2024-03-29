//易行_控制函数
#property   library
#include    <EasyGo\egEnvironmentVariables.mqh>     //环境变量
#include    <EasyGo\egOrdersVariables.mqh>          //订单变量
#include    <EasyGo\egUIFunctions.mqh>              //界面函数

/*
函    数:数组平仓
输出参数:false-平仓失败,true-平仓成功
算    法:
*/
bool egArrayClose(int    &myCloseArray[],   //平仓数组
                  const int myTradingDelay=5000 //延时
                 )
{
    int cnt=0,i=0;  //循环计数器变量
    for (cnt=0;cnt<ArraySize(myCloseArray);cnt++)
    {
        if (myCloseArray[cnt]>0 && OrderSelect(myCloseArray[cnt],SELECT_BY_TICKET,MODE_TRADES))
        {
            egTradeDelay(myTradingDelay);
            //买入成交持仓单市价平仓
            if (OrderType()==OP_BUY && OrderClose(OrderTicket(),OrderLots(),MarketInfo(OrderSymbol(),MODE_BID),0))
            {
                myCloseArray[cnt]=-1;
                i++; //未平仓单计数
            }
            //卖出成交持仓单市价平仓
            if (OrderType()==OP_SELL && OrderClose(OrderTicket(),OrderLots(),MarketInfo(OrderSymbol(),MODE_ASK),0))
            {
                myCloseArray[cnt]=-1;
                i++; //未平仓单计数
            }
            //撤销挂单
            if (   (OrderType()==OP_BUYLIMIT || OrderType()==OP_BUYSTOP || OrderType()==OP_SELLLIMIT || OrderType()==OP_SELLSTOP)
                && OrderDelete(OrderTicket())
               )
            {
                myCloseArray[cnt]=-1;
                i++; //未平仓单计数
            }
        }
    }
    if (i==0) 
    {
        ArrayInitialize(myCloseArray,-1); //初始化平仓数组
        return(false);
    }
    return(true);
}

/*
函    数:一维数组排序
输出参数:冒泡，数组降序排列
算    法:
*/
void egArraySort(double    &myArray[], //目标数组
                )
{
    if (ArraySize(myArray)<=0) return;
    int i=0,j=0; //循环计数器变量
    double mySwap=0; //交换变量
    for (i=0;i<ArraySize(myArray);i++)
    {
        for (j=ArraySize(myArray)-1;j>i;j--)
        {
            if (myArray[j]>myArray[j-1])
            {
                mySwap=myArray[j-1];
                myArray[j-1]=myArray[j];
                myArray[j]=mySwap;
            }
        }
    }
    return;
}

/*
函    数:余额保护
输出参数:true-执行，false-未执行
算    法:
记录初始余额，按当前余额计算余额增量
当前余额保护系数=当前商品利润/余额增量
如果当前系数<预定系数，全体平仓
*/
bool egBalanceProtection(TradesStatistical   &myTS,              //持仓单统计
                         TradesOrders        &myTO[],            //持仓单数组
                         double              myBalance,          //当前余额
                         double              myInitBalance,      //初始余额
                         double              myBPBase,           //保护基数
                         double              myBPRatio,          //保护系数(%)
                         int                 &myCloseTicket[]    //平仓数组
                        )
{
    if (   myBPRatio>0  //执行余额保护
        && myTS.buy_grp_profit+myTS.sell_grp_profit<0   //有浮亏
        && myBalance-myInitBalance>myBPBase    //余额增量，基数达标
        && -(myTS.buy_grp_profit+myTS.sell_grp_profit)/(myBalance-myInitBalance)<myBPRatio  //系数达标
       )
    {
        int i=0;
        ArrayInitialize(myCloseTicket,-1); //平仓数组初始化
        for (int cnt=0;cnt<ArraySize(myTO);cnt++)
        {
            myCloseTicket[i]=myTO[cnt].ticket;
            i++;
        }
        if (myCloseTicket[0]>0) return(true);
    }
    return(false);
}

/*
函    数:k线平均高度
输出参数:-1 无输出
算    法:
取最近ShiftNum个k线，计算实体均高
*/
int egBarAvgHigh(int ShiftNum  //k线数量
                )
{
    double myTotal=0;
    if (ShiftNum>Bars) ShiftNum=Bars-1;
    for (int cnt=0;cnt<ShiftNum;cnt++)
    {
        myTotal=myTotal+MathAbs(Open[cnt]-Close[cnt]);
    }
    if (ShiftNum>0) return((int)((myTotal/ShiftNum)/Point()));
    return(-1);
}

/*
函    数:基于起点的k线平均高度
输出参数:-1 无输出
算    法:
取从myPos开始最近ShiftNum个k线，计算实体均高
*/
int egBarAvgHighByPos(int myPos, //k线起点
                      int ShiftNum  //k线数量
                     )
{
    double myTotal=0;
    if (myPos+ShiftNum>Bars) ShiftNum=Bars-1;
    for (int cnt=myPos;cnt<myPos+ShiftNum;cnt++)
    {
        myTotal=myTotal+MathAbs(Open[cnt]-Close[cnt]);
    }
    if (ShiftNum>0) return((int)((myTotal/ShiftNum)/Point()));
    return(-1);
}

/*
函    数:条件平仓
输出参数:false-平仓失败,true-平仓成功
算    法:
*/
bool egCloseByCondition(TradesOrders &myTO[], //持仓单源数组
                        int &myCloseTicket[], //平仓单目标数组
                        int myType, //平仓单类型 0-Buy,1-Sell,2-BuyLimit,3-SellLimit,4-BuyStop,5-SellStop,9-所有
                        int myMode //平仓模式 0=浮赢,2=浮亏,9=任意
                       )
{
    int i=0,j=0;  //循环计数器变量
    ArrayInitialize(myCloseTicket,-1);
    for (i=0;i<ArraySize(myTO);i++)
    {
        if (   myTO[i].ticket>0 //有效持仓单
            //平仓单类型
            && (   myTO[i].type==myType //指定类型
                || myType==9 //所有类型
               )
            //平仓模式
            && (   (myMode==0 && myTO[i].profit>0) //浮赢
                || (myMode==1 && myTO[i].profit<0) //浮亏
                || myMode==9 //任意
               )
           )
        {
            myCloseTicket[j]=myTO[i].ticket;
            j++;
        }
    }
    if (myCloseTicket[0]>0) return(true);
    return(false);
}

/*
函    数:仪表盘开启/关闭
输出参数:true-开启，false-关闭
算    法:
*/
bool egDashboard(bool               isout,      //仪表盘显示开关
                 TradesStatistical  &myTS,      //持仓单统计数据
                 HistoryStatistical &myHS,      //历史单统计数据
                 AccountInfo        &myAI,      //账户信息
                 SymbolInfo         &mySI,      //商品信息
                 color              bkcolor,    //背景色
                 int                x,          //x起始坐标
                 int                y,          //y起始坐标
                 int                h           //仪表盘高度
                )
{
    if (!isout) return(false);
    color   myInfoColor=clrBlue;
    string  myfont="Arial";
    string  myNote="";
//--- 仪表盘外框
    egButtonOut(true,0,"btn_retract",0,20,20,15,15,CORNER_RIGHT_UPPER,">","Arial",12,clrRed,bkcolor,bkcolor,false,false,false,true,0);
    egRectangleOut(true,0,"Rec",0,x,y,180,h,bkcolor,BORDER_SUNKEN,CORNER_RIGHT_UPPER,clrRed,STYLE_DOT,4,true,false,true,0);   //实时数据
//--- 货币对名称、报价时间
    egEditOut(true,0,"Symbol",0,x-5,y+5,170,20,mySI.symbol,myfont,12,ALIGN_CENTER,true,CORNER_RIGHT_UPPER,myInfoColor,bkcolor,bkcolor,true,false,true,0);
    egEditOut(true,0,"Time",0,x-5,y+25,170,15,TimeToStr(TimeCurrent(),TIME_DATE|TIME_MINUTES|TIME_SECONDS),myfont,8,ALIGN_CENTER,true,CORNER_RIGHT_UPPER,myInfoColor,bkcolor,bkcolor,true,false,true,0);
//--- Sell组
    //组名
    egEditOut(true,0,"SellGrp",0,x-100,y+40,70,20,"SellGrp",myfont,12,ALIGN_CENTER,true,CORNER_RIGHT_UPPER,clrRed,bkcolor,bkcolor,true,false,true,0);
    //Ask报价
    egEditOut(true,0,"Ask",0,x-100,y+60,70,20,DoubleToStr(mySI.ask,mySI.digits),myfont,11,ALIGN_CENTER,true,CORNER_RIGHT_UPPER,egObjectColor(myTS.sell_grp_profit),bkcolor,bkcolor,true,false,true,0);
    //持仓单数量
    egEditOut(true,0,"SellOrders",0,x-100,y+80,70,15,DoubleToStr(myTS.sell_orders,0)+"  "+DoubleToStr(myTS.selllimit_orders,0)+"  "+DoubleToStr(myTS.sellstop_orders,0),myfont,10,ALIGN_CENTER,true,CORNER_RIGHT_UPPER,egObjectColor(myTS.sell_grp_profit),bkcolor,bkcolor,true,false,true,0);
    //持仓量
    egEditOut(true,0,"SellLots",0,x-100,y+95,70,15,DoubleToStr(myTS.sell_grp_lots,2),myfont,10,ALIGN_CENTER,true,CORNER_RIGHT_UPPER,egObjectColor(myTS.sell_grp_profit),bkcolor,bkcolor,true,false,true,0);
    //持仓利润
    egEditOut(true,0,"SellProfit",0,x-100,y+110,70,15,DoubleToStr(myTS.sell_grp_profit,2),myfont,10,ALIGN_CENTER,true,CORNER_RIGHT_UPPER,egObjectColor(myTS.sell_grp_profit),bkcolor,bkcolor,true,false,true,0);
    //持仓均价
    egEditOut(true,0,"SellAvg",0,x-100,y+125,70,15,DoubleToStr(myTS.sell_grp_avg,mySI.digits),myfont,10,ALIGN_CENTER,true,CORNER_RIGHT_UPPER,egObjectColor(myTS.sell_grp_profit),bkcolor,bkcolor,true,false,true,0);
//--- Buy组
    //组名
    egEditOut(true,0,"BuyGrp",0,x-10,y+40,70,20,"BuyGrp",myfont,12,ALIGN_CENTER,true,CORNER_RIGHT_UPPER,clrGreen,bkcolor,bkcolor,true,false,true,0);
    //Ask报价
    egEditOut(true,0,"Bid",0,x-10,y+60,70,20,DoubleToStr(mySI.bid,mySI.digits),myfont,11,ALIGN_CENTER,true,CORNER_RIGHT_UPPER,egObjectColor(myTS.buy_grp_profit),bkcolor,bkcolor,true,false,true,0);
    //持仓单数量
    egEditOut(true,0,"BuyOrders",0,x-10,y+80,70,15,DoubleToStr(myTS.buy_orders,0)+"  "+DoubleToStr(myTS.buylimit_orders,0)+"  "+DoubleToStr(myTS.buystop_orders,0),myfont,10,ALIGN_CENTER,true,CORNER_RIGHT_UPPER,egObjectColor(myTS.buy_grp_profit),bkcolor,bkcolor,true,false,true,0);
    //持仓量
    egEditOut(true,0,"BuyLots",0,x-10,y+95,70,15,DoubleToStr(myTS.buy_grp_lots,2),myfont,10,ALIGN_CENTER,true,CORNER_RIGHT_UPPER,egObjectColor(myTS.buy_grp_profit),bkcolor,bkcolor,true,false,true,0);
    //持仓利润
    egEditOut(true,0,"BuyProfit",0,x-10,y+110,70,15,DoubleToStr(myTS.buy_grp_profit,2),myfont,10,ALIGN_CENTER,true,CORNER_RIGHT_UPPER,egObjectColor(myTS.buy_grp_profit),bkcolor,bkcolor,true,false,true,0);
    //持仓均价
    egEditOut(true,0,"BuyAvg",0,x-10,y+125,70,15,DoubleToStr(myTS.buy_grp_avg,mySI.digits),myfont,10,ALIGN_CENTER,true,CORNER_RIGHT_UPPER,egObjectColor(myTS.buy_grp_profit),bkcolor,bkcolor,true,false,true,0);
//--- 组风险
    //Sell组
    color   mySellRiskColor=myTS.risk_level_clr_1;
    if (myAI.equity>0 && myTS.sell_grp_risk<0 && -myTS.sell_grp_risk>=myTS.risk_level_value_1 && -myTS.sell_grp_risk<myTS.risk_level_value_2) mySellRiskColor=myTS.risk_level_clr_2;
    if (myAI.equity>0 && myTS.sell_grp_risk<0 && -myTS.sell_grp_risk>=myTS.risk_level_value_2 && -myTS.sell_grp_risk<myTS.risk_level_value_3) mySellRiskColor=myTS.risk_level_clr_3;
    if (myAI.equity>0 && myTS.sell_grp_risk<0 && -myTS.sell_grp_risk>=myTS.risk_level_value_3 && -myTS.sell_grp_risk<myTS.risk_level_value_4) mySellRiskColor=myTS.risk_level_clr_4;
    if (myAI.equity>0 && myTS.sell_grp_risk<0 && -myTS.sell_grp_risk>=myTS.risk_level_value_4) mySellRiskColor=myTS.risk_level_clr_5;
    egEditOut(true,0,"SellRiskV",0,x-100,y+145,70,15,DoubleToStr(myTS.sell_grp_risk*100,2)+"%",myfont,8,ALIGN_CENTER,true,CORNER_RIGHT_UPPER,mySellRiskColor,bkcolor,bkcolor,true,false,true,0);
    egRectangleOut(true,0,"SellRisk",0,x-100,y+160,70,10,mySellRiskColor,BORDER_FLAT,CORNER_RIGHT_UPPER,mySellRiskColor,STYLE_DOT,0,true,false,true,0);
    //Buy组
    color   myBuyRiskColor=myTS.risk_level_clr_1;
    if (myAI.equity>0 && myTS.buy_grp_risk<0 && -myTS.buy_grp_risk>=myTS.risk_level_value_1 && -myTS.buy_grp_risk<myTS.risk_level_value_2) myBuyRiskColor=myTS.risk_level_clr_2;
    if (myAI.equity>0 && myTS.buy_grp_risk<0 && -myTS.buy_grp_risk>=myTS.risk_level_value_2 && -myTS.buy_grp_risk<myTS.risk_level_value_3) myBuyRiskColor=myTS.risk_level_clr_3;
    if (myAI.equity>0 && myTS.buy_grp_risk<0 && -myTS.buy_grp_risk>=myTS.risk_level_value_3 && -myTS.buy_grp_risk<myTS.risk_level_value_4) myBuyRiskColor=myTS.risk_level_clr_4;
    if (myAI.equity>0 && myTS.buy_grp_risk<0 && -myTS.buy_grp_risk>=myTS.risk_level_value_4) myBuyRiskColor=myTS.risk_level_clr_5;
    egEditOut(true,0,"BuyRiskV",0,x-10,y+145,70,15,DoubleToStr(myTS.buy_grp_risk*100,2)+"%",myfont,8,ALIGN_CENTER,true,CORNER_RIGHT_UPPER,myBuyRiskColor,bkcolor,bkcolor,true,false,true,0);
    egRectangleOut(true,0,"BuyRisk",0,x-10,y+160,70,10,myBuyRiskColor,BORDER_FLAT,CORNER_RIGHT_UPPER,myBuyRiskColor,STYLE_DOT,0,true,false,true,0);
    //刻度
    color   myTotalRiskColor=myTS.risk_level_clr_1;
    double  myTotalRisk=0;if (AccountEquity()!=0) myTotalRisk=(myTS.buy_grp_profit+myTS.sell_grp_profit)/AccountEquity();
    if (myAI.equity>0 && myTotalRisk<0 && -myTotalRisk>=myTS.risk_level_value_1 && -myTotalRisk<myTS.risk_level_value_2) myTotalRiskColor=myTS.risk_level_clr_2;
    if (myAI.equity>0 && myTotalRisk<0 && -myTotalRisk>=myTS.risk_level_value_2 && -myTotalRisk<myTS.risk_level_value_3) myTotalRiskColor=myTS.risk_level_clr_3;
    if (myAI.equity>0 && myTotalRisk<0 && -myTotalRisk>=myTS.risk_level_value_3 && -myTotalRisk<myTS.risk_level_value_4) myTotalRiskColor=myTS.risk_level_clr_4;
    if (myAI.equity>0 && myTotalRisk<0 && -myTotalRisk>=myTS.risk_level_value_4) myTotalRiskColor=myTS.risk_level_clr_5;
    egEditOut(true,0,"RiskMark",0,x-5,y+170,170,10,
              DoubleToStr(myTS.risk_level_value_1*100,2)+"%     "+DoubleToStr(myTS.risk_level_value_2*100,2)+"%     "+DoubleToStr(myTS.risk_level_value_3*100,2)+"%     "+DoubleToStr(myTS.risk_level_value_4*100,2)+"%",
              myfont,6,ALIGN_CENTER,true,CORNER_RIGHT_UPPER,myTotalRiskColor,bkcolor,bkcolor,true,false,true,0);
    //以下是4个节点单独显示代码，备用
    //egEditOut(true,0,"BlueRisk",0,x-10,y+170,25,10,DoubleToStr(myTS.risk_level_value_1,2),myfont,6,ALIGN_RIGHT,true,CORNER_RIGHT_UPPER,myTS.risk_level_clr_1,bkcolor,bkcolor,true,false,true,0);
    //egEditOut(true,0,"GreenRisk",0,x-53,y+170,25,10,DoubleToStr(myTS.risk_level_value_2,2),myfont,6,ALIGN_RIGHT,true,CORNER_RIGHT_UPPER,myTS.risk_level_clr_2,bkcolor,bkcolor,true,false,true,0);
    //egEditOut(true,0,"YellowRisk",0,x-106,y+170,25,10,DoubleToStr(myTS.risk_level_value_3,2),myfont,6,ALIGN_RIGHT,true,CORNER_RIGHT_UPPER,myTS.risk_level_clr_3,bkcolor,bkcolor,true,false,true,0);
    //egEditOut(true,0,"RedRisk",0,x-149,y+170,25,10,DoubleToStr(myTS.risk_level_value_4,2),myfont,6,ALIGN_RIGHT,true,CORNER_RIGHT_UPPER,myTS.risk_level_clr_4,bkcolor,bkcolor,true,false,true,0);
    //egEditOut(true,0,"BlackRisk",0,x-145,y+170,25,10,DoubleToStr(myTS.risk_level_value_5,2),myfont,6,ALIGN_RIGHT,true,CORNER_RIGHT_UPPER,myTS.risk_level_clr_5,bkcolor,bkcolor,true,false,true,0);
//--- 统计信息
    egRectangleOut(true,0,"Rec1",0,x+210,y,210,h,bkcolor,BORDER_SUNKEN,CORNER_RIGHT_UPPER,clrRed,STYLE_DOT,4,true,false,true,0);   //统计数据
    egEditOut(true,0,"StatisticsInfo",0,x-5+180,y+5,170,25,"交易统计",myfont,12,ALIGN_CENTER,true,CORNER_RIGHT_UPPER,myInfoColor,bkcolor,bkcolor,true,false,true,0);
    //历史总量
    egEditOut(true,0,"LotsTotal",0,x+180,y+40,170,20,DoubleToStr(myHS.buy_lots+myHS.sell_lots,2)+"  历史总量",myfont,8,ALIGN_RIGHT,true,CORNER_RIGHT_UPPER,myInfoColor,bkcolor,bkcolor,true,false,true,0);
    //历史单数
    egEditOut(true,0,"OrdersTotal",0,x+180,y+60,170,20,DoubleToStr(myHS.buy_orders+myHS.sell_orders,0)+"  历史单数",myfont,8,ALIGN_RIGHT,true,CORNER_RIGHT_UPPER,myInfoColor,bkcolor,bkcolor,true,false,true,0);
    //历史盈亏
    egEditOut(true,0,"WinLossTotal",0,x+180,y+80,170,20,DoubleToString(myHS.buy_win_profit+myHS.sell_win_profit,2)+" / "+DoubleToString(myHS.buy_loss_profit+myHS.sell_loss_profit,2)+"  历史盈亏",myfont,8,ALIGN_RIGHT,true,CORNER_RIGHT_UPPER,myInfoColor,bkcolor,bkcolor,true,false,true,0);
    //胜(败)率
    egEditOut(true,0,"WinLossRatio",0,x+180,y+100,170,20,DoubleToString(myHS.win_ratio,4)+" / "+DoubleToString(myHS.loss_ratio,4)+"  胜  败  率",myfont,8,ALIGN_RIGHT,true,CORNER_RIGHT_UPPER,myInfoColor,bkcolor,bkcolor,true,false,true,0);
    //凯利赔率
    egEditOut(true,0,"KellyOdds",0,x+180,y+120,170,20,DoubleToString(myHS.kelly,4)+" / "+DoubleToString(myHS.odds,4)+"  凯利赔率",myfont,8,ALIGN_RIGHT,true,CORNER_RIGHT_UPPER,myInfoColor,bkcolor,bkcolor,true,false,true,0);
    
    //账户余额
    egEditOut(true,0,"Balance",0,x+180,y+140,170,20,DoubleToStr(myAI.balance,2)+"  账户余额",myfont,8,ALIGN_RIGHT,true,CORNER_RIGHT_UPPER,myInfoColor,bkcolor,bkcolor,true,false,true,0);
    //账户净值
    egEditOut(true,0,"Equity",0,x+180,y+160,170,20,DoubleToStr(myAI.equity,2)+"  账户净值",myfont,8,ALIGN_RIGHT,true,CORNER_RIGHT_UPPER,myInfoColor,bkcolor,bkcolor,true,false,true,0);
    //最大持仓
    if (myTS.max_margin<MathAbs(myTS.buy_grp_margin-myTS.sell_grp_margin))
    {
        myTS.max_margin=MathAbs(myTS.buy_grp_margin-myTS.sell_grp_margin);
    }
    if (AccountEquity()!=0) egEditOut(true,0,"MaxMargin",0,x+180,y+180,170,20,DoubleToString(myTS.max_margin,2)+" ("+DoubleToString(myTS.max_margin/AccountEquity()*100,2)+"%)  最大持仓",myfont,8,ALIGN_RIGHT,true,CORNER_RIGHT_UPPER,myInfoColor,bkcolor,bkcolor,true,false,true,0);
    //当前持仓(保证金占用)
    egEditOut(true,0,"FloatingMargin",0,x+180,y+200,170,20,DoubleToString(MathAbs(myTS.buy_grp_margin-myTS.sell_grp_margin),2)+"  当前持仓",myfont,8,ALIGN_RIGHT,true,CORNER_RIGHT_UPPER,myInfoColor,bkcolor,bkcolor,true,false,true,0);
    //最大浮亏
    if (myTS.max_floating_loss>=myTS.buy_grp_profit+myTS.sell_grp_profit && myTS.buy_grp_profit+myTS.sell_grp_profit<0)
    {
        myTS.max_floating_loss=myTS.buy_grp_profit+myTS.sell_grp_profit;
    }
    if (AccountEquity()!=0) egEditOut(true,0,"MaxLoss",0,x+180,y+220,170,20,DoubleToString(myTS.max_floating_loss,2)+" ("+DoubleToString(myTS.max_floating_loss/AccountEquity()*100,2)+"%)  最大浮亏",myfont,8,ALIGN_RIGHT,true,CORNER_RIGHT_UPPER,myInfoColor,bkcolor,bkcolor,true,false,true,0);
    //最大浮盈
    if (myTS.max_floating_profit<myTS.buy_grp_profit+myTS.sell_grp_profit && myTS.buy_grp_profit+myTS.sell_grp_profit>0)
    {
        myTS.max_floating_profit=myTS.buy_grp_profit+myTS.sell_grp_profit;
    }
    if (AccountEquity()!=0) egEditOut(true,0,"MaxProfit",0,x+180,y+240,170,20,DoubleToString(myTS.max_floating_profit,2)+" ("+DoubleToString(myTS.max_floating_profit/AccountEquity()*100,2)+"%)  最大浮赢",myfont,8,ALIGN_RIGHT,true,CORNER_RIGHT_UPPER,myInfoColor,bkcolor,bkcolor,true,false,true,0);
    //浮动利润(不计算税费)
    if (AccountEquity()!=0) egEditOut(true,0,"FloatingProfit",0,x+180,y+260,170,20,DoubleToString(myTS.buy_grp_profit+myTS.sell_grp_profit,2)+" ("+DoubleToString((myTS.buy_grp_profit+myTS.sell_grp_profit)/AccountEquity()*100,2)+"%)  浮动利润",myfont,8,ALIGN_RIGHT,true,CORNER_RIGHT_UPPER,myInfoColor,bkcolor,bkcolor,true,false,true,0);
    //余额增量
    egEditOut(true,0,"AccountIncrement",0,x+180,y+280,170,20,DoubleToStr(myTS.account_increment,2)+"  余额增量",myfont,8,ALIGN_RIGHT,true,CORNER_RIGHT_UPPER,myInfoColor,bkcolor,bkcolor,true,false,true,0);
    GetLastError();  //有这条语句就不会有4201错误，奇怪吧
    return(true);
}

/*
函    数:文件读写
输出参数:true-操作成功，false-操作失败
算    法:
myString输入输出读写内容
*/
bool    egFileRW(string     myString,       //读写结果变量
                 int        type=0,         //操作类型,0-读,1-写
                 string     name="",        //文件名,含路径"\\"
                 int        modifytype=0,   //写方式,0-新建,1-追加
                 int        filetype=8      //文件格式,4-BIN,8-CSV,16-TXT
                )
{
    ResetLastError();
    if (filetype==4)  name=name+".bin"; //如果是csv，文件名加.bin后缀
    if (filetype==8)  name=name+".csv"; //如果是csv，文件名加.csv后缀
    if (filetype==16) name=name+".txt"; //如果是csv，文件名加.txt后缀
    int handle=FileOpen(name,FILE_READ|FILE_WRITE|filetype);
//--- 写变量到文件
    if (   type==1
        && handle!=INVALID_HANDLE
       )
    {
        if (modifytype==0) //新建
        {
            FileSeek(handle,0,SEEK_SET);
            FileWriteString(handle,myString);
        }
        if (modifytype==1) //追加 ok
        {
            FileSeek(handle,0,SEEK_END);
            FileWriteString(handle,"\n"+myString);
        }
        FileClose(handle); 
        return(true);
    }
//--- 读文件到变量
    if (   type==0
        && handle!=INVALID_HANDLE
       )
    {
        while(!FileIsEnding(handle)) 
        { 
            myString=FileReadString(handle,FileReadInteger(handle,INT_VALUE)); 
        } 
        FileClose(handle); 
        return(true);
    }
    return(false);
}

/*
函    数:查找是否有指定注释的订单
输出参数:订单号，-1为没有
算    法:
*/
int egFindCommentOrder(TradesOrders &myTO[],    //持仓单数组
                       string       myComment,  //订单注释
                       int          myType,     //订单类型,9-任意类型
                       int          myMagicNum  //订单特征码,-1全部
                      )
{
    for (int cnt=0;cnt<ArraySize(myTO);cnt++)
    {
        if (   myTO[cnt].comment==myComment
            && (   myTO[cnt].magicnumber==myMagicNum
                || myMagicNum==-1
               )
            && (   myTO[cnt].type==myType
                || myType==9
               )
            
           )
        {
            return(myTO[cnt].ticket);
        }
    }
    return(-1);
}

/*
函    数:查找是否有指定程序识别码的订单
输出参数:订单号，-1为没有
算    法:
*/
int egFindMagicNumberOrder(TradesOrders &myTO[], //持仓单数组
                           int          myMagicNum, //订单特征码,-1全部
                           int          myType //订单类型,9-任意类型
                          )
{
    for (int cnt=0;cnt<ArraySize(myTO);cnt++)
    {
        if (   (   myTO[cnt].magicnumber==myMagicNum
                || myMagicNum==-1
               )
            && (   myTO[cnt].type==myType
                || myType==9
               )
           )
        {
            return(myTO[cnt].ticket);
        }
    }
    return(-1);
}

/*
函    数：金额转换建仓量
输出参数：-1表示转换失败
算    法：
*/
double egFundsToHands(string mySymbol,  //货币对名称
                      double myFunds    //资金基数
                     )
{
    if (MarketInfo(mySymbol,MODE_MARGINREQUIRED)!=0 && MarketInfo(mySymbol,MODE_MINLOT)!=0)
    {
        return(MathRound((myFunds/MarketInfo(mySymbol,MODE_MARGINREQUIRED))/MarketInfo(mySymbol,MODE_MINLOT))*MarketInfo(mySymbol,MODE_MINLOT));
    }
    return(-1);
}

/*
函    数:获取错误信息
输出参数:中文错误信息
算    法:
*/
string egGetErrorInfo(int myErrorNum //错误代码
                     )
{
    if(myErrorNum<=0) return("");
    string myLastErrorStr;
    switch (myErrorNum)
    {
        case 0   :myLastErrorStr="交易报错码:0 没有错误返回";break;
        case 1   :myLastErrorStr="交易报错码:1 可能是反复同价修改,尝试报价整形";break;
        case 2   :myLastErrorStr="交易报错码:2 一般错误";break;
        case 3   :myLastErrorStr="交易报错码:3 交易参数出错";break;
        case 4   :myLastErrorStr="交易报错码:4 交易服务器繁忙";break;
        case 5   :myLastErrorStr="交易报错码:5 客户终端软件版本太旧";break;
        case 6   :myLastErrorStr="交易报错码:6 没有连接交易服务器";break;
        case 7   :myLastErrorStr="交易报错码:7 操作权限不够";break;
        case 8   :myLastErrorStr="交易报错码:8 交易请求过于频繁";break;
        case 9   :myLastErrorStr="交易报错码:9 交易操作故障";break;
        case 64  :myLastErrorStr="交易报错码:64 账户被禁用";break;
        case 65  :myLastErrorStr="交易报错码:65 无效账户";break;
        case 128 :myLastErrorStr="交易报错码:128 交易超时";break;
        case 129 :myLastErrorStr="交易报错码:129 无效报价";break;
        case 130 :myLastErrorStr="交易报错码:130 止盈止损错误";break;
        case 131 :myLastErrorStr="交易报错码:131 交易量错误";break;
        case 132 :myLastErrorStr="交易报错码:132 休市";break;
        case 133 :myLastErrorStr="交易报错码:133 禁止交易,可能是临时休市";break;
        case 134 :myLastErrorStr="交易报错码:134 资金不足";break;
        case 135 :myLastErrorStr="交易报错码:135 报价发生改变";break;
        case 136 :myLastErrorStr="交易报错码:136 建仓价过期";break;
        case 137 :myLastErrorStr="交易报错码:137 经纪商很忙";break;
        case 138 :myLastErrorStr="交易报错码:138 报价使用错误，检查Ask、Bid";break;
        case 139 :myLastErrorStr="交易报错码:139 定单被锁定";break;
        case 140 :myLastErrorStr="交易报错码:140 只允许做买入类型操作";break;
        case 141 :myLastErrorStr="交易报错码:141 请求过多";break;
        case 145 :myLastErrorStr="交易报错码:145 过于接近报价，禁止修改";break;
        case 146 :myLastErrorStr="交易报错码:146 交易繁忙";break;
        case 147 :myLastErrorStr="交易报错码:147 交易期限被经纪商取消";break;
        case 148 :myLastErrorStr="交易报错码:148 持仓单数量超过经纪商的规定";break;
        case 149 :myLastErrorStr="交易报错码:149 禁止对冲";break;
        case 150 :myLastErrorStr="交易报错码:150 FIFO禁则";break;
        case 4000:myLastErrorStr="运行报错码:4000 没有错误返回";break;
        case 4001:myLastErrorStr="运行报错码:4001 函数指针错误";break;
        case 4002:myLastErrorStr="运行报错码:4002 数组越界";break;
        case 4003:myLastErrorStr="运行报错码:4003 调用栈导致内存不足";break;
        case 4004:myLastErrorStr="运行报错码:4004 递归栈溢出";break;
        case 4005:myLastErrorStr="运行报错码:4005 堆栈参数导致内存不足";break;
        case 4006:myLastErrorStr="运行报错码:4006 字符串参数导致内存不足";break;
        case 4007:myLastErrorStr="运行报错码:4007 临时字符串导致内存不足";break;
        case 4008:myLastErrorStr="运行报错码:4008 字符串变量缺少初始化赋值";break;
        case 4009:myLastErrorStr="运行报错码:4009 字符串数组缺少初始化赋值";break;
        case 4010:myLastErrorStr="运行报错码:4010 字符串数组空间不够";break;
        case 4011:myLastErrorStr="运行报错码:4011 字符串太长";break;
        case 4012:myLastErrorStr="运行报错码:4012 因除数为零导致的错误";break;
        case 4013:myLastErrorStr="运行报错码:4013 除数为零";break;
        case 4014:myLastErrorStr="运行报错码:4014 错误的命令";break;
        case 4015:myLastErrorStr="运行报错码:4015 错误的跳转";break;
        case 4016:myLastErrorStr="运行报错码:4016 数组没有初始化";break;
        case 4017:myLastErrorStr="运行报错码:4017 禁止调用DLL ";break;
        case 4018:myLastErrorStr="运行报错码:4018 库文件无法调用";break;
        case 4019:myLastErrorStr="运行报错码:4019 函数无法调用";break;
        case 4020:myLastErrorStr="运行报错码:4020 禁止调用智EA函数";break;
        case 4021:myLastErrorStr="运行报错码:4021 函数中临时字符串返回导致内存不够";break;
        case 4022:myLastErrorStr="运行报错码:4022 系统繁忙";break;
        case 4023:myLastErrorStr="运行报错码:4023 DLL函数调用错误";break;
        case 4024:myLastErrorStr="运行报错码:4024 内部错误";break;
        case 4025:myLastErrorStr="运行报错码:4025 内存不够";break;
        case 4026:myLastErrorStr="运行报错码:4026 指针错误";break;
        case 4027:myLastErrorStr="运行报错码:4027 过多的格式定义";break;
        case 4028:myLastErrorStr="运行报错码:4028 参数计数器越界";break;
        case 4029:myLastErrorStr="运行报错码:4029 数组错误";break;
        case 4030:myLastErrorStr="运行报错码:4030 图表没有响应";break;
        case 4050:myLastErrorStr="运行报错码:4050 参数无效";break;
        case 4051:myLastErrorStr="运行报错码:4051 参数值无效";break;
        case 4052:myLastErrorStr="运行报错码:4052 字符串函数内部错误";break;
        case 4053:myLastErrorStr="运行报错码:4053 数组错误";break;
        case 4054:myLastErrorStr="运行报错码:4054 数组使用不正确";break;
        case 4055:myLastErrorStr="运行报错码:4055 自定义指标错误";break;
        case 4056:myLastErrorStr="运行报错码:4056 数组不兼容";break;
        case 4057:myLastErrorStr="运行报错码:4057 全局变量处理错误";break;
        case 4058:myLastErrorStr="运行报错码:4058 没有发现全局变量";break;
        case 4059:myLastErrorStr="运行报错码:4059 测试模式中函数被禁用";break;
        case 4060:myLastErrorStr="运行报错码:4060 函数未确认";break;
        case 4061:myLastErrorStr="运行报错码:4061 发送邮件错误";break;
        case 4062:myLastErrorStr="运行报错码:4062 String参数错误";break;
        case 4063:myLastErrorStr="运行报错码:4063 Integer参数错误";break;
        case 4064:myLastErrorStr="运行报错码:4064 Double参数错误";break;
        case 4065:myLastErrorStr="运行报错码:4065 数组参数错误";break;
        case 4066:myLastErrorStr="运行报错码:4066 历史数据有错误";break;
        case 4067:myLastErrorStr="运行报错码:4067 交易内部错误";break;
        case 4068:myLastErrorStr="运行报错码:4068 没有发现资源文件";break;
        case 4069:myLastErrorStr="运行报错码:4069 不支持资源文件";break;
        case 4070:myLastErrorStr="运行报错码:4070 重复的资源文件";break;
        case 4071:myLastErrorStr="运行报错码:4071 自定义指标没有初始化";break;
        case 4099:myLastErrorStr="运行报错码:4099 文件末尾";break;
        case 4100:myLastErrorStr="运行报错码:4100 文件错误";break;
        case 4101:myLastErrorStr="运行报错码:4101 文件名称错误";break;
        case 4102:myLastErrorStr="运行报错码:4102 打开文件过多";break;
        case 4103:myLastErrorStr="运行报错码:4103 不能打开文件";break;
        case 4104:myLastErrorStr="运行报错码:4104 不兼容的文件";break;
        case 4105:myLastErrorStr="运行报错码:4105 没有选择定单";break;
        case 4106:myLastErrorStr="运行报错码:4106 未知的商品名称";break;
        case 4107:myLastErrorStr="运行报错码:4107 价格无效";break;
        case 4108:myLastErrorStr="运行报错码:4108 无效订单号";break;
        case 4109:myLastErrorStr="运行报错码:4109 禁止交易，请尝试修改EA属性";break;
        case 4110:myLastErrorStr="运行报错码:4110 禁止买入类型交易，请尝试修改EA属性";break;
        case 4111:myLastErrorStr="运行报错码:4111 禁止卖出类型交易，请尝试修改EA属性";break;
        case 4200:myLastErrorStr="运行报错码:4200 对象已经存在";break;
        case 4201:myLastErrorStr="运行报错码:4201 未知的对象属性";break;
        case 4202:myLastErrorStr="运行报错码:4202 对象不存在";break;
        case 4203:myLastErrorStr="运行报错码:4203 未知的对象类型";break;
        case 4204:myLastErrorStr="运行报错码:4204 对象没有命名";break;
        case 4205:myLastErrorStr="运行报错码:4205 对象坐标错误";break;
        case 4206:myLastErrorStr="运行报错码:4206 没有指定副图窗口";break;
        case 4207:myLastErrorStr="运行报错码:4207 图形对象错误";break;
        case 4210:myLastErrorStr="运行报错码:4210 未知的图表属性";break;
        case 4211:myLastErrorStr="运行报错码:4211 没有发现主图";break;
        case 4212:myLastErrorStr="运行报错码:4212 没有发现副图";break;
        case 4213:myLastErrorStr="运行报错码:4210 图表中没有发现指标";break;
        case 4220:myLastErrorStr="运行报错码:4220 商品选择错误";break;
        case 4250:myLastErrorStr="运行报错码:4250 消息传递错误";break;
        case 4251:myLastErrorStr="运行报错码:4251 消息参数错误";break;
        case 4252:myLastErrorStr="运行报错码:4252 消息被禁用";break;
        case 4253:myLastErrorStr="运行报错码:4253 消息发送过于频繁";break;
        case 5001:myLastErrorStr="运行报错码:5001 文件打开过多";break;
        case 5002:myLastErrorStr="运行报错码:5002 错误的文件名";break;
        case 5003:myLastErrorStr="运行报错码:5003 文件名过长";break;
        case 5004:myLastErrorStr="运行报错码:5004 无法打开文件";break;
        case 5005:myLastErrorStr="运行报错码:5005 文本文件缓冲区分配错误";break;
        case 5006:myLastErrorStr="运行报错码:5006 文无法删除文件";break;
        case 5007:myLastErrorStr="运行报错码:5007 文件句柄无效";break;
        case 5008:myLastErrorStr="运行报错码:5008 文件句柄错误";break;
        case 5009:myLastErrorStr="运行报错码:5009 文件必须设置为FILE_WRITE";break;
        case 5010:myLastErrorStr="运行报错码:5010 文件必须设置为FILE_READ";break;
        case 5011:myLastErrorStr="运行报错码:5011 文件必须设置为FILE_BIN";break;
        case 5012:myLastErrorStr="运行报错码:5012 文件必须设置为FILE_TXT";break;
        case 5013:myLastErrorStr="运行报错码:5013 文件必须设置为FILE_TXT或FILE_CSV";break;
        case 5014:myLastErrorStr="运行报错码:5014 文件必须设置为FILE_CSV";break;
        case 5015:myLastErrorStr="运行报错码:5015 读文件错误";break;
        case 5016:myLastErrorStr="运行报错码:5016 写文件错误";break;
        case 5017:myLastErrorStr="运行报错码:5017 二进制文件必须指定字符串大小";break;
        case 5018:myLastErrorStr="运行报错码:5018 文件不兼容";break;
        case 5019:myLastErrorStr="运行报错码:5019 目录名非文件名";break;
        case 5020:myLastErrorStr="运行报错码:5020 文件不存在";break;
        case 5021:myLastErrorStr="运行报错码:5021 文件不能被重复写入";break;
        case 5022:myLastErrorStr="运行报错码:5022 错误的目录名";break;
        case 5023:myLastErrorStr="运行报错码:5023 目录名不存在";break;
        case 5024:myLastErrorStr="运行报错码:5024 指定文件而不是目录";break;
        case 5025:myLastErrorStr="运行报错码:5025 不能删除目录";break;
        case 5026:myLastErrorStr="运行报错码:5026 不能清空目录";break;
        case 5027:myLastErrorStr="运行报错码:5027 改变数组大小错误";break;
        case 5028:myLastErrorStr="运行报错码:5028 改变字符串大小错误";break;
        case 5029:myLastErrorStr="运行报错码:5029 结构体包含字符串或者动态数组";break;
    }
    return(myLastErrorStr);
}

/*
函    数:插入订单
输出参数:1-允许插入，-1-禁止插入
算    法:
目标建仓价正负间隔范围内没有其他同类型持仓单，允许插入，否则禁止插入
*/
int egInsertOrder(TradesOrders        &myTO[],        //持仓单数组
                  TradesStatistical   &myTS,          //持仓单统计数组
                  int                 myOrderType,    //建仓类型 9-任意类型
                  double              myPrice,        //建仓价
                  double              myInterval      //建仓间隔(报价单位)
                 )
{
    if (myPrice<=0 || myInterval<=0) return(-1);
    int myValue=1;
    if (myTS.buy_orders+myTS.buylimit_orders+myTS.buystop_orders+myTS.sell_orders+myTS.selllimit_orders+myTS.sellstop_orders==0) return(myValue);
    for (int cnt=0;cnt<ArraySize(myTO);cnt++)
    {
        if (   (   myTO[cnt].type==myOrderType
                || myOrderType==9
               )
            && myTO[cnt].ticket>0
            && myTO[cnt].openprice>myPrice-myInterval && myTO[cnt].openprice<myPrice+myInterval
           )
        {
            myValue=-1;
            break;
        }
    }
    return(myValue);
}

/*
函    数:基于基数百分比的建仓量
输出参数:建仓量
算    法:
按指定基数百分比计算建仓量。建仓比例≤0,或不足最小建仓量,按最小建仓量计算
*/
double egLotsByBaseAmount(double myScale,       //建仓比例
                          double myBaseAmount   //基数
                         )
{
    double myLots=egFundsToHands(Symbol(),myBaseAmount*myScale/100);
    if (myLots>SymbolInfoDouble(Symbol(),SYMBOL_VOLUME_MIN)) return(myLots);
    return(SymbolInfoDouble(Symbol(),SYMBOL_VOLUME_MIN));
}

/*
函    数:建仓量整形
输出参数:符合平台规定格式的开仓量。-1表示整形失败
算    法:调整不规范的开仓量数据，按照四舍五入原则及平台开仓量格式规范数据
*/
double egLotsFormat(string   mySymbol,   //货币对名称
                    double   myLots      //需要整形的开仓量
                   )
{
    double myBase=SymbolInfoDouble(mySymbol,SYMBOL_VOLUME_STEP);
    if (myBase!=0) return(MathRound(myLots/myBase)*myBase);
    return(-1);
}

/*
函    数:指定开仓量、开仓价浮动利润
输出参数:当前报价利润
算    法:
*/
double egLotsOpenpriceToProfit(string    mySymbol,       //货币对名称
                               double    mySpecifyLots,  //指定开仓量
                               double    mySpecifyPrice, //指定开仓价
                               int       mySpecifyType   //指定类型,买入或者卖出
                              )
{
    double myReturn=0;
    //买入类型
    if (mySpecifyType==OP_BUY)
    {
        return(((Bid-mySpecifyPrice)/Point)*MarketInfo(mySymbol,MODE_TICKVALUE)*mySpecifyLots);
    }
    //卖出类型
    if (mySpecifyType==OP_SELL)
    {
        return(((mySpecifyPrice-Ask)/Point)*MarketInfo(mySymbol,MODE_TICKVALUE)*mySpecifyLots);
    }
    return(0);
}

/*
函    数:指定开仓量、利润转点数
输出参数:点数
算    法:
*/
int egLotsProfitToPoint(string    mySymbol,        //货币对名称
                        double    mySpecifyLots,   //指定开仓量
                        double    mySpecifyProfit  //指定利润
                       )
{
    //点数=指定利润/(指定建仓量*单点价值)
    if (mySpecifyLots!=0 && MarketInfo(mySymbol,MODE_TICKVALUE)!=0) return(mySpecifyProfit/(mySpecifyLots*MarketInfo(mySymbol,MODE_TICKVALUE)));
    return(0);
}

/*
函    数:报价附近2张单的单号
输出参数:
算    法:
*/
void egNearestOrderTicket(TradesOrders        &myTO[],       //持仓单数组
                          TradesStatistical   &myTS,         //持仓单统计数组
                          int                 myOrderType,   //建仓类型 9-任意类型
                          double              myBasePrice,   //基准价
                          int                 &myNearestTicket[2]  //上下订单单号
                         )
{
    myNearestTicket[0]=0;myNearestTicket[1]=0;
    if (myBasePrice<0 || myTS.buy_orders+myTS.buylimit_orders+myTS.buystop_orders+myTS.sell_orders+myTS.selllimit_orders+myTS.sellstop_orders==0) return;
//--- 基准价在最高价之上
    if (   egOrderLocationSearch(myTO,myTS.symbol,1,myOrderType,-1,1)>0 //有最高价
        && myBasePrice>myTO[egOrderPos(myTO,egOrderLocationSearch(myTO,myTS.symbol,1,myOrderType,-1,1))].openprice //基准价在最高价之上
       )
    {
        myNearestTicket[1]=egOrderLocationSearch(myTO,myTS.symbol,1,myOrderType,-1,1);
        return;
    }
//--- 基准价在最低价之下
    if (   egOrderLocationSearch(myTO,myTS.symbol,1,myOrderType,-1,-1)>0 //有最低价
        && myBasePrice<myTO[egOrderPos(myTO,egOrderLocationSearch(myTO,myTS.symbol,1,myOrderType,-1,-1))].openprice //基准价在最低价之下
       )
    {
        myNearestTicket[0]=egOrderLocationSearch(myTO,myTS.symbol,1,myOrderType,-1,-1);
        return;
    }
//--- 基准价在报价之间
    for (int cnt=1;cnt<ArraySize(myTO);cnt++)
    {
        //报价在两个订单之间
        if (   egOrderLocationSearch(myTO,myTS.symbol,1,myOrderType,-1,cnt)>0
            && egOrderLocationSearch(myTO,myTS.symbol,1,myOrderType,-1,cnt+1)>0
            && myBasePrice<myTO[egOrderPos(myTO,egOrderLocationSearch(myTO,myTS.symbol,1,myOrderType,-1,cnt))].openprice
            && myBasePrice>myTO[egOrderPos(myTO,egOrderLocationSearch(myTO,myTS.symbol,1,myOrderType,-1,cnt+1))].openprice
           )
        {
            myNearestTicket[0]=egOrderLocationSearch(myTO,myTS.symbol,1,myOrderType,-1,cnt);
            myNearestTicket[1]=egOrderLocationSearch(myTO,myTS.symbol,1,myOrderType,-1,cnt+1);
            break;
        }
    }
    return;
}

/*
函    数:持仓商品
输出参数:商品名称数组
算    法:
*/
void egTradingSymbols(string   &mySymbol[]) //商品名称数组
{
    int myNum=0; //持仓商品数量
//--- 有持仓单，统计商品数量
    if (OrdersTotal()>0)
    {
        int i=0,j=0,k; //循环计数器变量
        ArrayResize(mySymbol,1);mySymbol[0]=""; //初始化商品名称数组
        ArrayResize(mySymbol,OrdersTotal()); //重定义商品名称数组尺寸
        string mySymbol_temp[];ArrayResize(mySymbol_temp,OrdersTotal()); //重定义商品名称临时数组尺寸
        //构建商品名称临时数组
        for (i=0;i<OrdersTotal();i++)
        {
            if (OrderSelect(i,SELECT_BY_POS,MODE_TRADES))
            {
                mySymbol_temp[i]=OrderSymbol();
            }
        }
        //去重商品名称数组
        for (i=0;i<OrdersTotal();i++) //按顺序在临时数组取商品名称
        {
            k=0;
            for (j=0;j<OrdersTotal();j++) //累计该商品在临时数组中数量
            {
                if (mySymbol_temp[i]==mySymbol[j]) k++;
                //mySymbol[myNum]=mySymbol_temp[i];
            }
            if (k==0)
            {
                mySymbol[myNum]=mySymbol_temp[i];
                myNum++;
            }
        }
        ArrayResize(mySymbol,myNum); //重定义商品名称数组尺寸
    }
    return;
}

/*
函    数:双向对冲
输出参数:true--成功,false--不成功
算    法:
双向持仓,整体盈利,全体清仓
*/
bool egODHR(TradesOrders            &myTradingOrders[],         //持仓单数组
            TradesStatistical       &myTradingStatistical,      //持仓单统计数组
            int                     &myCloseTicket[],           //平仓数组
            double                  myBudgetRate,               //对冲平衡系数
            string                  myNote                      //输出信息
           )
{
    if (myTradingStatistical.buy_orders==0 || myTradingStatistical.sell_orders==0) return(false);
    int cnt=0,i=0;  //循环计数器变量
    double  myTempTake=0,myTempLoss=0;  //浮动盈利、亏损变量
    ArrayInitialize(myCloseTicket,-1); //平仓数组初始化
    for (cnt=0;cnt<ArraySize(myTradingOrders);cnt++)
    {
        if (myTradingOrders[cnt].profit>0)
        {
            myTempTake=myTempTake+myTradingOrders[cnt].profit;
            myCloseTicket[i]=myTradingOrders[cnt].ticket;i++;
        }
        if (myTradingOrders[cnt].profit<=0)
        {
            myTempLoss=myTempLoss+myTradingOrders[cnt].profit;
            myCloseTicket[i]=myTradingOrders[cnt].ticket;i++;
        }
    }
    if (myTempTake+myTempLoss*myBudgetRate>0 && myTempLoss<0)
    {
        Print(myNote);
        return(true);
    }
    ArrayInitialize(myCloseTicket,-1); //平仓数组初始化
    return(false);
}

/*
函    数:双向对冲:m带n
输出参数:true--成功,false--不成功
算    法:
赢利组m张及以内数量的赢利单可与亏损组n张亏损单按系数对冲平仓
分为最小盈亏mn对冲和最大盈亏对冲两种模式
*/
bool egODHR_mn(TradesOrders &myTO[],          //持仓单数组
               SymbolInfo   &mySI,            //商品信息变量
               TradesStatistical   &myTS,     //持仓单统计数组
               int          &myCloseTicket[], //平仓数组
               int          myODHRType,       //平仓单类型
               int          mm,               //最大赢利单数量  数量在范围内参与对冲
               int          m,                //最小赢利单数量  数量不够不执行
               int          n,                //亏损单数量  数量不够不执行
               int          myMode,           //对冲模式 0=最小盈亏,1=最大盈亏,2=距离最近,3=距离最远
               double       myBudgetRate      //对冲平衡系数 负数为金额
              )
{
    int i=0,j=0,k=0; //循环计数器变量
    int TLNum[2]; //盈亏单数量  0-赢利单数量，1-亏损单数量
    double ProfitTicket[][2]; //赢利单  0=订单号,1=订单利润
    double LossTicket[][2]; //亏损单  0=订单号,1=订单利润
    double Total_Profit=0; //盈利累计
    double Total_Loss=0; //亏损累计
    int myNearestTicket[2]; //报价最近持仓单单号
    int myNearestPos=0; //最近亏损持仓单在数组中的序号
    ArrayInitialize(myNearestTicket,0);
    ArrayInitialize(myCloseTicket,0);
//--- 赢利组为Buy
    if (myODHRType==OP_BUY)
    {
        ArrayInitialize(TLNum,0);
        Total_Profit=0;Total_Loss=0;
    //--- 检测盈亏单数量是否满足mn
        for (i=0;i<ArraySize(myTO);i++)
        {
            if (myTO[i].type==OP_BUY  && myTO[i].profit>0) TLNum[0]++; //赢利单数量
            if (myTO[i].type==OP_SELL && myTO[i].profit<0) TLNum[1]++; //亏损单数量
        }
        //赢利单小于m,或者亏损单数量小于n，不执行
        if (TLNum[0]<m || TLNum[1]<n) return(false);
        //初始化盈亏订单号数组
        ArrayResize(ProfitTicket,mm);ArrayInitialize(ProfitTicket,0);
        ArrayResize(LossTicket,n);ArrayInitialize(LossTicket,0);
    //--- myMode=0  最小盈亏
        if (myMode==0)
        {
            k=0;j=0;
            //Sell从亏损最小递增
            for (i=1;i<=n;i++)
            {
                if (egOrderLocationSearch(myTO,mySI.symbol,3,OP_SELL,-1,-i)>0)
                {
                    LossTicket[j][0]=egOrderLocationSearch(myTO,mySI.symbol,3,OP_SELL,-1,-i);
                    LossTicket[j][1]=myTO[egOrderPos(myTO,(int)LossTicket[j][0])].profit;
                    Total_Loss+=LossTicket[j][1];
                    myCloseTicket[k]=(int)LossTicket[j][0];
                    j++;k++;
                }
            }
            if (myCloseTicket[0]==0) return(false); //没有亏损单，不执行
            //Buy从盈利最小递增
            j=0;
            for (i=1;i<=mm;i++)
            {
                //满足对冲条件，退出循环
                if (   (myBudgetRate>=0 && Total_Profit+Total_Loss*myBudgetRate>0)
                    || (myBudgetRate<0  && Total_Profit+Total_Loss+myBudgetRate>0)
                   )
                {
                    return(true);
                }
                //赢利单累计
                if (egOrderLocationSearch(myTO,mySI.symbol,2,OP_BUY,-1,-i)>0) 
                {
                    ProfitTicket[j][0]=egOrderLocationSearch(myTO,mySI.symbol,2,OP_BUY,-1,-i);
                    ProfitTicket[j][1]=myTO[egOrderPos(myTO,(int)ProfitTicket[j][0])].profit;
                    Total_Profit+=ProfitTicket[j][1];
                    myCloseTicket[k]=(int)ProfitTicket[j][0];
                    j++;k++;
                }
            }
        }
    //--- myMode=1  最大盈亏
        if (myMode==1)
        {
            k=0;j=0;
            //Sell从亏损最大递减
            for (i=1;i<=n;i++)
            {
                if (egOrderLocationSearch(myTO,mySI.symbol,3,OP_SELL,-1,i)>0)
                {
                    LossTicket[j][0]=egOrderLocationSearch(myTO,mySI.symbol,3,OP_SELL,-1,i);
                    LossTicket[j][1]=myTO[egOrderPos(myTO,(int)LossTicket[j][0])].profit;
                    Total_Loss+=LossTicket[j][1];
                    myCloseTicket[k]=(int)LossTicket[j][0];
                    j++;k++;
                }
            }
            if (myCloseTicket[0]==0) return(false); //没有亏损单，不执行
            //Buy从盈利最大递减
            j=0;
            for (i=1;i<=mm;i++)
            {
                //满足对冲条件，退出循环
                if (   (myBudgetRate>=0 && Total_Profit+Total_Loss*myBudgetRate>0)
                    || (myBudgetRate<0  && Total_Profit+Total_Loss+myBudgetRate>0)
                   )
                {
                    return(true);
                }
                //赢利单累计
                if (egOrderLocationSearch(myTO,mySI.symbol,2,OP_BUY,-1,i)>0)
                {
                    ProfitTicket[j][0]=egOrderLocationSearch(myTO,mySI.symbol,2,OP_BUY,-1,i);
                    ProfitTicket[j][1]=myTO[egOrderPos(myTO,(int)ProfitTicket[j][0])].profit;
                    Total_Profit+=ProfitTicket[j][1];
                    myCloseTicket[k]=(int)ProfitTicket[j][0];
                    j++;k++;
                }
            }
        }
/*
    //--- myMode=2  距离最近
        if (myMode==2)
        {
            k=0;
            //距离最近的亏损Sell单
            egNearestOrderTicket(myTO,myTS,OP_SELL,mySI.bid,myNearestTicket);
            if (myNearestTicket[1]==0) return(false); //没有亏损单，不执行
            myNearestPos=egOrderPos(myTO,myNearestTicket[1]);
            j=0;
            for (i=1;i<=n;i++)
            {
                if (egOrderLocationSearch(myTO,mySI.symbol,3,OP_SELL,-1,i)>0) //从亏损最大递减
                {
                    LossTicket[j][0]=egOrderLocationSearch(myTO,mySI.symbol,3,OP_SELL,-1,i);
                    LossTicket[j][1]=myTO[egOrderPos(myTO,(int)LossTicket[j][0])].profit;
                    Total_Loss+=LossTicket[j][1];
                    myCloseTicket[k]=(int)LossTicket[j][0];
                    j++;k++;
                }
            }
            if (myCloseTicket[0]==0) return(false); //没有亏损单，不执行
            //最大的赢利Buy单
            j=0;
            for (i=1;i<=m;i++)
            {
                //满足对冲条件，退出循环
                if (   (myBudgetRate>=0 && Total_Profit+Total_Loss*myBudgetRate>0)
                    || (myBudgetRate<0  && Total_Profit+Total_Loss+myBudgetRate>0)
                   )
                {
                    return(true);
                }
                //赢利单累计
                if (egOrderLocationSearch(myTO,mySI.symbol,2,OP_BUY,-1,i)>0) //从盈利最大递减
                {
                    ProfitTicket[j][0]=egOrderLocationSearch(myTO,mySI.symbol,2,OP_BUY,-1,i);
                    ProfitTicket[j][1]=myTO[egOrderPos(myTO,(int)ProfitTicket[j][0])].profit;
                    Total_Profit+=ProfitTicket[j][1];
                    myCloseTicket[k]=(int)ProfitTicket[j][0];
                    j++;k++;
                }
            }
        }
*/
    //--- myMode=3  距离最远
        if (myMode==3)
        {
            k=0;j=0;
            //Sell从距离最远递减
            for (i=1;i<=n;i++)
            {
                if (   egOrderLocationSearch(myTO,mySI.symbol,1,OP_SELL,-1,-i)>0
                    && myTO[egOrderPos(myTO,egOrderLocationSearch(myTO,mySI.symbol,1,OP_SELL,-1,-i))].profit<0
                   )
                {
                    LossTicket[j][0]=egOrderLocationSearch(myTO,mySI.symbol,1,OP_SELL,-1,-i);
                    LossTicket[j][1]=myTO[egOrderPos(myTO,(int)LossTicket[j][0])].profit;
                    Total_Loss+=LossTicket[j][1];
                    myCloseTicket[k]=(int)LossTicket[j][0];
                    j++;k++;
                }
            }
            if (myCloseTicket[0]==0) return(false); //没有亏损单，不执行
            //Buy从距离最远递减
            j=0;
            for (i=1;i<=mm;i++)
            {
                //满足对冲条件，退出循环
                if (   (myBudgetRate>=0 && Total_Profit+Total_Loss*myBudgetRate>0)
                    || (myBudgetRate<0  && Total_Profit+Total_Loss+myBudgetRate>0)
                   )
                {
                    return(true);
                }
                //赢利单累计
                if (   egOrderLocationSearch(myTO,mySI.symbol,1,OP_BUY,-1,-i)>0
                    && myTO[egOrderPos(myTO,egOrderLocationSearch(myTO,mySI.symbol,1,OP_BUY,-1,-i))].profit>0
                   )
                {
                    ProfitTicket[j][0]=egOrderLocationSearch(myTO,mySI.symbol,1,OP_BUY,-1,-i);
                    ProfitTicket[j][1]=myTO[egOrderPos(myTO,(int)ProfitTicket[j][0])].profit;
                    Total_Profit+=ProfitTicket[j][1];
                    myCloseTicket[k]=(int)ProfitTicket[j][0];
                    j++;k++;
                }
            }
        }
    }
//--- 赢利组为Sell
    if (myODHRType==OP_SELL)
    {
        ArrayInitialize(TLNum,0);
        Total_Profit=0;Total_Loss=0;
    //--- 检测盈亏单数量是否满足mn
        for (i=0;i<ArraySize(myTO);i++)
        {
            if (myTO[i].type==OP_SELL && myTO[i].profit>0) TLNum[0]++; //赢利单数量
            if (myTO[i].type==OP_BUY  && myTO[i].profit<0) TLNum[1]++; //亏损单数量
        }
        //赢利单小于m,或者亏损单数量小于n，不执行
        if (TLNum[0]<m || TLNum[1]<n) return(false);
        //初始化盈亏订单号数组
        ArrayResize(ProfitTicket,mm);ArrayInitialize(ProfitTicket,0);
        ArrayResize(LossTicket,n);ArrayInitialize(LossTicket,0);
    //--- myMode=0  最小盈亏
        if (myMode==0)
        {
            k=0;j=0;
            //Buy从亏损最小递增
            for (i=1;i<=n;i++)
            {
                if (egOrderLocationSearch(myTO,mySI.symbol,3,OP_BUY,-1,-i)>0)
                {
                    LossTicket[j][0]=egOrderLocationSearch(myTO,mySI.symbol,3,OP_BUY,-1,-i);
                    LossTicket[j][1]=myTO[egOrderPos(myTO,(int)LossTicket[j][0])].profit;
                    Total_Loss+=LossTicket[j][1];
                    myCloseTicket[k]=(int)LossTicket[j][0];
                    j++;k++;
                }
            }
            if (myCloseTicket[0]==0) return(false); //没有亏损单，不执行
            //Sell从盈利最小递增
            j=0;
            for (i=1;i<=mm;i++)
            {
                //满足对冲条件，退出循环
                //满足对冲条件，退出循环
                if (   (myBudgetRate>=0 && Total_Profit+Total_Loss*myBudgetRate>0)
                    || (myBudgetRate<0  && Total_Profit+Total_Loss+myBudgetRate>0)
                   )
                {
                    return(true);
                }
                //赢利单累计
                if (egOrderLocationSearch(myTO,mySI.symbol,2,OP_SELL,-1,-i)>0)
                {
                    ProfitTicket[j][0]=egOrderLocationSearch(myTO,mySI.symbol,2,OP_SELL,-1,-i);
                    ProfitTicket[j][1]=myTO[egOrderPos(myTO,(int)ProfitTicket[j][0])].profit;
                    Total_Profit+=ProfitTicket[j][1];
                    myCloseTicket[k]=(int)ProfitTicket[j][0];
                    j++;k++;
                }
            }
        }
    //--- myMode=1  最大盈亏
        if (myMode==1)
        {
            k=0;j=0;
            //Buy从亏损最大递减
            for (i=1;i<=n;i++)
            {
                if (egOrderLocationSearch(myTO,mySI.symbol,3,OP_BUY,-1,i)>0)
                {
                    LossTicket[j][0]=egOrderLocationSearch(myTO,mySI.symbol,3,OP_BUY,-1,i);
                    LossTicket[j][1]=myTO[egOrderPos(myTO,(int)LossTicket[j][0])].profit;
                    Total_Loss+=LossTicket[j][1];
                    myCloseTicket[k]=(int)LossTicket[j][0];
                    j++;k++;
                }
            }
            if (myCloseTicket[0]==0) return(false); //没有亏损单，不执行
            //Sell从盈利最大递减
            j=0;
            for (i=1;i<=mm;i++)
            {
                //满足对冲条件，退出循环
                if (   (myBudgetRate>=0 && Total_Profit+Total_Loss*myBudgetRate>0)
                    || (myBudgetRate<0  && Total_Profit+Total_Loss+myBudgetRate>0)
                   )
                {
                    return(true);
                }
                //赢利单累计
                if (egOrderLocationSearch(myTO,mySI.symbol,2,OP_SELL,-1,i)>0)
                {
                    ProfitTicket[j][0]=egOrderLocationSearch(myTO,mySI.symbol,2,OP_SELL,-1,i);
                    ProfitTicket[j][1]=myTO[egOrderPos(myTO,(int)ProfitTicket[j][0])].profit;
                    Total_Profit+=ProfitTicket[j][1];
                    myCloseTicket[k]=(int)ProfitTicket[j][0];
                    j++;k++;
                }
            }
        }
/*
    //--- myMode=2  距离最近
        if (myMode==2)
        {
            k=0;
            //距离最近的亏损Sell单
            egNearestOrderTicket(myTO,myTS,OP_SELL,mySI.bid,myNearestTicket);
            if (myNearestTicket[1]==0) return(false); //没有亏损单，不执行
            myNearestPos=egOrderPos(myTO,myNearestTicket[1]);
            j=0;
            for (i=1;i<=n;i++)
            {
                if (egOrderLocationSearch(myTO,mySI.symbol,3,OP_SELL,-1,i)>0) //从亏损最大递减
                {
                    LossTicket[j][0]=egOrderLocationSearch(myTO,mySI.symbol,3,OP_SELL,-1,i);
                    LossTicket[j][1]=myTO[egOrderPos(myTO,(int)LossTicket[j][0])].profit;
                    Total_Loss+=LossTicket[j][1];
                    myCloseTicket[k]=(int)LossTicket[j][0];
                    j++;k++;
                }
            }
            if (myCloseTicket[0]==0) return(false); //没有亏损单，不执行
            //最大的赢利Buy单
            j=0;
            for (i=1;i<=m;i++)
            {
                //满足对冲条件，退出循环
                if (   (myBudgetRate>=0 && Total_Profit+Total_Loss*myBudgetRate>0)
                    || (myBudgetRate<0  && Total_Profit+Total_Loss+myBudgetRate>0)
                   )
                {
                    return(true);
                }
                //赢利单累计
                if (egOrderLocationSearch(myTO,mySI.symbol,2,OP_BUY,-1,i)>0) //从盈利最大递减
                {
                    ProfitTicket[j][0]=egOrderLocationSearch(myTO,mySI.symbol,2,OP_BUY,-1,i);
                    ProfitTicket[j][1]=myTO[egOrderPos(myTO,(int)ProfitTicket[j][0])].profit;
                    Total_Profit+=ProfitTicket[j][1];
                    myCloseTicket[k]=(int)ProfitTicket[j][0];
                    j++;k++;
                }
            }
        }
*/
    //--- myMode=3  距离最远
        if (myMode==3)
        {
            k=0;j=0;
            //Buy从距离最远递减
            for (i=1;i<=n;i++)
            {
                if (   egOrderLocationSearch(myTO,mySI.symbol,1,OP_BUY,-1,i)>0
                    && myTO[egOrderPos(myTO,egOrderLocationSearch(myTO,mySI.symbol,1,OP_BUY,-1,i))].profit<0
                   )
                {
                    LossTicket[j][0]=egOrderLocationSearch(myTO,mySI.symbol,1,OP_BUY,-1,i);
                    LossTicket[j][1]=myTO[egOrderPos(myTO,(int)LossTicket[j][0])].profit;
                    Total_Loss+=LossTicket[j][1];
                    myCloseTicket[k]=(int)LossTicket[j][0];
                    j++;k++;
                }
            }
            if (myCloseTicket[0]==0) return(false); //没有亏损单，不执行
            //Sell从距离最远递减
            j=0;
            for (i=1;i<=mm;i++)
            {
                //满足对冲条件，退出循环
                if (   (myBudgetRate>=0 && Total_Profit+Total_Loss*myBudgetRate>0)
                    || (myBudgetRate<0  && Total_Profit+Total_Loss+myBudgetRate>0)
                   )
                {
                    return(true);
                }
                //赢利单累计
                if (   egOrderLocationSearch(myTO,mySI.symbol,1,OP_SELL,-1,i)>0
                    && myTO[egOrderPos(myTO,egOrderLocationSearch(myTO,mySI.symbol,1,OP_SELL,-1,i))].profit>0
                   )
                {
                    ProfitTicket[j][0]=egOrderLocationSearch(myTO,mySI.symbol,1,OP_SELL,-1,i);
                    ProfitTicket[j][1]=myTO[egOrderPos(myTO,(int)ProfitTicket[j][0])].profit;
                    Total_Profit+=ProfitTicket[j][1];
                    myCloseTicket[k]=(int)ProfitTicket[j][0];
                    j++;k++;
                }
            }
        }
    }
    ArrayInitialize(myCloseTicket,0);
    return(false);
}

/*
函    数:订单对冲量
输出参数:0-无
算    法:
指定订单开仓价可与目标金额对冲的当前建仓量
*/
double egOrderBudgetLots(SymbolInfo &mySI,          //商品信息变量
                         double     myOrderPrice,   //订单开仓价
                         double     myAmount,       //目标金额
                         double     myPrice         //市场报价
                        )
{
    //myAmount=myLots*MathAbs(myOrderPrice-myPrice)/mySI.point*mySI.trade_tick_value
    //金额=建仓量*价差*单点价值
    double myLots=0;
    if (mySI.point!=0 && MathAbs(myOrderPrice-myPrice)/mySI.point*mySI.trade_tick_value!=0)
    {
        myLots=egLotsFormat(mySI.symbol,myAmount/(MathAbs(myOrderPrice-myPrice)/mySI.point*mySI.trade_tick_value));
    }
    return(myLots);
}

/*
函    数:建仓、加仓
输出参数:true-建仓成功，false-建仓失败
算    法:建仓、加仓
BuyLimit挂单价<=Ask-StopLevel      BuyStop挂单价>=Ask+StopLevel 
SellLimit挂单价>=Bid+StopLevel	    SellStop挂单价<=Bid-StopLevel
*/
bool egOrderCreat(int           myType,         //建仓类型
                  double        myLots,         //建仓量
                  string        myComment,      //订单注释
                  int           myMagicNum,     //程序控制码
                  SymbolInfo    &mySI,          //商品信息
                  double        myPrice         //建仓价
                 )
{
//建仓量不合规 不执行
    if (myLots<=0) return(false);
//正常建仓
    myLots=egLotsFormat(mySI.symbol,myLots);
    if (   myType==OP_BUY
        && OrderSend(mySI.symbol,OP_BUY,myLots,mySI.ask,0,0,0,myComment,myMagicNum,0)>0
       )
    {
        return(true);
    }
    if (   myType==OP_BUYLIMIT
        && myPrice<=mySI.ask-mySI.trade_stop_level*mySI.point
        && OrderSend(mySI.symbol,OP_BUYLIMIT,myLots,myPrice,0,0,0,myComment,myMagicNum,0)>0
       )
    {
        return(true);
    }
    if (   myType==OP_BUYSTOP
        && myPrice>=mySI.ask+mySI.trade_stop_level*mySI.point
        && OrderSend(mySI.symbol,OP_BUYSTOP,myLots,myPrice,0,0,0,myComment,myMagicNum,0)>0
       )
    {
        return(true);
    }
    if (   myType==OP_SELL
        && OrderSend(mySI.symbol,OP_SELL,myLots,mySI.bid,0,0,0,myComment,myMagicNum,0)>0
       )
    {
        return(true);
    }
    if (   myType==OP_SELLLIMIT
        && myPrice>=mySI.bid+mySI.trade_stop_level*mySI.point
        && OrderSend(mySI.symbol,OP_SELLLIMIT,myLots,myPrice,0,0,0,myComment,myMagicNum,0)>0
       )
    {
        return(true);
    }
    if (   myType==OP_SELLSTOP
        && myPrice<=mySI.bid-mySI.trade_stop_level*mySI.point
        && OrderSend(mySI.symbol,OP_SELLSTOP,myLots,myPrice,0,0,0,myComment,myMagicNum,0)>0
       )
    {
        return(true);
    }
    return(false);
}

/*
函    数：订单利润转换点数
输出参数：订单净值点数
算法说明：
*/
int egOrderEquitToPoint(int myTicket    //订单号
                       )
{
    int myPoint=0;
    if (OrderSelect(myTicket,SELECT_BY_TICKET,MODE_TRADES))
    {
        if (OrderType()==OP_BUY)
        {
            myPoint=(int)((Bid-OrderOpenPrice())/Point);
        }
        if (OrderType()==OP_SELL)
        {
            myPoint=(int)((OrderOpenPrice()-Ask)/Point);
        }
    }
    return(myPoint);
}

/*
函    数：持仓单定位搜索
输出参数：订单号，-1表示无订单
算法说明：冒泡
针对指定的订单数组执行按组合条件定位搜索。
*/
int egOrderLocationSearch(TradesOrders   &myTO[],        //持仓单数组
                          string         mySymbol,       //商品名称，Symbol()为当前图表商品名，"*"为所有商品
                          int            mySeekMode,     //排序类型 0-按建仓时间,1-按建仓价,2-按盈利,3-按亏损
                          int            myOrderType,    //订单类型 0-Buy,1-Sell,2-BuyLimit,3-SellLimit,4-BuyStop,5-SellStop,9-所有
                          int            myMagicNum,     //程序识别码，-1-所有订单
                          int            mySerialNumber  //排序1为最大，2为次大，以此类推，-1为最小，-2为次小，以此类推
                         )
{
    int cnt=0,i=0;  //循环计数器变量
    //没有持仓单，不执行
    if (OrdersTotal()<=0) return(-1); 
    egOrdersArraySort(myTO,mySymbol,mySeekMode);
    switch (mySeekMode)
    {
        case 0: //持仓单数组的建仓时间按降序排列
        {
            //按3、4、5条件筛选
            if (mySerialNumber>0) //从大到小
            {
                i=1;
                for (cnt=0;cnt<ArraySize(myTO);cnt++)
                {
                    if (   (mySymbol=="*" || mySymbol==myTO[cnt].symbol) //商品名称
                        && (myOrderType==9 || myOrderType==myTO[cnt].type) //订单类型
                        && (myMagicNum==-1 || myMagicNum==myTO[cnt].magicnumber) //程序识别码
                       )
                    {
                        if (mySerialNumber==i) return(myTO[cnt].ticket); //符合顺序的订单
                        i++; 
                    }
                }
            }
            if (mySerialNumber<0) //从小到大
            {
                i=-1;
                for (cnt=ArraySize(myTO)-1;cnt>=0;cnt--)
                {
                    if (   (mySymbol=="*" || mySymbol==myTO[cnt].symbol) //商品名称
                        && (myOrderType==9 || myOrderType==myTO[cnt].type) //订单类型
                        && (myMagicNum==-1 || myMagicNum==myTO[cnt].magicnumber) //程序识别码
                       )
                    {
                        if (mySerialNumber==i) return(myTO[cnt].ticket); //符合顺序的订单
                        i--; 
                    }
                }
            }
            break;
        }
        case 1: //持仓单数组的建价按降序排列
        {
            //按3、4、5条件筛选
            if (mySerialNumber>0) //从大到小
            {
                i=1;
                for (cnt=0;cnt<ArraySize(myTO);cnt++)
                {
                    if (   (mySymbol=="*" || mySymbol==myTO[cnt].symbol) //商品名称
                        && (myOrderType==9 || myOrderType==myTO[cnt].type) //订单类型
                        && (myMagicNum==-1 || myMagicNum==myTO[cnt].magicnumber) //程序识别码
                       )
                    {
                        if (mySerialNumber==i) return(myTO[cnt].ticket); //符合顺序的订单
                        i++; 
                    }
                }
            }
            if (mySerialNumber<0) //从小到大
            {
                i=-1;
                for (cnt=ArraySize(myTO)-1;cnt>=0;cnt--)
                {
                    if (   (mySymbol=="*" || mySymbol==myTO[cnt].symbol) //商品名称
                        && (myOrderType==9 || myOrderType==myTO[cnt].type) //订单类型
                        && (myMagicNum==-1 || myMagicNum==myTO[cnt].magicnumber) //程序识别码
                       )
                    {
                        if (mySerialNumber==i) return(myTO[cnt].ticket); //符合顺序的订单
                        i--; 
                    }
                }
            }
            break;
        }
        case 2: //持仓单数组的利润按降序排列  浮动盈利
        {
            //按3、4、5条件筛选
            if (mySerialNumber>0) //从大到小
            {
                i=1;
                for (cnt=0;cnt<ArraySize(myTO);cnt++)
                {
                    if (   (mySymbol=="*" || mySymbol==myTO[cnt].symbol) //商品名称
                        && (myOrderType==9 || myOrderType==myTO[cnt].type) //订单类型
                        && (myMagicNum==-1 || myMagicNum==myTO[cnt].magicnumber) //程序识别码
                        && myTO[cnt].profit>0 //浮盈
                       )
                    {
                        if (mySerialNumber==i) return(myTO[cnt].ticket); //符合顺序的订单
                        i++; 
                    }
                }
            }
            if (mySerialNumber<0) //从小到大
            {
                i=-1;
                for (cnt=ArraySize(myTO)-1;cnt>=0;cnt--)
                {
                    if (   (mySymbol=="*" || mySymbol==myTO[cnt].symbol) //商品名称
                        && (myOrderType==9 || myOrderType==myTO[cnt].type) //订单类型
                        && (myMagicNum==-1 || myMagicNum==myTO[cnt].magicnumber) //程序识别码
                        && myTO[cnt].profit>0 //浮盈
                       )
                    {
                        if (mySerialNumber==i) return(myTO[cnt].ticket); //符合顺序的订单
                        i--; 
                    }
                }
            }
            break;
        }
        case 3: //持仓单数组的利润按降序排列  浮动亏损
        {
            //按3、4、5条件筛选
            if (mySerialNumber>0) //从大到小
            {
                i=1;
                for (cnt=ArraySize(myTO)-1;cnt>=0;cnt--)
                {
                    if (   (mySymbol=="*" || mySymbol==myTO[cnt].symbol) //商品名称
                        && (myOrderType==9 || myOrderType==myTO[cnt].type) //订单类型
                        && (myMagicNum==-1 || myMagicNum==myTO[cnt].magicnumber) //程序识别码
                        && myTO[cnt].profit<0 //浮亏
                       )
                    {
                        if (mySerialNumber==i) return(myTO[cnt].ticket); //符合顺序的订单
                        i++; 
                    }
                }
            }
            if (mySerialNumber<0) //从小到大
            {
                i=-1;
                for (cnt=0;cnt<ArraySize(myTO);cnt++)
                {
                    if (   (mySymbol=="*" || mySymbol==myTO[cnt].symbol) //商品名称
                        && (myOrderType==9 || myOrderType==myTO[cnt].type) //订单类型
                        && (myMagicNum==-1 || myMagicNum==myTO[cnt].magicnumber) //程序识别码
                        && myTO[cnt].profit<0 //浮亏
                       )
                    {
                        if (mySerialNumber==i) return(myTO[cnt].ticket); //符合顺序的订单
                        i--; 
                    }
                }
            }
            break;
        }
    }
    return(-1);
}

/*
函    数：历史单定位搜索
输出参数：订单号，-1表示无订单
算法说明：冒泡
针对指定的订单数组执行按组合条件定位搜索。
*/
int egOrderLocationSearchHst(HistoryOrders   &myHO[],        //持仓单数组
                             string          mySymbol,       //商品名称，Symbol()为当前图表商品名，"*"为所有商品
                             int             mySeekMode,     //排序类型 0-按建仓时间,1-按建仓价,2-按盈利,3-按亏损,4-按平仓时间
                             int             myOrderType,    //订单类型 0-Buy,1-Sell,2-BuyLimit,3-SellLimit,4-BuyStop,5-SellStop,9-所有
                             int             myMagicNum,     //程序识别码，-1-所有订单
                             int             mySerialNumber  //排序1为最大，2为次大，以此类推，-1为最小，-2为次小，以此类推
                            )
{
    int cnt=0,i=0;  //循环计数器变量
    //没有历史单，不执行
    if (ArraySize(myHO)<=0) return(-1); 
    egOrdersArraySortHst(myHO,mySymbol,mySeekMode);
    switch (mySeekMode)
    {
        case 0: //持仓单数组的建仓时间按降序排列
        {
            //按3、4、5条件筛选
            if (mySerialNumber>0) //从大到小
            {
                i=1;
                for (cnt=0;cnt<ArraySize(myHO);cnt++)
                {
                    if (   (mySymbol=="*" || mySymbol==myHO[cnt].symbol) //商品名称
                        && (myOrderType==9 || myOrderType==myHO[cnt].type) //订单类型
                        && (myMagicNum==-1 || myMagicNum==myHO[cnt].magicnumber) //程序识别码
                       )
                    {
                        if (mySerialNumber==i) return(myHO[cnt].ticket); //符合顺序的订单
                        i++; 
                    }
                }
            }
            if (mySerialNumber<0) //从小到大
            {
                i=-1;
                for (cnt=ArraySize(myHO)-1;cnt>=0;cnt--)
                {
                    if (   (mySymbol=="*" || mySymbol==myHO[cnt].symbol) //商品名称
                        && (myOrderType==9 || myOrderType==myHO[cnt].type) //订单类型
                        && (myMagicNum==-1 || myMagicNum==myHO[cnt].magicnumber) //程序识别码
                       )
                    {
                        if (mySerialNumber==i) return(myHO[cnt].ticket); //符合顺序的订单
                        i--; 
                    }
                }
            }
            break;
        }
        case 1: //持仓单数组的建价按降序排列
        {
            //按3、4、5条件筛选
            if (mySerialNumber>0) //从大到小
            {
                i=1;
                for (cnt=0;cnt<ArraySize(myHO);cnt++)
                {
                    if (   (mySymbol=="*" || mySymbol==myHO[cnt].symbol) //商品名称
                        && (myOrderType==9 || myOrderType==myHO[cnt].type) //订单类型
                        && (myMagicNum==-1 || myMagicNum==myHO[cnt].magicnumber) //程序识别码
                       )
                    {
                        if (mySerialNumber==i) return(myHO[cnt].ticket); //符合顺序的订单
                        i++; 
                    }
                }
            }
            if (mySerialNumber<0) //从小到大
            {
                i=-1;
                for (cnt=ArraySize(myHO)-1;cnt>=0;cnt--)
                {
                    if (   (mySymbol=="*" || mySymbol==myHO[cnt].symbol) //商品名称
                        && (myOrderType==9 || myOrderType==myHO[cnt].type) //订单类型
                        && (myMagicNum==-1 || myMagicNum==myHO[cnt].magicnumber) //程序识别码
                       )
                    {
                        if (mySerialNumber==i) return(myHO[cnt].ticket); //符合顺序的订单
                        i--; 
                    }
                }
            }
            break;
        }
        case 2: //持仓单数组的利润按降序排列  浮动盈利
        {
            //按3、4、5条件筛选
            if (mySerialNumber>0) //从大到小
            {
                i=1;
                for (cnt=0;cnt<ArraySize(myHO);cnt++)
                {
                    if (   (mySymbol=="*" || mySymbol==myHO[cnt].symbol) //商品名称
                        && (myOrderType==9 || myOrderType==myHO[cnt].type) //订单类型
                        && (myMagicNum==-1 || myMagicNum==myHO[cnt].magicnumber) //程序识别码
                        && myHO[cnt].profit>0 //浮盈
                       )
                    {
                        if (mySerialNumber==i) return(myHO[cnt].ticket); //符合顺序的订单
                        i++; 
                    }
                }
            }
            if (mySerialNumber<0) //从小到大
            {
                i=-1;
                for (cnt=ArraySize(myHO)-1;cnt>=0;cnt--)
                {
                    if (   (mySymbol=="*" || mySymbol==myHO[cnt].symbol) //商品名称
                        && (myOrderType==9 || myOrderType==myHO[cnt].type) //订单类型
                        && (myMagicNum==-1 || myMagicNum==myHO[cnt].magicnumber) //程序识别码
                        && myHO[cnt].profit>0 //浮盈
                       )
                    {
                        if (mySerialNumber==i) return(myHO[cnt].ticket); //符合顺序的订单
                        i--; 
                    }
                }
            }
            break;
        }
        case 3: //持仓单数组的利润按降序排列  浮动亏损
        {
            //按3、4、5条件筛选
            if (mySerialNumber>0) //从大到小
            {
                i=1;
                for (cnt=ArraySize(myHO)-1;cnt>=0;cnt--)
                {
                    if (   (mySymbol=="*" || mySymbol==myHO[cnt].symbol) //商品名称
                        && (myOrderType==9 || myOrderType==myHO[cnt].type) //订单类型
                        && (myMagicNum==-1 || myMagicNum==myHO[cnt].magicnumber) //程序识别码
                        && myHO[cnt].profit<0 //浮亏
                       )
                    {
                        if (mySerialNumber==i) return(myHO[cnt].ticket); //符合顺序的订单
                        i++; 
                    }
                }
            }
            if (mySerialNumber<0) //从小到大
            {
                i=-1;
                for (cnt=0;cnt<ArraySize(myHO);cnt++)
                {
                    if (   (mySymbol=="*" || mySymbol==myHO[cnt].symbol) //商品名称
                        && (myOrderType==9 || myOrderType==myHO[cnt].type) //订单类型
                        && (myMagicNum==-1 || myMagicNum==myHO[cnt].magicnumber) //程序识别码
                        && myHO[cnt].profit<0 //浮亏
                       )
                    {
                        if (mySerialNumber==i) return(myHO[cnt].ticket); //符合顺序的订单
                        i--; 
                    }
                }
            }
            break;
        }
        case 4: //持仓单数组的平仓时间按降序排列
        {
            //按3、4、5条件筛选
            if (mySerialNumber>0) //从大到小
            {
                i=1;
                for (cnt=0;cnt<ArraySize(myHO);cnt++)
                {
                    if (   (mySymbol=="*" || mySymbol==myHO[cnt].symbol) //商品名称
                        && (myOrderType==9 || myOrderType==myHO[cnt].type) //订单类型
                        && (myMagicNum==-1 || myMagicNum==myHO[cnt].magicnumber) //程序识别码
                       )
                    {
                        if (mySerialNumber==i) return(myHO[cnt].ticket); //符合顺序的订单
                        i++; 
                    }
                }
            }
            if (mySerialNumber<0) //从小到大
            {
                i=-1;
                for (cnt=ArraySize(myHO)-1;cnt>=0;cnt--)
                {
                    if (   (mySymbol=="*" || mySymbol==myHO[cnt].symbol) //商品名称
                        && (myOrderType==9 || myOrderType==myHO[cnt].type) //订单类型
                        && (myMagicNum==-1 || myMagicNum==myHO[cnt].magicnumber) //程序识别码
                       )
                    {
                        if (mySerialNumber==i) return(myHO[cnt].ticket); //符合顺序的订单
                        i--; 
                    }
                }
            }
            break;
        }
    }
    return(-1);
}

/*
函    数：持仓单定位
输出参数：持仓单在myTO数组中的位置,-1表示找不到订单
算法说明：
*/
int egOrderPos(TradesOrders     &myTO[],    //持仓单数组
               int              myTicket    //订单号
              )
{
    if (myTicket<=0 || ArraySize(myTO)==0) return(-1);
    for (int cnt=0;cnt<ArraySize(myTO);cnt++)
    {
        if (myTO[cnt].ticket==myTicket) return(cnt);
    }
    return(-1);
}

/*
函    数：历史单定位
输出参数：持仓单在myHO数组中的位置,-1表示找不到订单
算法说明：
*/
int egOrderPosHst(HistoryOrders    &myHO[],    //历史单数组
                  int              myTicket    //订单号
                 )
{
    if (myTicket<=0 || ArraySize(myHO)==0) return(-1);
    for (int cnt=0;cnt<ArraySize(myHO);cnt++)
    {
        if (myHO[cnt].ticket==myTicket) return(cnt);
    }
    return(-1);
}

/*
函    数：持仓单单数组按类型排序
输出参数：
算法说明：冒泡
针对指定的订单数组执行按组合条件降序排序。
*/
void egOrdersArraySort(TradesOrders     &myTO[],    //持仓单数组
                       string           mySymbol,   //商品名称，Symbol()为当前图表商品名，"*"为所有商品
                       int              mySeekMode  //排序类型 0-按建仓时间,1-按建仓价,2、3-按利润
                     )
{
    int myArrayRange=ArraySize(myTO);   //数组边界变量
    int i,j;                            //循环计数器变量
    TradesOrders mySwapArray[1];        //交换数组变量
    switch (mySeekMode)
    {
        case 0: //按建仓时间，结果是降序
        {
            for (i=0;i<myArrayRange;i++)
            {
                for (j=myArrayRange-1;j>i;j--)
                {
                    if (myTO[j].opentime>myTO[j-1].opentime)
                    {
                        mySwapArray[0].ticket     =myTO[j-1].ticket;
                        mySwapArray[0].opentime   =myTO[j-1].opentime;
                        mySwapArray[0].type       =myTO[j-1].type;
                        mySwapArray[0].lots       =myTO[j-1].lots;
                        mySwapArray[0].symbol     =myTO[j-1].symbol;
                        mySwapArray[0].openprice  =myTO[j-1].openprice;
                        mySwapArray[0].stoploss   =myTO[j-1].stoploss;
                        mySwapArray[0].takeprofit =myTO[j-1].takeprofit;
                        mySwapArray[0].commission =myTO[j-1].commission;
                        mySwapArray[0].swap       =myTO[j-1].swap;
                        mySwapArray[0].profit     =myTO[j-1].profit;
                        mySwapArray[0].comment    =myTO[j-1].comment;
                        mySwapArray[0].magicnumber=myTO[j-1].magicnumber;
                        mySwapArray[0].cost       =myTO[j-1].cost;
                        
                        myTO[j-1].ticket     =myTO[j].ticket;
                        myTO[j-1].opentime   =myTO[j].opentime;
                        myTO[j-1].type       =myTO[j].type;
                        myTO[j-1].lots       =myTO[j].lots;
                        myTO[j-1].symbol     =myTO[j].symbol;
                        myTO[j-1].openprice  =myTO[j].openprice;
                        myTO[j-1].stoploss   =myTO[j].stoploss;
                        myTO[j-1].takeprofit =myTO[j].takeprofit;
                        myTO[j-1].commission =myTO[j].commission;
                        myTO[j-1].swap       =myTO[j].swap;
                        myTO[j-1].profit     =myTO[j].profit;
                        myTO[j-1].comment    =myTO[j].comment;
                        myTO[j-1].magicnumber=myTO[j].magicnumber;
                        myTO[j-1].cost       =myTO[j].cost;
                        
                        myTO[j].ticket     =mySwapArray[0].ticket;
                        myTO[j].opentime   =mySwapArray[0].opentime;
                        myTO[j].type       =mySwapArray[0].type;
                        myTO[j].lots       =mySwapArray[0].lots;
                        myTO[j].symbol     =mySwapArray[0].symbol;
                        myTO[j].openprice  =mySwapArray[0].openprice;
                        myTO[j].stoploss   =mySwapArray[0].stoploss;
                        myTO[j].takeprofit =mySwapArray[0].takeprofit;
                        myTO[j].commission =mySwapArray[0].commission;
                        myTO[j].swap       =mySwapArray[0].swap;
                        myTO[j].profit     =mySwapArray[0].profit;
                        myTO[j].comment    =mySwapArray[0].comment;
                        myTO[j].magicnumber=mySwapArray[0].magicnumber;
                        myTO[j].cost       =mySwapArray[0].cost;
                    }
                }
            }
            break;
        }
        case 1: //按建仓价，结果是降序
        {
            for (i=0;i<myArrayRange;i++)
            {
                for (j=myArrayRange-1;j>i;j--)
                {
                    if (myTO[j].openprice>myTO[j-1].openprice)
                    {
                        mySwapArray[0].ticket     =myTO[j-1].ticket;
                        mySwapArray[0].opentime   =myTO[j-1].opentime;
                        mySwapArray[0].type       =myTO[j-1].type;
                        mySwapArray[0].lots       =myTO[j-1].lots;
                        mySwapArray[0].symbol     =myTO[j-1].symbol;
                        mySwapArray[0].openprice  =myTO[j-1].openprice;
                        mySwapArray[0].stoploss   =myTO[j-1].stoploss;
                        mySwapArray[0].takeprofit =myTO[j-1].takeprofit;
                        mySwapArray[0].commission =myTO[j-1].commission;
                        mySwapArray[0].swap       =myTO[j-1].swap;
                        mySwapArray[0].profit     =myTO[j-1].profit;
                        mySwapArray[0].comment    =myTO[j-1].comment;
                        mySwapArray[0].magicnumber=myTO[j-1].magicnumber;
                        mySwapArray[0].cost       =myTO[j-1].cost;
                        
                        myTO[j-1].ticket     =myTO[j].ticket;
                        myTO[j-1].opentime   =myTO[j].opentime;
                        myTO[j-1].type       =myTO[j].type;
                        myTO[j-1].lots       =myTO[j].lots;
                        myTO[j-1].symbol     =myTO[j].symbol;
                        myTO[j-1].openprice  =myTO[j].openprice;
                        myTO[j-1].stoploss   =myTO[j].stoploss;
                        myTO[j-1].takeprofit =myTO[j].takeprofit;
                        myTO[j-1].commission =myTO[j].commission;
                        myTO[j-1].swap       =myTO[j].swap;
                        myTO[j-1].profit     =myTO[j].profit;
                        myTO[j-1].comment    =myTO[j].comment;
                        myTO[j-1].magicnumber=myTO[j].magicnumber;
                        myTO[j-1].cost       =myTO[j].cost;
                        
                        myTO[j].ticket     =mySwapArray[0].ticket;
                        myTO[j].opentime   =mySwapArray[0].opentime;
                        myTO[j].type       =mySwapArray[0].type;
                        myTO[j].lots       =mySwapArray[0].lots;
                        myTO[j].symbol     =mySwapArray[0].symbol;
                        myTO[j].openprice  =mySwapArray[0].openprice;
                        myTO[j].stoploss   =mySwapArray[0].stoploss;
                        myTO[j].takeprofit =mySwapArray[0].takeprofit;
                        myTO[j].commission =mySwapArray[0].commission;
                        myTO[j].swap       =mySwapArray[0].swap;
                        myTO[j].profit     =mySwapArray[0].profit;
                        myTO[j].comment    =mySwapArray[0].comment;
                        myTO[j].magicnumber=mySwapArray[0].magicnumber;
                        myTO[j].cost       =mySwapArray[0].cost;
                    }
                }
            }
            break;
        }
        case 2: //按浮动利润，结果是降序
        {
            for (i=0;i<myArrayRange;i++)
            {
                for (j=myArrayRange-1;j>i;j--)
                {
                    if (myTO[j].profit>myTO[j-1].profit)
                    {
                        mySwapArray[0].ticket     =myTO[j-1].ticket;
                        mySwapArray[0].opentime   =myTO[j-1].opentime;
                        mySwapArray[0].type       =myTO[j-1].type;
                        mySwapArray[0].lots       =myTO[j-1].lots;
                        mySwapArray[0].symbol     =myTO[j-1].symbol;
                        mySwapArray[0].openprice  =myTO[j-1].openprice;
                        mySwapArray[0].stoploss   =myTO[j-1].stoploss;
                        mySwapArray[0].takeprofit =myTO[j-1].takeprofit;
                        mySwapArray[0].commission =myTO[j-1].commission;
                        mySwapArray[0].swap       =myTO[j-1].swap;
                        mySwapArray[0].profit     =myTO[j-1].profit;
                        mySwapArray[0].comment    =myTO[j-1].comment;
                        mySwapArray[0].magicnumber=myTO[j-1].magicnumber;
                        mySwapArray[0].cost       =myTO[j-1].cost;
                        
                        myTO[j-1].ticket     =myTO[j].ticket;
                        myTO[j-1].opentime   =myTO[j].opentime;
                        myTO[j-1].type       =myTO[j].type;
                        myTO[j-1].lots       =myTO[j].lots;
                        myTO[j-1].symbol     =myTO[j].symbol;
                        myTO[j-1].openprice  =myTO[j].openprice;
                        myTO[j-1].stoploss   =myTO[j].stoploss;
                        myTO[j-1].takeprofit =myTO[j].takeprofit;
                        myTO[j-1].commission =myTO[j].commission;
                        myTO[j-1].swap       =myTO[j].swap;
                        myTO[j-1].profit     =myTO[j].profit;
                        myTO[j-1].comment    =myTO[j].comment;
                        myTO[j-1].magicnumber=myTO[j].magicnumber;
                        myTO[j-1].cost       =myTO[j].cost;
                        
                        myTO[j].ticket     =mySwapArray[0].ticket;
                        myTO[j].opentime   =mySwapArray[0].opentime;
                        myTO[j].type       =mySwapArray[0].type;
                        myTO[j].lots       =mySwapArray[0].lots;
                        myTO[j].symbol     =mySwapArray[0].symbol;
                        myTO[j].openprice  =mySwapArray[0].openprice;
                        myTO[j].stoploss   =mySwapArray[0].stoploss;
                        myTO[j].takeprofit =mySwapArray[0].takeprofit;
                        myTO[j].commission =mySwapArray[0].commission;
                        myTO[j].swap       =mySwapArray[0].swap;
                        myTO[j].profit     =mySwapArray[0].profit;
                        myTO[j].comment    =mySwapArray[0].comment;
                        myTO[j].magicnumber=mySwapArray[0].magicnumber;
                        myTO[j].cost       =mySwapArray[0].cost;
                    }
                }
            }
            break;
        }
        case 3: //按浮动利润，结果是降序
        {
            for (i=0;i<myArrayRange;i++)
            {
                for (j=myArrayRange-1;j>i;j--)
                {
                    if (myTO[j].profit>myTO[j-1].profit)
                    {
                        mySwapArray[0].ticket     =myTO[j-1].ticket;
                        mySwapArray[0].opentime   =myTO[j-1].opentime;
                        mySwapArray[0].type       =myTO[j-1].type;
                        mySwapArray[0].lots       =myTO[j-1].lots;
                        mySwapArray[0].symbol     =myTO[j-1].symbol;
                        mySwapArray[0].openprice  =myTO[j-1].openprice;
                        mySwapArray[0].stoploss   =myTO[j-1].stoploss;
                        mySwapArray[0].takeprofit =myTO[j-1].takeprofit;
                        mySwapArray[0].commission =myTO[j-1].commission;
                        mySwapArray[0].swap       =myTO[j-1].swap;
                        mySwapArray[0].profit     =myTO[j-1].profit;
                        mySwapArray[0].comment    =myTO[j-1].comment;
                        mySwapArray[0].magicnumber=myTO[j-1].magicnumber;
                        mySwapArray[0].cost       =myTO[j-1].cost;
                        
                        myTO[j-1].ticket     =myTO[j].ticket;
                        myTO[j-1].opentime   =myTO[j].opentime;
                        myTO[j-1].type       =myTO[j].type;
                        myTO[j-1].lots       =myTO[j].lots;
                        myTO[j-1].symbol     =myTO[j].symbol;
                        myTO[j-1].openprice  =myTO[j].openprice;
                        myTO[j-1].stoploss   =myTO[j].stoploss;
                        myTO[j-1].takeprofit =myTO[j].takeprofit;
                        myTO[j-1].commission =myTO[j].commission;
                        myTO[j-1].swap       =myTO[j].swap;
                        myTO[j-1].profit     =myTO[j].profit;
                        myTO[j-1].comment    =myTO[j].comment;
                        myTO[j-1].magicnumber=myTO[j].magicnumber;
                        myTO[j-1].cost       =myTO[j].cost;
                        
                        myTO[j].ticket     =mySwapArray[0].ticket;
                        myTO[j].opentime   =mySwapArray[0].opentime;
                        myTO[j].type       =mySwapArray[0].type;
                        myTO[j].lots       =mySwapArray[0].lots;
                        myTO[j].symbol     =mySwapArray[0].symbol;
                        myTO[j].openprice  =mySwapArray[0].openprice;
                        myTO[j].stoploss   =mySwapArray[0].stoploss;
                        myTO[j].takeprofit =mySwapArray[0].takeprofit;
                        myTO[j].commission =mySwapArray[0].commission;
                        myTO[j].swap       =mySwapArray[0].swap;
                        myTO[j].profit     =mySwapArray[0].profit;
                        myTO[j].comment    =mySwapArray[0].comment;
                        myTO[j].magicnumber=mySwapArray[0].magicnumber;
                        myTO[j].cost       =mySwapArray[0].cost;
                    }
                }
            }
            break;
        }
    } 
    return;
}

/*
函    数：历史单数组按类型排序
输出参数：
算法说明：冒泡
针对指定的订单数组执行按组合条件降序排序。
*/
void egOrdersArraySortHst(HistoryOrders     &myHO[],    //持仓单数组
                          string            mySymbol,   //商品名称，Symbol()为当前图表商品名，"*"为所有商品
                          int               mySeekMode  //排序类型 0-按建仓时间,1-按建仓价,2、3-按利润,4-按平仓时间
                         )
{
    int myArrayRange=ArraySize(myHO);   //数组边界变量
    int i,j;                            //循环计数器变量
    HistoryOrders mySwapArray[1];      //交换数组变量
    switch (mySeekMode)
    {
        case 0: //按建仓时间，结果是降序
        {
            for (i=0;i<myArrayRange;i++)
            {
                for (j=myArrayRange-1;j>i;j--)
                {
                    if (myHO[j].opentime>myHO[j-1].opentime)
                    {
                        mySwapArray[0].ticket     =myHO[j-1].ticket;
                        mySwapArray[0].opentime   =myHO[j-1].opentime;
                        mySwapArray[0].closetime  =myHO[j-1].closetime;
                        mySwapArray[0].type       =myHO[j-1].type;
                        mySwapArray[0].lots       =myHO[j-1].lots;
                        mySwapArray[0].symbol     =myHO[j-1].symbol;
                        mySwapArray[0].openprice  =myHO[j-1].openprice;
                        mySwapArray[0].closeprice =myHO[j-1].closeprice;
                        mySwapArray[0].stoploss   =myHO[j-1].stoploss;
                        mySwapArray[0].takeprofit =myHO[j-1].takeprofit;
                        mySwapArray[0].commission =myHO[j-1].commission;
                        mySwapArray[0].swap       =myHO[j-1].swap;
                        mySwapArray[0].profit     =myHO[j-1].profit;
                        mySwapArray[0].comment    =myHO[j-1].comment;
                        mySwapArray[0].magicnumber=myHO[j-1].magicnumber;
                        mySwapArray[0].cost       =myHO[j-1].cost;
                        
                        myHO[j-1].ticket     =myHO[j].ticket;
                        myHO[j-1].opentime   =myHO[j].opentime;
                        myHO[j-1].closetime  =myHO[j].closetime;
                        myHO[j-1].type       =myHO[j].type;
                        myHO[j-1].lots       =myHO[j].lots;
                        myHO[j-1].symbol     =myHO[j].symbol;
                        myHO[j-1].openprice  =myHO[j].openprice;
                        myHO[j-1].closeprice =myHO[j].closeprice;
                        myHO[j-1].stoploss   =myHO[j].stoploss;
                        myHO[j-1].takeprofit =myHO[j].takeprofit;
                        myHO[j-1].commission =myHO[j].commission;
                        myHO[j-1].swap       =myHO[j].swap;
                        myHO[j-1].profit     =myHO[j].profit;
                        myHO[j-1].comment    =myHO[j].comment;
                        myHO[j-1].magicnumber=myHO[j].magicnumber;
                        myHO[j-1].cost       =myHO[j].cost;
                        
                        myHO[j].ticket     =mySwapArray[0].ticket;
                        myHO[j].opentime   =mySwapArray[0].opentime;
                        myHO[j].closetime  =mySwapArray[0].closetime;
                        myHO[j].type       =mySwapArray[0].type;
                        myHO[j].lots       =mySwapArray[0].lots;
                        myHO[j].symbol     =mySwapArray[0].symbol;
                        myHO[j].openprice  =mySwapArray[0].openprice;
                        myHO[j].closeprice =mySwapArray[0].closeprice;
                        myHO[j].stoploss   =mySwapArray[0].stoploss;
                        myHO[j].takeprofit =mySwapArray[0].takeprofit;
                        myHO[j].commission =mySwapArray[0].commission;
                        myHO[j].swap       =mySwapArray[0].swap;
                        myHO[j].profit     =mySwapArray[0].profit;
                        myHO[j].comment    =mySwapArray[0].comment;
                        myHO[j].magicnumber=mySwapArray[0].magicnumber;
                        myHO[j].cost       =mySwapArray[0].cost;
                    }
                }
            }
            break;
        }
        case 1: //按建仓价，结果是降序
        {
            for (i=0;i<myArrayRange;i++)
            {
                for (j=myArrayRange-1;j>i;j--)
                {
                    if (myHO[j].openprice>myHO[j-1].openprice)
                    {
                        mySwapArray[0].ticket     =myHO[j-1].ticket;
                        mySwapArray[0].opentime   =myHO[j-1].opentime;
                        mySwapArray[0].closetime  =myHO[j-1].closetime;
                        mySwapArray[0].type       =myHO[j-1].type;
                        mySwapArray[0].lots       =myHO[j-1].lots;
                        mySwapArray[0].symbol     =myHO[j-1].symbol;
                        mySwapArray[0].openprice  =myHO[j-1].openprice;
                        mySwapArray[0].closeprice =myHO[j-1].closeprice;
                        mySwapArray[0].stoploss   =myHO[j-1].stoploss;
                        mySwapArray[0].takeprofit =myHO[j-1].takeprofit;
                        mySwapArray[0].commission =myHO[j-1].commission;
                        mySwapArray[0].swap       =myHO[j-1].swap;
                        mySwapArray[0].profit     =myHO[j-1].profit;
                        mySwapArray[0].comment    =myHO[j-1].comment;
                        mySwapArray[0].magicnumber=myHO[j-1].magicnumber;
                        mySwapArray[0].cost       =myHO[j-1].cost;
                        
                        myHO[j-1].ticket     =myHO[j].ticket;
                        myHO[j-1].opentime   =myHO[j].opentime;
                        myHO[j-1].closetime  =myHO[j].closetime;
                        myHO[j-1].type       =myHO[j].type;
                        myHO[j-1].lots       =myHO[j].lots;
                        myHO[j-1].symbol     =myHO[j].symbol;
                        myHO[j-1].openprice  =myHO[j].openprice;
                        myHO[j-1].closeprice =myHO[j].closeprice;
                        myHO[j-1].stoploss   =myHO[j].stoploss;
                        myHO[j-1].takeprofit =myHO[j].takeprofit;
                        myHO[j-1].commission =myHO[j].commission;
                        myHO[j-1].swap       =myHO[j].swap;
                        myHO[j-1].profit     =myHO[j].profit;
                        myHO[j-1].comment    =myHO[j].comment;
                        myHO[j-1].magicnumber=myHO[j].magicnumber;
                        myHO[j-1].cost       =myHO[j].cost;
                        
                        myHO[j].ticket     =mySwapArray[0].ticket;
                        myHO[j].opentime   =mySwapArray[0].opentime;
                        myHO[j].closetime  =mySwapArray[0].closetime;
                        myHO[j].type       =mySwapArray[0].type;
                        myHO[j].lots       =mySwapArray[0].lots;
                        myHO[j].symbol     =mySwapArray[0].symbol;
                        myHO[j].openprice  =mySwapArray[0].openprice;
                        myHO[j].closeprice =mySwapArray[0].closeprice;
                        myHO[j].stoploss   =mySwapArray[0].stoploss;
                        myHO[j].takeprofit =mySwapArray[0].takeprofit;
                        myHO[j].commission =mySwapArray[0].commission;
                        myHO[j].swap       =mySwapArray[0].swap;
                        myHO[j].profit     =mySwapArray[0].profit;
                        myHO[j].comment    =mySwapArray[0].comment;
                        myHO[j].magicnumber=mySwapArray[0].magicnumber;
                        myHO[j].cost       =mySwapArray[0].cost;
                    }
                }
            }
            break;
        }
        case 2: //按浮动利润，结果是降序
        {
            for (i=0;i<myArrayRange;i++)
            {
                for (j=myArrayRange-1;j>i;j--)
                {
                    if (myHO[j].profit>myHO[j-1].profit)
                    {
                        mySwapArray[0].ticket     =myHO[j-1].ticket;
                        mySwapArray[0].opentime   =myHO[j-1].opentime;
                        mySwapArray[0].closetime  =myHO[j-1].closetime;
                        mySwapArray[0].type       =myHO[j-1].type;
                        mySwapArray[0].lots       =myHO[j-1].lots;
                        mySwapArray[0].symbol     =myHO[j-1].symbol;
                        mySwapArray[0].openprice  =myHO[j-1].openprice;
                        mySwapArray[0].closeprice =myHO[j-1].closeprice;
                        mySwapArray[0].stoploss   =myHO[j-1].stoploss;
                        mySwapArray[0].takeprofit =myHO[j-1].takeprofit;
                        mySwapArray[0].commission =myHO[j-1].commission;
                        mySwapArray[0].swap       =myHO[j-1].swap;
                        mySwapArray[0].profit     =myHO[j-1].profit;
                        mySwapArray[0].comment    =myHO[j-1].comment;
                        mySwapArray[0].magicnumber=myHO[j-1].magicnumber;
                        mySwapArray[0].cost       =myHO[j-1].cost;
                        
                        myHO[j-1].ticket     =myHO[j].ticket;
                        myHO[j-1].opentime   =myHO[j].opentime;
                        myHO[j-1].closetime  =myHO[j].closetime;
                        myHO[j-1].type       =myHO[j].type;
                        myHO[j-1].lots       =myHO[j].lots;
                        myHO[j-1].symbol     =myHO[j].symbol;
                        myHO[j-1].openprice  =myHO[j].openprice;
                        myHO[j-1].closeprice =myHO[j].closeprice;
                        myHO[j-1].stoploss   =myHO[j].stoploss;
                        myHO[j-1].takeprofit =myHO[j].takeprofit;
                        myHO[j-1].commission =myHO[j].commission;
                        myHO[j-1].swap       =myHO[j].swap;
                        myHO[j-1].profit     =myHO[j].profit;
                        myHO[j-1].comment    =myHO[j].comment;
                        myHO[j-1].magicnumber=myHO[j].magicnumber;
                        myHO[j-1].cost       =myHO[j].cost;
                        
                        myHO[j].ticket     =mySwapArray[0].ticket;
                        myHO[j].opentime   =mySwapArray[0].opentime;
                        myHO[j].closetime  =mySwapArray[0].closetime;
                        myHO[j].type       =mySwapArray[0].type;
                        myHO[j].lots       =mySwapArray[0].lots;
                        myHO[j].symbol     =mySwapArray[0].symbol;
                        myHO[j].openprice  =mySwapArray[0].openprice;
                        myHO[j].closeprice =mySwapArray[0].closeprice;
                        myHO[j].stoploss   =mySwapArray[0].stoploss;
                        myHO[j].takeprofit =mySwapArray[0].takeprofit;
                        myHO[j].commission =mySwapArray[0].commission;
                        myHO[j].swap       =mySwapArray[0].swap;
                        myHO[j].profit     =mySwapArray[0].profit;
                        myHO[j].comment    =mySwapArray[0].comment;
                        myHO[j].magicnumber=mySwapArray[0].magicnumber;
                        myHO[j].cost       =mySwapArray[0].cost;
                    }
                }
            }
            break;
        }
        case 3: //按浮动利润，结果是降序
        {
            for (i=0;i<myArrayRange;i++)
            {
                for (j=myArrayRange-1;j>i;j--)
                {
                    if (myHO[j].profit>myHO[j-1].profit)
                    {
                        mySwapArray[0].ticket     =myHO[j-1].ticket;
                        mySwapArray[0].opentime   =myHO[j-1].opentime;
                        mySwapArray[0].closetime  =myHO[j-1].closetime;
                        mySwapArray[0].type       =myHO[j-1].type;
                        mySwapArray[0].lots       =myHO[j-1].lots;
                        mySwapArray[0].symbol     =myHO[j-1].symbol;
                        mySwapArray[0].openprice  =myHO[j-1].openprice;
                        mySwapArray[0].closeprice =myHO[j-1].closeprice;
                        mySwapArray[0].stoploss   =myHO[j-1].stoploss;
                        mySwapArray[0].takeprofit =myHO[j-1].takeprofit;
                        mySwapArray[0].commission =myHO[j-1].commission;
                        mySwapArray[0].swap       =myHO[j-1].swap;
                        mySwapArray[0].profit     =myHO[j-1].profit;
                        mySwapArray[0].comment    =myHO[j-1].comment;
                        mySwapArray[0].magicnumber=myHO[j-1].magicnumber;
                        mySwapArray[0].cost       =myHO[j-1].cost;
                        
                        myHO[j-1].ticket     =myHO[j].ticket;
                        myHO[j-1].opentime   =myHO[j].opentime;
                        myHO[j-1].closetime  =myHO[j].closetime;
                        myHO[j-1].type       =myHO[j].type;
                        myHO[j-1].lots       =myHO[j].lots;
                        myHO[j-1].symbol     =myHO[j].symbol;
                        myHO[j-1].openprice  =myHO[j].openprice;
                        myHO[j-1].closeprice =myHO[j].closeprice;
                        myHO[j-1].stoploss   =myHO[j].stoploss;
                        myHO[j-1].takeprofit =myHO[j].takeprofit;
                        myHO[j-1].commission =myHO[j].commission;
                        myHO[j-1].swap       =myHO[j].swap;
                        myHO[j-1].profit     =myHO[j].profit;
                        myHO[j-1].comment    =myHO[j].comment;
                        myHO[j-1].magicnumber=myHO[j].magicnumber;
                        myHO[j-1].cost       =myHO[j].cost;
                        
                        myHO[j].ticket     =mySwapArray[0].ticket;
                        myHO[j].opentime   =mySwapArray[0].opentime;
                        myHO[j].closetime  =mySwapArray[0].closetime;
                        myHO[j].type       =mySwapArray[0].type;
                        myHO[j].lots       =mySwapArray[0].lots;
                        myHO[j].symbol     =mySwapArray[0].symbol;
                        myHO[j].openprice  =mySwapArray[0].openprice;
                        myHO[j].closeprice =mySwapArray[0].closeprice;
                        myHO[j].stoploss   =mySwapArray[0].stoploss;
                        myHO[j].takeprofit =mySwapArray[0].takeprofit;
                        myHO[j].commission =mySwapArray[0].commission;
                        myHO[j].swap       =mySwapArray[0].swap;
                        myHO[j].profit     =mySwapArray[0].profit;
                        myHO[j].comment    =mySwapArray[0].comment;
                        myHO[j].magicnumber=mySwapArray[0].magicnumber;
                        myHO[j].cost       =mySwapArray[0].cost;
                    }
                }
            }
            break;
        }
        case 4: //按平仓时间，结果是降序
        {
            for (i=0;i<myArrayRange;i++)
            {
                for (j=myArrayRange-1;j>i;j--)
                {
                    if (myHO[j].closetime>myHO[j-1].closetime)
                    {
                        mySwapArray[0].ticket     =myHO[j-1].ticket;
                        mySwapArray[0].opentime   =myHO[j-1].opentime;
                        mySwapArray[0].closetime  =myHO[j-1].closetime;
                        mySwapArray[0].type       =myHO[j-1].type;
                        mySwapArray[0].lots       =myHO[j-1].lots;
                        mySwapArray[0].symbol     =myHO[j-1].symbol;
                        mySwapArray[0].openprice  =myHO[j-1].openprice;
                        mySwapArray[0].closeprice =myHO[j-1].closeprice;
                        mySwapArray[0].stoploss   =myHO[j-1].stoploss;
                        mySwapArray[0].takeprofit =myHO[j-1].takeprofit;
                        mySwapArray[0].commission =myHO[j-1].commission;
                        mySwapArray[0].swap       =myHO[j-1].swap;
                        mySwapArray[0].profit     =myHO[j-1].profit;
                        mySwapArray[0].comment    =myHO[j-1].comment;
                        mySwapArray[0].magicnumber=myHO[j-1].magicnumber;
                        mySwapArray[0].cost       =myHO[j-1].cost;
                        
                        myHO[j-1].ticket     =myHO[j].ticket;
                        myHO[j-1].opentime   =myHO[j].opentime;
                        myHO[j-1].closetime  =myHO[j].closetime;
                        myHO[j-1].type       =myHO[j].type;
                        myHO[j-1].lots       =myHO[j].lots;
                        myHO[j-1].symbol     =myHO[j].symbol;
                        myHO[j-1].openprice  =myHO[j].openprice;
                        myHO[j-1].closeprice =myHO[j].closeprice;
                        myHO[j-1].stoploss   =myHO[j].stoploss;
                        myHO[j-1].takeprofit =myHO[j].takeprofit;
                        myHO[j-1].commission =myHO[j].commission;
                        myHO[j-1].swap       =myHO[j].swap;
                        myHO[j-1].profit     =myHO[j].profit;
                        myHO[j-1].comment    =myHO[j].comment;
                        myHO[j-1].magicnumber=myHO[j].magicnumber;
                        myHO[j-1].cost       =myHO[j].cost;
                        
                        myHO[j].ticket     =mySwapArray[0].ticket;
                        myHO[j].opentime   =mySwapArray[0].opentime;
                        myHO[j].closetime  =mySwapArray[0].closetime;
                        myHO[j].type       =mySwapArray[0].type;
                        myHO[j].lots       =mySwapArray[0].lots;
                        myHO[j].symbol     =mySwapArray[0].symbol;
                        myHO[j].openprice  =mySwapArray[0].openprice;
                        myHO[j].closeprice =mySwapArray[0].closeprice;
                        myHO[j].stoploss   =mySwapArray[0].stoploss;
                        myHO[j].takeprofit =mySwapArray[0].takeprofit;
                        myHO[j].commission =mySwapArray[0].commission;
                        myHO[j].swap       =mySwapArray[0].swap;
                        myHO[j].profit     =mySwapArray[0].profit;
                        myHO[j].comment    =mySwapArray[0].comment;
                        myHO[j].magicnumber=mySwapArray[0].magicnumber;
                        myHO[j].cost       =mySwapArray[0].cost;
                    }
                }
            }
            break;
        }
    } 
    return;
}

/*
函    数:当前k线订单数量
输出参数:持仓/历史单在当前k线上的数量
算    法:
*/
int egOrdersInShift(TradesOrders        &myTradingOrders[], //持仓单数组
                    string              mySymbol,           //货币对名称
                    int                 myTimeFrame,        //时间框架
                    int                 myGroupType,        //组类型，0-买入组，1-卖出组
                    bool                myHistory,          //true-含历史单，false-不含历史单
                    int                 myMagicNum          //订单特征码 -1-全部
                   )
{
    datetime myBarOpenTime=iTime(mySymbol,myTimeFrame,0);    //当前k线开盘时间
    if (myBarOpenTime==0) return(-1);
    int myOrders=0;     //订单数量变量
    int i;            //循环计数器变量
    int HistoryTotal=OrdersHistoryTotal();
    //统计卖出组
    if (myGroupType==OP_SELL)
    {
        //持仓单
        for (i=0;i<ArraySize(myTradingOrders);i++)
        {
            if (   (myTradingOrders[i].magicnumber==myMagicNum || myMagicNum==-1) //EA订单
                && myTradingOrders[i].symbol==mySymbol //指定货币对
                && myTradingOrders[i].type==OP_SELL //Sell类型
                && myBarOpenTime<=myTradingOrders[i].opentime //在k0
               )
            {
                myOrders++; //订单数量累计
            }
        }
        //历史单
        if (myHistory)
        {
            for (i=0;i<HistoryTotal;i++)
            {
                if (   OrderSelect(i,SELECT_BY_POS,MODE_HISTORY)
                    && (OrderMagicNumber()==myMagicNum || myMagicNum==-1) //EA订单
                    && OrderSymbol()==mySymbol //指定货币对
                    && OrderType()==OP_SELL //Sell类型
                    && myBarOpenTime<=OrderCloseTime() //在k0
                   )
                {
                    myOrders++; //订单数量累计
                }
            }
        }
    }
    //统计买入组
    if (myGroupType==OP_BUY)
    {
        //持仓单
        for (i=0;i<ArraySize(myTradingOrders);i++)
        {
            if (   (myTradingOrders[i].magicnumber==myMagicNum || myMagicNum==-1) //EA订单
                && myTradingOrders[i].symbol==mySymbol //指定货币对
                && myTradingOrders[i].type==OP_BUY //Buy类型
                && myBarOpenTime<=myTradingOrders[i].opentime //在k0
               )
            {
                myOrders++; //订单数量累计
            }
        }
        //历史单
        if (myHistory)
        {
            for (i=0;i<HistoryTotal;i++)
            {
                if (   OrderSelect(i,SELECT_BY_POS,MODE_HISTORY)
                    && (OrderMagicNumber()==myMagicNum || myMagicNum==-1) //EA订单
                    && OrderSymbol()==mySymbol //指定货币对
                    && OrderType()==OP_BUY //Buy类型
                    && myBarOpenTime<=OrderCloseTime() //在k0
                   )
                {
                    myOrders++; //订单数量累计
                }
            }
        }
    }
    return(myOrders);
}

/*
函    数:订单类型转中文字符
输出参数:6个常用订单类型
算法说明:
*/
string  egOrderTypeToString(int     myType  //订单类型
                           )
{
    if (myType==0)  return("Buy");
    if (myType==1)  return("Sell");
    if (myType==2)  return("BuyLimit");
    if (myType==3)  return("SellLimit");
    if (myType==4)  return("BuyStop");
    if (myType==5)  return("SellStop");
    return("AnyType");
}

/*
函    数：刷新环境变量(当前商品)
输出参数：
算法说明：
*/
bool    egRefreshEV(AccountInfo   &myAI,    //账户信息
                    SymbolInfo    &mySI     //商品信息
                   )
{
        myAI.login=AccountInfoInteger(ACCOUNT_LOGIN);
        myAI.trade_mode=(int)AccountInfoInteger(ACCOUNT_TRADE_MODE);
        myAI.leverage=AccountInfoInteger(ACCOUNT_LEVERAGE);
        myAI.limit_orders=AccountInfoInteger(ACCOUNT_LIMIT_ORDERS);
        myAI.margin_so_mode=(int)AccountInfoInteger(ACCOUNT_MARGIN_SO_MODE);
        myAI.trade_allowed=AccountInfoInteger(ACCOUNT_TRADE_ALLOWED);
        myAI.trade_expert=AccountInfoInteger(ACCOUNT_TRADE_EXPERT);
        
        myAI.balance=AccountInfoDouble(ACCOUNT_BALANCE);
        myAI.credit=AccountInfoDouble(ACCOUNT_CREDIT);
        myAI.profit=AccountInfoDouble(ACCOUNT_PROFIT);
        myAI.equity=AccountInfoDouble(ACCOUNT_EQUITY);
        myAI.margin=AccountInfoDouble(ACCOUNT_MARGIN);
        myAI.margin_free=AccountInfoDouble(ACCOUNT_MARGIN_FREE);
        myAI.margin_level=AccountInfoDouble(ACCOUNT_MARGIN_LEVEL);
        myAI.margin_so_call=AccountInfoDouble(ACCOUNT_MARGIN_SO_CALL);
        myAI.margin_so_so=AccountInfoDouble(ACCOUNT_MARGIN_SO_SO);
        
        myAI.name=AccountInfoString(ACCOUNT_NAME);
        myAI.server=AccountInfoString(ACCOUNT_SERVER);
        myAI.currency=AccountInfoString(ACCOUNT_CURRENCY);
        myAI.company=AccountInfoString(ACCOUNT_COMPANY);
        egTradingSymbols(myAI.trade_symbols);
        
        mySI.select=SymbolInfoInteger(Symbol(),SYMBOL_SELECT);
        mySI.time=(datetime)SymbolInfoInteger(Symbol(),SYMBOL_TIME);
        mySI.digits=(int)SymbolInfoInteger(Symbol(),SYMBOL_DIGITS);
        mySI.spread_float=SymbolInfoInteger(Symbol(),SYMBOL_SPREAD_FLOAT);
        mySI.spread=(int)SymbolInfoInteger(Symbol(),SYMBOL_SPREAD);
        mySI.trade_calc_mode=(int)SymbolInfoInteger(Symbol(),SYMBOL_TRADE_CALC_MODE);
        mySI.trade_mode=(int)SymbolInfoInteger(Symbol(),SYMBOL_TRADE_MODE);
        mySI.start_time=(datetime)SymbolInfoInteger(Symbol(),SYMBOL_START_TIME);
        mySI.expiration_time=(datetime)SymbolInfoInteger(Symbol(),SYMBOL_EXPIRATION_TIME);
        mySI.trade_stop_level=(int)SymbolInfoInteger(Symbol(),SYMBOL_TRADE_STOPS_LEVEL);
        mySI.trade_freeze_level=SymbolInfoInteger(Symbol(),SYMBOL_TRADE_FREEZE_LEVEL);
        mySI.trade_exemode=(int)SymbolInfoInteger(Symbol(),SYMBOL_TRADE_EXEMODE);
        mySI.swap_mode=SymbolInfoInteger(Symbol(),SYMBOL_SWAP_MODE);
        mySI.swap_rollover3days=SymbolInfoInteger(Symbol(),SYMBOL_SWAP_ROLLOVER3DAYS);

        mySI.bid=SymbolInfoDouble(Symbol(),SYMBOL_BID);
        mySI.ask=SymbolInfoDouble(Symbol(),SYMBOL_ASK);
        mySI.mid_price=(SymbolInfoDouble(Symbol(),SYMBOL_BID)+SymbolInfoDouble(Symbol(),SYMBOL_ASK))/2.0;
        mySI.point=SymbolInfoDouble(Symbol(),SYMBOL_POINT);
        mySI.trade_tick_value=SymbolInfoDouble(Symbol(),SYMBOL_TRADE_TICK_VALUE);
        mySI.trade_tick_size=SymbolInfoDouble(Symbol(),SYMBOL_TRADE_TICK_SIZE);
        mySI.trade_contract_size=SymbolInfoDouble(Symbol(),SYMBOL_TRADE_CONTRACT_SIZE);
        mySI.volume_min=SymbolInfoDouble(Symbol(),SYMBOL_VOLUME_MIN);
        mySI.volume_max=SymbolInfoDouble(Symbol(),SYMBOL_VOLUME_MAX);
        mySI.volum_step=SymbolInfoDouble(Symbol(),SYMBOL_VOLUME_STEP);
        mySI.swap_long=SymbolInfoDouble(Symbol(),SYMBOL_SWAP_LONG);
        mySI.swap_short=SymbolInfoDouble(Symbol(),SYMBOL_SWAP_SHORT);
        mySI.margin_initial=SymbolInfoDouble(Symbol(),SYMBOL_MARGIN_INITIAL);
        mySI.margin_maintenance=SymbolInfoDouble(Symbol(),SYMBOL_MARGIN_MAINTENANCE);
        
        mySI.currency_base=SymbolInfoString(Symbol(),SYMBOL_CURRENCY_BASE);
        mySI.currency_profit=SymbolInfoString(Symbol(),SYMBOL_CURRENCY_PROFIT);
        mySI.currency_margin=SymbolInfoString(Symbol(),SYMBOL_CURRENCY_MARGIN);
        mySI.descript=SymbolInfoString(Symbol(),SYMBOL_DESCRIPTION);
        mySI.path=SymbolInfoString(Symbol(),SYMBOL_PATH);
        
        mySI.symbols_total=SymbolsTotal(false);
        mySI.symbol=Symbol();
        
        mySI.margin_hedged=MarketInfo(Symbol(),MODE_MARGINHEDGED);
        mySI.margin_required=MarketInfo(Symbol(),MODE_MARGINREQUIRED);
        
        return(true);
}

/*
函    数：刷新环境变量(指定商品)
输出参数：
算法说明：
*/
bool    egRefreshEV_Specify(string        mySymbol, //指定商品
                            AccountInfo   &myAI,    //账户信息
                            SymbolInfo    &mySI     //商品信息
                           )
{
        myAI.login=AccountInfoInteger(ACCOUNT_LOGIN);
        myAI.trade_mode=(int)AccountInfoInteger(ACCOUNT_TRADE_MODE);
        myAI.leverage=AccountInfoInteger(ACCOUNT_LEVERAGE);
        myAI.limit_orders=AccountInfoInteger(ACCOUNT_LIMIT_ORDERS);
        myAI.margin_so_mode=(int)AccountInfoInteger(ACCOUNT_MARGIN_SO_MODE);
        myAI.trade_allowed=AccountInfoInteger(ACCOUNT_TRADE_ALLOWED);
        myAI.trade_expert=AccountInfoInteger(ACCOUNT_TRADE_EXPERT);
        
        myAI.balance=AccountInfoDouble(ACCOUNT_BALANCE);
        myAI.credit=AccountInfoDouble(ACCOUNT_CREDIT);
        myAI.profit=AccountInfoDouble(ACCOUNT_PROFIT);
        myAI.equity=AccountInfoDouble(ACCOUNT_EQUITY);
        myAI.margin=AccountInfoDouble(ACCOUNT_MARGIN);
        myAI.margin_free=AccountInfoDouble(ACCOUNT_MARGIN_FREE);
        myAI.margin_level=AccountInfoDouble(ACCOUNT_MARGIN_LEVEL);
        myAI.margin_so_call=AccountInfoDouble(ACCOUNT_MARGIN_SO_CALL);
        myAI.margin_so_so=AccountInfoDouble(ACCOUNT_MARGIN_SO_SO);
        
        myAI.name=AccountInfoString(ACCOUNT_NAME);
        myAI.server=AccountInfoString(ACCOUNT_SERVER);
        myAI.currency=AccountInfoString(ACCOUNT_CURRENCY);
        myAI.company=AccountInfoString(ACCOUNT_COMPANY);
        
        mySI.select=SymbolInfoInteger(mySymbol,SYMBOL_SELECT);
        mySI.time=(datetime)SymbolInfoInteger(mySymbol,SYMBOL_TIME);
        mySI.digits=(int)SymbolInfoInteger(mySymbol,SYMBOL_DIGITS);
        mySI.spread_float=SymbolInfoInteger(mySymbol,SYMBOL_SPREAD_FLOAT);
        mySI.spread=(int)SymbolInfoInteger(mySymbol,SYMBOL_SPREAD);
        mySI.trade_calc_mode=(int)SymbolInfoInteger(mySymbol,SYMBOL_TRADE_CALC_MODE);
        mySI.trade_mode=(int)SymbolInfoInteger(mySymbol,SYMBOL_TRADE_MODE);
        mySI.start_time=(datetime)SymbolInfoInteger(mySymbol,SYMBOL_START_TIME);
        mySI.expiration_time=(datetime)SymbolInfoInteger(mySymbol,SYMBOL_EXPIRATION_TIME);
        mySI.trade_stop_level=(int)SymbolInfoInteger(mySymbol,SYMBOL_TRADE_STOPS_LEVEL);
        mySI.trade_freeze_level=SymbolInfoInteger(mySymbol,SYMBOL_TRADE_FREEZE_LEVEL);
        mySI.trade_exemode=(int)SymbolInfoInteger(mySymbol,SYMBOL_TRADE_EXEMODE);
        mySI.swap_mode=SymbolInfoInteger(mySymbol,SYMBOL_SWAP_MODE);
        mySI.swap_rollover3days=SymbolInfoInteger(mySymbol,SYMBOL_SWAP_ROLLOVER3DAYS);

        mySI.bid=SymbolInfoDouble(mySymbol,SYMBOL_BID);
        mySI.ask=SymbolInfoDouble(mySymbol,SYMBOL_ASK);
        mySI.point=SymbolInfoDouble(mySymbol,SYMBOL_POINT);
        mySI.trade_tick_value=SymbolInfoDouble(mySymbol,SYMBOL_TRADE_TICK_VALUE);
        mySI.trade_tick_size=SymbolInfoDouble(mySymbol,SYMBOL_TRADE_TICK_SIZE);
        mySI.trade_contract_size=SymbolInfoDouble(mySymbol,SYMBOL_TRADE_CONTRACT_SIZE);
        mySI.volume_min=SymbolInfoDouble(mySymbol,SYMBOL_VOLUME_MIN);
        mySI.volume_max=SymbolInfoDouble(mySymbol,SYMBOL_VOLUME_MAX);
        mySI.volum_step=SymbolInfoDouble(mySymbol,SYMBOL_VOLUME_STEP);
        mySI.swap_long=SymbolInfoDouble(mySymbol,SYMBOL_SWAP_LONG);
        mySI.swap_short=SymbolInfoDouble(mySymbol,SYMBOL_SWAP_SHORT);
        mySI.margin_initial=SymbolInfoDouble(mySymbol,SYMBOL_MARGIN_INITIAL);
        mySI.margin_maintenance=SymbolInfoDouble(mySymbol,SYMBOL_MARGIN_MAINTENANCE);
        
        mySI.currency_base=SymbolInfoString(mySymbol,SYMBOL_CURRENCY_BASE);
        mySI.currency_profit=SymbolInfoString(mySymbol,SYMBOL_CURRENCY_PROFIT);
        mySI.currency_margin=SymbolInfoString(mySymbol,SYMBOL_CURRENCY_MARGIN);
        mySI.descript=SymbolInfoString(mySymbol,SYMBOL_DESCRIPTION);
        mySI.path=SymbolInfoString(mySymbol,SYMBOL_PATH);
        
        mySI.symbols_total=SymbolsTotal(false);
        mySI.symbol=mySymbol;
        
        mySI.margin_hedged=MarketInfo(mySymbol,MODE_MARGINHEDGED);
        mySI.margin_required=MarketInfo(mySymbol,MODE_MARGINREQUIRED);
        
        return(true);
}

/*
函    数：刷新历史单数组
输出参数：历史单数量 
算法说明：
*/
int egRefreshHO(HistoryOrders   &myHO[],    //历史单数组
                string          mySymbol,   //指定商品，"*"表示所有持仓单
                int             myMagicNum  //程序识别码, -1表示所有持仓单
               )
{
    int i=0,j=0,k=0; //循环计数器变量
    int HistoryTotal=OrdersHistoryTotal();
    //重新界定订单数组
    ArrayResize(myHO,HistoryTotal); 
    //刷新原始数组
    for (i=0;i<HistoryTotal;i++)
    {
        if (   OrderSelect(i,SELECT_BY_POS,MODE_HISTORY) //选中历史单
            && (   mySymbol==OrderSymbol() //指定商品
                || mySymbol=="*" //所有商品
               )
            && (   myMagicNum==OrderMagicNumber() //指定程序订单
                || myMagicNum==-1 //所有订单
               )
           )
        {
            myHO[j].ticket=NULL;
            myHO[j].symbol=NULL;
            myHO[j].type=NULL;
            myHO[j].lots=NULL;
            myHO[j].opentime=NULL;
            myHO[j].openprice=NULL;
            myHO[j].closetime=NULL;
            myHO[j].closeprice=NULL;
            myHO[j].stoploss=NULL;
            myHO[j].takeprofit=NULL;
            myHO[j].profit=NULL;
            myHO[j].commission=NULL;
            myHO[j].swap=NULL;
            myHO[j].comment=NULL;
            myHO[j].magicnumber=NULL;
            myHO[j].cost=NULL;
            
            myHO[j].ticket=OrderTicket();                                       //订单号
            myHO[j].symbol=OrderSymbol();                                       //商品名称
            myHO[j].type=OrderType();                                           //订单类型
            myHO[j].lots=OrderLots();                                           //开仓量
            myHO[j].opentime=OrderOpenTime();                                   //开仓时间
            myHO[j].openprice=NormalizeDouble(OrderOpenPrice(),Digits);         //建仓价
            myHO[j].closetime=OrderCloseTime();                                 //平仓时间
            myHO[j].closeprice=NormalizeDouble(OrderClosePrice(),Digits);       //平仓价
            myHO[j].stoploss=NormalizeDouble(OrderStopLoss(),Digits);           //止损价
            myHO[j].takeprofit=NormalizeDouble(OrderTakeProfit(),Digits);       //止盈价
            myHO[j].profit=OrderProfit();                                       //利润
            myHO[j].commission=OrderCommission();                               //佣金
            myHO[j].swap=OrderSwap();                                           //利息
            myHO[j].comment=OrderComment();                                     //注释
            myHO[j].magicnumber=OrderMagicNumber();                             //程序识别码
            myHO[j].cost=OrderSwap()+OrderCommission();                         //成本
            
            //在历史记录中查找掉期记录并累计，订单注释栏有from*****字样，*****为扣除掉期的订单号，订单类型为6。
            for (k=0;k<HistoryTotal;k++)
            {
                if (   OrderSelect(k,SELECT_BY_POS,MODE_HISTORY) //选择历史单
                    && myHO[j].type==6
                    && StringFind(OrderComment(),(string)myHO[j].ticket,0)>=0 //有扣除掉期记录
                   )
                {
                    myHO[j].cost+=OrderSwap(); //累计掉期
                }
            }
            j++;
        }
    }
    if (j>0) 
    {
        ArrayResize(myHO,j); //重新界定数组边界
    }
    else //没有持仓单，所有项目NULL
    {
        ArrayResize(myHO,1);
        myHO[j].ticket=NULL;
        myHO[j].symbol=NULL;
        myHO[j].type=NULL;
        myHO[j].lots=NULL;
        myHO[j].opentime=NULL;
        myHO[j].openprice=NULL;
        myHO[j].closetime=NULL;
        myHO[j].closeprice=NULL;
        myHO[j].stoploss=NULL;
        myHO[j].takeprofit=NULL;
        myHO[j].profit=NULL;
        myHO[j].commission=NULL;
        myHO[j].swap=NULL;
        myHO[j].comment=NULL;
        myHO[j].magicnumber=NULL;
        myHO[j].cost=NULL;
    }
    return(j);
}

/*
函    数：刷新部分历史单数组
输出参数：历史单数量 
算法说明：刷新指定时间之后的历史单记录
*/
int egRefreshHO_byCloseTime(HistoryOrders   &myHO[],    //历史单数组
                            string          mySymbol,   //指定商品，"*"表示所有持仓单
                            int             myMagicNum,  //程序识别码, -1表示所有持仓单
                            const datetime  myStartTime=0 //历史单平仓开始时间
                           )
{
    int i=0,j=0,k=0; //循环计数器变量
    int HistoryTotal=OrdersHistoryTotal();
    //重新界定订单数组
    ArrayResize(myHO,HistoryTotal); 
    //刷新原始数组
    for (i=0;i<HistoryTotal;i++)
    {
        if (   OrderSelect(i,SELECT_BY_POS,MODE_HISTORY) //选中历史单
            && myStartTime<=OrderCloseTime()
            && (   mySymbol==OrderSymbol() //指定商品
                || mySymbol=="*" //所有商品
               )
            && (   myMagicNum==OrderMagicNumber() //指定程序订单
                || myMagicNum==-1 //所有订单
               )
           )
        {
            myHO[j].ticket=NULL;
            myHO[j].symbol=NULL;
            myHO[j].type=NULL;
            myHO[j].lots=NULL;
            myHO[j].opentime=NULL;
            myHO[j].openprice=NULL;
            myHO[j].closetime=NULL;
            myHO[j].closeprice=NULL;
            myHO[j].stoploss=NULL;
            myHO[j].takeprofit=NULL;
            myHO[j].profit=NULL;
            myHO[j].commission=NULL;
            myHO[j].swap=NULL;
            myHO[j].comment=NULL;
            myHO[j].magicnumber=NULL;
            myHO[j].cost=NULL;
            
            myHO[j].ticket=OrderTicket();                                       //订单号
            myHO[j].symbol=OrderSymbol();                                       //商品名称
            myHO[j].type=OrderType();                                           //订单类型
            myHO[j].lots=OrderLots();                                           //开仓量
            myHO[j].opentime=OrderOpenTime();                                   //开仓时间
            myHO[j].openprice=NormalizeDouble(OrderOpenPrice(),Digits);         //建仓价
            myHO[j].closetime=OrderCloseTime();                                 //平仓时间
            myHO[j].closeprice=NormalizeDouble(OrderClosePrice(),Digits);       //平仓价
            myHO[j].stoploss=NormalizeDouble(OrderStopLoss(),Digits);           //止损价
            myHO[j].takeprofit=NormalizeDouble(OrderTakeProfit(),Digits);       //止盈价
            myHO[j].profit=OrderProfit();                                       //利润
            myHO[j].commission=OrderCommission();                               //佣金
            myHO[j].swap=OrderSwap();                                           //利息
            myHO[j].comment=OrderComment();                                     //注释
            myHO[j].magicnumber=OrderMagicNumber();                             //程序识别码
            myHO[j].cost=OrderSwap()+OrderCommission();                         //成本
            
            //在历史记录中查找掉期记录并累计，订单注释栏有from*****字样，*****为扣除掉期的订单号，订单类型为6。
            for (k=0;k<HistoryTotal;k++)
            {
                if (   OrderSelect(k,SELECT_BY_POS,MODE_HISTORY) //选择历史单
                    && myHO[j].type==6
                    && StringFind(OrderComment(),(string)myHO[j].ticket,0)>=0 //有扣除掉期记录
                   )
                {
                    myHO[j].cost+=OrderSwap(); //累计掉期
                }
            }
            j++;
        }
    }
    if (j>0) 
    {
        ArrayResize(myHO,j); //重新界定数组边界
    }
    else //没有持仓单，所有项目NULL
    {
        ArrayResize(myHO,1);
        myHO[j].ticket=NULL;
        myHO[j].symbol=NULL;
        myHO[j].type=NULL;
        myHO[j].lots=NULL;
        myHO[j].opentime=NULL;
        myHO[j].openprice=NULL;
        myHO[j].closetime=NULL;
        myHO[j].closeprice=NULL;
        myHO[j].stoploss=NULL;
        myHO[j].takeprofit=NULL;
        myHO[j].profit=NULL;
        myHO[j].commission=NULL;
        myHO[j].swap=NULL;
        myHO[j].comment=NULL;
        myHO[j].magicnumber=NULL;
        myHO[j].cost=NULL;
    }
    return(j);
}

/*
函    数:刷新历史单统计信息
输出参数:false-未统计，true-已统计
算    法:统计myHO数组，给myHS赋值。
*/
bool egRefreshHS(HistoryOrders       &myHO[],    //持仓单数组
                 HistoryStatistical  &myHS       //统计结果
                )
{
    if (ArraySize(myHO)==0) return(false); //订单数组为空，不计算
//--- 初始化myHS
    myHS.buy_win_orders=NULL;     //Buy盈利单数量总计
    myHS.buy_loss_orders=NULL;    //Buy亏损单数量总计
    myHS.buy_orders=NULL;         //Buy单数量总计
    myHS.buy_win_profit=NULL;     //Buy盈利单利润总计
    myHS.buy_loss_profit=NULL;    //Buy亏损单利润总计
    myHS.buy_profit=NULL;         //Buy单成交利润总计
    myHS.buy_lots=NULL;           //Buy单成交量总计
    myHS.buy_limit_orders=NULL;   //BuyLimit单数量总计
    myHS.buy_stop_orders=NULL;    //BuyStop单数量总计

    myHS.sell_win_orders=NULL;    //Sell盈利单数量总计
    myHS.sell_loss_orders=NULL;   //Sell亏损单数量总计
    myHS.sell_orders=NULL;        //Sell单数量总计
    myHS.sell_win_profit=NULL;    //Sell盈利单利润总计
    myHS.sell_loss_profit=NULL;   //Sell亏损单利润总计
    myHS.sell_profit=NULL;        //Sell单成交利润总计
    myHS.sell_lots=NULL;          //Sell单成交量总计
    myHS.sell_limit_orders=NULL;  //SellLimit单数量总计
    myHS.sell_stop_orders=NULL;   //SellStop单数量总计
    
    myHS.win_ratio=NULL;          //胜率
    myHS.loss_ratio=NULL;         //败率
    myHS.odds=NULL;               //赔率
    myHS.kelly=NULL;              //凯利
//--- 统计分组信息
    for (int cnt=0;cnt<ArraySize(myHO);cnt++)
    {
        if (myHO[cnt].lots>0 && myHO[cnt].type==OP_BUY)
        {
            if (myHO[cnt].profit>0)
            {
                myHS.buy_win_orders++;  //Buy盈利单数量总计
                myHS.buy_win_profit=myHS.buy_win_profit+myHO[cnt].profit+myHO[cnt].commission+myHO[cnt].swap;     //Buy盈利单利润总计
            }
            if (myHO[cnt].profit<=0)
            {
                myHS.buy_loss_orders++;  //Buy亏损单数量总计
                myHS.buy_loss_profit=myHS.buy_loss_profit+myHO[cnt].profit+myHO[cnt].commission+myHO[cnt].swap;    //Buy亏损单利润总计
            }
            myHS.buy_orders++;         //Buy单数量总计
            myHS.buy_profit=myHS.buy_profit+myHO[cnt].profit+myHO[cnt].commission+myHO[cnt].swap;         //Buy单成交利润总计
            myHS.buy_lots=myHS.buy_lots+myHO[cnt].lots;           //Buy单成交量总计
        }
        if (myHO[cnt].lots>0 && myHO[cnt].type==OP_BUYLIMIT)
        {
            myHS.buy_limit_orders++;   //BuyLimit单数量总计
        }
        if (myHO[cnt].lots>0 && myHO[cnt].type==OP_BUYSTOP)
        {
            myHS.buy_stop_orders++;   //BuyStop单数量总计
        }
        
        if (myHO[cnt].lots>0 && myHO[cnt].type==OP_SELL)
        {
            if (myHO[cnt].profit>0)
            {
                myHS.sell_win_orders++;  //Sell盈利单数量总计
                myHS.sell_win_profit=myHS.sell_win_profit+myHO[cnt].profit+myHO[cnt].commission+myHO[cnt].swap;     //Sell盈利单利润总计
            }
            if (myHO[cnt].profit<=0)
            {
                myHS.sell_loss_orders++;  //Sell亏损单数量总计
                myHS.sell_loss_profit=myHS.sell_loss_profit+myHO[cnt].profit+myHO[cnt].commission+myHO[cnt].swap;    //Sell亏损单利润总计
            }
            myHS.sell_orders++;         //Sell单数量总计
            myHS.sell_profit=myHS.sell_profit+myHO[cnt].profit+myHO[cnt].commission+myHO[cnt].swap;         //Sell单成交利润总计
            myHS.sell_lots=myHS.sell_lots+myHO[cnt].lots;           //Sell单成交量总计
        }
        if (myHO[cnt].lots>0 && myHO[cnt].type==OP_SELLLIMIT)
        {
            myHS.sell_limit_orders++;   //SellLimit单数量总计
        }
        if (myHO[cnt].lots>0 && myHO[cnt].type==OP_SELLSTOP)
        {
            myHS.sell_stop_orders++;   //SellStop单数量总计
        }
    }
//--- 计算评估指标
    if (myHS.buy_orders+myHS.sell_orders>0)
    {
        myHS.win_ratio=(double)(myHS.buy_win_orders+myHS.sell_win_orders)/(myHS.buy_orders+myHS.sell_orders);   //胜率=赢利单数量/所有单数量
        myHS.loss_ratio=1-myHS.win_ratio;   //败率=1-胜率
        if (myHS.win_ratio>0)
        {
            myHS.odds=(1/myHS.win_ratio)*(1-0.08);   //赔率=(1/胜率)*(1-手续费)
        }
        if (myHS.odds>0)
        {
            myHS.kelly=(myHS.odds*myHS.win_ratio-myHS.loss_ratio)/myHS.odds;    //凯利=(赔率*胜率-败率)/赔率
        }
    }
    return(true);
}

/*
函    数：刷新持仓单数组
输出参数：持仓单数量 
算法说明：
*/
int egRefreshTO(TradesOrders    &myTO[],    //持仓单数组
                string          mySymbol,   //指定商品，"*"表示所有持仓单
                int             myMagicNum  //程序识别码, -1表示所有持仓单
               )
{
    int i=0,j=0,k=0; //循环计数器变量
    int HistoryTotal=OrdersHistoryTotal();
    //重新界定订单数组
    ArrayResize(myTO,OrdersTotal()); 
    //刷新原始数组
    for (i=0;i<OrdersTotal();i++)
    {
        if (   OrderSelect(i,SELECT_BY_POS,MODE_TRADES) //选中持仓单
            && (   mySymbol==OrderSymbol() //指定商品
                || mySymbol=="*" //所有商品
               )
            && (   myMagicNum==OrderMagicNumber() //指定程序订单
                || myMagicNum==-1 //所有订单
               )
           )
        {
            myTO[j].ticket=NULL;
            myTO[j].opentime=NULL;
            myTO[j].type=NULL;
            myTO[j].lots=NULL;
            myTO[j].symbol=NULL;
            myTO[j].openprice=NULL;
            myTO[j].stoploss=NULL;
            myTO[j].takeprofit=NULL;
            myTO[j].commission=NULL;
            myTO[j].swap=NULL;
            myTO[j].profit=NULL;
            myTO[j].comment=NULL;
            myTO[j].magicnumber=NULL;
            myTO[j].cost=NULL;
            
            myTO[j].ticket=OrderTicket();                                       //订单号
            myTO[j].opentime=OrderOpenTime();                                   //开仓时间
            myTO[j].type=OrderType();                                           //订单类型
            myTO[j].lots=OrderLots();                                           //开仓量
            myTO[j].symbol=OrderSymbol();                                       //商品名称
            myTO[j].openprice=NormalizeDouble(OrderOpenPrice(),Digits);         //建仓价
            myTO[j].stoploss=NormalizeDouble(OrderStopLoss(),Digits);           //止损价
            myTO[j].takeprofit=NormalizeDouble(OrderTakeProfit(),Digits);       //止盈价
            myTO[j].commission=OrderCommission();                               //佣金
            myTO[j].swap=OrderSwap();                                           //利息
            myTO[j].profit=OrderProfit();                                       //利润
            myTO[j].comment=OrderComment();                                     //注释
            myTO[j].magicnumber=OrderMagicNumber();                             //程序识别码
            myTO[j].cost=OrderCommission()+OrderSwap();                         //成本
            
            //在历史记录中查找掉期记录并累计，订单注释栏有from*****字样，*****为扣除掉期的订单号，订单类型为6。
            for (k=0;k<HistoryTotal;k++)
            {
                if (   OrderSelect(k,SELECT_BY_POS,MODE_HISTORY) //选择历史单
                    && OrderType()==6 //扣款类型
                    && StringFind(OrderComment(),(string)myTO[j].ticket,0)>=0 //有扣除掉期记录
                   )
                {
                    myTO[j].cost+=OrderSwap(); //成本累计掉期
                }
            }
            j++;
        }
    }
    if (j>0) 
    {
        ArrayResize(myTO,j); //重新界定数组边界
    }
    else //没有持仓单，所有项目NULL
    {
        ArrayResize(myTO,1);
        myTO[j].ticket=NULL;
        myTO[j].symbol=NULL;
        myTO[j].type=NULL;
        myTO[j].lots=NULL;
        myTO[j].opentime=NULL;
        myTO[j].openprice=NULL;
        myTO[j].stoploss=NULL;
        myTO[j].takeprofit=NULL;
        myTO[j].profit=NULL;
        myTO[j].commission=NULL;
        myTO[j].swap=NULL;
        myTO[j].comment=NULL;
        myTO[j].magicnumber=NULL;
        myTO[j].cost=NULL;
    }
    return(j);
}

/*
函    数:刷新持仓单统计信息
输出参数:false-未统计，true-已统计
算    法:统计myTO数组，给myTS赋值。其中最大盈利、最大亏损、最大保证金占用不重新计算
*/
bool egRefreshTS(TradesOrders       &myTO[],    //持仓单数组
                 TradesStatistical  &myTS,      //统计结果
                 AccountInfo        &myAI,      //账户信息
                 SymbolInfo         &mySI       //商品信息
                )
{
    double  myBuyValue,mySellValue;
//--- 初始化myTS,其中最大盈利、最大亏损、最大保证金占用不重新计算
    myTS.symbol=mySI.symbol;
    myTS.buy_orders=NULL;
    myTS.buylimit_orders=NULL;
    myTS.buystop_orders=NULL;
    myTS.buy_grp_lots=NULL;
    myTS.buy_grp_profit=NULL;
    myTS.buy_grp_avg=NULL;
    myTS.buy_grp_margin=NULL;
    myTS.buy_grp_cost=NULL;
    
    myTS.sell_orders=NULL;
    myTS.selllimit_orders=NULL;
    myTS.sellstop_orders=NULL;
    myTS.sell_grp_lots=NULL;
    myTS.sell_grp_profit=NULL;
    myTS.sell_grp_avg=NULL;
    myTS.sell_grp_margin=NULL;
    myTS.sell_grp_cost=NULL;

    if (ArraySize(myTO)==0) return(false); //订单数组为空，不计算
//--- 统计分组信息
    for (int cnt=0;cnt<ArraySize(myTO);cnt++)
    {
        if (myTO[cnt].ticket>0 && myTO[cnt].type==OP_BUY)
        {
            myTS.buy_orders++;  //Buy单数量总计
            myTS.buy_grp_lots=myTS.buy_grp_lots+myTO[cnt].lots; //Buy组成交持仓单建仓量总计
            myTS.buy_grp_cost=myTS.buy_grp_cost+myTO[cnt].cost; //Buy组成交持仓单成本总计
            myTS.buy_grp_profit=myTS.buy_grp_profit+myTO[cnt].profit+myTO[cnt].swap+myTO[cnt].commission;   //Buy组成交持仓单利润总计
            myBuyValue=myBuyValue+myTO[cnt].openprice*myTO[cnt].lots;   //Buy组总价值
        }
        if (myTO[cnt].ticket>0 && myTO[cnt].type==OP_BUYLIMIT)
        {
            myTS.buylimit_orders++;  //BuyLimit单数量总计
        }
        if (myTO[cnt].ticket>0 && myTO[cnt].type==OP_BUYSTOP)
        {
            myTS.buystop_orders++;  //BuyStop单数量总计
        }
        
        if (myTO[cnt].ticket>0 && myTO[cnt].type==OP_SELL)
        {
            myTS.sell_orders++;  //Sell单数量总计
            myTS.sell_grp_lots=myTS.sell_grp_lots+myTO[cnt].lots; //Sell组成交持仓单建仓量总计
            myTS.sell_grp_cost=myTS.sell_grp_cost+myTO[cnt].cost; //Sell组成交持仓单成本总计
            myTS.sell_grp_profit=myTS.sell_grp_profit+myTO[cnt].profit+myTO[cnt].swap+myTO[cnt].commission;   //Sell组成交持仓单利润总计
            mySellValue=mySellValue+myTO[cnt].openprice*myTO[cnt].lots;   //Sell组总价值
        }
        if (myTO[cnt].ticket>0 && myTO[cnt].type==OP_SELLLIMIT)
        {
            myTS.selllimit_orders++;  //SellLimit单数量总计
        }
        if (myTO[cnt].ticket>0 && myTO[cnt].type==OP_SELLSTOP)
        {
            myTS.sellstop_orders++;  //SellStop单数量总计
        }
    }
//--- 统计汇总信息
    //风险值
    if (myAI.equity>0)
    {
        myTS.buy_grp_risk=myTS.buy_grp_profit/myAI.equity;
        myTS.sell_grp_risk=myTS.sell_grp_profit/myAI.equity;
    }
    //组均价
    if (myTS.buy_grp_lots>0) myTS.buy_grp_avg=myBuyValue/myTS.buy_grp_lots;
    if (myTS.sell_grp_lots>0) myTS.sell_grp_avg=mySellValue/myTS.sell_grp_lots;
    //保证金占用
    myTS.buy_grp_margin=myTS.buy_grp_lots*mySI.margin_required;
    myTS.sell_grp_margin=myTS.sell_grp_lots*mySI.margin_required;
    //余额增量  本轮净利
    int i=0;    //循环计数器变量
    datetime    myBaseTime; //基准时间变量
    int HistoryTotal=OrdersHistoryTotal();
    //有持仓单，开始计算
    myTS.account_increment=0;
    myTS.current_profit=0;
    if (myTS.buy_orders+myTS.sell_orders>0)
    {
        //获取最早持仓单建仓时间
        if (egOrderLocationSearch(myTO,mySI.symbol,0,9,-1,-1)<=0) myTS.account_increment=0;
        if (egOrderLocationSearch(myTO,mySI.symbol,0,9,-1,-1)>0) myBaseTime=myTO[egOrderPos(myTO,egOrderLocationSearch(myTO,mySI.symbol,0,9,-1,-1))].opentime;
        //查找历史订单中本轮交易最早单建仓时间
        for (i=0;i<HistoryTotal;i++)
        {
            if (   OrderSelect(i,SELECT_BY_POS,MODE_HISTORY)
                && OrderSymbol()==mySI.symbol
                && (OrderType()==OP_BUY || OrderType()==OP_SELL)
                && OrderOpenTime()<myBaseTime && OrderCloseTime()>myBaseTime
               )
            {
                myBaseTime=OrderOpenTime();
            }
        }
        //统计从本轮开始历史单实现的余额增量,本轮净利
        for (i=0;i<HistoryTotal;i++)
        {
            if (   OrderSelect(i,SELECT_BY_POS,MODE_HISTORY)
                && OrderCloseTime()>myBaseTime
                && (OrderType()==OP_BUY || OrderType()==OP_SELL)
               )
            {
                myTS.account_increment=myTS.account_increment+OrderProfit()+OrderCommission()+OrderSwap();
                if (OrderSymbol()==mySI.symbol)
                {
                    myTS.current_profit=myTS.current_profit+OrderProfit()+OrderCommission()+OrderSwap();
                }
            }
            //单独扣除掉期的记录
            if (   OrderSelect(i,SELECT_BY_POS,MODE_HISTORY) //选择历史单
                && OrderCloseTime()>myBaseTime
                && OrderType()==6
                && StringFind(OrderComment(),(string)OrderTicket(),0)>=0 //有扣除掉期记录
               )
            {
                myTS.account_increment+=OrderSwap(); //累计掉期
                if (OrderSymbol()==mySI.symbol)
                {
                    myTS.current_profit+=OrderSwap();
                }
            }
        }
    }
    //最大可建仓量=可用保证金/单点价值
    if (mySI.margin_required>0) myTS.max_lots=egLotsFormat(mySI.symbol,myAI.margin_free/mySI.margin_required);
    else myTS.max_lots=egLotsFormat(mySI.symbol,myAI.margin_free);
    return(true);
}

/*
函    数:同向对冲
输出参数:true--成功,false--不成功
算    法:
所有盈利单与最远开始所有可保本亏损单一起平仓
*/
bool egSDHR(TradesOrders            &myTradingOrders[],         //持仓单数组
            TradesStatistical       &myTradingStatistical,      //持仓单统计数组
            int                     myType,                     //持仓单类型
            int                     myMagicNumber,              //订单识别码
            int                     &myCloseTicket[],           //平仓数组
            double                  myInterval1,                //回调间距(价格)
            double                  myBudgetRate                //对冲平衡系数
           )
{
    int     cnt=0,i=0,j=0;  //循环计数器变量
    double  myTempTake=0,myTempLoss=0;  //浮动盈利、亏损变量
    ArrayInitialize(myCloseTicket,-1); //平仓数组初始化
//--- Buy类型
    if (   myTradingStatistical.buy_orders>1   //有2张以上单
        && myType==OP_BUY
        && egOrderLocationSearch(myTradingOrders,Symbol(),2,OP_BUY,myMagicNumber,1)>0 //有赢利单
        && egOrderLocationSearch(myTradingOrders,Symbol(),3,OP_BUY,myMagicNumber,1)>0 //有亏损单
        && Bid-myTradingOrders[egOrderPos(myTradingOrders,egOrderLocationSearch(myTradingOrders,Symbol(),1,OP_BUY,myMagicNumber,-1))].openprice>myInterval1   //最低价盈利目标间距
       )
    {
        myTempTake=0;myTempLoss=0;i=0;j=1;
        //累计盈利，记录盈利单号
        for (cnt=0;cnt<ArraySize(myTradingOrders);cnt++)
        {
            if (   myTradingOrders[cnt].type==OP_BUY
                && myTradingOrders[cnt].profit>0
               )
            {
                myTempTake=myTempTake+myTradingOrders[cnt].profit; //累计盈利
                myCloseTicket[i]=myTradingOrders[cnt].ticket;    //记录盈利单号
                i++;
            }
        }
        cnt=i;
        //从最高价Buy单开始，累计亏损不超过盈利的亏损，记录亏损单号
        for (j=1;j<ArraySize(myTradingOrders);j++)
        {
            if (   egOrderLocationSearch(myTradingOrders,Symbol(),1,OP_BUY,myMagicNumber,j)>0
                && myTradingOrders[egOrderPos(myTradingOrders,egOrderLocationSearch(myTradingOrders,Symbol(),1,OP_BUY,myMagicNumber,j))].type==OP_BUY
                && myTradingOrders[egOrderPos(myTradingOrders,egOrderLocationSearch(myTradingOrders,Symbol(),1,OP_BUY,myMagicNumber,j))].profit<0
               )
            {
                myTempLoss=myTempLoss+myTradingOrders[egOrderPos(myTradingOrders,egOrderLocationSearch(myTradingOrders,Symbol(),1,OP_BUY,myMagicNumber,j))].profit; //累计亏损
                if (myTempTake+myTempLoss*myBudgetRate>0)
                {
                    myCloseTicket[i]=myTradingOrders[egOrderPos(myTradingOrders,egOrderLocationSearch(myTradingOrders,Symbol(),1,OP_BUY,myMagicNumber,j))].ticket;    //记录亏损单号
                    i++;
                }
            }
        }
        if (cnt<i)
        {
            return(true);
        }
    }
//--- Sell类型
    if (   myTradingStatistical.sell_orders>1   //有2张以上单
        && myType==OP_SELL
        && egOrderLocationSearch(myTradingOrders,Symbol(),2,OP_SELL,myMagicNumber,1)>0 //有赢利单
        && egOrderLocationSearch(myTradingOrders,Symbol(),3,OP_SELL,myMagicNumber,1)>0 //有亏损单
        && myTradingOrders[egOrderPos(myTradingOrders,egOrderLocationSearch(myTradingOrders,Symbol(),1,OP_SELL,myMagicNumber,1))].openprice-Ask>myInterval1   //最高价盈利目标间距
       )
    {
        myTempTake=0;myTempLoss=0;i=0;j=1;
        //累计盈利，记录盈利单号
        for (cnt=0;cnt<ArraySize(myTradingOrders);cnt++)
        {
            if (   myTradingOrders[cnt].type==OP_SELL
                && myTradingOrders[cnt].profit>0
               )
            {
                myTempTake=myTempTake+myTradingOrders[cnt].profit; //累计盈利
                myCloseTicket[i]=myTradingOrders[cnt].ticket;    //记录盈利单号
                i++;
            }
        }
        cnt=i;
        //从最低价Sell单开始，累计亏损不超过盈利的亏损，记录亏损单号
        for (j=1;j<ArraySize(myTradingOrders);j++)
        {
            if (   egOrderLocationSearch(myTradingOrders,Symbol(),1,OP_SELL,myMagicNumber,-j)>0
                && myTradingOrders[egOrderPos(myTradingOrders,egOrderLocationSearch(myTradingOrders,Symbol(),1,OP_SELL,myMagicNumber,-j))].type==OP_SELL
                && myTradingOrders[egOrderPos(myTradingOrders,egOrderLocationSearch(myTradingOrders,Symbol(),1,OP_SELL,myMagicNumber,-j))].profit<0
               )
            {
                myTempLoss=myTempLoss+myTradingOrders[egOrderPos(myTradingOrders,egOrderLocationSearch(myTradingOrders,Symbol(),1,OP_SELL,myMagicNumber,-j))].profit; //累计亏损
                if (myTempTake+myTempLoss*myBudgetRate>0)
                {
                    myCloseTicket[i]=myTradingOrders[egOrderPos(myTradingOrders,egOrderLocationSearch(myTradingOrders,Symbol(),1,OP_SELL,myMagicNumber,-j))].ticket;    //记录亏损单号
                    i++;
                }
            }
        }
        if (cnt<i)
        {
            return(true);
        }
    }
    ArrayInitialize(myCloseTicket,-1); //平仓数组初始化
    return(false);
}

/*
函    数:预算同向盈利对冲
输出参数:myBudget[0]-建仓量，myBudget[1]-止盈价
当前浮亏+加仓后浮盈=0
算    法:
*/
void egSDHRData(double &myBudget[2],       //预算数组  myBudget[0]-建仓量，myBudget[1]-止盈价
                int    myType,             //订单组类型
                double myPrice1,           //已有持仓单建仓价
                double myLots1,            //已有持仓单建仓量
                double myPrice2,           //加仓单建仓价
                double myBackInterval      //回调间距(元)
               )
{
    myBudget[0]=-1;myBudget[1]=-1;
    if (myBackInterval<=0 || myLots1<=0) return;
/*
【动态建仓量计算方法  Buy】
已知：现有持仓单开仓量L1，开仓价P1，盈利目标i，现价P2
计算：建仓量x，止盈价y
等式一：加仓后总值=目标位总值
P1*L1+P2*x=(P2+i)*(L1+x)
x=(P1-P2-i)*L1/i
等式二：加仓单盈利额=加仓后盈利
i*x=(y-(P1*L1+P2*x)/(L1+x)))*(L1+x)
y=(i*x+P1*L1+P2*x)/(L1+x)
*/
    if (myType==OP_BUY)
    {
        //myBudget[0]=egLotsFormat(Symbol(),((myPrice1-myPrice2-myBackInterval)*myLots1)/myBackInterval);
        myBudget[0]=egLotsFormat(Symbol(),((2*myPrice1-2*myPrice2-myBackInterval)/(myBackInterval))*myLots1);
//Comment(myPrice1,"  ",myPrice2,"  ",myBackInterval,"  ",myLots1,"\n",((2*myPrice1-2*myPrice2-myBackInterval)/(myBackInterval))*myLots1,"  ",((myPrice1-myPrice2-myBackInterval)*myLots1)/myBackInterval);
        if (myBudget[0]<=0) {myBudget[0]=-1;return;}
        myBudget[1]=NormalizeDouble((myBackInterval*myBudget[0]+myPrice2*myBudget[0]+myPrice1*myLots1)/(myLots1+myBudget[0]),Digits());
    }

/*
【动态建仓量计算方法  Sell】
已知：现有持仓单开仓量L1，开仓价P1，盈利目标i，现价P2
计算：建仓量x，止盈价y
等式一：加仓后总值=目标位总值
P1*L1+P2*x=(P2-i)*(L1+x)
x=(P2-P1-i)*L1/i
等式二：加仓单盈利额=加仓后盈利
i*x=((P1*L1+P2*x)/(L1+x)-y)*(L1+x)
y=(P1*L1+P2*x-i*x)/(L1+x)
*/
    if (myType==OP_SELL)
    {
        //myBudget[0]=egLotsFormat(Symbol(),((myPrice2-myPrice1-myBackInterval)*myLots1)/myBackInterval);
        myBudget[0]=egLotsFormat(Symbol(),((2*myPrice2-2*myPrice1+myBackInterval)/(myBackInterval))*myLots1);
        if (myBudget[0]<=0) {myBudget[0]=-1;return;}
        myBudget[1]=NormalizeDouble((myPrice2*myBudget[0]+myPrice1*myLots1-myBackInterval*myBudget[0])/(myLots1+myBudget[0]),Digits());
    }
    return;
}

/*
函    数:推送信息
输出参数:true-成功，False-不推送
算    法:
*/
bool egSendInfo(string  myInfo,                 //推送信息
                bool    my_Alert_Window=false,  //弹出窗口推送
                bool    my_Alert_EMail=false,   //邮件推送
                bool    my_Alert_APP=false      //手机APP推送
               )
{
    if (my_Alert_Window) Alert(myInfo);
    if (my_Alert_EMail) SendMail(myInfo,myInfo);
    if (my_Alert_APP) SendNotification(myInfo);
    return(true);
}

/*
函    数:设置止盈止损
输出参数:true-成功，false-失败
算法说明:
Buy单止损价<=Bid-StopLevel	    Buy单止盈价>=Bid+StopLevel
Sell单止损价>=Ask+StopLevel	    Sell单止盈价<=Ask-StopLevel
*/
bool    egSetTakeLoss(int           ticket, //订单号
                      int           type,   //止盈=0,止损=1
                      double        price,  //止盈止损价
                      SymbolInfo    &mySI   //商品信息
                     )
{
    if (ticket==0 || !OrderSelect(ticket,SELECT_BY_TICKET,MODE_TRADES))   return(false);
    price=NormalizeDouble(price,mySI.digits);
//Sell
    if (OrderType()==OP_SELL)
    {
        if (   type==0
            && price!=NormalizeDouble(OrderTakeProfit(),mySI.digits)
            && (   price<=mySI.ask-mySI.trade_stop_level*mySI.point
                || price==0.0
               )
            && OrderModify(OrderTicket(),OrderOpenPrice(),OrderStopLoss(),price,0)
           )
        {
            return(true);
        }
        if (   type==1
            && price!=NormalizeDouble(OrderStopLoss(),mySI.digits)
            && (   price>=mySI.ask+mySI.trade_stop_level*mySI.point
                || price==0.0
               )
            && OrderModify(OrderTicket(),OrderOpenPrice(),price,OrderTakeProfit(),0)
           )
        {
            return(true);
        }
    }
//Buy
    if (OrderType()==OP_BUY)
    {
        if (   type==0
            && price!=NormalizeDouble(OrderTakeProfit(),mySI.digits)
            && (   price>=mySI.bid+mySI.trade_stop_level*mySI.point
                || price==0.0
               )
            && OrderModify(OrderTicket(),OrderOpenPrice(),OrderStopLoss(),price,0)
           )
        {
            return(true);
        }
        if (   type==1
            && price!=NormalizeDouble(OrderStopLoss(),mySI.digits)
            && (   price<=mySI.bid-mySI.trade_stop_level*mySI.point
                || price==0.0
               )
            && OrderModify(OrderTicket(),OrderOpenPrice(),price,OrderTakeProfit(),0)
           )
        {
            return(true);
        }
    }
    return(false);
}
/*
函    数:时间框架转中文字符
输出参数:
算法说明:
*/
string  egTimeFrameToString(int     my_TimeFrame      //时间周期
                           )
{
    if (my_TimeFrame==PERIOD_M1)    return("1分钟");
    if (my_TimeFrame==PERIOD_M5)    return("5分钟");
    if (my_TimeFrame==PERIOD_M15)   return("15分钟");
    if (my_TimeFrame==PERIOD_M30)   return("30分钟");
    if (my_TimeFrame==PERIOD_H1)    return("1小时");
    if (my_TimeFrame==PERIOD_H4)    return("4小时");
    if (my_TimeFrame==PERIOD_D1)    return("1日");
    if (my_TimeFrame==PERIOD_W1)    return("1周");
    if (my_TimeFrame==PERIOD_MN1)   return("1月");
    if (my_TimeFrame==PERIOD_CURRENT)   return((string)Period()+"分钟");
    return((string)my_TimeFrame+"分钟");
}

/*
函    数：有效时间段
输出参数：true-有效  false-无效
算    法：
*/
bool egTimeValid(string myStartTime,    //开始时间，标准格式为hh:mm
                 string myEndTime,      //结束时间，标准格式为hh:mm
                 bool myServerTime      //true为服务器时间, false为计算机时间
                )
{
    if (myStartTime==myEndTime) return(true);
    int myST=0,myET=0;
    if (myServerTime==true) //计算服务器起止时间
    {
        myST=(int)StrToTime((string)Year()+"."+(string)Month()+"."+(string)Day()+" "+myStartTime);
        myET=(int)StrToTime((string)Year()+"."+(string)Month()+"."+(string)Day()+" "+myEndTime);
        if (TimeCurrent()>myST && TimeCurrent()<myET) return(true);
        if (   myST>myET //开始时间大于结束时间
            && (   (TimeCurrent()>myST-1440*60 && TimeCurrent()<myET) //早上时间段
                || TimeCurrent()>myST //晚上时间段
               )
           )
        {
            return(true);
        }
    }
    if (myServerTime==false) //计算本地计算机起止时间
    {
        myST=(int)StrToTime(myStartTime);
        myET=(int)StrToTime(myEndTime);
        if (TimeLocal()>myST && TimeLocal()<myET) return(true);
        if (   myST>myET
            && (   (TimeLocal()>myST-1440*60 && TimeLocal()<myET)
                || TimeLocal()>myST
               )
           )
        {
            return(true);
        }
    }
    return(false);
}

/*
函    数：交易延时
输出参数：
算法说明：
*/
void egTradeDelay(int myDelayTime   //延时(毫秒)
                 )
{
    while (!IsTradeAllowed() || IsTradeContextBusy()) Sleep(myDelayTime);
    RefreshRates();
    return;
}
