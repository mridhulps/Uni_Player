import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:uniplayer/Repository/controller/audiocontroller.dart';
import 'package:uniplayer/Resources/const/constants.dart';

class BuildSongs extends StatelessWidget {
  final BuildContext drawerctx;
  BuildSongs({super.key, required this.drawerctx});

  final controller = Get.find<PlayerController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => FutureBuilder<List<SongModel>>(
          future: controller.querysongsinfo(),
          builder: ((context, snapshot) {
            final data = snapshot.data;

            if (data == null) {
              return const Center(
                child: Text(
                  'No Songs Found',
                  style: TextStyle(color: whitcolor),
                ),
              );
            } else {
              controller.tempholdlist.clear();
              controller.tempholdlist.addAll(data);
            }

            if (data.isEmpty) {
              return const Center(
                child: Text(
                  'NO Song Found',
                  style: TextStyle(color: whitcolor),
                ),
              );
            } else {
              return ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: ((context, index) {
                    final model = data[index];

                    return ListTile(
                      minVerticalPadding: 15,
                      leading: CircleAvatar(
                        child: QueryArtworkWidget(
                          id: model.id,
                          type: ArtworkType.AUDIO,
                          nullArtworkWidget: const Icon(Icons.music_note),
                        ),
                      ),
                      title: Text(
                        model.displayNameWOExt,
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      subtitle: Text(model.artist ?? '<Unknown>',
                          style:
                              TextStyle(color: Colors.white.withOpacity(0.5))),
                      onTap: () {
                        controller.songplay(
                          index,
                          data,
                        );

                        controller.generatemodel(data);

                        controller.songinformationstreams();
                        controller.isEntryplaybutton=false;
                        controller.animatewidget(true);
                        Scaffold.of(drawerctx).closeDrawer();
                      },
                    );
                  }),
                  separatorBuilder: ((context, index) {
                    return const SizedBox(
                      height: 5,
                    );
                  }),
                  itemCount: data.length);
            }
          })),
    );
  }
}
