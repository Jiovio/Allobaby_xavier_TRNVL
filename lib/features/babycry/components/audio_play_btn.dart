import 'package:allobaby/Config/Color.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class AudioPlayerButton extends StatefulWidget {
  final String assetPath;

  const AudioPlayerButton({Key? key, required this.assetPath}) : super(key: key);

  @override
  _AudioPlayerWidgetState createState() => _AudioPlayerWidgetState();
}

class _AudioPlayerWidgetState extends State<AudioPlayerButton> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool isPlaying = false;

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  void _togglePlayPause() async {
    if (isPlaying) {
      await _audioPlayer.pause();
    } else {
      await _audioPlayer.play(AssetSource(widget.assetPath));
    }
    setState(() {
      isPlaying = !isPlaying;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: PrimaryColor,
        borderRadius: BorderRadius.circular(50)
      ),
      child: IconButton(
        
        icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow, size: 30,color: Colors.white,),
        onPressed: _togglePlayPause,
      ),
    );
  }
}