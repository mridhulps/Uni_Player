import 'package:get/get.dart';
import 'package:uniplayer/Repository/controller/audiocontroller.dart';

class InitializeController extends Bindings {
  @override
  void dependencies() {
    Get.put<PlayerController>(PlayerController());
  }
}
