import 'package:acr_cloud_sdk/acr_cloud_sdk.dart';
import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tunescout_project/services/models/deezer_song_model.dart';
import 'package:tunescout_project/services/song_service.dart';

class HomeViewModel extends ChangeNotifier {
  HomeViewModel() {
    initAcr();
  }
  final AcrCloudSdk acr = AcrCloudSdk();
  final songService = SongService();
  DeezerSongModel? currentSong;
  bool isRecognizing = false;
  bool success = false;

  Future<void> initAcr() async {
    try {
      acr
        ..init(
          // Albert's credentials, new ones should be taken from:  https://www.acrcloud.com/
          host: 'identify-eu-west-1.acrcloud.com',
          accessKey: 'fc1e85c2c909cdab39426747052331d4',
          accessSecret: '23rURKZpSMrNm8tceAuSFkiKwSWvYH2mI7cpgZMR',
          setLog: true,
        )
        ..songModelStream.listen(searchSong);
    } catch (e) {
      print(e.toString());
    }
  }

  void searchSong(SongModel song) async {
    final metaData = song.metadata;
    if (metaData != null && metaData.music?.length != null
        && metaData.music!.isNotEmpty) {
      final trackId = metaData.music?[0].externalMetadata?.deezer?.track?.id;
      try {
        final res = await songService.getTrack(trackId);
        currentSong = res;
        success = true;
        notifyListeners();
      } catch (e) {
        isRecognizing = false;
        success = false;
        notifyListeners();
      }
    }
  }

  Future<void> startRecognizing() async {
    isRecognizing = true;
    success = false;
    notifyListeners();
    try {
      await acr.start();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> stopRecognizing() async {
    isRecognizing = false;
    success = false;
    notifyListeners();
    try {
      await acr.stop();
    } catch (e) {
      print(e.toString());
    }
  }
}

final homeViewModel = ChangeNotifierProvider<HomeViewModel>((ref) {
  print('>>> In homeViewModel');
  return HomeViewModel();
});
