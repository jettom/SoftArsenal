#property copyright "Copyright 2014, MetaQuotes Software Corp."
#property link      "http://www.mql5.com"
#property version   "1.00"
#property strict
string oclh[4];
void OnStart()
  {
   //FolderCreate("f",0);
   //FolderDelete("f",0);
   //FolderClean("a",0);
   /*
   string filename;
   long fff=FileFindFirst("a*",filename,0);
   if(fff!=INVALID_HANDLE)
    {
      do
       {
         //FileIsExist(filename);
       }
      while(FileFindNext(fff,filename)==true);
    }*/
   if(FileCopy("a//a.txt",0,"b//b.txt",0)==false)
     {
       printf(GetLastError());
     }
   if(FileMove("a//a.txt",0,"b//b.txt",0)==false)
     {
       printf(GetLastError());
     }
     
   //FileDelete("test.csv");
   /*
   if(FileIsExist("test.csv")==true)
     {
       Alert("文件存在");
     }
   else
     {
       Alert("文件不存在");
     */
   int a=125;
   int h=FileOpen("test.csv",FILE_READ|FILE_WRITE|FILE_CSV|FILE_SHARE_READ,',',CP_ACP);
   if(h!=INVALID_HANDLE)
    {
       oclh[0]=Open[0];
       oclh[1]=Close[0];
       oclh[2]=High[0];
       oclh[3]=Low[0];
     //FileWrite(h,Open[0],Close[0],High[0],Low[0]);
     //FileWrite(h,Open[1],Close[1],High[1],Low[1]);
       // FileWriteDouble(h,1.321);
      //FileFlush(h);
      //FileWriteArray(h,oclh,0,WHOLE_ARRAY);
      string read;
      ulong ft=0;
      while(FileIsEnding(h)!=True)
        {
          if(FileIsLineEnding(h)==True)
           {
             printf(read);//打印一行内容
             read="";
           }
          FileSeek(h,16,SEEK_SET);
          ft=FileTell(h);
          read=FileReadString(h,0);
          ft=FileTell(h);
        }
      FileClose(h);
    }
  }
