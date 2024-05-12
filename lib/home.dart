import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tunescout_project/song_detection.dart';

class HomePage extends HookConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: const Color(0xFF042442),
      body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Here there will be a list of shazamed songs at different locations /'
                    'or an empty list placeholder',
                style: TextStyle(color: Colors.white, fontSize: 26),
              ),
              SizedBox(
                height: 40,
              ),
            ],
          )),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        foregroundColor: Theme.of(context).primaryColor,
        onPressed: () {
          Navigator.of(context).push(
              MaterialPageRoute(
                  builder: (context) => const SongDetection()
              )
          );
        },
        child: const Icon(Icons.music_note),
      )
    );
  }
}
