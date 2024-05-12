import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'song_screen.dart';
import 'viewmodels/home_vm.dart';

class SongDetection extends HookConsumerWidget {
  const SongDetection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vm = ref.watch(homeViewModel);

    useEffect(() {
      return () {
        if (vm.success && vm.currentSong != null) {
          vm.stopRecognizing().whenComplete(() =>
              Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) => SongScreen(
                        song: vm.currentSong!,
                      )))
          );
        }
      };
    }, [vm.success]);

    return Scaffold(
      backgroundColor: const Color(0xFF042442),
      body: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Tap to detect song',
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
                        'assets/images/music-logo.png',
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              )
            ],
          )),
    );
  }
}

