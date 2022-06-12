import '../../models/action.dart';

abstract class HomePageView{

  void loadAllData();
  void onError();
  void buttonPressed();
  void animation(Action animationAction);
  void toast(Action toastAction);
  void notification(Action notifictionAction);
}