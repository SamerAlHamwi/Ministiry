

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:ministry_minister_app/features/home_app/data/calls_list_response.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../core/utils/Navigation/Navigation.dart';
import '../../home_app/presentation/pages/home_app.dart';


class VideoCallScreen extends StatefulWidget {
  const VideoCallScreen({super.key,required this.model});

  final Call model;

  @override
  State<VideoCallScreen> createState() => _VideoCallScreenState();
}

class _VideoCallScreenState extends State<VideoCallScreen> {
  late RtcEngine _engine;
  bool _isAgoraInitialized = false;
  bool muted = false;
  List _users = [];

  @override
  void initState() {
    super.initState();
    initAgora();
  }

  @override
  void dispose() {
    _users.clear();
    _engine.leaveChannel();
    _engine.release();
    super.dispose();
  }

  Future<void> initAgora() async {
    await [Permission.camera,Permission.microphone].request();

    _engine = createAgoraRtcEngine();
    await _engine.initialize(RtcEngineContext(
      appId: widget.model.agoraAppId,
    ));

    await _engine.enableVideo();

    await _engine.setVideoEncoderConfiguration(const VideoEncoderConfiguration(
      dimensions: VideoDimensions(width: 1280, height: 720), // Set the resolution to 720p
      frameRate: 30, // Set frame rate to 30 FPS
      bitrate: 1130, // Set bitrate in kbps
      orientationMode: OrientationMode.orientationModeAdaptive,
    ));

    await _engine.startPreview();

    await _engine.joinChannel(
      channelId: widget.model.channelName!,
      options: const ChannelMediaOptions(
        clientRoleType: ClientRoleType.clientRoleBroadcaster,
        publishCameraTrack: true,
        publishThirdScreenTrack: true,
        autoSubscribeVideo: true,
      ),
      token: widget.model.agoraRtcToken!,
      uid: widget.model.userId!,
    );
    _engine.registerEventHandler(
      RtcEngineEventHandler(
        onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
          debugPrint(" local user ${connection.localUid} joined");
          setState(() {});
        },
        onLeaveChannel: (RtcConnection connection, RtcStats stats) {
          debugPrint(" local user ${connection.localUid} left, duration ${stats.duration}");
          // setState(() {});
        },
        onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
          print(" remote user $remoteUid joined");
          setState(() {
            _isAgoraInitialized = false;
          });
          setState(() {
            _users.add(remoteUid);
          });
          setState(() {
            _isAgoraInitialized = true;
          });
        },
        onUserOffline: (RtcConnection connection, int remoteUid,
            UserOfflineReasonType reason) {
          debugPrint(" remote user $remoteUid left channel");
          setState(() {
            _users.remove(remoteUid);
          });
          if(widget.model.interpreterId == remoteUid){
            _onCallEnd(context);
          }
        },
        onTokenPrivilegeWillExpire: (RtcConnection connection, String token) {
          debugPrint(
              '[onTokenPrivilegeWillExpire] connection: ${connection.toJson()}, token: $token');
        },
      ),
    );

    setState(() {
      _isAgoraInitialized = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _isAgoraInitialized ? _viewRows() : const SizedBox(),
          _toolbar(),
        ],
      ),
    );
  }

  Widget _viewRows() {
    final views = _getRenderViews();
    switch (views.length) {
      case 1:
        return Column(
          children: <Widget>[_videoView(views[0])],
        );
      case 2:
        return Column(
          children: <Widget>[
            _expandedVideoRow([views[0]]),
            _expandedVideoRow([views[1]])
          ],
        );
      case 3:
        return Column(
          children: <Widget>[
            _expandedVideoRow(views.sublist(0, 2)),
            _expandedVideoRow(views.sublist(2, 3))
          ],
        );
      case 4:
        return Column(
          children: <Widget>[
            _expandedVideoRow(views.sublist(0, 2)),
            _expandedVideoRow(views.sublist(2, 4))
          ],
        );
      default:
    }
    return Container();
  }

  List<Widget> _getRenderViews() {
    final List<Widget> list = [];
    list.add(AgoraVideoView(
      controller: VideoViewController(
        rtcEngine: _engine,
        canvas: const VideoCanvas(uid: 0),
      ),
    ));

    if (_users.isNotEmpty) {
      for (var uid in _users) {
        list.add(AgoraVideoView(
        controller: VideoViewController.remote(
          rtcEngine: _engine,
          canvas: VideoCanvas(uid: uid),
          connection: RtcConnection(channelId: widget.model.channelName),
        ),
      ));
      }
    }
    return list;
  }


  Widget _videoView(view) {
    return Expanded(child: Container(child: view));
  }

  Widget _expandedVideoRow(List<Widget> views) {
    final wrappedViews = views.map<Widget>(_videoView).toList();
    return Expanded(
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Row(
          children: wrappedViews,
        ),
      ),
    );
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
            shape: const CircleBorder(),
            elevation: 2.0,
            fillColor: muted ? Colors.blueAccent : Colors.white,
            padding: const EdgeInsets.all(12.0),
            child: Icon(
              muted ? Icons.mic_off : Icons.mic,
              color: muted ? Colors.white : Colors.blueAccent,
              size: 20.0,
            ),
          ),
          RawMaterialButton(
            onPressed: () => _onCallEnd(context),
            shape: const CircleBorder(),
            elevation: 2.0,
            fillColor: Colors.redAccent,
            padding: const EdgeInsets.all(15.0),
            child: const Icon(
              Icons.call_end,
              color: Colors.white,
              size: 35.0,
            ),
          ),
          RawMaterialButton(
            onPressed: _onSwitchCamera,
            shape: const CircleBorder(),
            elevation: 2.0,
            fillColor: Colors.white,
            padding: const EdgeInsets.all(12.0),
            child: const Icon(
              Icons.switch_camera,
              color: Colors.blueAccent,
              size: 20.0,
            ),
          )
        ],
      ),
    );
  }

  void _onToggleMute() {
    setState(() {
      muted = !muted;
    });
    _engine.muteLocalAudioStream(muted);
  }

  void _onCallEnd(BuildContext context) {
    Navigation.pushReplacement(HomeApp());
  }

  void _onSwitchCamera() {
    _engine.switchCamera();
  }

}

