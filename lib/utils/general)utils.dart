class GeneralUtils{

  int getDay(DateTime time){
    if(time.weekday==7){return 0;}
    return time.weekday;
  }

}