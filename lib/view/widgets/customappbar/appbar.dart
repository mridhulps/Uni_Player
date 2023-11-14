import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uniplayer/Repository/controller/audiocontroller.dart';

import 'package:uniplayer/Resources/const/constants.dart';


class CustomAppbar extends StatefulWidget {
 const CustomAppbar({super.key, required this.height});

  final double height;

  @override
  State<CustomAppbar> createState() => _CustomAppbarState();
}

class _CustomAppbarState extends State<CustomAppbar> {
  final controll = Get.find<PlayerController>();
//SONGLIST DRAWER;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: widget.height,
      child: Padding(
        padding: const EdgeInsetsDirectional.only(top: 20, end: 10, start: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () {
                Scaffold.of(context).openDrawer();
              },
              child: const Icon(
                Icons.arrow_forward_ios_rounded,
                color: whitcolor,
              ),
            ),

            //SHARE BUTTON
          ],
        ),
      ),
    );
  }
}
