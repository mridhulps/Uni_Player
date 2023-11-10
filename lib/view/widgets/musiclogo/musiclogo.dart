import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:on_audio_query/on_audio_query.dart';
import 'package:uniplayer/controller/audiocontroller.dart';

import 'package:uniplayer/view/const/constants.dart';

class MusicLogo extends StatelessWidget {
  MusicLogo({super.key});

  final controll = Get.find<PlayerController>();

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(10.0),
        child: Obx(
          () => RotationTransition(
            turns:
                Tween(begin: 0.0, end: 1.0).animate(controll.animecontroller),
            child: CircleAvatar(
              backgroundColor: artworkcolor,
              radius: 50 * 3,
              child: QueryArtworkWidget(
                id: controll.id.value,
                type: ArtworkType.AUDIO,
                artworkFit: BoxFit.contain,
                artworkHeight: 50 * 6,
                artworkWidth: 50 * 6,
                artworkBorder: BorderRadius.circular(200),
                size: 1000,
                nullArtworkWidget: const Icon(
                  Icons.music_note,
                  size: 150,
                  color: whitcolor,
                ),
              ),
            ),
          ),
        ));
  }
}
