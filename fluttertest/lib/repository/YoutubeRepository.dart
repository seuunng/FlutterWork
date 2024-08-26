import 'package:dio/dio.dart';
import 'package:fluttertest/const/api.dart';
import '../model/video_model.dart';

class YoutubeRepository {
  static Future<List<VideoModel>> getVideos() async {
    try {
    final resp = await Dio().get(
      YOUTUBE_API_BASE_URL,
      queryParameters: {
        'channelId': CF_CHANNEL_ID,
        'maxResults': 50,
        'key': API_KEY,
        'part': 'snippet',
        'order': 'date',
      },
    );
    // 'times'가 null이 아니고, 리스트 데이터가 있을 때만 처리
    if (resp.data != null && resp.data['items'] != null) {
      final listWithData = resp.data['items'].where(
            (item) =>
        item?['id']?['videoId'] != null && item?['snippet']?['title'] != null,
      ).toList();

      // VideoModel로 매핑하여 반환
      return listWithData.map<VideoModel>(
            (item) => VideoModel(
          id: item['id']['videoId'],
          title: item['snippet']['title'],
        ),
      ).toList();
    } else {
      // 'items'가 null이거나 데이터가 없을 경우 빈 리스트 반환
      return [];
    }
  } catch (e) {
  // 에러 처리
  throw Exception('Failed to load videos: $e');
  }
}
}