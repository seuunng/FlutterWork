import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertest/repository/YoutubeRepository.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../component/custom_youtube_player.dart';
import '../model/video_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

  class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          '코팩튜브',
        ),
        backgroundColor: Colors.black,
      ),
      body: FutureBuilder<List<VideoModel>>(
        future: YoutubeRepository.getVideos(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(
                snapshot.error.toString(),
              ),
            );
          }
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return RefreshIndicator(
          onRefresh: () async {
            setState(() { });
          },
          child: ListView(
            physics: BouncingScrollPhysics(),
            children: snapshot.data!
            .map((e)=>CustomYoutubePlayer(videoModel: e))
            .toList(),
            ),
          );
        },
      ),
  );
  }
}
