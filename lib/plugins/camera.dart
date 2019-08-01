import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:camera/camera.dart';

Future<void> main() async {
  // Obtain a list of the available cameras on the device
  final cameras = await availableCameras();

  // Get a specific camera from the list of available cameras
  final firstCamera = cameras.first;

  runApp(
    MaterialApp(
      theme: ThemeData.dark(),
      home: TakePictureScreen(
        // Pass the appropiate camera to the TakePictureScreen widget
        camera: firstCamera
      )
    )
  );
}

// A screen that allows users to take a picture using a given camera
class TakePictureScreen extends StatefulWidget {
  final CameraDescription camera;

  TakePictureScreen({Key key, @required this.camera}) : super(key: key);

  @override
  _TakePictureScreenState createState() => _TakePictureScreenState();
}

class _TakePictureScreenState extends State<TakePictureScreen> {
  // Add two variables to the state class to store the CameraController
  // and the future
  CameraController _controller;
  Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    // to display the current output from the camera,
    // create a CameraController
    _controller = CameraController(
        // Get a specific camera from the list of available cameras
        widget.camera,
        // Define the resolution to use
        ResolutionPreset.high);

    // Next, initialize the controller. This returns a future
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Take a picture')),
      // Wait until the controller is initialized before displaying the
      // camera preview. Use a FutureBuilder to display a loading spinner
      // until the controller has finished initializing
      body: FutureBuilder(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // If the Future is complete, display the preview
            return CameraPreview(_controller);
          } else {
            // Otherwise display a loading indicator
            return Center(child: CircularProgressIndicator());
          }
        }
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // Take the Picture in a try / catch
          try {
            // Ensure the camera is initialized
            await _initializeControllerFuture;

            // Construct the path where the image should be saved using the
            // pattern package
            final path = join(
              // Store the picture in the temp directory
              (await getTemporaryDirectory()).path,
              '${DateTime.now()}.png'
            );

            // Attempt to take a picture and log where it's been saved
            await _controller.takePicture(path);

            // If the picture was taken, display it on a new screen
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => DisplayPictureScreen(imagePath: path))
            );
          } catch(e) {
            print(e);
          }
        }
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

// A widget that displays the picture taken by the user
class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;

  const DisplayPictureScreen({Key key, this.imagePath}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Display the picture')),
      body: Image.file(File(imagePath))
    );
  }
}
