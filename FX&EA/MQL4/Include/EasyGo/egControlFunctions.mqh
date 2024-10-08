//易行_控制函数
#include    <EasyGo\egEnvironmentVariables.mqh>     //环境变量
#include    <EasyGo\egOrdersVariables.mqh>          //订单变量
#import     "EasyGo\\egControlFunctions.ex4"

/*
函    数:数组平仓
输出参数:false-平仓失败,true-平仓成功
算    法:
*/
bool egArrayClose(int    &myCloseArray[],   //平仓数组
                  const int myTradingDelay=5000 //延时
                 );

/*
函    数:一维数组排序
输出参数:冒泡，数组降序排列
算    法:
*/
void egArraySort(double    &myArray[], //目标数组
                );

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
                        );

/*
函    数:k线平均高度
输出参数:-1 无输出
算    法:
取最近ShiftNum个k线，计算实体均高
*/
int egBarAvgHigh(int ShiftNum  //k线数量
                );

/*
函    数:基于起点的k线平均高度
输出参数:-1 无输出
算    法:
取从myPos开始最近ShiftNum个k线，计算实体均高
*/
int egBarAvgHighByPos(int myPos, //k线起点
                      int ShiftNum  //k线数量
                     );

/*
函    数:条件平仓
输出参数:false-平仓失败,true-平仓成功
算    法:
*/
bool egCloseByCondition(TradesOrders &myTO[], //持仓单源数组
                        int &myCloseTicket[], //平仓单目标数组
                        int myType, //平仓单类型 0-Buy,1-Sell,2-BuyLimit,3-SellLimit,4-BuyStop,5-SellStop,9-所有
                        int myMode //平仓模式 0=浮赢,2=浮亏,9=任意
                       );

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
                );

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
                );

/*
函    数:查找是否有指定注释的订单
输出参数:订单号，-1为没有
算    法:
*/
int egFindCommentOrder(TradesOrders &myTO[],    //持仓单数组
                       string       myComment,  //订单注释
                       int          myType,     //订单类型,9-任意类型
                       int          myMagicNum  //订单特征码,-1全部
                      );

/*
函    数:查找是否有指定程序识别码的订单
输出参数:订单号，-1为没有
算    法:
*/
int egFindMagicNumberOrder(TradesOrders &myTO[], //持仓单数组
                           int          myMagicNum, //订单特征码,-1全部
                           int          myType //订单类型,9-任意类型
                          );

/*
函    数：金额转换建仓量
输出参数：-1表示转换失败
算    法：
*/
double egFundsToHands(string mySymbol,  //货币对名称
                      double myFunds    //资金基数
                     );

/*
函    数:获取错误信息
输出参数:中文错误信息
算    法:
*/
string egGetErrorInfo(int myErrorNum //错误代码
                     );

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
                 );

/*
函    数:基于基数百分比的建仓量
输出参数:建仓量
算    法:
按指定基数百分比计算建仓量。建仓比例≤0,或不足最小建仓量,按最小建仓量计算
*/
double egLotsByBaseAmount(double myScale,       //建仓比例
                          double myBaseAmount   //基数
                         );

/*
函    数:建仓量整形
输出参数:符合平台规定格式的开仓量。-1表示整形失败
算    法:调整不规范的开仓量数据，按照四舍五入原则及平台开仓量格式规范数据
*/
double egLotsFormat(string   mySymbol,   //货币对名称
                    double   myLots      //需要整形的开仓量
                   );

/*
函    数:指定开仓量、开仓价浮动利润
输出参数:当前报价利润
算    法:
*/
double egLotsOpenpriceToProfit(string    mySymbol,       //货币对名称
                               double    mySpecifyLots,  //指定开仓量
                               double    mySpecifyPrice, //指定开仓价
                               int       mySpecifyType   //指定类型,买入或者卖出
                              );

/*
函    数:指定开仓量、利润转点数
输出参数:点数
算    法:
*/
int egLotsProfitToPoint(string    mySymbol,        //货币对名称
                        double    mySpecifyLots,   //指定开仓量
                        double    mySpecifyProfit  //指定利润
                       );

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
                         );

/*
函    数:持仓商品
输出参数:商品名称数组
算    法:
*/
void egTradingSymbols(string   &mySymbol[] //商品名称数组
                     );

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
           );

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
              );

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
                        );

/*
函    数:建仓、加仓
输出参数:true-建仓成功，false-建仓失败
算    法:建仓、加仓
*/
bool egOrderCreat(int           myType,         //建仓类型
                  double        myLots,         //建仓量
                  string        myComment,      //订单注释
                  int           myMagicNum,     //程序控制码
                  SymbolInfo    &mySI,          //商品信息
                  double        myPrice         //建仓价
                 );

/*
函    数：订单利润转换点数
输出参数：订单净值点数
算法说明：
*/
int egOrderEquitToPoint(int myTicket    //订单号
                       );

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
                         );

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
                            );

/*
函    数：订单定位
输出参数：持仓单在myTO数组中的位置,-1表示找不到订单
算法说明：
*/
int egOrderPos(TradesOrders     &myTO[],    //持仓单数组
               int              myTicket    //订单号
              );

