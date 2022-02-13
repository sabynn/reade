import 'package:google_ml_kit/google_ml_kit.dart';

import '../../models/face_model.dart';

class FaceDetectorController {
  FaceDetector? _faceDetector;

  Future<List<FaceModel>?> processImage(inputImage) async {
    _faceDetector = GoogleMlKit.vision.faceDetector(
      const FaceDetectorOptions(
        enableClassification: true,
        enableLandmarks: true,
      ),
    );

    final faces = await _faceDetector?.processImage(inputImage);
    return extractFaceInfo(faces);
  }

  List<FaceModel>? extractFaceInfo(List<Face>? faces) {
    List<FaceModel>? response = [];
    double? smile;
    double? leftEye;
    double? rightEye;

    for (Face face in faces!) {
      final rect = face.boundingBox;
      if (face.smilingProbability != null) {
        smile = face.smilingProbability;
      }

      leftEye = face.leftEyeOpenProbability;
      rightEye = face.rightEyeOpenProbability;

      final faceModel = FaceModel(
        smile: smile,
        leftEyeOpen: leftEye,
        rightEyeOpen: rightEye,
      );

      response.add(faceModel);
    }

    return response;
  }
}
