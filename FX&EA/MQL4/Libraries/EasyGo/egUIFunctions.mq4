//易行_界面函数
#property library
/*
函    数:输出箭头到图表
输出参数:true-输出成功
算    法:
*/
bool    egArrowOut(const   bool                 isout=true,             //允许输出
                   const   long                 chart_ID=0,             //主图ID
                   const   string               name="Arrow",           //对象名称
                   const   int                  sub_window=0,           //副图编号
                   const   datetime             time=0,                 //标注点k线时间
                   const   double               price=0,                //标注点k线价格
                   const   uchar                arrow_code=252,         //箭头代码
                   const   ENUM_ARROW_ANCHOR    anchor=ANCHOR_BOTTOM,   //锚点
                   const   color                clr=clrRed,             //箭头颜色
                   const   ENUM_LINE_STYLE      style=STYLE_SOLID,      //显示类新型
                   const   int                  width=3,                //箭头尺寸
                   const   bool                 back=false,             //设置为背景
                   const   bool                 selection=false,        //高亮移动
                   const   bool                 hidden=true,            //列表中隐藏对象名
                   const   long                 z_order=0               // priority for mouse click 
                  )
{
    if (!isout) return(true);
    //更改对象属性
    if (ObjectFind(chart_ID,name)!=-1)
    {
        ObjectSetInteger(chart_ID,name,OBJPROP_TIME,time);
        ObjectSetDouble(chart_ID,name,OBJPROP_PRICE,price);
        ObjectSetInteger(chart_ID,name,OBJPROP_ARROWCODE,arrow_code); 
        ObjectSetInteger(chart_ID,name,OBJPROP_ANCHOR,anchor); 
        ObjectSetInteger(chart_ID,name,OBJPROP_COLOR,clr); 
        ObjectSetInteger(chart_ID,name,OBJPROP_STYLE,style); 
        ObjectSetInteger(chart_ID,name,OBJPROP_WIDTH,width); 
        ObjectSetInteger(chart_ID,name,OBJPROP_BACK,back); 
        ObjectSetInteger(chart_ID,name,OBJPROP_SELECTABLE,selection); 
        ObjectSetInteger(chart_ID,name,OBJPROP_SELECTED,selection); 
        ObjectSetInteger(chart_ID,name,OBJPROP_HIDDEN,hidden); 
        ObjectSetInteger(chart_ID,name,OBJPROP_ZORDER,z_order); 
        return(true);
    }
    //创建输出对象
    ObjectCreate(chart_ID,name,OBJ_ARROW,sub_window,time,price);
    ObjectSetInteger(chart_ID,name,OBJPROP_ARROWCODE,arrow_code); 
    ObjectSetInteger(chart_ID,name,OBJPROP_ANCHOR,anchor); 
    ObjectSetInteger(chart_ID,name,OBJPROP_COLOR,clr); 
    ObjectSetInteger(chart_ID,name,OBJPROP_STYLE,style); 
    ObjectSetInteger(chart_ID,name,OBJPROP_WIDTH,width); 
    ObjectSetInteger(chart_ID,name,OBJPROP_BACK,back); 
    ObjectSetInteger(chart_ID,name,OBJPROP_SELECTABLE,selection); 
    ObjectSetInteger(chart_ID,name,OBJPROP_SELECTED,selection); 
    ObjectSetInteger(chart_ID,name,OBJPROP_HIDDEN,hidden); 
    ObjectSetInteger(chart_ID,name,OBJPROP_ZORDER,z_order); 
    return(true);
}

/*
函    数:输出Bit图片到图表(时间-价格)
输出参数:true-输出成功
算    法:
*/
bool    egBitmapOut(const   bool              isout=true,               //允许输出
                    const   long              chart_ID=0,               //主图ID
                    const   string            name="Bitmap",            //对象名称
                    const   int               sub_window=0,             //副图编号
                            datetime          time=0,                   //锚点时间 
                            double            price=0,                  //锚点价格 
                    const   string            file="",                  //图片文件名 
                    const   int               width=10,                 //对象宽度
                    const   int               height=10,                //对象高度
                    const   int               x_offset=0,               // X轴偏移
                    const   int               y_offset=0,               //Y轴偏移
                    const   color             clr=clrRed,               //背景颜色
                    const   ENUM_LINE_STYLE   style=STYLE_SOLID,        //线型
                    const   int               point_width=1,            //移动尺寸
                    const   bool              back=false,               //设置为背景
                    const   bool              selection=false,          //高亮移动
                    const   bool              hidden=true,              //列表中隐藏对象名
                    const   long              z_order=0                 // priority for mouse click 
                   )
{
    if (!isout) return(true);
    //更改对象属性
    if (ObjectFind(chart_ID,name)!=-1)
    {
        ObjectSetInteger(chart_ID,name,OBJPROP_TIME,time);
        ObjectSetDouble(chart_ID,name,OBJPROP_PRICE,price);
        ObjectSetString(chart_ID,name,OBJPROP_BMPFILE,file);
        ObjectSetInteger(chart_ID,name,OBJPROP_XSIZE,width); 
        ObjectSetInteger(chart_ID,name,OBJPROP_YSIZE,height); 
        ObjectSetInteger(chart_ID,name,OBJPROP_XOFFSET,x_offset); 
        ObjectSetInteger(chart_ID,name,OBJPROP_YOFFSET,y_offset); 
        ObjectSetInteger(chart_ID,name,OBJPROP_COLOR,clr); 
        ObjectSetInteger(chart_ID,name,OBJPROP_STYLE,style); 
        ObjectSetInteger(chart_ID,name,OBJPROP_WIDTH,point_width); 
        ObjectSetInteger(chart_ID,name,OBJPROP_BACK,back); 
        ObjectSetInteger(chart_ID,name,OBJPROP_SELECTABLE,selection); 
        ObjectSetInteger(chart_ID,name,OBJPROP_SELECTED,selection); 
        ObjectSetInteger(chart_ID,name,OBJPROP_HIDDEN,hidden); 
        ObjectSetInteger(chart_ID,name,OBJPROP_ZORDER,z_order); 
        return(true);
    }
    //创建输出对象
    ObjectCreate(chart_ID,name,OBJ_BITMAP,sub_window,time,price);
    ObjectSetString(chart_ID,name,OBJPROP_BMPFILE,file);
    ObjectSetInteger(chart_ID,name,OBJPROP_XSIZE,width); 
    ObjectSetInteger(chart_ID,name,OBJPROP_YSIZE,height); 
    ObjectSetInteger(chart_ID,name,OBJPROP_XOFFSET,x_offset); 
    ObjectSetInteger(chart_ID,name,OBJPROP_YOFFSET,y_offset); 
    ObjectSetInteger(chart_ID,name,OBJPROP_COLOR,clr); 
    ObjectSetInteger(chart_ID,name,OBJPROP_STYLE,style); 
    ObjectSetInteger(chart_ID,name,OBJPROP_WIDTH,point_width); 
    ObjectSetInteger(chart_ID,name,OBJPROP_BACK,back); 
    ObjectSetInteger(chart_ID,name,OBJPROP_SELECTABLE,selection); 
    ObjectSetInteger(chart_ID,name,OBJPROP_SELECTED,selection); 
    ObjectSetInteger(chart_ID,name,OBJPROP_HIDDEN,hidden); 
    ObjectSetInteger(chart_ID,name,OBJPROP_ZORDER,z_order); 
    return(true);
}

