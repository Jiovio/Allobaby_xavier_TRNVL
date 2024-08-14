import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';


class PageViewExample extends StatefulWidget {
  @override
  _PageViewExampleState createState() => _PageViewExampleState();
}

class _PageViewExampleState extends State<PageViewExample> {
  late PageController _pageController;
  late List<VideoPlayerController> _videoControllers;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _videoControllers = [
      VideoPlayerController.networkUrl(
              Uri.parse(
        'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
      ),
      )
        ..initialize().then((_) {
          setState(() {});
        }),
      VideoPlayerController.networkUrl(
              Uri.parse(
        'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
      ),
      )
        ..initialize().then((_) {
          setState(() {});
        }),
      VideoPlayerController.networkUrl(
              Uri.parse(
        'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
      ),
      )
        ..initialize().then((_) {
          setState(() {});
        }),
    ];
    _pageController.addListener(_pageListener);
  }

  void _pageListener() {
    int newPage = _pageController.page!.round();
    if (newPage != _currentPage) {
      _videoControllers[_currentPage].pause();
      _videoControllers[newPage].play();
      setState(() {
        _currentPage = newPage;
      });
    }
  }

  @override
  void dispose() {
    _pageController.removeListener(_pageListener);
    _pageController.dispose();
    for (var controller in _videoControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _pageController,
      children: <Widget>[
        _buildVideoPage(_videoControllers[0]),
        _buildVideoPage(_videoControllers[1]),
        _buildVideoPage(_videoControllers[2]),
      ],
    );
  }

  Widget _buildVideoPage(VideoPlayerController controller) {
    return Center(
      child: controller.value.isInitialized
          ? AspectRatio(
              aspectRatio: controller.value.aspectRatio,
              child: VideoPlayer(controller),
            )
          : CircularProgressIndicator(),
    );
  }
}
