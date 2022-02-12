import 'package:camera/camera.dart';

class CameraManager {
  List<CameraDescription>? cameras;
  CameraController? _controller;
  CameraDescription? cameraDescription;

  Future<CameraController?> load() async {
    cameras = await availableCameras();
    //Set front camera if available or back if not available
    int position = cameras!.length > 1 ? 1 : 0;
    _controller = CameraController(
      cameras![position],
      ResolutionPreset.high,
      enableAudio: true,
    );
    cameraDescription = _controller?.description;
    print("HERE WE GO AGAIN");
    await _controller?.initialize();
    return _controller;
  }

  Future<CameraController?> changeCamera() async {
    print("HEHE KESINIII");
    cameras = await availableCameras();
    final lensDirection =  _controller?.description.lensDirection;
    CameraDescription newDescription;
    if(lensDirection == CameraLensDirection.front){
      newDescription = cameras!.firstWhere((description) => description.lensDirection == CameraLensDirection.back);
    }
    else{
      newDescription = cameras!.firstWhere((description) => description.lensDirection == CameraLensDirection.front);
    }

    _controller = CameraController(
      newDescription,
      ResolutionPreset.medium,
      enableAudio: true,
    );

    cameraDescription = _controller?.description;
    await _controller?.initialize();
    return _controller;
  }

  CameraController? get controller => _controller;
}
