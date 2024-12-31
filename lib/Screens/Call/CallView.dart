import 'package:allobaby/Config/OurFirebase.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

// Fill in the app ID obtained from the Agora Console

// Fill in the temporary token generated from Agora Console
// const token = "007eJxTYDivEmBj43p967WVLJHWgSvOR/CfLbyp915VY+GhgpLgQxcVGBItzS0TEw3MElMMzE1Mk8yTkhLNLQ3NTVMNjYwszFLT5vvypTcEMjKIl+cxMzJAIIjPwlCSWlzCwAAAG1geUg==";
// // Fill in the channel name you used to generate the token
// const channel = "test"

 const appId = "a979aa06ad0745b7bba79175e12286ef";

class Callview extends StatefulWidget {

  String channel;
  String token;
  String path;

   Callview({Key? key, required this.channel, required this.token, required this.path}) : super(key: key);

  @override
  State<Callview> createState() => _CallviewState();
}

class _CallviewState extends State<Callview> {
  int? _remoteUid;
  bool _localUserJoined = false;
  late RtcEngine _engine;
  bool _muted = false;
  bool _cameraOff = false;

 

  @override
  void initState() {
    super.initState();
    initAgora();
    FlutterRingtonePlayer().stop();

  }

  Future<void> initAgora() async {
    await [Permission.microphone, Permission.camera].request();

    _engine = createAgoraRtcEngine();
    await _engine.initialize(const RtcEngineContext(
      appId: appId,
      channelProfile: ChannelProfileType.channelProfileLiveBroadcasting,
    ));

    _engine.registerEventHandler(
      RtcEngineEventHandler(
        onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
          debugPrint('local user ${connection.localUid} joined');
          setState(() {
            _localUserJoined = true;
          });
        },
        onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
          debugPrint("remote user $remoteUid joined");
          setState(() {
            _remoteUid = remoteUid;
          });
        },
        onUserOffline: (RtcConnection connection, int remoteUid,
            UserOfflineReasonType reason) {
          debugPrint("remote user $remoteUid left channel");
          setState(() {
            _remoteUid = null;
          });
        },
      ),
    );

    await _engine.enableVideo();
    await _engine.startPreview();
    await _engine.setClientRole(role: ClientRoleType.clientRoleBroadcaster);
    await _engine.joinChannel(
      token: widget.token,
      channelId: widget.channel,
      uid: 0,
      options: const ChannelMediaOptions(),
    );
  }



  @override
  void dispose() {
    _dispose();
    super.dispose();
  }

  Future<void> _dispose() async {
    await _engine.leaveChannel();
    await _engine.release();
  }


  Future<void> cutCall() async {
    OurFirebase.cutCall(widget.path);


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: _remoteVideo(),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: SizedBox(
              width: 100,
              height: 150,
              child: 
              _cameraOff ?

              Container(
      // padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(

        color: Colors.black,
        borderRadius: BorderRadius.circular(12),
  
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,

        children: [
          Icon(
            Icons.videocam_off_rounded,
            color: Colors.white,
            size: 24,
          ),
          const SizedBox(width: 12),
          FittedBox(
            child: Text(
              'Camera is OFF',
              
              style: TextStyle(
                color: Colors.white,
                // fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    )

              :
               Center(
                child: _localUserJoined
                    ? AgoraVideoView(
                        controller: VideoViewController(
                          rtcEngine: _engine,
                          canvas: const VideoCanvas(uid: 0),
                        ),
                      )
                    : const CircularProgressIndicator(),
              ),
            ),
          ),
          _toolbar(),
        ],
      ),
    );
  }

  Widget _remoteVideo() {
    if (_remoteUid != null) {
      return AgoraVideoView(
        controller: VideoViewController.remote(
          rtcEngine: _engine,
          canvas: VideoCanvas(uid: _remoteUid),
          connection:  RtcConnection(channelId: widget.channel),
        ),
      );
    } else {
      return  Text(
        'Waiting'.tr,
        textAlign: TextAlign.center,
      );
    }
  }

  Widget _toolbar() {
    return Container(
      alignment: Alignment.bottomCenter,
      padding: const EdgeInsets.symmetric(vertical: 48),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          RawMaterialButton(
            onPressed: _onToggleMute,
            child: Icon(
              _muted ? Icons.mic_off : Icons.mic,
              color: _muted ? Colors.white : Colors.blueAccent,
              size: 20.0,
            ),
            shape: const CircleBorder(),
            elevation: 2.0,
            fillColor: _muted ? Colors.blueAccent : Colors.white,
            padding: const EdgeInsets.all(12.0),
          ),
          RawMaterialButton(
            onPressed: _onCallEnd,
            child: const Icon(
              Icons.call_end,
              color: Colors.white,
              size: 35.0,
            ),
            shape: const CircleBorder(),
            elevation: 2.0,
            fillColor: Colors.redAccent,
            padding: const EdgeInsets.all(15.0),
          ),
          RawMaterialButton(
            onPressed: _onSwitchCamera,
            child: const Icon(
              Icons.switch_camera,
              color: Colors.blueAccent,
              size: 20.0,
            ),
            shape: const CircleBorder(),
            elevation: 2.0,
            fillColor: Colors.white,
            padding: const EdgeInsets.all(12.0),
          ),
          RawMaterialButton(
            onPressed: _onToggleVideoMute,
            child: Icon(
              _cameraOff ? Icons.videocam_off : Icons.videocam,
              color: _cameraOff ? Colors.white : Colors.blueAccent,
              size: 20.0,
            ),
            shape: const CircleBorder(),
            elevation: 2.0,
            fillColor: _cameraOff ? Colors.blueAccent : Colors.white,
            padding: const EdgeInsets.all(12.0),
          ),
        ],
      ),
    );
  }

  void _onCallEnd() async {

    await cutCall();
    _dispose();
    Navigator.pop(context);
  }

  void _onToggleMute() {
    setState(() {
      _muted = !_muted;
    });
    _engine.muteLocalAudioStream(_muted);
  }

  void _onSwitchCamera() {
    _engine.switchCamera();
  }

  void _onToggleVideoMute() {
    setState(() {
      _cameraOff = !_cameraOff;
    });
    _engine.muteLocalVideoStream(_cameraOff);
  }
}