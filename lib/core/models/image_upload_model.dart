import 'dart:io';

enum CustomImageType { file, url, add }

class ImageUploadModel {
  bool? isUploaded;
  bool? uploading;
  File? imageFile;
  String? imageNetWork;
  String? imageUrl;
  CustomImageType type;

  ImageUploadModel({
    this.isUploaded,
    this.uploading,
    this.imageFile,
    this.imageUrl,
    required this.type,
    this.imageNetWork,
  });
}