/*
函    数:输出Bit图片到图表(像素)
输出参数:true-输出成功
算    法:
*/
bool    egBitmapLableOut(const   bool              isout=true,               //允许输出
                         const   long              chart_ID=0,               //主图ID
                         const   string            name="BmpLabel",          //对象名称
                         const   int               sub_window=0,             //副图编号
                         const   int               x=0,                      //x坐标
                         const   int               y=0,                      //y坐标
                         const   string            file_on="",               //On模式图片名
                         const   string            file_off="",              //Off模式图片名
                         const   int               width=10,                 //对象宽度
                         const   int               height=10,                //对象高度
                         const   int               x_offset=0,               //X轴偏移
                         const   int               y_offset=0,               //Y轴偏移
                         const   bool              state=false,              //按下/松开 
                         const   ENUM_BASE_CORNER  corner=CORNER_LEFT_UPPER, //锚点位置
                         const   ENUM_ANCHOR_POINT anchor=ANCHOR_LEFT_UPPER, //锚类型
                         const   color             clr=clrRed,               //背景颜色
                         const   ENUM_LINE_STYLE   style=STYLE_SOLID,        //线型
                         const   int               point_width=1,            //移动尺寸
                         const   bool              back=false,               //设置为背景
                         const   bool              selection=false,          //高亮移动
                         const   bool              hidden=true,              //列表中隐藏对象名
                         const   long              z_order=0                 //priority for mouse click 
                   )
{
    if (!isout) return(true);
    //更改对象属性
    if (ObjectFind(chart_ID,name)!=-1)
    {
        ObjectCreate(chart_ID,name,OBJ_BITMAP_LABEL,sub_window,0,0);
        ObjectSetString(chart_ID,name,OBJPROP_BMPFILE,0,file_on);
        ObjectSetString(chart_ID,name,OBJPROP_BMPFILE,1,file_off);
        ObjectSetInteger(chart_ID,name,OBJPROP_XDISTANCE,x); 
        ObjectSetInteger(chart_ID,name,OBJPROP_YDISTANCE,y); 
        ObjectSetInteger(chart_ID,name,OBJPROP_XSIZE,width); 
        ObjectSetInteger(chart_ID,name,OBJPROP_YSIZE,height); 
        ObjectSetInteger(chart_ID,name,OBJPROP_XOFFSET,x_offset); 
        ObjectSetInteger(chart_ID,name,OBJPROP_YOFFSET,y_offset); 
        ObjectSetInteger(chart_ID,name,OBJPROP_STATE,state); 
        ObjectSetInteger(chart_ID,name,OBJPROP_CORNER,corner); 
        ObjectSetInteger(chart_ID,name,OBJPROP_ANCHOR,anchor); 
        ObjectSetInteger(chart_ID,name,OBJPROP_COLOR,clr); 
        ObjectSetInteger(chart_ID,name,OBJPROP_STYLE,style); 
        ObjectSetInteger(chart_ID,name,OBJPROP_WIDTH,point_width); 
        ObjectSetInteger(chart_ID,name,OBJPROP_BACK,back); 
        ObjectSetInteger(chart_ID,name,OBJPROP_SELECTABLE,selection); 
        ObjectSetInteger(chart_ID,name,OBJPROP_SELECTED,selection); 
        ObjectSetInteger(chart_ID,name,OBJPROP_HIDDEN,hidden); 
        ObjectSetInteger(chart_ID,name,OBJPROP_ZORDER,z_order); 
        return(true);
    }
    //创建输出对象
    ObjectCreate(chart_ID,name,OBJ_BITMAP_LABEL,sub_window,0,0);
    ObjectSetString(chart_ID,name,OBJPROP_BMPFILE,0,file_on);
    ObjectSetString(chart_ID,name,OBJPROP_BMPFILE,1,file_off);
    ObjectSetInteger(chart_ID,name,OBJPROP_XDISTANCE,x); 
    ObjectSetInteger(chart_ID,name,OBJPROP_YDISTANCE,y); 
    ObjectSetInteger(chart_ID,name,OBJPROP_XSIZE,width); 
    ObjectSetInteger(chart_ID,name,OBJPROP_YSIZE,height); 
    ObjectSetInteger(chart_ID,name,OBJPROP_XOFFSET,x_offset); 
    ObjectSetInteger(chart_ID,name,OBJPROP_YOFFSET,y_offset); 
    ObjectSetInteger(chart_ID,name,OBJPROP_STATE,state); 
    ObjectSetInteger(chart_ID,name,OBJPROP_CORNER,corner); 
    ObjectSetInteger(chart_ID,name,OBJPROP_ANCHOR,anchor); 
    ObjectSetInteger(chart_ID,name,OBJPROP_COLOR,clr); 
    ObjectSetInteger(chart_ID,name,OBJPROP_STYLE,style); 
    ObjectSetInteger(chart_ID,name,OBJPROP_WIDTH,point_width); 
    ObjectSetInteger(chart_ID,name,OBJPROP_BACK,back); 
    ObjectSetInteger(chart_ID,name,OBJPROP_SELECTABLE,selection); 
    ObjectSetInteger(chart_ID,name,OBJPROP_SELECTED,selection); 
    ObjectSetInteger(chart_ID,name,OBJPROP_HIDDEN,hidden); 
    ObjectSetInteger(chart_ID,name,OBJPROP_ZORDER,z_order); 
    return(true);
}

