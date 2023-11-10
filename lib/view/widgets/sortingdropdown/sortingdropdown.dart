import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:uniplayer/controller/audiocontroller.dart';
import 'package:uniplayer/view/const/constants.dart';

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
              PopupMenuItem(
                value: Sortitem.date,
                textStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                    color: controller.getsort == 'date'
                        ? Colors.blue
                        : blackcolor),
                onTap: () {
                  controller.getsort = 'date';
                },
                child: const Text('Date'),
              ),
              PopupMenuItem(
                value: Sortitem.artist,
                textStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                    color: controller.getsort == 'artist'
                        ? Colors.blue
                        : blackcolor),
                onTap: () {
                  controller.getsort = 'artist';
                },
                child: const Text('Artist'),
              ),
              PopupMenuItem(
                value: Sortitem.album,
                textStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                    color: controller.getsort == 'album'
                        ? Colors.blue
                        : blackcolor),
                onTap: () {
                  controller.getsort = 'album';
                },
                child: const Text('Album'),
              ),
              PopupMenuItem(
                value: Sortitem.size,
                textStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                    color: controller.getsort == 'size'
                        ? Colors.blue
                        : blackcolor),
                onTap: () {
                  controller.getsort = 'size';
                },
                child: const Text('Size'),
              ),
              PopupMenuItem(
                value: Sortitem.duration,
                textStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                    color: controller.getsort == 'duration'
                        ? Colors.blue
                        : blackcolor),
                onTap: () {
                  controller.getsort = 'duration;';
                },
                child: const Text('Duration'),
              ),
            ]);
  }
}

enum Sortitem { date, artist, album, size, duration }
