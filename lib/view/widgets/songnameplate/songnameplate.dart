import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uniplayer/controller/audiocontroller.dart';

import '../../const/constants.dart';

class SongNamePlate extends StatelessWidget {
  SongNamePlate({super.key});

  final controll = Get.find<PlayerController>();

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 30, left: 20),
        child: Obx(
          () => SizedBox(
              width: 50 * 5,
              height: 70,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: controll.obtitle.isNotEmpty
                            ? Text(
                                controll.obtitle.value,
                                overflow: TextOverflow.visible,
                                style: const TextStyle(
                                    color: whitcolor,
                                    fontWeight: FontWeight.bold),
                              )
                            : const Text(
                                'Waiting For Playing',
                                style: TextStyle(
                                    color: whitcolor,
                                    fontWeight: FontWeight.bold),
                              )),
                    Text(
                      controll.obartist.value,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          color: whitcolor, fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              )),
        ));
  }
}