/*
函    数:输出按钮到图表
输出参数:true-输出成功
算    法:
*/
bool    egButtonOut(const   bool              isout=true,               //允许输出
                    const   long              chart_ID=0,               //主图ID
                    const   string            name="Button",            //对象名称
                    const   int               sub_window=0,             //副图编号
                    const   int               x=0,                      //x坐标
                    const   int               y=0,                      //y坐标
                    const   int               width=50,                 //按钮宽度
                    const   int               height=18,                //按钮高度
                    const   ENUM_BASE_CORNER  corner=CORNER_LEFT_UPPER, //锚点
                    const   string            text="Button",            //按钮文字
                    const   string            font="Arial",             //文字字体
                    const   int               font_size=10,             //文字尺寸
                    const   color             clr=clrBlack,             //文字颜色
                    const   color             back_clr=clrGray,         //背景色
                    const   color             border_clr=clrNONE,       //边框色
                    const   bool              state=false,              //按下状态
                    const   bool              back=false,               //设置为背景
                    const   bool              selection=false,          //高亮移动
                    const   bool              hidden=true,              //列表中隐藏对象名
                    const   long              z_order=0                 // priority for mouse click
                   )
{
    if (!isout) return(true);
    //更改对象属性
    if (ObjectFind(chart_ID,name)!=-1)
    {
        ObjectSetInteger(chart_ID,name,OBJPROP_XDISTANCE,x);
        ObjectSetInteger(chart_ID,name,OBJPROP_YDISTANCE,y);
        ObjectSetInteger(chart_ID,name,OBJPROP_XSIZE,width);
        ObjectSetInteger(chart_ID,name,OBJPROP_YSIZE,height);
        ObjectSetInteger(chart_ID,name,OBJPROP_CORNER,corner);
        ObjectSetString(chart_ID,name,OBJPROP_TEXT,text);
        ObjectSetString(chart_ID,name,OBJPROP_FONT,font);
        ObjectSetInteger(chart_ID,name,OBJPROP_FONTSIZE,font_size);
        ObjectSetInteger(chart_ID,name,OBJPROP_COLOR,clr);
        ObjectSetInteger(chart_ID,name,OBJPROP_BGCOLOR,back_clr);
        ObjectSetInteger(chart_ID,name,OBJPROP_BORDER_COLOR,border_clr);
        ObjectSetInteger(chart_ID,name,OBJPROP_BACK,back);
        ObjectSetInteger(chart_ID,name,OBJPROP_STATE,state);
        ObjectSetInteger(chart_ID,name,OBJPROP_SELECTABLE,selection);
        ObjectSetInteger(chart_ID,name,OBJPROP_SELECTED,selection);
        ObjectSetInteger(chart_ID,name,OBJPROP_HIDDEN,hidden);
        ObjectSetInteger(chart_ID,name,OBJPROP_ZORDER,z_order);
        return(true);
    }
    //创建输出对象
    ObjectCreate(chart_ID,name,OBJ_BUTTON,sub_window,0,0);
    ObjectSetInteger(chart_ID,name,OBJPROP_XDISTANCE,x);
    ObjectSetInteger(chart_ID,name,OBJPROP_YDISTANCE,y);
    ObjectSetInteger(chart_ID,name,OBJPROP_XSIZE,width);
    ObjectSetInteger(chart_ID,name,OBJPROP_YSIZE,height);
    ObjectSetInteger(chart_ID,name,OBJPROP_CORNER,corner);
    ObjectSetString(chart_ID,name,OBJPROP_TEXT,text);
    ObjectSetString(chart_ID,name,OBJPROP_FONT,font);
    ObjectSetInteger(chart_ID,name,OBJPROP_FONTSIZE,font_size);
    ObjectSetInteger(chart_ID,name,OBJPROP_COLOR,clr);
    ObjectSetInteger(chart_ID,name,OBJPROP_BGCOLOR,back_clr);
    ObjectSetInteger(chart_ID,name,OBJPROP_BORDER_COLOR,border_clr);
    ObjectSetInteger(chart_ID,name,OBJPROP_BACK,back);
    ObjectSetInteger(chart_ID,name,OBJPROP_STATE,state);
    ObjectSetInteger(chart_ID,name,OBJPROP_SELECTABLE,selection);
    ObjectSetInteger(chart_ID,name,OBJPROP_SELECTED,selection);
    ObjectSetInteger(chart_ID,name,OBJPROP_HIDDEN,hidden);
    ObjectSetInteger(chart_ID,name,OBJPROP_ZORDER,z_order);
    return(true);
}

/*
函    数:输出信息到图表
输出参数:true-成功
算    法:
*/
bool    egCommentOut(const    bool    isout=true,   //允许输出
                     const    string  text="text"   //输出信息
                    )
{
    if (isout) Comment(text);
    return(true);
}

