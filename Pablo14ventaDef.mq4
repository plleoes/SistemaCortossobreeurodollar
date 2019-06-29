//+------------------------------------------------------------------+
//|                                                       Pablo1.mq4 |
//|                        Copyright 2014, MetaQuotes Software Corp. |
//|                                        http://www.metaquotes.net |
//+------------------------------------------------------------------+
#property copyright "Copyright 2014, MetaQuotes Software Corp."
#property link      "http://www.metaquotes.net"
   int ticket1=0;
   int ticket2=0;
   double pip=0.0001,S1=0,S2=0,S3=0,R1=0,R2=0,R3=0,ATR=0,MM8=0;
   bool PMMM200=false;
   bool PmMM200=false;
   int CompraEsS=0;
   int VentaEsS=0;
   int Nexitos=0;
   double exitosATR[];
   double exitosBen[];
   bool Stop1=false;
   extern double Vola=0.0275;
   extern int F1ten1=5;
   extern int F1ten2=3;
   extern int F1ten3=5;
   extern int F1difer=3;
   extern int EsH4v1=21;
   extern int EsH4v2=7;
   extern int EsH4v3=3;
   extern int EsM5v1=17;
   extern int EsM5v2=9;
   extern int EsM5v3=7;
   extern int Lmin=0;

  extern int Naltos=2;
//   extern int pMM=480;

   
   extern int F1ten1b=5;
   extern int F1ten2b=3;
   extern int F1ten3b=3;
   extern int F1diferb=3;
   extern int EsH4v1b=8;
   extern int EsH4v2b=5;
   extern int EsH4v3b=3;
   extern int EsM5v1b=11;
   extern int EsM5v2b=5;
   extern int EsM5v3b=3;
   extern int Naltosb=4;


//+------------------------------------------------------------------+
//| expert initialization function                                   |
//+------------------------------------------------------------------+
int init()
  {
//----
   
//----
   return(0);
  }
//+------------------------------------------------------------------+
//| expert deinitialization function                                 |
//+------------------------------------------------------------------+
int deinit()
  {
//----
int i;
double MaxATR,MinATR,SumATR=0,MedATR=0;
MaxATR=exitosATR[ArrayMaximum(exitosATR,WHOLE_ARRAY,0)];
MinATR=exitosATR[ArrayMinimum(exitosATR,WHOLE_ARRAY,0)];
for(i=1;i<=Nexitos;i++){
SumATR=SumATR+exitosATR[i-1];
}
MedATR=SumATR/Nexitos;

Print("Exitos: Maximo ATR: ",MaxATR," Minimo ATR: ",MinATR," ATR medio: ",MedATR);


   
//----
   return(0);
  }
