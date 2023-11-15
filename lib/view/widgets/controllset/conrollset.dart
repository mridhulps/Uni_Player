import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:uniplayer/Repository/controller/audiocontroller.dart';

import 'package:uniplayer/Resources/const/constants.dart';

class Controller extends StatelessWidget {
  Controller({super.key});

  final controll = Get.find<PlayerController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          //SLIDER

          Slider(
              thumbColor: Colors.lightBlue[600],
              activeColor: Colors.lightBlue[500],
              inactiveColor: whitcolor,
              value: controll.position.value.inSeconds.toDouble(),
              min: 0,
              max: controll.totalduration.value.inSeconds.toDouble(),
              onChanged: (value) async {
                final position = Duration(seconds: value.toInt());
                await controll.audioplayer.seek(position);
              }),

          Padding(
            padding: const EdgeInsets.only(left: 25, right: 25),
            child: SizedBox(
              child: Row(
                //DURATIONS
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(controll.position.value.toString().split('.').first),
                  Text(controll.totalduration.toString().split('.').first)
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 50),
            child: SizedBox(
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    //LOOP  BUTTON

                    Obx(() => InkWell(
                        onTap: () {
                          controll.loopsettings();
                        },
                        child: controll.loop.value == LoopMode.all
                            ? const Icon(Icons.repeat)
                            : const Icon(Icons.repeat_one))),

                    //PREVIOUS BUTTON
                    InkWell(
                        onTap: () {
                          if (controll.audioplayer.hasPrevious) {
                            controll.audioplayer.seekToPrevious();
                          }
                        },
                        child: const Icon(Icons.skip_previous, size: 40)),
                    //seek

                    InkWell(
                      onTap: () {
                        if (controll.position.value.inSeconds >= 5) {
                          controll.audioplayer.seek(Duration(
                              seconds: controll.position.value.inSeconds - 5));
                        }
                      },
                      child: const Icon(Icons.replay_5,
                          size: 30, color: Colors.black54),
                    ),
                    //PLAY BUTTON
                    StreamBuilder<PlayerState>(
                        stream: controll.audioplayer.playerStateStream,
                        builder: (context, snapshot) {
                          if (snapshot.data == null) {
                            return Center(
                                child: CircleAvatar(
                                    backgroundColor: Colors.lightBlue.shade500,
                                    radius: 35,
                                    child: const Icon(
                                      Icons.play_arrow_rounded,
                                      size: 50,
                                      color: whitcolor,
                                    )));
                          } else if (snapshot.data!.processingState ==
                              ProcessingState.completed) {
                            controll.position.value = Duration.zero;
                            return CircleAvatar(
                                backgroundColor: Colors.lightBlue.shade500,
                                radius: 35,
                                child: const Icon(
                                  Icons.play_arrow_rounded,
                                  size: 50,
                                  color: whitcolor,
                                ));
                          }

                          final playing = snapshot.data!.playing;
                          final idle = snapshot.data!.processingState;

                          if (idle == ProcessingState.idle) {
                            controll.animatewidget(false);
                          } else if (playing == false) {
                            controll.animatewidget(false);
                          } else if (playing == true) {
                            controll.animatewidget(true);
                          }

                          return InkWell(
                            onTap: () {
                              if (controll.isEntryplaybutton == true) {
                                // nothing changes.
                              } else {
                                if (playing) {
                                  controll.audioplayer.pause();
                                } else {
                                  controll.audioplayer.play();
                                }
                              }
                            },
                            child: CircleAvatar(
                                backgroundColor: Colors.lightBlue.shade500,
                                radius: 35,
                                child: playing
                                    ? const Icon(
                                        Icons.pause,
                                        size: 45,
                                        color: whitcolor,
                                      )
                                    : const Icon(
                                        Icons.play_arrow_rounded,
                                        size: 50,
                                        color: whitcolor,
                                      )),
                          );
                        }),

                    //fORWARD
                    InkWell(
                      onTap: () {
                        if (controll.position.value.inSeconds <=
                            controll.totalduration.value.inSeconds - 5) {
                          controll.audioplayer.seek(Duration(
                              seconds: controll.position.value.inSeconds + 5));
                        }
                      },
                      child: const Icon(Icons.forward_5,
                          size: 30, color: Colors.black54),
                    ),
                    //NEXT BUTTON
                    InkWell(
                      onTap: () {
                        if (controll.audioplayer.hasNext) {
                          controll.audioplayer.seekToNext();
                        }
                      },
                      child: const Icon(
                        Icons.skip_next,
                        size: 40,
                      ),
                    ),
                    // SHUFFLE BUTTON;

                    StreamBuilder<bool>(
                        stream: controll.audioplayer.shuffleModeEnabledStream,
                        builder: (context, snapshot) {
                          var isshuffle = snapshot.data ?? false;
                          final getvalue = controll.getshuffle();
                          isshuffle = getvalue ?? false;

                          return InkWell(
                              onTap: () {
                                isshuffle = !isshuffle;
                                controll.shufflemodeenabled(isshuffle);

                                controll.saveshuffle(isshuffle);

                                if (isshuffle == false) {
                                  controll.toast('Shuffle Mode disabled');
                                } else {
                                  controll.toast('Shuffle Mode Enabled');
                                }
                              },
                              child: Icon(
                                Icons.shuffle,
                                color: isshuffle == true
                                    ? Colors.lightBlue
                                    : Colors.black,
                              ));
                        }),
                  ]),
            ),
          ),
        ],
      ),
    );
  }
}
