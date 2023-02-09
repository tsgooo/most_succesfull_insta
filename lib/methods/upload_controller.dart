import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:tagramm/models/video.dart';
import 'package:video_compress/video_compress.dart';

class UploadVideoController extends GetxController {
  _compressVideo(String videoPath) async {
    final compressedVideo = await VideoCompress.compressVideo(
      videoPath,
      quality: VideoQuality.MediumQuality,
    );
    return compressedVideo!.file;
  }

  _getThumbnail(String videoPath) async {
    final thumbnail = await VideoCompress.getFileThumbnail(videoPath);
    return thumbnail;
  }

  _uploadImageToStorage(String id, String videoPath) async {
    Reference ref =
        FirebaseStorage.instance.ref().child('thumbnails').child(id);
    UploadTask uploadTask = ref.putFile(await _getThumbnail(videoPath));
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }

  Future<String> _uploadVideoToStorage(String id, String videoPath) async {
    Reference ref = FirebaseStorage.instance.ref().child('videos').child(id);

    UploadTask uploadTask = ref.putFile(await _compressVideo(videoPath));
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }

  uploadVideo(String caption, String videoPath) async {
    try {
      String uid = FirebaseAuth.instance.currentUser!.uid;
      DocumentSnapshot userDoc =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();
      var allDocs = await FirebaseFirestore.instance.collection('videos').get();
      int videoLen = allDocs.docs.length;
      String videoUrl =
          await _uploadVideoToStorage('Video $videoLen', videoPath);
      String thumbnail =
          await _uploadImageToStorage("Video $videoLen", videoPath);

      Video video = Video(
        username: (userDoc.data()! as Map<String, dynamic>)['username'],
        uid: uid,
        id: 'Video $videoLen',
        likes: [],
        commentCount: 0,
        shareCount: 0,
        caption: caption,
        videoUrl: videoUrl,
        profilePhoto: (userDoc.data()! as Map<String, dynamic>)['profileUrl'],
        thumbnail: thumbnail,
      );

      await FirebaseFirestore.instance
          .collection('videos')
          .doc('Video $videoLen')
          .set(
            video.toJson(),
          );
      Get.back();
    } catch (e) {
      Get.snackbar(
        'Error uploading video',
        e.toString(),
      );
    }
  }
}
