class FaceAnalysis {
  double scoreSmile;
  double scoreRightEyeOpen;
  double scoreLeftEyeOpen;
  int countSmile;
  int countRightEyeOpen;
  int countLeftEyeOpen;

  FaceAnalysis({
    this.scoreSmile = 0,
    this.scoreRightEyeOpen = 0,
    this.scoreLeftEyeOpen = 0,
    this.countSmile = 0,
    this.countLeftEyeOpen = 0,
    this.countRightEyeOpen = 0,
  });
}