//+------------------------------------------------------------------+
//| expert start function                                            |
//+------------------------------------------------------------------+
int start()
  {
//----

   int i=0,nop=0;
   bool ATRb=false,M2004h=false,Cmediasexpc=false, Cmediasexpv=false,AmarilloSe=false,mMM=false, MainBm=false,MainSm=false, MainB=false,MainS=false,CruceStoC=false,CruceStoV=false,PreciomMM50=false,PrecioMMM50=false,PreciomMM200=false,PrecioMMM200=false,PreciomMM400=false,PrecioMMM400=false,PreciomMM100=false,PrecioMMM100=false,PreciomMM800=false,PrecioMMM800=false,PrecioMMM1200=false,PreciomMM1200=false,PrecioMMM2400=false,PreciomMM2400=false,PrecioMMM4800=false,PreciomMM4800=false,PrecioMMM9600=false,PreciomMM9600=false,PrecioMMM19200=false,PreciomMM19200=false,AltoSto=false,BajoSto=false,BajoVol=false, Es1c=false, Es2c=false, Es3c=false,Es1v=false, Es2v=false, Es3v=false;
   double lots;
   double stoplosss;
  
   

   M2004h=iMA(NULL,PERIOD_H4,200,8,MODE_SMMA,PRICE_MEDIAN,0)>iMA(NULL,PERIOD_H4,200,8,MODE_SMMA,PRICE_MEDIAN,3)&& iMA(NULL,PERIOD_H4,200,8,MODE_SMMA,PRICE_MEDIAN,3)>iMA(NULL,PERIOD_H4,200,8,MODE_SMMA,PRICE_MEDIAN,6)&& iMA(NULL,PERIOD_H4,200,8,MODE_SMMA,PRICE_MEDIAN,6)>iMA(NULL,PERIOD_H4,200,8,MODE_SMMA,PRICE_MEDIAN,9);
   lots=NormalizeDouble(AccountBalance()*10/100000,2);
   if(iATR(NULL,PERIOD_W1,8,0)>Vola){
   mMM=true;//iClose(NULL,PERIOD_H4,0)<iMA(NULL,PERIOD_H4,pMM,8,MODE_SMMA,PRICE_MEDIAN,0);

   MainB=iStochastic(NULL,PERIOD_H4,5,3,3,MODE_LWMA,0,MODE_MAIN,1)>iStochastic(NULL,PERIOD_H4,5,3,3,MODE_LWMA,0,MODE_MAIN,0);
   
   Es2v=iStochastic(NULL,PERIOD_H4,EsH4v1,EsH4v2,EsH4v3,MODE_LWMA,0,MODE_MAIN,0)+3<iStochastic(NULL,PERIOD_H4,EsH4v1,EsH4v2,EsH4v3,MODE_LWMA,0,MODE_SIGNAL,0)  && iStochastic(NULL,PERIOD_H4,EsH4v1,EsH4v2,EsH4v3,MODE_LWMA,0,MODE_MAIN,0)<80&& iStochastic(NULL,PERIOD_H4,EsH4v1b,EsH4v2b,EsH4v3b,MODE_LWMA,0,MODE_MAIN,0)>Lmin && iStochastic(NULL,PERIOD_W1,F1ten1,F1ten2,F1ten3,MODE_SMA,0,MODE_MAIN,0)+F1difer<iStochastic(NULL,PERIOD_W1,F1ten1,F1ten2,F1ten3,MODE_SMA,0,MODE_SIGNAL,0);
   }
   else{
   mMM=true;

   MainB=iStochastic(NULL,PERIOD_H4,5,3,3,MODE_LWMA,0,MODE_MAIN,1)>iStochastic(NULL,PERIOD_H4,5,3,3,MODE_LWMA,0,MODE_MAIN,0);
   
   
   Es2v=iStochastic(NULL,PERIOD_H4,EsH4v1b,EsH4v2b,EsH4v3b,MODE_LWMA,0,MODE_MAIN,0)+3<iStochastic(NULL,PERIOD_H4,EsH4v1b,EsH4v2b,EsH4v3b,MODE_LWMA,0,MODE_SIGNAL,0)  && iStochastic(NULL,PERIOD_H4,EsH4v1b,EsH4v2b,EsH4v3b,MODE_LWMA,0,MODE_MAIN,0)<80  && iStochastic(NULL,PERIOD_W1,F1ten1b,F1ten2b,F1ten3b,MODE_SMA,0,MODE_MAIN,0)+F1diferb<iStochastic(NULL,PERIOD_W1,F1ten1b,F1ten2b,F1ten3b,MODE_SMA,0,MODE_SIGNAL,0);
   }
   if( Es2v && MainB && mMM ){
   VentaEsS=2;
   }
   else
   {
     VentaEsS=1;
   }
   nop=OrdersHistoryTotal()-1;
     if(OrderSelect(nop,SELECT_BY_POS,MODE_HISTORY)==true)
    {
    if(OrderTicket()==ticket2 && ATR!=0){
     if(OrderProfit()>lots*100000*0.01){
     Nexitos++;
     ArrayResize(exitosATR,Nexitos);
     ArrayResize(exitosBen,Nexitos);
     exitosATR[Nexitos-1]=ATR/MM8;
     exitosBen[Nexitos-1]=OrderProfit();
     ATR=0;
     }
    }
    }

   
   
   

   if(iClose(NULL,0,1)<iMA(NULL,0,50,8,MODE_SMMA,PRICE_MEDIAN,1) ){
   PreciomMM50=true;
   }
   else{
   PreciomMM50=false;
   }

   if(iClose(NULL,0,1)<iMA(NULL,0,200,8,MODE_SMMA,PRICE_MEDIAN,1) ){
   PreciomMM200=true;
   }
   else{
   PreciomMM200=false;
   }
   if(iClose(NULL,0,1)<iMA(NULL,0,400,8,MODE_SMMA,PRICE_MEDIAN,1) ){
   PreciomMM400=true;
   }
   else{
   PreciomMM400=false;
   }

   if(iClose(NULL,0,1)<iMA(NULL,0,100,8,MODE_SMMA,PRICE_MEDIAN,1) ){
   PreciomMM100=true;
   }
   else{
   PreciomMM100=false;
   }

   if(iClose(NULL,0,1)<iMA(NULL,0,1200,8,MODE_SMMA,PRICE_MEDIAN,1) ){
   PreciomMM1200=true;
   }
   else{
   PreciomMM1200=false;
   }
   if(iClose(NULL,0,1)<iMA(NULL,0,2400,8,MODE_SMMA,PRICE_MEDIAN,1) ){
   PreciomMM2400=true;
   }
   else{
   PreciomMM2400=false;
   }
   if(iClose(NULL,0,1)<iMA(NULL,0,4800,8,MODE_SMMA,PRICE_MEDIAN,1) ){
   PreciomMM4800=true;
   }
   else{
   PreciomMM4800=false;
   }
   if(iClose(NULL,0,1)<iMA(NULL,0,9600,8,MODE_SMMA,PRICE_MEDIAN,1) ){
   PreciomMM9600=true;
   }
   else{
   PreciomMM4800=false;
   }
   if(iClose(NULL,0,1)<iMA(NULL,0,19200,8,MODE_SMMA,PRICE_MEDIAN,1) ){
   PreciomMM19200=true;
   }
   else{
   PreciomMM19200=false;
   }
   if(iATR(NULL,PERIOD_W1,8,0)>Vola){

   MainBm=iStochastic(NULL,0,EsM5v1,EsM5v2,EsM5v3,MODE_LWMA,0,MODE_MAIN,1)>iStochastic(NULL,0,EsM5v1,EsM5v2,EsM5v3,MODE_LWMA,0,MODE_MAIN,0);

   if(iStochastic(NULL,0,EsM5v1,EsM5v2,EsM5v3,MODE_LWMA,0,MODE_MAIN,0)+3<iStochastic(NULL,0,EsM5v1,EsM5v2,EsM5v3,MODE_LWMA,0,MODE_SIGNAL,0) && iStochastic(NULL,0,EsM5v1,EsM5v2,EsM5v3,MODE_LWMA,0,MODE_MAIN,0)<80&& MainBm){
   CruceStoV=true;
   }
   else{
   CruceStoV=false;
   }
   }
   else{

   MainBm=iStochastic(NULL,0,EsM5v1b,EsM5v2b,EsM5v3b,MODE_LWMA,0,MODE_MAIN,1)>iStochastic(NULL,0,EsM5v1b,EsM5v2b,EsM5v3b,MODE_LWMA,0,MODE_MAIN,0);

   if(iStochastic(NULL,0,EsM5v1b,EsM5v2b,EsM5v3b,MODE_LWMA,0,MODE_MAIN,0)+3<iStochastic(NULL,0,EsM5v1b,EsM5v2b,EsM5v3b,MODE_LWMA,0,MODE_SIGNAL,0) && iStochastic(NULL,0,EsM5v1b,EsM5v2b,EsM5v3b,MODE_LWMA,0,MODE_MAIN,0)<80 && iStochastic(NULL,0,EsM5v1b,EsM5v2b,EsM5v3b,MODE_LWMA,0,MODE_MAIN,0)>0&& MainBm){
   CruceStoV=true;
   }
   else{
   CruceStoV=false;
   }
}

  
   
   
   if(VentaEsS==2 && VentaEsS!=1  && CruceStoV ){
  if(iATR(NULL,PERIOD_W1,8,0)>Vola){
   
   if(iCustom(NULL, 0, "WelchBBWidth", 20, 0, 2.0, 20, "x", 100, "x", false, 5, 0)>iHigh(NULL,0,iHighest(NULL,0,MODE_HIGH,Naltos,0)) && iHigh(NULL,0,iHighest(NULL,0,MODE_HIGH,Naltos,0))>=Ask ){
   stoplosss=NormalizeDouble(iHigh(NULL,0,iHighest(NULL,0,MODE_HIGH,Naltos,0))*1.0005,Digits);
   }
   else{
   stoplosss=NormalizeDouble(iCustom(NULL, 0, "WelchBBWidth", 20, 0, 2.0, 20, "x", 100, "x", false, 5, 0)*1.0005,Digits);
   }
   }
   else{
   if(iCustom(NULL, 0, "WelchBBWidth", 20, 0, 2.0, 20, "x", 100, "x", false, 5, 0)>iHigh(NULL,0,iHighest(NULL,0,MODE_HIGH,Naltosb,0)) && iHigh(NULL,0,iHighest(NULL,0,MODE_HIGH,Naltosb,0))>=Ask ){
   stoplosss=NormalizeDouble(iHigh(NULL,0,iHighest(NULL,0,MODE_HIGH,Naltosb,0))*1.0005,Digits);
   }
   else{
   stoplosss=NormalizeDouble(iCustom(NULL, 0, "WelchBBWidth", 20, 0, 2.0, 20, "x", 100, "x", false, 5, 0)*1.0005,Digits);
   }
  }
   

   
   
   
   
   
   if(OrdersTotal()<1){
   ticket2=OrderSend(Symbol(),OP_SELL,lots,NormalizeDouble(Bid,Digits),10 ,stoplosss,0,"My order #1",16384,0,Green);
   PMMM200=false;
   ATR=iATR(NULL,PERIOD_W1,2,0);
   MM8=iMA(NULL,PERIOD_W1,2,8,MODE_SMMA,PRICE_MEDIAN,0);
   ticket1=0;
   VentaEsS=0;
   }
   }
   
   if(OrdersTotal()>0 && ticket2 != 0 && ticket1 == 0){
   OrderSelect(ticket2,SELECT_BY_TICKET);

   if(PreciomMM200 && (!PreciomMM400 || !PreciomMM800 || !PreciomMM1200|| !PreciomMM2400|| !PreciomMM4800|| !PreciomMM9600|| !PreciomMM19200)){
      stoplosss=NormalizeDouble(iMA(NULL,0,200,8,MODE_SMMA,PRICE_MEDIAN,0)*1.001,Digits);

      OrderSelect(ticket2,SELECT_BY_TICKET);
      if(OrderType()==OP_SELL && NormalizeDouble(OrderStopLoss(),Digits)> stoplosss &&  OrderProfit()>100&& OrderOpenPrice()> stoplosss) {
      OrderModify(ticket2,OrderOpenPrice(),stoplosss,OrderTakeProfit(),0,Blue);
      }
      }

   if(PreciomMM200 &&PreciomMM400&& (!PreciomMM800 || !PreciomMM1200|| !PreciomMM2400|| !PreciomMM4800|| !PreciomMM9600|| !PreciomMM19200) ){
      stoplosss=NormalizeDouble(iMA(NULL,0,400,8,MODE_SMMA,PRICE_MEDIAN,0)*1.001,Digits);

      OrderSelect(ticket2,SELECT_BY_TICKET);
      if(OrderType()==OP_SELL && NormalizeDouble(OrderStopLoss(),Digits)> stoplosss &&  OrderProfit()>100&& OrderOpenPrice()> stoplosss) {
      OrderModify(ticket2,OrderOpenPrice(),stoplosss,OrderTakeProfit(),0,Blue);
      }
      }

   if(PreciomMM200 && PreciomMM400 &&PreciomMM800&& (!PreciomMM1200|| !PreciomMM2400|| !PreciomMM4800|| !PreciomMM9600|| !PreciomMM19200) ){
      stoplosss=NormalizeDouble(iMA(NULL,0,800,8,MODE_SMMA,PRICE_MEDIAN,0)*1.001,Digits);

      OrderSelect(ticket2,SELECT_BY_TICKET);
      if(OrderType()==OP_SELL && NormalizeDouble(OrderStopLoss(),Digits)> stoplosss &&  OrderProfit()>100&& OrderOpenPrice()> stoplosss) {
      OrderModify(ticket2,OrderOpenPrice(),stoplosss,OrderTakeProfit(),0,Blue);
      }
      }
   if(PreciomMM200 && PreciomMM400 && PreciomMM800 &&PreciomMM1200&& (!PreciomMM2400|| !PreciomMM4800|| !PreciomMM9600|| !PreciomMM19200)){
      stoplosss=NormalizeDouble(iMA(NULL,0,1200,8,MODE_SMMA,PRICE_MEDIAN,0)*1.001,Digits);

      OrderSelect(ticket2,SELECT_BY_TICKET);
      if(OrderType()==OP_SELL && NormalizeDouble(OrderStopLoss(),Digits)> stoplosss &&  OrderProfit()>100&& OrderOpenPrice()> stoplosss) {
      OrderModify(ticket2,OrderOpenPrice(),stoplosss,OrderTakeProfit(),0,Blue);
      }
      }
   if( PreciomMM200 && PreciomMM400 && PreciomMM800 && PreciomMM1200&& PreciomMM2400&& ( !PreciomMM4800|| !PreciomMM9600|| !PreciomMM19200)){
      stoplosss=NormalizeDouble(iMA(NULL,0,2400,8,MODE_SMMA,PRICE_MEDIAN,0)*1.001,Digits);

      OrderSelect(ticket2,SELECT_BY_TICKET);
      if(OrderType()==OP_SELL && NormalizeDouble(OrderStopLoss(),Digits)> stoplosss &&  OrderProfit()>100&& OrderOpenPrice()> stoplosss) {
      OrderModify(ticket2,OrderOpenPrice(),stoplosss,OrderTakeProfit(),0,Blue);
      }
      }
   if(  PreciomMM200 && PreciomMM400 && PreciomMM800 && PreciomMM1200&& PreciomMM2400&&PreciomMM4800&& (!PreciomMM9600|| !PreciomMM19200)){
      stoplosss=NormalizeDouble(iMA(NULL,0,4800,8,MODE_SMMA,PRICE_MEDIAN,0)*1.001,Digits);

      OrderSelect(ticket2,SELECT_BY_TICKET);
      if(OrderType()==OP_SELL && NormalizeDouble(OrderStopLoss(),Digits)> stoplosss &&  OrderProfit()>100&& OrderOpenPrice()> stoplosss) {
      OrderModify(ticket2,OrderOpenPrice(),stoplosss,OrderTakeProfit(),0,Blue);
      }
      }
   if(   PreciomMM200 && PreciomMM400 && PreciomMM800 && PreciomMM1200&& PreciomMM2400&& PreciomMM4800&&PreciomMM9600&& (!PreciomMM19200)){
      stoplosss=NormalizeDouble(iMA(NULL,0,9600,8,MODE_SMMA,PRICE_MEDIAN,0)*1.001,Digits);

      OrderSelect(ticket2,SELECT_BY_TICKET);
      if(OrderType()==OP_SELL && NormalizeDouble(OrderStopLoss(),Digits)> stoplosss &&  OrderProfit()>100&& OrderOpenPrice()> stoplosss) {
      OrderModify(ticket2,OrderOpenPrice(),stoplosss,OrderTakeProfit(),0,Blue);
      }
      }
   if( PreciomMM200 && PreciomMM400 && PreciomMM800 && PreciomMM1200&& PreciomMM2400&& PreciomMM4800&& PreciomMM9600&&PreciomMM19200){
      stoplosss=NormalizeDouble(iMA(NULL,0,19200,8,MODE_SMMA,PRICE_MEDIAN,0)*1.001,Digits);

      OrderSelect(ticket2,SELECT_BY_TICKET);
      if(OrderType()==OP_SELL && NormalizeDouble(OrderStopLoss(),Digits)> stoplosss &&  OrderProfit()>100 && OrderOpenPrice()> stoplosss) {
      OrderModify(ticket2,OrderOpenPrice(),stoplosss,OrderTakeProfit(),0,Blue);
      }
      }


   }
   
 
//----
   return(0);
   
   }
  
//+------------------------------------------------------------------+


