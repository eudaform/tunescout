import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tunescout_project/song_screen.dart';
import 'package:tunescout_project/viewmodels/home_vm.dart';

class HomePage extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vm = ref.watch(homeViewModel);

    //TODO define state provider for this
    return ProviderListener<HomeViewModel>(
      provider: homeViewModel,
      onChange: (context, vm) {
        if (vm.success) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => SongScreen(
                    song: vm.currentSong,
                  )));
        }
      },
      child: Scaffold(
        backgroundColor: const Color(0xFF042442),
        body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Tap to Shazam',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                const SizedBox(
                  height: 40,
                ),
                AvatarGlow(
                  glowRadiusFactor: 0.7,
                  animate: vm.isRecognizing,
                  child: GestureDetector(
                    onTap: () => vm.isRecognizing
                        ? vm.stopRecognizing()
                        : vm.startRecognizing(),
                    child: Material(
                      shape: const CircleBorder(),
                      elevation: 8,
                      child: Container(
                        padding: const EdgeInsets.all(40),
                        height: 200,
                        width: 200,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: Color(0xFF089af8)),
                        child: Image.asset(
                          'assets/images/shazam-logo.png',
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            )),
      ),
    );
  }
}

