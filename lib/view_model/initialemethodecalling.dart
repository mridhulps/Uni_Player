import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uniplayer/Repository/controller/audiocontroller.dart';

class InitialMethodeCalling {
  final controller = Get.find<PlayerController>();

  InitialMethodeCalling.initialcalling() {
    initialCallingMethode();
  }

  Future<void> initialCallingMethode() async {
    controller.sharedpreference = await SharedPreferences.getInstance();
    controller.getvariable();
    final issuffleEnable = controller.getshuffle();

    controller.shufflemodeenabled(issuffleEnable ?? false);
  }
}
