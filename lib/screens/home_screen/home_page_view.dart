import '../../models/action.dart';

abstract class HomePageView{

  void loadAllData();
  void onError();
  void buttonPressed();

  void noActionAvailable();

  void animation(String animationAction);
  void toast(String toastAction);
  void notification(String notifictionAction);
}