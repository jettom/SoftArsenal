//+------------------------------------------------------------------+
//|                                                   templateEA.mq4 |
//|                                                               JT |
//|                                                              XXX |
//+------------------------------------------------------------------+
#property copyright "JT"
#property link      "XXX"
#property version   "1.00"
#property strict
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
//---
   //--- Creating a 1.5 inch wide button on a screen
int button_width = 20;
int screen_dpi = TerminalInfoInteger(TERMINAL_SCREEN_DPI); // Find DPI of the user monitor
int base_width = 144;                                      // The basic width in the screen points for standard monitors with DPI=96
int width      = (button_width * screen_dpi) / 96;         // Calculate the button width for the user monitor (for the specific DPI)
 
//--- Calculating the scaling factor as a percentage
int scale_factor = (TerminalInfoInteger(TERMINAL_SCREEN_DPI) * 100) / 96;
//--- Use of the scaling factor
width=(base_width * scale_factor) / 100;

Print("screen_dpi = ",screen_dpi);
Print("scale_factor = ",scale_factor);
//---
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
//---
   
  }
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
  {
//---
   
  }
//+------------------------------------------------------------------+
