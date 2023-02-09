//

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddVideo extends StatefulWidget {
  const AddVideo({super.key});

  @override
  State<AddVideo> createState() => _AddVideoState();
}

class _AddVideoState extends State<AddVideo> {
  // File? video;

  pickVideo(ImageSource source, BuildContext context) async {
    final video = await ImagePicker().pickVideo(source: source);
    if (video != null) {
      // Navigator.of(context).push(
      //   MaterialPageRoute(
      //     builder: (context) => ConfirmScreen(
      //       videoFile: File(video.path),
      //       videoPath: video.path,
      //     ),
      //   ),
      // );
    }
  }

  _selectImage(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: const Text('Create a post'),
            children: [
              SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text('Record a video'),
                onPressed: () => pickVideo(ImageSource.camera, context),
              ),
              SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text('Choose from gallery'),
                onPressed: () => pickVideo(ImageSource.gallery, context),
              ),
              SimpleDialogOption(
                  padding: const EdgeInsets.all(20),
                  child: const Text('Cancel'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  }),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: InkWell(
        onTap: () => _selectImage(context),
        child: Center(
          child: Container(
            margin: const EdgeInsets.all(8),
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.upload_file_outlined,
                  color: Colors.white,
                ),
                Text(
                  'Add video',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