/*
函    数:画k线
输出参数:
算    法:
*/
void egDrawCandle(const long        myChartID,      //主图ID
                  const int         myWindow,       //副图编号
                  const string      object_name1,   //实体对象名称
                  const string      object_name2,   //引线对象名称
                  const datetime    &time,          //时间
                  const double      &open_price,    //开盘价
                  const double      &high_price,    //最高价
                  const double      &low_price,     //最低价
                  const double      &close_price,   //收盘价
                  const color       candle_color,   //k线颜色
                  const int         body_width=3,   //实体宽度
                  const int         wick_width=1    //引线宽度
                 )
{
    //画实体
    if(ObjectFind(myChartID,object_name1)!=-1) ObjectDelete(myChartID,object_name1);
    if(!ObjectCreate(myChartID,object_name1,OBJ_TREND,myWindow,time,open_price,time,close_price)) Print(__FUNCTION__,": error ",GetLastError());
    ObjectSetInteger(myChartID,object_name1,OBJPROP_WIDTH,body_width);
    ObjectSetInteger(myChartID,object_name1,OBJPROP_COLOR,candle_color);
    ObjectSetInteger(myChartID,object_name1,OBJPROP_RAY,false);
    ObjectSetInteger(myChartID,object_name1,OBJPROP_HIDDEN,true);
    ObjectSetInteger(myChartID,object_name1,OBJPROP_SELECTABLE,false);
    //画引线
    if(ObjectFind(myChartID,object_name2)!=-1) ObjectDelete(myChartID,object_name2);
    if(!ObjectCreate(myChartID,object_name2,OBJ_TREND,myWindow,time,high_price,time,low_price)) Print(__FUNCTION__,": error ",GetLastError());
    ObjectSetInteger(myChartID,object_name2,OBJPROP_WIDTH,wick_width);
    ObjectSetInteger(myChartID,object_name2,OBJPROP_COLOR,candle_color);
    ObjectSetInteger(myChartID,object_name2,OBJPROP_RAY,false);
    ObjectSetInteger(myChartID,object_name2,OBJPROP_HIDDEN,true);
    ObjectSetInteger(myChartID,object_name2,OBJPROP_SELECTABLE,false);
   return;
}

/*
函    数:输出可编辑文字到图表
输出参数:true-输出成功
算    法:
*/
bool    egEditOut(const     bool             isout=true,               //允许输出
                  const     long             chart_ID=0,               //主图ID
                  const     string           name="Edit",              //对象名称
                  const     int              sub_window=0,             //副图编号
                  const     int              x=0,                      //x坐标
                  const     int              y=0,                      //y坐标
                  const     int              width=50,                 //编辑框宽度
                  const     int              height=18,                //编辑框高度
                  const     string           text="Text",              //编辑内容
                  const     string           font="Arial",             //字体
                  const     int              font_size=10,             //字号
                  const     ENUM_ALIGN_MODE  align=ALIGN_CENTER,       //对齐方式
                  const     bool             read_only=false,          //禁止编辑
                  const     ENUM_BASE_CORNER corner=CORNER_LEFT_UPPER, //锚点
                  const     color            clr=clrBlack,             //字色
                  const     color            back_clr=clrWhite,        //背景色
                  const     color            border_clr=clrNONE,       //边框色
                  const     bool             back=false,               //设置为背景
                  const     bool             selection=false,          //高亮移动
                  const     bool             hidden=true,              //列表中隐藏对象名
                  const     long             z_order=0                 // priority for mouse click
                 )
{
    if (!isout) return(true);
    //更改对象属性
    if (ObjectFind(chart_ID,name)!=-1)
    {
        ObjectSetInteger(chart_ID,name,OBJPROP_XDISTANCE,x);
        ObjectSetInteger(chart_ID,name,OBJPROP_YDISTANCE,y);
        ObjectSetInteger(chart_ID,name,OBJPROP_XSIZE,width);
        ObjectSetInteger(chart_ID,name,OBJPROP_YSIZE,height);
        ObjectSetString(chart_ID,name,OBJPROP_TEXT,text);
        ObjectSetString(chart_ID,name,OBJPROP_FONT,font);
        ObjectSetInteger(chart_ID,name,OBJPROP_FONTSIZE,font_size);
        ObjectSetInteger(chart_ID,name,OBJPROP_ALIGN,align);
        ObjectSetInteger(chart_ID,name,OBJPROP_READONLY,read_only);
        ObjectSetInteger(chart_ID,name,OBJPROP_CORNER,corner);
        ObjectSetInteger(chart_ID,name,OBJPROP_COLOR,clr);
        ObjectSetInteger(chart_ID,name,OBJPROP_BGCOLOR,back_clr);
        ObjectSetInteger(chart_ID,name,OBJPROP_BORDER_COLOR,border_clr);
        ObjectSetInteger(chart_ID,name,OBJPROP_BACK,back);
        ObjectSetInteger(chart_ID,name,OBJPROP_SELECTABLE,selection);
        ObjectSetInteger(chart_ID,name,OBJPROP_SELECTED,selection);
        ObjectSetInteger(chart_ID,name,OBJPROP_HIDDEN,hidden);
        ObjectSetInteger(chart_ID,name,OBJPROP_ZORDER,z_order);
        return(true);
    }
    //创建输出对象
    ObjectCreate(chart_ID,name,OBJ_EDIT,sub_window,0,0);
    ObjectSetInteger(chart_ID,name,OBJPROP_XDISTANCE,x);
    ObjectSetInteger(chart_ID,name,OBJPROP_YDISTANCE,y);
    ObjectSetInteger(chart_ID,name,OBJPROP_XSIZE,width);
    ObjectSetInteger(chart_ID,name,OBJPROP_YSIZE,height);
    ObjectSetString(chart_ID,name,OBJPROP_TEXT,text);
    ObjectSetString(chart_ID,name,OBJPROP_FONT,font);
    ObjectSetInteger(chart_ID,name,OBJPROP_FONTSIZE,font_size);
    ObjectSetInteger(chart_ID,name,OBJPROP_ALIGN,align);
    ObjectSetInteger(chart_ID,name,OBJPROP_READONLY,read_only);
    ObjectSetInteger(chart_ID,name,OBJPROP_CORNER,corner);
    ObjectSetInteger(chart_ID,name,OBJPROP_COLOR,clr);
    ObjectSetInteger(chart_ID,name,OBJPROP_BGCOLOR,back_clr);
    ObjectSetInteger(chart_ID,name,OBJPROP_BORDER_COLOR,border_clr);
    ObjectSetInteger(chart_ID,name,OBJPROP_BACK,back);
    ObjectSetInteger(chart_ID,name,OBJPROP_SELECTABLE,selection);
    ObjectSetInteger(chart_ID,name,OBJPROP_SELECTED,selection);
    ObjectSetInteger(chart_ID,name,OBJPROP_HIDDEN,hidden);
    ObjectSetInteger(chart_ID,name,OBJPROP_ZORDER,z_order);
 
    return(true);
}

