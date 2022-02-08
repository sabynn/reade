import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import '../../models/face_model.dart';
import 'camera_controller.dart';
import 'face_detention_controller.dart';

class InterviewController extends GetxController {
  CameraManager? _cameraManager;
  CameraController? cameraController;
  FaceDetetorController? _faceDetect;
  bool _isDetecting = false;
  List<FaceModel>? faces;
  String? faceAtMoment = 'normal_face.png';
  String? smileLabel = 'Normal';
  String? leftEyeLabel = 'Left Eye State';
  String? rightEyeLabel = 'Right Eye State';

  InterviewController() {
    _cameraManager = CameraManager();
    _faceDetect = FaceDetetorController();
  }

  Future<void> loadCamera() async {
    cameraController = await _cameraManager?.load();
    update();
  }

  Future<void> startImageStream() async {
    CameraDescription camera = cameraController!.description;

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
    faces = await _faceDetect?.processImage(inputImage);

    if (faces != null && faces!.isNotEmpty) {
      FaceModel? face = faces?.first;
      smileLabel = detectSmile(face?.smile);
      leftEyeLabel = detectLeftEye(face?.leftEyeOpen);
      rightEyeLabel = detectRightEye(face?.rightEyeOpen);
    } else {
      faceAtMoment = 'normal_face.png';
      smileLabel = 'Not face detected';
    }
    _isDetecting = false;

    update();
  }

  String detectSmile(smileProb) {
    if (smileProb > 0.86) {
      faceAtMoment = 'happy_face.png';
      return 'Big smile with teeth';
    } else if (smileProb > 0.8) {
      faceAtMoment = 'happy_face.png';
      return 'Big Smile';
    } else if (smileProb > 0.3) {
      faceAtMoment = 'happy_face.png';
      return 'Smile';
    } else {
      faceAtMoment = 'sady_face.png';
      return 'Sad';
    }
  }

  String detectLeftEye(leftEyeProb) {
    if (leftEyeProb > 0.86) {
      return 'Left Eye Open Very Clearly';
    } else if (leftEyeProb > 0.8) {
      return 'Left Eye Open Clearly';
    } else if (leftEyeProb > 0.3) {
      return 'Left Eye Open ';
    } else {
      return 'Left Eye Closed ';
    }
  }

  String detectRightEye(rightEyeProb) {
    if (rightEyeProb > 0.86) {
      return 'Right Eye Open Very Clearly';
    } else if (rightEyeProb > 0.8) {
      return 'Right Eye Open Clearly';
    } else if (rightEyeProb > 0.3) {
      return 'Right Eye Open ';
    } else {
      return 'Right Eye Closed ';
    }
  }
}
