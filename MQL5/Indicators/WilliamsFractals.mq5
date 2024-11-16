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
#property indicator_plots 2
#property indicator_buffers 2

// types
//...

// buffers
double ExtHigherHighBuffer[];
double ExtLowerLowBuffer[];

// config
input group "Section :: Main";
input int InpPeriods = 3;

input group "Section :: Style";
input int InpArrowShift = 20;
input int InpArrowSize = 2;

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

   IndicatorSetInteger(INDICATOR_DIGITS, _Digits);

   ArraySetAsSeries(ExtHigherHighBuffer, true);
   ArrayInitialize(ExtHigherHighBuffer, EMPTY_VALUE);

   SetIndexBuffer(0, ExtHigherHighBuffer, INDICATOR_DATA);
   PlotIndexSetString(0, PLOT_LABEL, "Higher High");
   PlotIndexSetDouble(0, PLOT_EMPTY_VALUE, EMPTY_VALUE);
   PlotIndexSetInteger(0, PLOT_DRAW_TYPE, DRAW_ARROW);
   PlotIndexSetInteger(0, PLOT_ARROW, 217);
   PlotIndexSetInteger(0, PLOT_ARROW_SHIFT, -InpArrowShift);
   PlotIndexSetInteger(0, PLOT_LINE_WIDTH, InpArrowSize);
   PlotIndexSetInteger(0, PLOT_LINE_COLOR, clrGreen);

   ArraySetAsSeries(ExtLowerLowBuffer, true);
   ArrayInitialize(ExtLowerLowBuffer, EMPTY_VALUE);

   SetIndexBuffer(1, ExtLowerLowBuffer, INDICATOR_DATA);
   PlotIndexSetString(1, PLOT_LABEL, "Lower Low");
   PlotIndexSetDouble(1, PLOT_EMPTY_VALUE, EMPTY_VALUE);
   PlotIndexSetInteger(1, PLOT_DRAW_TYPE, DRAW_ARROW);
   PlotIndexSetInteger(1, PLOT_ARROW, 218);
   PlotIndexSetInteger(1, PLOT_ARROW_SHIFT, InpArrowShift);
   PlotIndexSetInteger(1, PLOT_LINE_WIDTH, InpArrowSize);
   PlotIndexSetInteger(1, PLOT_LINE_COLOR, clrRed);

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

   ArrayFill(ExtHigherHighBuffer, 0, ArraySize(ExtHigherHighBuffer), EMPTY_VALUE);
   ArrayFree(ExtHigherHighBuffer);

   ArrayFill(ExtLowerLowBuffer, 0, ArraySize(ExtLowerLowBuffer), EMPTY_VALUE);
   ArrayFree(ExtLowerLowBuffer);

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
   if(rates_total == prev_calculated || rates_total < InpPeriods || IsStopped())
     {
      return rates_total;
     }

   ArraySetAsSeries(high, true);
   ArraySetAsSeries(low, true);

   int limit = rates_total - (prev_calculated < 1 ? 1 : prev_calculated);
   if(InpDebugEnabled)
     {
      PrintFormat("RatesTotal: %i, PrevCalculated: %i, Limit: %i", rates_total, prev_calculated, limit);
     }

   for(int i = InpPeriods; i < limit - InpPeriods; i++)
     {
      bool isHigherHigh = true;
      bool isLowerLow = true;

      for(int j = i - InpPeriods; j <= i + InpPeriods; j++)
        {
         if(isHigherHigh && i != j && high[i] < high[j])
           {
            isHigherHigh = false;
           }
         if(isLowerLow && i != j && low[i] > low[j])
           {
            isLowerLow = false;
           }
        }

      ExtHigherHighBuffer[i] = ExtHigherHighBuffer[i - 1] == EMPTY_VALUE && isHigherHigh ? high[i] : EMPTY_VALUE;
      ExtLowerLowBuffer[i] = ExtLowerLowBuffer[i - 1] == EMPTY_VALUE && isLowerLow ? low[i] : EMPTY_VALUE;
     }

   return rates_total;
  }
//+------------------------------------------------------------------+
