import 'dart:async';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

void main() => runApp(VideoPlayerApp());

class VideoPlayerApp extends StatelessWidget {
  final String appTitle = 'Video Player Demo';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appTitle,
      home: VideoPlayerScreen(title: appTitle),
    );
  }
}

class VideoPlayerScreen extends StatefulWidget {
  final String title;

  VideoPlayerScreen({Key key, this.title}) : super(key: key);

  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  VideoPlayerController _controller;
  Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    // Create and store the VideoPlayerController
    // The VideoPlayerController offers several different constructors
    // to play videos from assets, files or the internet
    _controller = VideoPlayerController.network(
        'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4');
    // Initialize the controller and store the Future for later use
    _initializeVideoPlayerFuture = _controller.initialize();
    // Use the controller to loop the video
    _controller.setLooping(true);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: FutureBuilder(
          future: _initializeVideoPlayerFuture,
          builder: (context, snapshot) {
            // If the VudeoPlayerController has finished initialization,
            // use the data it provides to limit the aspect ratio of the video
            if (snapshot.connectionState == ConnectionState.done) {
              return AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  // Use the VideoPlayer widget to display the video
                  child: VideoPlayer(_controller));
            } else {
              // If the VideoPlayerController is still initializing, show a
              // loading spinner
              return Center(child: CircularProgressIndicator());
            }
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Wrap the play or pause in a call to 'setState'. This ensures
          // the correct icon is shown
          setState(() {
            // If it's playing pause it
            if (_controller.value.isPlaying) {
              _controller.pause();
            } else {
              // Otherwise play it
              _controller.play();
            }
          });
        },
        child:
            Icon(_controller.value.isPlaying ? Icons.pause : Icons.play_arrow),
      ),
    );
  }

  @override
  void dispose() {
    // Ensure disposing of the VideoPlayerController to free up resources
    _controller.dispose();
    super.dispose();
  }
}