/*
函    数:输出水平线到图表
输出参数:true-输出成功
算    法:
*/
bool    egHLineOut(const    bool            isout=true,         //允许输出
                   const    long            chart_ID=0,         //主图ID
                   const    string          name="HLine",       //对象名称
                   const    int             sub_window=0,       //副图编号
                   const    double          price=0,            //线价格
                   const    color           clr=clrRed,         //线色
                   const    ENUM_LINE_STYLE style=STYLE_SOLID,  //线型
                   const    int             width=1,            //线宽
                   const    bool            back=false,         //设置为背景
                   const    bool            selection=true,     //高亮移动
                   const    bool            hidden=true,        //列表中隐藏对象名
                   const    long            z_order=0           // priority for mouse click
                 )
{
    if (!isout) return(true);
    //更改对象属性
    if (ObjectFind(chart_ID,name)!=-1)
    {
        ObjectSetDouble(chart_ID,name,OBJPROP_PRICE,price);
        ObjectSetInteger(chart_ID,name,OBJPROP_COLOR,clr);
        ObjectSetInteger(chart_ID,name,OBJPROP_STYLE,style);
        ObjectSetInteger(chart_ID,name,OBJPROP_WIDTH,width);
        ObjectSetInteger(chart_ID,name,OBJPROP_BACK,back);
        ObjectSetInteger(chart_ID,name,OBJPROP_SELECTABLE,selection);
        ObjectSetInteger(chart_ID,name,OBJPROP_SELECTED,selection);
        ObjectSetInteger(chart_ID,name,OBJPROP_HIDDEN,hidden);
        ObjectSetInteger(chart_ID,name,OBJPROP_ZORDER,z_order);
        return(true);
    }
    //创建输出对象
    ObjectCreate(chart_ID,name,OBJ_HLINE,sub_window,0,price);
    ObjectSetInteger(chart_ID,name,OBJPROP_COLOR,clr);
    ObjectSetInteger(chart_ID,name,OBJPROP_STYLE,style);
    ObjectSetInteger(chart_ID,name,OBJPROP_WIDTH,width);
    ObjectSetInteger(chart_ID,name,OBJPROP_BACK,back);
    ObjectSetInteger(chart_ID,name,OBJPROP_SELECTABLE,selection);
    ObjectSetInteger(chart_ID,name,OBJPROP_SELECTED,selection);
    ObjectSetInteger(chart_ID,name,OBJPROP_HIDDEN,hidden);
    ObjectSetInteger(chart_ID,name,OBJPROP_ZORDER,z_order);
    return(true);
}

/*
函    数:输出标签到图表
输出参数:true-输出成功
算    法:
*/
bool    egLableOut(const    bool                isout=true,               //允许输出
                   const    string              text="Label",             //输出内容
                   const    string              name="Label",             //对象名称
                   const    int                 font_size=10,             //字体尺寸
                   const    color               clr=clrRed,               //字体颜色
                   const    long                chart_ID=0,               //主图ID
                   const    int                 sub_window=0,             //副图编号
                   const    ENUM_BASE_CORNER    corner=CORNER_LEFT_UPPER, //锚点
                   const    int                 x=0,                      //x坐标
                   const    int                 y=0,                      //y坐标
                   const    string              font="Arial",             //字体类型
                   const    double              angle=0.0,                //字体角度
                   const    ENUM_ANCHOR_POINT   anchor=ANCHOR_LEFT_UPPER, //原始坐标
                   const    bool                back=false,               //设置为背景
                   const    bool                selection=false,          //高亮移动
                   const    bool                hidden=true,             //列表中隐藏对象名
                   const    long                z_order=0                 //priority for mouse click
                  )
{
    if (!isout) return(true);
    if (ObjectFind(chart_ID,name)!=-1)
    {
        //修改对象属性
        ObjectSetInteger(chart_ID,name,OBJPROP_XDISTANCE,x);
        ObjectSetInteger(chart_ID,name,OBJPROP_YDISTANCE,y);
        ObjectSetInteger(chart_ID,name,OBJPROP_CORNER,corner);
        ObjectSetString(chart_ID,name,OBJPROP_TEXT,text);
        ObjectSetString(chart_ID,name,OBJPROP_FONT,font);
        ObjectSetInteger(chart_ID,name,OBJPROP_FONTSIZE,font_size);
        ObjectSetDouble(chart_ID,name,OBJPROP_ANGLE,angle);
        ObjectSetInteger(chart_ID,name,OBJPROP_ANCHOR,anchor);
        ObjectSetInteger(chart_ID,name,OBJPROP_COLOR,clr);
        ObjectSetInteger(chart_ID,name,OBJPROP_BACK,back);
        ObjectSetInteger(chart_ID,name,OBJPROP_SELECTABLE,selection);
        ObjectSetInteger(chart_ID,name,OBJPROP_SELECTED,selection);
        ObjectSetInteger(chart_ID,name,OBJPROP_HIDDEN,hidden);
        ObjectSetInteger(chart_ID,name,OBJPROP_ZORDER,z_order);
        return(true);
    }
    //创建输出对象
    ObjectCreate(chart_ID,name,OBJ_LABEL,sub_window,0,0);
    ObjectSetInteger(chart_ID,name,OBJPROP_XDISTANCE,x);
    ObjectSetInteger(chart_ID,name,OBJPROP_YDISTANCE,y);
    ObjectSetInteger(chart_ID,name,OBJPROP_CORNER,corner);
    ObjectSetString(chart_ID,name,OBJPROP_TEXT,text);
    ObjectSetString(chart_ID,name,OBJPROP_FONT,font);
    ObjectSetInteger(chart_ID,name,OBJPROP_FONTSIZE,font_size);
    ObjectSetDouble(chart_ID,name,OBJPROP_ANGLE,angle);
    ObjectSetInteger(chart_ID,name,OBJPROP_ANCHOR,anchor);
    ObjectSetInteger(chart_ID,name,OBJPROP_COLOR,clr);
    ObjectSetInteger(chart_ID,name,OBJPROP_BACK,back);
    ObjectSetInteger(chart_ID,name,OBJPROP_SELECTABLE,selection);
    ObjectSetInteger(chart_ID,name,OBJPROP_SELECTED,selection);
    ObjectSetInteger(chart_ID,name,OBJPROP_HIDDEN,hidden);
    ObjectSetInteger(chart_ID,name,OBJPROP_ZORDER,z_order);
    return(true);
}

