#property copyright "Copyright 2014, MetaQuotes Software Corp."
#property link      "http://www.mql5.com"
#property version   "1.00"
#property strict
#property show_inputs
enum week
{
  M=1,//星期一
  T=2,//星期二
};
extern week xingqi=M;
extern int a=123456;
input double b=6.8;
string c="张三";
color d=clrGold;
datetime e=D'2014.01.01 00:00';
int k[10];
void OnStart()
 {
    a=1;
    //b=1;
    int f=4;
    //return;
    GlobalVariableSet("ok",f);
    double g=GlobalVariableGet("ok");
    double h=Ask;//Bid,Point
    k[0]=0;
    k[1]=1;
    k[2]=2;
    //OrderSend(....);
    datetime o=TimeCurrent();
    int a1=1;
    int b1=2;
    double c1=add(a1,b1);
    printf(a1);
    printf(b1);
    if(Bid>2)
     {
       //开单
     }
    else
     {
       //平仓 
     }
    for(int i=0;i<10;i++)
     {
       k[i]=i;
       if(i==2) continue;
       printf(i);
     }
    while(OrdersTotal()>0)
     {
       //平仓
     }
    if(OrdersTotal()==0 || TimeCurrent()==D'2014.01.01 00:00')
     {
       //开仓
     }
  }
double add(int &a1,int &b1)
  {
    a1=a1*2;
    b1=b1*2;
    return(a1+b1);
  }