//+------------------------------------------------------------------+
//|                                             WilliamsFractals.mq5 |
//|                                         Copyright 2024, rpanchyk |
//|                                      https://github.com/rpanchyk |
//+------------------------------------------------------------------+
#property copyright   "Copyright 2024, rpanchyk"
#property link        "https://github.com/rpanchyk"
#property version     "1.00"
#property description "Indicator shows Williams fractals"

#property indicator_chart_window
#property indicator_plots 0

// types
//...

// buffers
//...

// config
input group "Section :: Main";
//...

input group "Section :: Dev";
input bool InpDebugEnabled = true; // Enable debug (verbose logging)

// constants
//...

// runtime
//...

//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int OnInit()
  {
   if(InpDebugEnabled)
     {
      Print("WilliamsFractals indicator initialization started");
     }

   if(InpDebugEnabled)
     {
      Print("WilliamsFractals indicator initialization finished");
     }
   return(INIT_SUCCEEDED);
  }

//+------------------------------------------------------------------+
//| Custom indicator deinitialization function                       |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
   if(InpDebugEnabled)
     {
      Print("WilliamsFractals indicator deinitialization started");
     }

   if(InpDebugEnabled)
     {
      Print("WilliamsFractals indicator deinitialization finished");
     }
  }

//+------------------------------------------------------------------+
//| Custom indicator iteration function                              |
//+------------------------------------------------------------------+
int OnCalculate(const int rates_total,
                const int prev_calculated,
                const datetime &time[],
                const double &open[],
                const double &high[],
                const double &low[],
                const double &close[],
                const long &tick_volume[],
                const long &volume[],
                const int &spread[])
  {
   if(rates_total == prev_calculated)
     {
      return rates_total;
     }

   return rates_total;
  }
//+------------------------------------------------------------------+