/*
函    数:删除关键字对象
输出参数:
算    法:
*/
void egObjectsDeleteByKeyword(const  long   chart_ID=0, //主图ID
                                     string keyword=""
                             )
{
    for (int i=ObjectsTotal(chart_ID)-1;i>=0;i--)
    {
        if (StringFind(ObjectName(i),keyword,0)>-1)
        {
            ObjectDelete(chart_ID,ObjectName(i));
        }
    }
    return;
}

/*
函    数：物件颜色
输出参数：颜色
算    法：负数为红色，正数为绿色，0为蓝色
*/
color egObjectColor(double myInput  //数值
                   )
{
    if (myInput>0) return(clrGreen);        //正数颜色为绿色
    if (myInput<0) return(clrRed);          //负数颜色为红色
    if (myInput==0) return(clrBlue);        //0 颜色为其他色
    return(NULL);
}

/*
函    数:输出信息到日志
输出参数:true-成功
算    法:
*/
bool    egPrintOut(const    bool    isout=true,    //允许输出
                   const    string  text="text"    //输出信息
                  )
{
    if (isout) Print(text);
    return(true);
}

/*
函    数:输出矩形到图表
输出参数:true-输出成功
算    法:
*/
bool    egRectangleOut(const    bool                 isout=true,                 //允许输出
                       const    long                 chart_ID=0,                 //主图ID
                       const    string               name="RectLabel",           //对象名称
                       const    int                  sub_window=0,               //副图编号
                       const    int                  x=0,                        //x坐标
                       const    int                  y=0,                        //y坐标
                       const    int                  width=50,                   //矩形宽度
                       const    int                  height=18,                  //矩形高度
                       const    color                back_clr=clrGray,           //背景色
                       const    ENUM_BORDER_TYPE     border=BORDER_SUNKEN,       //矩形效果
                       const    ENUM_BASE_CORNER     corner=CORNER_LEFT_UPPER,   //锚点
                       const    color                clr=clrRed,                 //边框颜色
                       const    ENUM_LINE_STYLE      style=STYLE_SOLID,          //边框类型
                       const    int                  line_width=1,               //边框宽度
                       const    bool                 back=false,                 //设置为背景
                       const    bool                 selection=false,            //高亮移动
                       const    bool                 hidden=true,                //列表中隐藏对象名
                       const    long                 z_order=0                   // priority for mouse click
                      )
{
    if (!isout) return(true);
    //更改对象属性
    if (ObjectFind(chart_ID,name)!=-1)
    {
        ObjectSetInteger(chart_ID,name,OBJPROP_XDISTANCE,x);
        ObjectSetInteger(chart_ID,name,OBJPROP_YDISTANCE,y);
        ObjectSetInteger(chart_ID,name,OBJPROP_XSIZE,width);
        ObjectSetInteger(chart_ID,name,OBJPROP_YSIZE,height);
        ObjectSetInteger(chart_ID,name,OBJPROP_BGCOLOR,back_clr);
        ObjectSetInteger(chart_ID,name,OBJPROP_BORDER_TYPE,border);
        ObjectSetInteger(chart_ID,name,OBJPROP_CORNER,corner);
        ObjectSetInteger(chart_ID,name,OBJPROP_COLOR,clr);
        ObjectSetInteger(chart_ID,name,OBJPROP_STYLE,style);
        ObjectSetInteger(chart_ID,name,OBJPROP_WIDTH,line_width);
        ObjectSetInteger(chart_ID,name,OBJPROP_BACK,back);
        ObjectSetInteger(chart_ID,name,OBJPROP_SELECTABLE,selection);
        ObjectSetInteger(chart_ID,name,OBJPROP_SELECTED,selection);
        ObjectSetInteger(chart_ID,name,OBJPROP_HIDDEN,hidden);
        ObjectSetInteger(chart_ID,name,OBJPROP_ZORDER,z_order);
        return(true);
    }
    //创建输出对象
    ObjectCreate(chart_ID,name,OBJ_RECTANGLE_LABEL,sub_window,0,0);
    ObjectSetInteger(chart_ID,name,OBJPROP_XDISTANCE,x);
    ObjectSetInteger(chart_ID,name,OBJPROP_YDISTANCE,y);
    ObjectSetInteger(chart_ID,name,OBJPROP_XSIZE,width);
    ObjectSetInteger(chart_ID,name,OBJPROP_YSIZE,height);
    ObjectSetInteger(chart_ID,name,OBJPROP_BGCOLOR,back_clr);
    ObjectSetInteger(chart_ID,name,OBJPROP_BORDER_TYPE,border);
    ObjectSetInteger(chart_ID,name,OBJPROP_CORNER,corner);
    ObjectSetInteger(chart_ID,name,OBJPROP_COLOR,clr);
    ObjectSetInteger(chart_ID,name,OBJPROP_STYLE,style);
    ObjectSetInteger(chart_ID,name,OBJPROP_WIDTH,line_width);
    ObjectSetInteger(chart_ID,name,OBJPROP_BACK,back);
    ObjectSetInteger(chart_ID,name,OBJPROP_SELECTABLE,selection);
    ObjectSetInteger(chart_ID,name,OBJPROP_SELECTED,selection);
    ObjectSetInteger(chart_ID,name,OBJPROP_HIDDEN,hidden);
    ObjectSetInteger(chart_ID,name,OBJPROP_ZORDER,z_order);
    return(true);
}

