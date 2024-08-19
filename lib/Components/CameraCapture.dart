import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class CameraCapture extends StatefulWidget {
  const CameraCapture({Key? key}) : super(key: key);

  @override
  _CameraCaptureState createState() => _CameraCaptureState();
}

class _CameraCaptureState extends State<CameraCapture> {
  CameraController? _controller;
  List<CameraDescription>? _cameras;
  bool _isCameraInitialized = false;
  int _selectedCameraIndex = 0;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    _cameras = await availableCameras();
    print("cameras");
    print(_cameras);
    if (_cameras!.isNotEmpty) {
      _selectedCameraIndex = 0;
      await _initializeCameraController();
    } else {
      print('No cameras available');
    }
  }

  Future<void> _initializeCameraController() async {
    _controller = CameraController(_cameras![_selectedCameraIndex], ResolutionPreset.high);

    try {
      await _controller!.initialize();
      setState(() {
        _isCameraInitialized = true;
      });
    } catch (e) {
      print('Error initializing camera: $e');
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  Future<void> _captureImage() async {
    if (_controller == null || !_controller!.value.isInitialized) {
      return;
    }

    if (_controller!.value.isTakingPicture) {
      return;
    }

    try {
      XFile image = await _controller!.takePicture();
      // You can now do something with the captured image
      print('Image captured: ${image.path}');
    } catch (e) {
      print('Error capturing image: $e');
    }
  }

  void _flipCamera() async {
    if (_cameras!.length < 2) return;

    setState(() {
      _isCameraInitialized = false;
    });

    _selectedCameraIndex = (_selectedCameraIndex + 1) % _cameras!.length;

    await _initializeCameraController();
  }

  @override
  Widget build(BuildContext context) {
    if (_controller == null || !_isCameraInitialized) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Camera Capture'),
      ),
      body: Column(
        children: [
          Expanded(
            child: AspectRatio(
              aspectRatio: _controller!.value.aspectRatio,
              child: CameraPreview(_controller!),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
            color: Colors.black87,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: const Icon(Icons.flip_camera_ios, color: Colors.white, size: 30),
                  onPressed: _flipCamera,
                ),
                GestureDetector(
                  onTap: _captureImage,
                  child: Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 4),
                      color: Colors.white24,
                    ),
                    child: const Icon(Icons.camera, color: Colors.white, size: 40),
                  ),
                ),
                const SizedBox(width: 60), // Placeholder to balance the layout
              ],
            ),
          ),
        ],
      ),
    );
  }
}