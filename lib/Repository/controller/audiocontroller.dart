import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:on_audio_query/on_audio_query.dart';

import 'package:permission_handler/permission_handler.dart';
import 'package:uniplayer/Models/songinfo_model/songinfomodel.dart';

import 'package:uniplayer/Resources/const/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:uniplayer/view/widgets/sortingdropdown/sortingdropdown.dart';

import '../../view/screens/home_screen/homescreen.dart';

class PlayerController extends GetxController
    with GetSingleTickerProviderStateMixin {

  late AnimationController animecontroller;

  final audioquery = OnAudioQuery();

  final audioplayer = AudioPlayer();

  late SharedPreferences sharedpreference;

  // VARIABLES

  var obtitle = ''.obs;
  var obartist = ''.obs;
  var id = 0.obs;
  Rx<LoopMode> loop = LoopMode.all.obs;
  Rx<SongSortType> sorttype = SongSortType.DATE_ADDED.obs;
  Rx<Duration> totalduration = Duration.zero.obs;
  Rx<Duration> position = Duration.zero.obs;

  List<SongModel> tempholdlist = <SongModel>[];

  RxList<SongModel> searchresult = <SongModel>[].obs;

  RxBool searchisempty = true.obs;
  String getsort = 'date';

  @override
  void onInit() async {
    print('getx builded');
    await checkpermissionrequist();

    super.onInit();
  }

  //PERMISSION METHODE;

  Future checkpermissionrequist() async {
    final requist = await Permission.storage.request();

    if (requist.isGranted) {
      gotohomescreen();
      sharedpreference = await SharedPreferences.getInstance();
      animecontroller = AnimationController(
          vsync: this, duration: const Duration(seconds: 40));
    } else if (requist.isDenied) {
      checkpermissionrequist();
    } else if (requist.isPermanentlyDenied) {
      openAppSettings();
    }
  }

  Future<void> gotohomescreen() async {
    await Future.delayed(const Duration(seconds: 1));

    Get.to(() => HomeScreen());
  }

  //QUERYSONGS METHODE;

  Future<List<SongModel>> querysongsinfo() async {
    final songlist = await audioquery.querySongs(
        sortType: sorttype.value,
        orderType: OrderType.DESC_OR_GREATER,
        uriType: UriType.EXTERNAL,
        ignoreCase: true);

    return songlist;
  }

  // PLAYSONG METHODE;

  Future<void> songplay(int index, List<SongModel> modellist) async {
    try {
      await audioplayer.setAudioSource(
          songplayist(
            modellist,
          ),
          initialIndex: index);
      await audioplayer.play();
    } catch (e) {
      toast(e.toString());
    }
  }

  //SONG TITLE ARTIST ARTWORK INFO CUSTOM GENERATE;

  generatemodel(List<SongModel> modellist) {
    var customlist = modellist
        .map((e) => SongInfoModel(
              title: e.displayNameWOExt,
              artist: e.artist ?? '',
              id: e.id,
            ))
        .toList();

    audioplayer.currentIndexStream.listen((index) {
      if (index == null) {
        //TOAST MESSAGE;

        obtitle.value = '';
        obartist.value = '';
        toast('Something Went Wrong');
      }
      final song = customlist[index!];

      obtitle.value = song.title;
      obartist.value = song.artist;
      id.value = song.id;
    });
  }

  //SONGPLAYLIST METHODE;

  ConcatenatingAudioSource songplayist(List<SongModel> modellist) {
    var list = modellist
        .map((e) => AudioSource.uri(Uri.parse(e.uri!),
            tag: MediaItem(
              id: e.id.toString(),
              title: e.displayName,
              artist: e.artist,
              duration: const Duration(hours: 1),
            )))
        .toList();
    return ConcatenatingAudioSource(children: list);
  }

  //SONGNAME ARTWORK AND STREAMS  METHODE;

  songinformationstreams() {
    audioplayer.durationStream.listen((event) {
      totalduration.value = event ?? Duration.zero;
    });

    audioplayer.positionStream.listen((event) {
      position.value = event;
    });
  }

  // LOOPMODE METHODE;

  loopsettings() async {
    if (loop.value == LoopMode.all) {
      await audioplayer.setLoopMode(LoopMode.one);
      loop.value = LoopMode.one;
    } else if (loop.value == LoopMode.one) {
      await audioplayer.setLoopMode(LoopMode.all);
      loop.value = LoopMode.all;
    }
  }

  //SHUFFLE MODEL ENABLE METHODE;

  Future shufflemodeenabled(bool isshuffle) async {
    await audioplayer.setShuffleModeEnabled(isshuffle);
  }

  //SORTING METHODE;

  songsorting(Sortitem value) async {
    if (value == Sortitem.date) {
      sorttype.value = SongSortType.DATE_ADDED;

      savevariable('date');
    } else if (value == Sortitem.artist) {
      sorttype.value = SongSortType.ARTIST;
      savevariable('artist');
    } else if (value == Sortitem.album) {
      sorttype.value = SongSortType.ALBUM;
      savevariable('album');
    } else if (value == Sortitem.size) {
      sorttype.value = SongSortType.SIZE;
      savevariable('size');
    } else if (value == Sortitem.duration) {
      sorttype.value = SongSortType.DURATION;
      savevariable('duration');
    }
  }

  // TOAST MESSAGE;

  toast(String message) {
    Fluttertoast.showToast(
        msg: message,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.white38,
        textColor: blackcolor);
  }
  // ANIMATION ARTWORK METHODE;

  animatewidget(bool isanimate) {
    if (isanimate) {
      animecontroller.forward();
      animecontroller.repeat();
    } else {
      animecontroller.stop();
    }
  }

  //SAVE DATA METHODE USING SHARED PREFERENCES;

  //sort;

  Future<void> savevariable(String value) async {
    await sharedpreference.remove('sort');
    await sharedpreference.setString('sort', value);
  }

  // SAVE SHUFFLE MODE ENABLED ;

  Future<void> saveshuffle(bool isshuffle) async {
    await sharedpreference.remove('isshuffle');
    await sharedpreference.setBool('isshuffle', isshuffle);
  }

  //GET VARIABLE METHODE USING SHADE PREFERENCES;

  getvariable() {
    final getvalue = sharedpreference.getString('sort');

    if (getvalue == null) {
      sorttype.value = SongSortType.DATE_ADDED;
    } else {
      if (getvalue == 'date') {
        sorttype.value = SongSortType.DATE_ADDED;
        getsort = 'date';
      } else if (getvalue == 'artist') {
        sorttype.value = SongSortType.ARTIST;
        getsort = 'artist';
      } else if (getvalue == 'album') {
        sorttype.value = SongSortType.ALBUM;
        getsort = 'album';
      } else if (getvalue == 'size') {
        sorttype.value = SongSortType.SIZE;
        getsort = 'size';
      } else if (getvalue == 'duration') {
        sorttype.value = SongSortType.DURATION;
        getsort = 'duration';
      }
    }
  }

  // GET SHUFFLE METHODE;

  bool? getshuffle() {
    bool? getvalue = sharedpreference.getBool('isshuffle');

    return getvalue;
  }

  //SEARCH SONG METHODE;

  searchsong(String value) {
    List<SongModel> result = [];

    result = tempholdlist
        .where((element) => element.displayNameWOExt
            .toLowerCase()
            .contains(value.toLowerCase()))
        .toList();

    searchresult.value = result;

    if (value.isEmpty) {
      searchresult.clear();
      searchisempty.value = true;
    } else {
      searchisempty.value = false;
    }
  }
}