/*
函    数:输出矩形到图表(time_price)
输出参数:true-输出成功
算    法:
*/
bool    egRectangleTP (const    bool                 isout=true,                 //允许输出
                       const    long                 chart_ID=0,                 //主图ID
                       const    string               name="Rectangle",           //对象名称
                       const    int                  sub_window=0,               //副图编号
                                datetime             time1=0,                    //第1点时间
                                double               price1=0,                   //第1点价格
                                datetime             time2=0,                    //第2点时间
                                double               price2=0,                   //第2点价格
                       const    color                Rectangle_clr=clrGray,      //矩形颜色
                       const    ENUM_LINE_STYLE      style=STYLE_SOLID,          //边框线型
                       const    int                  width=1,                    //边框宽度
                       const    bool                 fill=false,                 //矩形填充颜色
                       const    bool                 back=false,                 //设置为背景
                       const    bool                 selection=false,            //高亮移动
                       const    bool                 hidden=true,                //列表中隐藏对象名
                       const    long                 z_order=0                   // priority for mouse click
                      )
{
    if (!isout) return(true);
    //更改对象属性
    if (ObjectFind(chart_ID,name)!=-1)
    {
        ObjectSetInteger(chart_ID,name,OBJPROP_TIME,time1);
        ObjectSetDouble(chart_ID,name,OBJPROP_PRICE,price1);
        ObjectSetInteger(chart_ID,name,OBJPROP_TIME,time2);
        ObjectSetDouble(chart_ID,name,OBJPROP_PRICE,price2);
        ObjectSetInteger(chart_ID,name,OBJPROP_COLOR,Rectangle_clr); 
        ObjectSetInteger(chart_ID,name,OBJPROP_STYLE,style); 
        ObjectSetInteger(chart_ID,name,OBJPROP_WIDTH,width); 
        ObjectSetInteger(chart_ID,name,OBJPROP_BACK,back); 
        ObjectSetInteger(chart_ID,name,OBJPROP_SELECTABLE,selection); 
        ObjectSetInteger(chart_ID,name,OBJPROP_SELECTED,selection); 
        ObjectSetInteger(chart_ID,name,OBJPROP_HIDDEN,hidden); 
        ObjectSetInteger(chart_ID,name,OBJPROP_ZORDER,z_order); 
        return(true);
    }
    //创建输出对象
    ObjectCreate(chart_ID,name,OBJ_RECTANGLE,sub_window,time1,price1,time2,price2);
    ObjectSetInteger(chart_ID,name,OBJPROP_COLOR,Rectangle_clr); 
    ObjectSetInteger(chart_ID,name,OBJPROP_STYLE,style); 
    ObjectSetInteger(chart_ID,name,OBJPROP_WIDTH,width); 
    ObjectSetInteger(chart_ID,name,OBJPROP_BACK,back); 
    ObjectSetInteger(chart_ID,name,OBJPROP_SELECTABLE,selection); 
    ObjectSetInteger(chart_ID,name,OBJPROP_SELECTED,selection); 
    ObjectSetInteger(chart_ID,name,OBJPROP_HIDDEN,hidden); 
    ObjectSetInteger(chart_ID,name,OBJPROP_ZORDER,z_order); 
    return(true);
}

/*
函    数:输出标注到图表
输出参数:true-输出成功
算    法:
*/
bool    egTextOut(const    bool                isout=true,                 //允许输出
                  const    string              text="Text",                //输出内容
                  const    string              name="Text",                //对象名称
                  const    int                 font_size=8,                //字体尺寸
                  const    color               clr=clrGreen,               //字体颜色
                  const    long                chart_ID=0,                 //主图ID
                  const    int                 sub_window=0,               //附图编号
                  const    datetime            time=0,                     //标注点时间
                  const    double              price=0,                    //标注点价格
                  const    string              font="Arial",               //字体类型
                  const    double              angle=0.0,                  //字体角度
                  const    ENUM_ANCHOR_POINT   anchor=ANCHOR_LEFT_UPPER,   //原始坐标
                  const    bool                back=false,                 //设置为背景
                  const    bool                selection=false,            //高亮移动
                  const    bool                hidden=false,               //列表中隐藏对象名
                  const    long                z_order=0                   //priority for mouse click
                 )
{
    if (!isout) return(true);
    //更改对象属性
    if (ObjectFind(chart_ID,name)!=-1)
    {
        ObjectSetDouble(chart_ID,name,OBJPROP_PRICE1,price);
        ObjectSetInteger(chart_ID,name,OBJPROP_TIME1,time);
        ObjectSetString(chart_ID,name,OBJPROP_TEXT,text);
        ObjectSetString(chart_ID,name,OBJPROP_FONT,font);
        ObjectSetInteger(chart_ID,name,OBJPROP_FONTSIZE,font_size);
        ObjectSetDouble(chart_ID,name,OBJPROP_ANGLE,angle);
        ObjectSetInteger(chart_ID,name,OBJPROP_ANCHOR,anchor);
        ObjectSetInteger(chart_ID,name,OBJPROP_COLOR,clr);
        ObjectSetInteger(chart_ID,name,OBJPROP_BACK,back);
        ObjectSetInteger(chart_ID,name,OBJPROP_SELECTABLE,selection);
        ObjectSetInteger(chart_ID,name,OBJPROP_SELECTED,selection);
        ObjectSetInteger(chart_ID,name,OBJPROP_HIDDEN,hidden);
        ObjectSetInteger(chart_ID,name,OBJPROP_ZORDER,z_order);
        return(true);
    }
    //创建输出对象
    ObjectCreate(chart_ID,name,OBJ_TEXT,sub_window,time,price);
    ObjectSetString(chart_ID,name,OBJPROP_TEXT,text);
    ObjectSetString(chart_ID,name,OBJPROP_FONT,font);
    ObjectSetInteger(chart_ID,name,OBJPROP_FONTSIZE,font_size);
    ObjectSetDouble(chart_ID,name,OBJPROP_ANGLE,angle);
    ObjectSetInteger(chart_ID,name,OBJPROP_ANCHOR,anchor);
    ObjectSetInteger(chart_ID,name,OBJPROP_COLOR,clr);
    ObjectSetInteger(chart_ID,name,OBJPROP_BACK,back);
    ObjectSetInteger(chart_ID,name,OBJPROP_SELECTABLE,selection);
    ObjectSetInteger(chart_ID,name,OBJPROP_SELECTED,selection);
    ObjectSetInteger(chart_ID,name,OBJPROP_HIDDEN,hidden);
    ObjectSetInteger(chart_ID,name,OBJPROP_ZORDER,z_order);
    return(true);
}

