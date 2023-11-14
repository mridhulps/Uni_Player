import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';

import 'package:uniplayer/Repository/controller/audiocontroller.dart';

import 'package:uniplayer/view/widgets/customappbar/appbar.dart';

import 'package:uniplayer/Resources/const/constants.dart';

import 'package:uniplayer/view/widgets/songnameplate/songnameplate.dart';

import '../../widgets/controllset/conrollset.dart';
import '../../widgets/customdrawer/customdrawer.dart';
import '../../widgets/musiclogo/musiclogo.dart';

class HomeScreen extends StatefulWidget {
   const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final state = GlobalKey<ScaffoldState>();

  final controll = Get.find<PlayerController>();

  @override
  void dispose() {
    Get.delete<PlayerController>();
    controll.audioplayer.dispose();
    controll.animecontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      state.currentState!.openDrawer();
      controll.getvariable();
      var isshuffle = controll.getshuffle();
      controll.shufflemodeenabled(isshuffle ?? false);
    });
    final size = MediaQuery.of(context).size;

    DateTime ispressed = DateTime.now();

    return WillPopScope(
      onWillPop: () async {
        final timedefference = DateTime.now().difference(ispressed);

        ispressed = DateTime.now();

        final isexit = timedefference <= const Duration(seconds: 2);

        if (isexit) {
          SystemChannels.platform.invokeMethod('SystemNavigator.pop');

          return false;
        } else {
          controll.toast('press back again to exit');
          return false;
        }
      },
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          key: state,
          body: Container(
            width: size.width,
            height: size.height,
            color: blackcolor,
            child: Column(
              children: [
                CustomAppbar(height: 90),

                //ARTWORK WIDGET
                Expanded(
                    flex: 2,
                    child: SizedBox(
                      width: size.width,
                      // color: Colors.orange,
                      child: Column(
                        children: [
                          MusicLogo(),
                          const SizedBox(
                            height: 20,
                          ),
                          SongNamePlate()
                        ],
                      ),
                    )),

                //SONGCONTROLL WIDGETS

                Expanded(
                    child: SizedBox(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: whitcolor,
                    ),
                    child: Controller(),
                  ),
                ))
              ],
            ),
          ),
          drawer: CustomDrawer()),
    );
  }
}