/*
函    数：历史单定位
输出参数：持仓单在myHO数组中的位置,-1表示找不到订单
算法说明：
*/
int egOrderPosHst(HistoryOrders    &myHO[],    //历史单数组
                  int              myTicket    //订单号
                 );

/*
函    数：持仓单数组按类型排序
输出参数：
算法说明：冒泡
针对指定的订单数组执行按组合条件降序排序。
*/
void egOrdersArraySort(TradesOrders     &myTO[],    //持仓单数组
                       string           mySymbol,   //商品名称，Symbol()为当前图表商品名，"*"为所有商品
                       int              mySeekMode  //排序类型 0-按建仓时间,1-按建仓价,2、3-按利润
                      );

/*
函    数：历史单数组按类型排序
输出参数：
算法说明：冒泡
针对指定的订单数组执行按组合条件降序排序。
*/
void egOrdersArraySortHst(HistoryOrders     &myHO[],    //持仓单数组
                          string            mySymbol,   //商品名称，Symbol()为当前图表商品名，"*"为所有商品
                          int               mySeekMode  //排序类型 0-按建仓时间,1-按建仓价,2、3-按利润,4-按平仓时间
                         );

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
                   );

/*
函    数：刷新环境变量(当前商品)
输出参数：
算法说明：
*/
bool    egRefreshEV(AccountInfo   &myAI,    //账户信息
                    SymbolInfo    &mySI     //商品信息
                   );

/*
函    数：刷新环境变量(指定商品)
输出参数：
算法说明：
*/
bool    egRefreshEV_Specify(string        mySymbol, //指定商品
                            AccountInfo   &myAI,    //账户信息
                            SymbolInfo    &mySI     //商品信息
                           );

/*
函    数：刷新历史单数组
输出参数：历史单数量 
算法说明：
*/
int egRefreshHO(HistoryOrders   &myHO[],    //历史单数组
                string          mySymbol,   //指定商品，"*"表示所有持仓单
                int             myMagicNum  //程序识别码, -1表示所有持仓单
               );

/*
函    数：刷新部分历史单数组
输出参数：历史单数量 
算法说明：刷新指定时间之后的历史单记录
*/
int egRefreshHO_byCloseTime(HistoryOrders   &myHO[],    //历史单数组
                            string          mySymbol,   //指定商品，"*"表示所有持仓单
                            int             myMagicNum,  //程序识别码, -1表示所有持仓单
                            const datetime  myStartTime=0 //历史单平仓开始时间
                           );

/*
函    数:刷新历史单统计信息
输出参数:false-未统计，true-已统计
算    法:统计myHO数组，给myHS赋值。
*/
bool egRefreshHS(HistoryOrders       &myHO[],    //持仓单数组
                 HistoryStatistical  &myHS       //统计结果
                );

/*
函    数：刷新持仓单数组
输出参数：持仓单数量 
算法说明：
*/
int egRefreshTO(TradesOrders    &myTO[],    //持仓单数组
                string          mySymbol,   //指定商品，"*"表示所有持仓单
                int             myMagicNum  //程序识别码, -1表示所有持仓单
               );

/*
函    数:刷新持仓单统计信息
输出参数:false-未统计，true-已统计
算    法:统计myTO数组，给myTS赋值。其中最大盈利、最大亏损、最大保证金占用不重新计算
*/
bool egRefreshTS(TradesOrders       &myTO[],    //持仓单数组
                 TradesStatistical  &myTS,      //统计结果
                 AccountInfo        &myAI,      //账户信息
                 SymbolInfo         &mySI       //商品信息
                );

/*
函    数:订单类型转中文字符
输出参数:6个常用订单类型
算法说明:
*/
string  egOrderTypeToString(int     myType  //订单类型
                           );

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
            double                  myBudgetRate                //对冲平衡系数(=盈利/亏损)
           );

/*
函    数:预算同向盈利对冲
输出参数:myBudget[0]-建仓量，myBudget[1]-止盈价
算    法:
*/
void egSDHRData(double &myBudget[2],       //预算数组  myBudget[0]-建仓量，myBudget[1]-止盈价
                int    myType,             //订单组类型
                double myPrice1,           //已有持仓单建仓价
                double myLots1,            //已有持仓单建仓量
                double myPrice2,           //加仓单建仓价
                double myBackInterval      //回调间距(元)
               );

/*
函    数:推送信息
输出参数:true-成功，False-不推送
算    法:
*/
bool egSendInfo(string  myInfo,                 //推送信息
                bool    my_Alert_Window=false,  //弹出窗口推送
                bool    my_Alert_EMail=false,   //邮件推送
                bool    my_Alert_APP=false      //手机APP推送
               );

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
                     );

/*
函    数:时间框架转中文字符
输出参数:
算法说明:
*/
string  egTimeFrameToString(ENUM_TIMEFRAMES     my_TimeFrame      //时间周期
                           );

/*
函    数：有效时间段
输出参数：true-有效  false-无效
算    法：
*/
bool egTimeValid(string myStartTime,    //开始时间，标准格式为hh:mm
                 string myEndTime,      //结束时间，标准格式为hh:mm
                 bool myServerTime      //true为服务器时间, false为计算机时间
                );

/*
函    数：交易延时
输出参数：
算法说明：
*/
void egTradeDelay(int myDelayTime   //延时(毫秒)
                 );
