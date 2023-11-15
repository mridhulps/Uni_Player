// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:uniplayer/Repository/controller/audiocontroller.dart';
import 'package:uniplayer/Resources/const/constants.dart';

import 'package:uniplayer/view/widgets/sortingdropdown/sortingdropdown.dart';

import '../searchlist/searchvalue_emptypage/searchvalue_emptypage.dart';
import '../songlist/songlist.dart';

class CustomDrawer extends StatelessWidget {
  CustomDrawer({super.key});

  TextEditingController textcontroller = TextEditingController();
  final controller = Get.find<PlayerController>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.transparent,
      body: Drawer(
        backgroundColor: Colors.black.withOpacity(0.8),
        width: size.width - 20,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(20),
                bottomRight: Radius.circular(20))),
        child: SizedBox(
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 0),
              child: AppBar(
                backgroundColor: blackcolor,
                elevation: 10,
                automaticallyImplyLeading: false,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(0),
                        bottomRight: Radius.circular(0))),
                title: const Text('Music'),
                actions: [
                  Padding(
                    padding: const EdgeInsets.only(right: 5),
                    child: SortingDropdown(),
                  ),
                  IconButton(
                      color: whitcolor,
                      onPressed: () {
                       // controller.searchisempty.value = true;
                        SystemChannels.textInput.invokeMethod('TextInput.hide');
                      },
                      icon: const Icon(
                        Icons.refresh_rounded,
                        size: 25,
                      ))
                ],
              ),
            ),
//SEARCH BAR;

            Padding(
              padding: const EdgeInsets.only(left: 5, right: 5, top: 0),
              child: Container(
                decoration: const BoxDecoration(
                    color: whitcolor,
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10))),
                child: TextFormField(
                  controller: textcontroller,
                  cursorColor: whitcolor,
                  decoration: const InputDecoration(
                      prefixIcon: Icon(
                        Icons.search,
                      ),
                      hintText: 'search for music',
                      contentPadding: EdgeInsets.all(10),
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                      fillColor: whitcolor),
                  onChanged: (value) {
                    controller.searchsong(value);
                  },
                ),
              ),
            ),
            Obx(
              () => Expanded(
                child: Stack(children: [
                  controller.searchisempty.value
                      ? BuildSongs(
                          drawerctx: context,
                        )
                      : SearchEmptyPage()
                ]),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
