import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:live_object_detection/main.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  CameraController? _controller;
  CameraImage? _cameraImage;

  @override
  void initState() {
    super.initState();
    if (cameras.isNotEmpty) {
      _controller = CameraController(cameras.first, ResolutionPreset.medium);
      _controller?.initialize().then((value) {
        if (mounted && cameras.isNotEmpty) {
          _controller?.startImageStream((image) {
            _cameraImage = image;
            setState(() {});
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        margin: const EdgeInsets.only(top: 20),
        child: Stack(
          children: [
            if ((_controller?.value.isInitialized ?? false) &&
                _controller != null)
              Positioned(
                top: 0.0,
                left: 0.0,
                width: size.width,
                height: size.height - 100,
                child: AspectRatio(
                  aspectRatio: _controller?.value.aspectRatio ?? 1 / 2,
                  child: CameraPreview(_controller!),
                ),
              )
          ],
        ),
      ),
    ));
  }
}
