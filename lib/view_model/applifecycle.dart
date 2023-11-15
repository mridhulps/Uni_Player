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
  void dispose() {
    log('disposed');
    super.dispose();
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

      PlayerController().audioplayer.dispose();
      PlayerController().animecontroller.dispose();
      Get.delete<PlayerController>();
    }

    super.didChangeAppLifecycleState(state);
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
