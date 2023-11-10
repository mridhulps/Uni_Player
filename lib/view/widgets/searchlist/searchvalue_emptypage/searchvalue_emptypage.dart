import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:uniplayer/controller/audiocontroller.dart';
import 'package:uniplayer/view/const/constants.dart';
import 'package:uniplayer/view/widgets/searchlist/searchlist.dart';

class SearchEmptyPage extends StatelessWidget {
  SearchEmptyPage({super.key});

  final controller = Get.find<PlayerController>();
  @override
  Widget build(BuildContext context) {
    return Obx(() => Container(
          color: Colors.black,
          child: controller.searchresult.isEmpty
              ? Padding(
                  padding: const EdgeInsets.only(top: 50 * 4),
                  child: Column(
                    children: [
                      const Align(
                        alignment: Alignment.topCenter,
                        child: Text(
                          'Song is Empty',
                          style: TextStyle(color: whitcolor,fontStyle: FontStyle.italic,fontWeight: FontWeight.bold),
                        ),
                      ),
                      IconButton(
                          color: whitcolor,
                          onPressed: () {
                            SystemChannels.textInput
                                .invokeMethod('TextInput.hide');
                            controller.searchisempty.value = true;
                          },
                          icon: const Icon(
                            Icons.refresh_rounded,
                            size: 34,
                          ))
                    ],
                  ),
                )
              : SearchList(),
        ));
  }
}
