#property copyright "Copyright 2014, MetaQuotes Software Corp."
#property link      "http://www.mql5.com"
#property version   "1.00"
#property strict
#property show_inputs
input int InpDepth=12;     // Depth
input int InpDeviation=5;  // Deviation
input int InpBackstep=3;   // Backstep
double zigzag[12][2];
void OnStart()
  {
    int jishu=0;
    for(int i=0;i<10000;i++)
     {
       if(zigzagzhi(i)>0)
        {
          if(jishu>11)
           {
             break;
           }
          zigzag[jishu][0]=zigzagzhi(i);
          zigzag[jishu][1]=i;
          jishu++;
        }
     }
    if(zigzag[0][0]>zigzag[1][0])
     {
       Alert("第一个点是高点:"+zigzag[0][0]+"序号:"+zigzag[0][1]);
     }
    else
     {
       Alert("第一个点是低点"+zigzag[0][0]+"序号:"+zigzag[0][1]);
     }
  }
double zigzagzhi(int shift)
  {
    return(iCustom(NULL,0,"ZigZag",InpDepth,InpDeviation,InpBackstep,0,shift));
  }