/*
函    数:输出线段到图表
输出参数:true-输出成功
算    法:
*/
bool    egTrendOut(const    bool            isout=true,         //允许输出
                   const    long            chart_ID=0,         //主图ID
                   const    string          name="TrendLine",   //对象名称
                   const    int             sub_window=0,       //副图编号
                            datetime        time1=0,            //第1点时间
                            double          price1=0,           //第1点价格 
                            datetime        time2=0,            //第2点时间
                            double          price2=0,           //第2点价格 
                   const    color           clr=clrRed,         //线色
                   const    ENUM_LINE_STYLE style=STYLE_SOLID,  //线型
                   const    int             width=1,            //线宽
                   const    bool            back=true,          //设置为背景
                   const    bool            selection=false,    //高亮移动
                   const    bool            ray_right=false,    //true为射线
                   const    bool            hidden=true,        //列表中隐藏对象名
                   const    long            z_order=0           //priority for mouse click
                 )
{
    if (!isout) return(true);
    //更改对象属性
    if (ObjectFind(chart_ID,name)!=-1)
    {
        ObjectSetInteger(chart_ID,name,OBJPROP_TIME1,time1); 
        ObjectSetDouble(chart_ID,name,OBJPROP_PRICE1,price1); 
        ObjectSetInteger(chart_ID,name,OBJPROP_TIME2,time2); 
        ObjectSetDouble(chart_ID,name,OBJPROP_PRICE2,price2); 
        ObjectSetInteger(chart_ID,name,OBJPROP_COLOR,clr); 
        ObjectSetInteger(chart_ID,name,OBJPROP_STYLE,style); 
        ObjectSetInteger(chart_ID,name,OBJPROP_WIDTH,width); 
        ObjectSetInteger(chart_ID,name,OBJPROP_BACK,back); 
        ObjectSetInteger(chart_ID,name,OBJPROP_SELECTABLE,selection); 
        ObjectSetInteger(chart_ID,name,OBJPROP_SELECTED,selection); 
        ObjectSetInteger(chart_ID,name,OBJPROP_RAY_RIGHT,ray_right); 
        ObjectSetInteger(chart_ID,name,OBJPROP_HIDDEN,hidden); 
        ObjectSetInteger(chart_ID,name,OBJPROP_ZORDER,z_order); 
        return(true);
    }
    //创建输出对象
    ObjectCreate(chart_ID,name,OBJ_TREND,sub_window,time1,price1,time2,price2);
    ObjectSetInteger(chart_ID,name,OBJPROP_COLOR,clr); 
    ObjectSetInteger(chart_ID,name,OBJPROP_STYLE,style); 
    ObjectSetInteger(chart_ID,name,OBJPROP_WIDTH,width); 
    ObjectSetInteger(chart_ID,name,OBJPROP_BACK,back); 
    ObjectSetInteger(chart_ID,name,OBJPROP_SELECTABLE,selection); 
    ObjectSetInteger(chart_ID,name,OBJPROP_SELECTED,selection); 
    ObjectSetInteger(chart_ID,name,OBJPROP_RAY_RIGHT,ray_right); 
    ObjectSetInteger(chart_ID,name,OBJPROP_HIDDEN,hidden); 
    ObjectSetInteger(chart_ID,name,OBJPROP_ZORDER,z_order); 
    return(true);
}

/*
函    数:输出垂直线到图表
输出参数:true-输出成功
算    法:
*/
bool    egVLineOut(const    bool            isout=true,         //允许输出
                   const    long            chart_ID=0,         //主图ID
                   const    string          name="VLine",       //对象名称
                   const    int             sub_window=0,       //副图编号
                   const    datetime        time=0,             //线时间
                   const    color           clr=clrRed,         //线色
                   const    ENUM_LINE_STYLE style=STYLE_SOLID,  //线型
                   const    int             width=1,            //线宽
                   const    bool            back=true,         //设置为背景
                   const    bool            selection=false,     //高亮移动
                   const    bool            hidden=true,        //列表中隐藏对象名
                   const    long            z_order=0           // priority for mouse click
                 )
{
    if (!isout) return(true);
    //更改对象属性
    if (ObjectFind(chart_ID,name)!=-1)
    {
        ObjectSetInteger(chart_ID,name,OBJPROP_TIME,time);
        ObjectSetInteger(chart_ID,name,OBJPROP_COLOR,clr);
        ObjectSetInteger(chart_ID,name,OBJPROP_STYLE,style);
        ObjectSetInteger(chart_ID,name,OBJPROP_WIDTH,width);
        ObjectSetInteger(chart_ID,name,OBJPROP_BACK,back);
        ObjectSetInteger(chart_ID,name,OBJPROP_SELECTABLE,selection);
        ObjectSetInteger(chart_ID,name,OBJPROP_SELECTED,selection);
        ObjectSetInteger(chart_ID,name,OBJPROP_HIDDEN,hidden);
        ObjectSetInteger(chart_ID,name,OBJPROP_ZORDER,z_order);
        return(true);
    }
    //创建输出对象
    ObjectCreate(chart_ID,name,OBJ_VLINE,sub_window,time,0);
    ObjectSetInteger(chart_ID,name,OBJPROP_COLOR,clr);
    ObjectSetInteger(chart_ID,name,OBJPROP_STYLE,style);
    ObjectSetInteger(chart_ID,name,OBJPROP_WIDTH,width);
    ObjectSetInteger(chart_ID,name,OBJPROP_BACK,back);
    ObjectSetInteger(chart_ID,name,OBJPROP_SELECTABLE,selection);
    ObjectSetInteger(chart_ID,name,OBJPROP_SELECTED,selection);
    ObjectSetInteger(chart_ID,name,OBJPROP_HIDDEN,hidden);
    ObjectSetInteger(chart_ID,name,OBJPROP_ZORDER,z_order);
    return(true);
}
