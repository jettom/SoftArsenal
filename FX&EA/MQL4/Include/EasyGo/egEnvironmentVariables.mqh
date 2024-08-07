//易行_环境变量
const string egFILE_PATH="EasyGo\\"; //文件路径

//--- 账户信息
struct  AccountInfo
{
    bool        trade_allowed;      //是否允许交易
    bool        trade_expert;       //是否允许智能交易
    
    int         trade_mode;         //账户类型
    int         margin_so_mode;     //强平模式(0-百分比,1-金额)
    long        login;              //账号
    long        leverage;           //杠杆
    long        limit_orders;       //最大持仓单数量
    
    double      balance;            //余额
    double      credit;             //信用
    double      profit;             //利润
    double      equity;             //净值
    double      margin;             //已用保证金
    double      margin_free;        //可用保证金
    double      margin_level;       //保证金水平
    double      margin_so_call;     //追加保证金水平
    double      margin_so_so;       //保证金强平水平
    
    string      name;               //账户名称
    string      server;             //服务器名称
    string      currency;           //结算货币
    string      company;            //服务商名称
    string      trade_symbols[];    //持仓商品名称列表(数组)
};

//--- 商品信息
struct  SymbolInfo
{
    bool        select;                 //是否商品可视
    bool        spread_float;           //是否浮动点差
    
    int         symbols_total;          //商品总数
    int         digits;                 //报价小数位数
    int         spread;                 //点差
    int         trade_stop_level;       //停止水平
    int         trade_calc_mode;        //合同价计算模式
    int         trade_mode;             //订单执行类型(0-禁止,1-Buy,2-Sell,3-只允许平仓,4-无限制)
    int         trade_exemode;          //合约执行模式(mql4无效  0-请求执行,1-即时执行,2-市场执行,3-交易执行)
    
    long        trade_freeze_level;     //冻结水平
    long        swap_mode;              //掉期计算模式
    long        swap_rollover3days;     //掉期执行日(0-周日,1-周一,2-周二,3-周三,4-周四,5-周五,6-周六)
    
    datetime    time;                   //最后报价时间
    datetime    start_time;             //商品开始交易时间(期货)
    datetime    expiration_time;        //商品结束交易时间(期货)
    
    double      bid;                    //卖出报价
    double      ask;                    //买入报价
    double      mid_price;              //中间报价
    double      unit_lots;              //单位仓量
    double      unit_high;              //单位高度
    double      unit_profit;            //单位利润
    double      point;                  //报价单位
    double      trade_tick_value;       //单点价值
    double      trade_tick_size;        //最小变动价位
    double      trade_contract_size;    //合约大小
    double      volume_min;             //最小建仓量
    double      volume_max;             //最大建仓量
    double      volum_step;             //最小建仓递增量
    double      swap_long;              //Buy单掉期
    double      swap_short;             //Sell单掉期
    double      margin_initial;         //初始保证金
    double      margin_maintenance;     //维持保证金
    double      margin_hedged;          //对冲保证金
    double      margin_required;        //1标准手保证金
    
    string      currency_base;          //基本货币
    string      currency_profit;        //利润货币
    string      currency_margin;        //保证金货币
    string      descript;               //商品描述
    string      path;                   //商品分类
    string      symbol;                 //当前商品名称
};
