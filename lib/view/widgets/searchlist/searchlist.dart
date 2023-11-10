import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:uniplayer/controller/audiocontroller.dart';

class SearchList extends StatelessWidget {
  SearchList({super.key});

  final controller = Get.find<PlayerController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ListView.separated(
          physics: const BouncingScrollPhysics(),
          itemBuilder: ((context, index) {
            final searchsong = controller.searchresult[index];
            final searchsonglist = controller.searchresult;

            return ListTile(
              minVerticalPadding: 15,
              leading: CircleAvatar(
                child: QueryArtworkWidget(
                  id: searchsong.id,
                  type: ArtworkType.AUDIO,
                  nullArtworkWidget: const Icon(Icons.music_note),
                ),
              ),
              title: Text(
                searchsong.displayNameWOExt,
                style: const TextStyle(color: Colors.white),
              ),
              subtitle: Text(searchsong.artist!,
                  style: TextStyle(color: Colors.white.withOpacity(0.5))),
              onTap: () {
                controller.songplay(index, searchsonglist);
                controller.generatemodel(searchsonglist);
              },
            );
          }),
          separatorBuilder: ((context, index) {
            return const SizedBox(
              height: 5,
            );
          }),
          itemCount: controller.searchresult.length),
    );

    
  }
}
