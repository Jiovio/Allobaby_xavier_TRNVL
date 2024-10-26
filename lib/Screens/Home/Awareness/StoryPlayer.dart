import 'dart:async';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class Storyplayer extends StatefulWidget {
  final String url;
  final String title;
  final String description;
  
  const Storyplayer({
    super.key, 
    required this.url, 
    required this.title, 
    required this.description
  });

  @override
  State<Storyplayer> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<Storyplayer> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(
      Uri.parse(widget.url),
    );
    _initializeVideoPlayerFuture = _controller.initialize();
    _controller.setLooping(true);
    _controller.play();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Video Player
          FutureBuilder(
            future: _initializeVideoPlayerFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Center(
                  child: AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: VideoPlayer(_controller),
                  ),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                );
              }
            },
          ),
          
          // Bottom text overlay
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Colors.black.withOpacity(0.8),
                    Colors.transparent,
                  ],
                ),
              ),
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Title
                  Text(
                    widget.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      shadows: [
                        Shadow(
                          offset: Offset(1.0, 1.0),
                          blurRadius: 3.0,
                          color: Colors.black,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Description
                  Text(
                    widget.description,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      shadows: [
                        Shadow(
                          offset: Offset(1.0, 1.0),
                          blurRadius: 3.0,
                          color: Colors.black,
                        ),
                      ],
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),


          // Positioned(
          //   left: 0,
          //   right: 0,
          //   bottom: 120, // Positioned above the text
          //   child: GestureDetector(
          //     onTap: () {
          //       setState(() {
          //         if (_controller.value.isPlaying) {
          //           _controller.pause();
          //         } else {
          //           _controller.play();
          //         }
          //       });
          //     },
          //     child: Container(
          //       height: 60,
          //       color: Colors.transparent,
          //       child: Center(
          //         child: Icon(
          //           _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
          //           color: Colors.white.withOpacity(0.8),
          //           size: 40,
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}