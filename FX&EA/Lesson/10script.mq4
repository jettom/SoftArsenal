#property copyright "Copyright 2014, MetaQuotes Software Corp."
#property link      "http://www.mql5.com"
#property version   "1.00"
#property strict
void OnStart()
  {
    //SendMail("test","test");
    //SendFTP("test.txt",NULL);
    //SendNotification("test");
    char post[];
    char result[];
    string headers;
    int res=WebRequest("GET","http://www.zidongjiaoyi.com/index.html",NULL,NULL,3000,post,0,result,headers);
    if(res==-1)
     {
       Alert("网址不存在或则打不开");
       Print("Error code =",GetLastError());
     }
    else
     {
       Alert("网页内容为:"+CharArrayToString(result,0,WHOLE_ARRAY,CP_ACP));
     }
  }
