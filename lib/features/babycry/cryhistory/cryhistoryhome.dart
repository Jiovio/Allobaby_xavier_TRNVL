import 'package:allobaby/API/Requests/BabyCryAPI.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:just_audio/just_audio.dart';

class CryHistory extends StatefulWidget {
  @override
  State<CryHistory> createState() => _CryHistoryState();
}

class _CryHistoryState extends State<CryHistory> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  int? _currentlyPlayingId;
  int? _expandedTileId;
  bool _isPlaying = false;
  Duration? _duration;
  Duration _position = Duration.zero;

  dynamic cryHistory ;

  bool _sortAscending = false;
  final primaryColor = Color(0xffFF626F);
  final backgroundColor = Color.fromARGB(255, 255, 255, 255);


  void fetchCrys () async {

    final data = await Babycryapi.getcrys();

    cryHistory = data;

    setState(() {
      
    });
  }

  @override
  void initState() {
    super.initState();
    _setupAudioPlayer();

    fetchCrys();
  }

  void _setupAudioPlayer() {
    _audioPlayer.playerStateStream.listen((state) {
      if (state.processingState == ProcessingState.completed) {
        setState(() {
          _isPlaying = false;
          _position = Duration.zero;
          _expandedTileId = null;
          _currentlyPlayingId = null;
        });
      }
    });

    _audioPlayer.positionStream.listen((position) {
      setState(() {
        _position = position;
      });
    });

    _audioPlayer.durationStream.listen((duration) {
      setState(() {
        _duration = duration;
      });
    });
  }

  Future<void> _playAudio(int id, String audioUrl) async {
    try {
      if (_currentlyPlayingId == id && _isPlaying) {
        await _audioPlayer.pause();
        setState(() {
          _isPlaying = false;
        });
      } else {
        if (_currentlyPlayingId != id) {
          await _audioPlayer.stop();
          await _audioPlayer.setUrl(audioUrl);
          setState(() {
            _position = Duration.zero;
            _currentlyPlayingId = id;
            _expandedTileId = id;
          });
        }
        await _audioPlayer.play();
        setState(() {
          _isPlaying = true;
          _expandedTileId = id;
        });
      }
    } catch (e) {
      print('Error playing audio: $e');
      // You might want to show a snackbar or alert here
      ScaffoldMessenger.of(context).showSnackBar(
       const SnackBar(content: Text('Error playing audio')),
      );
    }
  }

  void _toggleTile(int id) {
    setState(() {
      if (_expandedTileId == id) {
        _expandedTileId = null;
      } else {
        _expandedTileId = id;
      }
    });
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String minutes = twoDigits(duration.inMinutes.remainder(60));
    String seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }

  void _sortList() {
    setState(() {
      _sortAscending = !_sortAscending;
      cryHistory.sort((a, b) {
        final DateTime dateA = DateTime.parse(a['created_at']);
        final DateTime dateB = DateTime.parse(b['created_at']);
        return _sortAscending
            ? dateA.compareTo(dateB)
            : dateB.compareTo(dateA);
      });
    });
  }

  String _getReasonEmoji(String reason) {
    switch (reason) {
      case 'Hungry Cry':
        return '🍼';
      case 'Sleepy Cry':
        return '😴';
      case 'Pain Cry':
        return '🤕';
      case 'Discomfort Cry':
        return '😣';
      case 'Colic Cry':
        return '😢';
      default:
        return '👶';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: backgroundColor,
      appBar: AppBar(
        title: Text(
          "Cry History",
          style: GoogleFonts.poppins(
            color: primaryColor,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              _sortAscending ? Icons.arrow_upward : Icons.arrow_downward,
              color: primaryColor,
            ),
            onPressed: _sortList,
          ),
        ],
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: primaryColor),
      ),
      body:

      SingleChildScrollView(
        child: 
        Column(
          children: [
      cryHistory == null ?
      const Center(child: CircularProgressIndicator()) : 
       ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        padding: const EdgeInsets.all(16),
        itemCount: cryHistory.length,
        itemBuilder: (context, index) {
          final cry = cryHistory[index];
          final DateTime createdAt = DateTime.parse(cry['created_at']);
          final String formattedDate = DateFormat('MMM dd, yyyy').format(createdAt);
          final String formattedTime = DateFormat('hh:mm a').format(createdAt);
          final bool isCurrentlyPlaying = _currentlyPlayingId == cry['id'];
          final bool isExpanded = _expandedTileId == cry['id'];
      
          return TweenAnimationBuilder(
            duration: const Duration(milliseconds: 500),
            tween: Tween(begin: 0.0, end: 1.0),
            builder: (context, double value, child) {
              return Transform.translate(
                offset: Offset(50 * (1 - value), 0),
                child: Opacity(
                  opacity: value,
                  child: child,
                ),
              );
            },
            child: Card(
              margin: EdgeInsets.only(bottom: 16),
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: InkWell(
                onTap: () => _toggleTile(cry['id']),
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.white,
                        Color(0xffFFF0F1),
                      ],
                    ),
                  ),
                  child: Column(
                    children: [
                      ListTile(
                        contentPadding: EdgeInsets.all(16),
                        leading: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: primaryColor.withOpacity(0.1),
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Text(
                              _getReasonEmoji(cry['text']),
                              style: TextStyle(fontSize: 24),
                            ),
                          ),
                        ),
                        title: Text(
                          cry['text'],
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: primaryColor,
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 4),
                            Row(
                              children: [
                                Icon(Icons.calendar_today,
                                    size: 14, color: Colors.black54),
                                SizedBox(width: 4),
                                Text(
                                  formattedDate,
                                  style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    color: Colors.black54,
                                  ),
                                ),
                                SizedBox(width: 16),
                                Icon(Icons.access_time,
                                    size: 14, color: Colors.black54),
                                SizedBox(width: 4),
                                Text(
                                  formattedTime,
                                  style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    color: Colors.black54,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        trailing: IconButton(
                          icon: Icon(
                            isCurrentlyPlaying && _isPlaying
                                ? Icons.pause_circle_filled
                                : Icons.play_circle_filled,
                            color: primaryColor,
                            size: 32,
                          ),
                          onPressed: () => _playAudio(cry['id'], cry['audio_link']),
                        ),
                      ),
                      AnimatedCrossFade(
                        firstChild: Container(height: 0),
                        secondChild: isCurrentlyPlaying
                            ? Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 8),
                                child: Column(
                                  children: [
                                    SliderTheme(
                                      data: SliderThemeData(
                                        activeTrackColor: primaryColor,
                                        inactiveTrackColor:
                                            primaryColor.withOpacity(0.2),
                                        thumbColor: primaryColor,
                                        overlayColor: primaryColor.withOpacity(0.1),
                                      ),
                                      child: Slider(
                                        value: _position.inSeconds.toDouble(),
                                        max: (_duration?.inSeconds ?? 0).toDouble(),
                                        onChanged: (value) {
                                          _audioPlayer.seek(
                                              Duration(seconds: value.toInt()));
                                        },
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 16),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            _formatDuration(_position),
                                            style: GoogleFonts.poppins(
                                              fontSize: 12,
                                              color: Colors.black54,
                                            ),
                                          ),
                                          Text(
                                            _formatDuration(
                                                _duration ?? Duration.zero),
                                            style: GoogleFonts.poppins(
                                              fontSize: 12,
                                              color: Colors.black54,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : Container(height: 0),
                        crossFadeState: isExpanded
                            ? CrossFadeState.showSecond
                            : CrossFadeState.showFirst,
                        duration: Duration(milliseconds: 300),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    
              ],
        )
    )
    );
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }
}