class SizeInfo {
  int? preferId;
  int? breedTagId;
  double neck = 0;
  double chest = 0;
  double back = 0;
  double leg = 0;

  int petSizeId = 0;

  clearInfo() {
    preferId = 0;
    breedTagId = 0;
    neck = 0;
    chest = 0;
    back = 0;
    leg = 0;
  }
}

SizeInfo sizeInfo = SizeInfo();
