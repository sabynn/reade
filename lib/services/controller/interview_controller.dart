import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:reade/models/face_analysis.dart';
import '../../models/face_model.dart';
import 'camera_controller.dart';
import 'face_detention_controller.dart';

class InterviewController extends GetxController {
  CameraManager? cameraManager;
  CameraController? cameraController;
  FaceDetectorController? _faceDetect;
  bool _isDetecting = false;
  List<FaceModel>? faces;
  FaceAnalysis? faceAnalysis;

  InterviewController() {
    cameraManager = CameraManager();
    _faceDetect = FaceDetectorController();
    faceAnalysis = FaceAnalysis();
  }

  Future<void> loadCamera() async {
    cameraController = await cameraManager?.load();
    update();
  }

  Future<void> changeCamera() async {
    cameraController = await cameraManager?.changeCamera();
    startImageStream();
    update();
  }

  Future<void> startVideoRecording() async {
    final CameraController? camController = cameraController;

    if (camController == null || !camController.value.isInitialized) {
      print('Error: select a camera first.');
      return;
    }

    if (cameraController!.value.isRecordingVideo) {
      // A recording is already started, do nothing.
      return;
    }

    try {
      cameraController?.startVideoRecording();
    } on CameraException catch (e) {
      print(e);
      return;
    }
  }

  Future<XFile?> stopVideoRecording() async {
    final CameraController? camController = cameraController;

    if (camController == null || !camController.value.isRecordingVideo) {
      return null;
    }

    try {
      return camController.stopVideoRecording();
    } on CameraException catch (e) {
      print(e);
      return null;
    }
  }

  Future<void> stopImageStream() async {
    final CameraController? camController = cameraController;

    if (camController == null || !camController.value.isStreamingImages) {
      return;
    }

    try {
      return camController.stopImageStream();
    } on CameraException catch (e) {
      print(e);
      return;
    }
  }

  Future<void> startImageStream() async {
    CameraDescription camera = cameraController!.description;
    startVideoRecording();
    cameraController?.startImageStream((cameraImage) async {
      if (_isDetecting) return;

      _isDetecting = true;

      final WriteBuffer allBytes = WriteBuffer();
      for (Plane plane in cameraImage.planes) {
        allBytes.putUint8List(plane.bytes);
      }
      final bytes = allBytes.done().buffer.asUint8List();

      final Size imageSize =
          Size(cameraImage.width.toDouble(), cameraImage.height.toDouble());

      final InputImageRotation imageRotation =
          InputImageRotationMethods.fromRawValue(camera.sensorOrientation) ??
              InputImageRotation.Rotation_0deg;

      final InputImageFormat inputImageFormat =
          InputImageFormatMethods.fromRawValue(cameraImage.format.raw) ??
              InputImageFormat.NV21;

      final planeData = cameraImage.planes.map(
        (Plane plane) {
          return InputImagePlaneMetadata(
            bytesPerRow: plane.bytesPerRow,
            height: plane.height,
            width: plane.width,
          );
        },
      ).toList();
      final inputImageData = InputImageData(
        size: imageSize,
        imageRotation: imageRotation,
        inputImageFormat: inputImageFormat,
        planeData: planeData,
      );
      final inputImage = InputImage.fromBytes(
        bytes: bytes,
        inputImageData: inputImageData,
      );
      processImage(inputImage);
    });
  }

  Future<void> processImage(inputImage) async {
    await Future.delayed(Duration(seconds: 5));
    print("Detection");
    faces = await _faceDetect?.processImage(inputImage);

    if (faces != null && faces!.isNotEmpty) {
      FaceModel? face = faces?.first;
      detectSmile(face?.smile);
      detectLeftEye(face?.leftEyeOpen);
      detectRightEye(face?.rightEyeOpen);
    } else {
      print("NO FACE DETECTED");
    }
    _isDetecting = false;
    update();
  }

  void detectSmile(smileProb) {
    if(smileProb > 0.3){
      faceAnalysis!.scoreSmile += 1;
    }
    faceAnalysis!.countSmile += 1;
  }

  void detectLeftEye(leftEyeProb) {
    if(leftEyeProb > 0.3){
      faceAnalysis!.scoreLeftEyeOpen += 1;
    }
    faceAnalysis!.countLeftEyeOpen += 1;
  }

  void detectRightEye(rightEyeProb) {
    if(rightEyeProb > 0.3){
      faceAnalysis!.scoreRightEyeOpen += 1;
    }
    faceAnalysis!.countRightEyeOpen += 1;
  }
}
