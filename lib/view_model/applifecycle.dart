import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uniplayer/Repository/controller/audiocontroller.dart';

class PlayerLifeCycle extends StatefulWidget {
  final dynamic child;

  const PlayerLifeCycle({super.key, required this.child});

  @override
  State<PlayerLifeCycle> createState() => _PlayerLifeCycleState();
}

class _PlayerLifeCycleState extends State<PlayerLifeCycle>
    with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);

    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      log('paused');
    } else if (state == AppLifecycleState.resumed) {
      log('resuemed');
    } else if (state == AppLifecycleState.detached) {
      log('detached');
      WidgetsBinding.instance.removeObserver(this);
      Get.delete<PlayerController>();
      PlayerController().audioplayer.dispose();
      PlayerController().animecontroller.dispose();
    }

    super.didChangeAppLifecycleState(state);
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
