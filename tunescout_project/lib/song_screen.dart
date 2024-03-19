import 'package:flutter/material.dart';
import 'package:tunescout_project/services/models/deezer_song_model.dart';

class SongScreen extends StatelessWidget {
  final DeezerSongModel song;
  const SongScreen({super.key, required this.song}); //should be nullable params
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF042442),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.6,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage("https://api.deezer.com/artist/27/image"), //NetworkImage(song?.album?.coverMedium),
                          //: AssetImage('assets/images/todd.jpg'),
                      fit: BoxFit.cover)),
              // child: Image.asset('assets/images/todd.jpg'),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(20),
                width: MediaQuery.of(context).size.width,
                color: Colors.black,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 100,
                      child: Column(
                        children: [
                          Expanded(
                            child: Text(song?.title ?? '',
                                // overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 40,
                                    fontWeight: FontWeight.w500)),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(song?.artist?.name ?? '',
                        style: const TextStyle(color: Colors.white, fontSize: 15))
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
