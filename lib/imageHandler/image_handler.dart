
import 'dart:typed_data';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:firebase_storage/firebase_storage.dart';

Future<String?> pickAndUploadImage() async {
  XFile? pickedFile;
  final picker = ImagePicker();
  final pickedImage = await picker.pickImage(source: ImageSource.gallery);

  if (pickedImage == null) {
    // User canceled the image picking
    return null;
  }

  // Crop the image to a square
  final croppedFile = await ImageCropper().cropImage(
      sourcePath: pickedFile!.path,
      compressFormat: ImageCompressFormat.jpg,
      compressQuality: 100,
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Cropper',
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
      ]);

  if (croppedFile == null) {
    // User canceled the image cropping
    return null;
  }

  // Read the file as bytes
  final List<int> bytes = await croppedFile.readAsBytes();

  // Customize the compression quality based on your requirements
  // Adjust the quality value between 0 and 100 (higher values mean better quality)
  const int compressionQuality = 90;

  // Upload the compressed image to Firebase Storage
  final storage = FirebaseStorage.instance;
  final Reference storageReference = storage
      .ref()
      .child('profile_images/${DateTime.now().millisecondsSinceEpoch}.jpg');
  final UploadTask uploadTask = storageReference.putData(
      Uint8List.fromList(bytes),
      SettableMetadata(
          contentType: 'image/jpeg',
          customMetadata: {'quality': '$compressionQuality'}));

  // Wait for the upload to complete
  await uploadTask.whenComplete(() {});

  // Get the download URL
  final String imageUrl = await storageReference.getDownloadURL();

  return imageUrl;
}
