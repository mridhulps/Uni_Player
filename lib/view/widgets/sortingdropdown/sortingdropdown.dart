import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:uniplayer/Repository/controller/audiocontroller.dart';
import 'package:uniplayer/Resources/const/constants.dart';

class SortingDropdown extends StatelessWidget {
  SortingDropdown({super.key});

  final controller = Get.find<PlayerController>();

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<Sortitem>(
        shape: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide.none),
        clipBehavior: Clip.antiAlias,
        // color: Colors.lightBlue.shade100,
        elevation: 10,
        onSelected: (value) {
          controller.songsorting(value);
        },
        child: const Icon(
          Icons.sort,
          size: 25,
        ),
        itemBuilder: (context) => [
              customItem('Date', Sortitem.date),
              customItem('Artist', Sortitem.artist),
              customItem('Album ', Sortitem.album),
              customItem('Size', Sortitem.size),
              customItem('Duration', Sortitem.duration),
            ]);
  }
}

PopupMenuEntry<Sortitem> customItem(String text, Sortitem type) {
  final controller = Get.find<PlayerController>();

  return PopupMenuItem<Sortitem>(
      value: type,
      textStyle: TextStyle(
          fontWeight: FontWeight.bold,
          fontStyle: FontStyle.italic,
          color: controller.getsort == text ? Colors.blue : blackcolor),
      onTap: () {
        controller.getsort = text;
      },
      child: Text(text));
}

enum Sortitem { date, artist, album, size, duration }
