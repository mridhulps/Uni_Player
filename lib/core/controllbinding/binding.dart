import 'package:get/get.dart';
import 'package:uniplayer/controller/audiocontroller.dart';

class initialcontroll implements Bindings {
  @override
  void dependencies() {
    Get.put<PlayerController>(PlayerController());
  }
}
