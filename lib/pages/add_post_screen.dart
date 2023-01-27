import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tagramm/methods/firestore_method.dart';
import 'package:tagramm/utilities/colors.dart';
import 'package:tagramm/utilities/utils.dart';

class AddPost extends StatefulWidget {
  const AddPost({super.key});

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  Uint8List? _file;
  final TextEditingController _descriptionController = TextEditingController();
  bool _isLoading = false;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  String username = '';
  String uid = '';
  String profileImage = '';

  @override
  void initState() {
    super.initState();
    getUserDetails();
  }

  void getUserDetails() async {
    DocumentSnapshot snap = await FirebaseFirestore.instance
        .collection('users')
        .doc(_auth.currentUser!.uid)
        .get();
    setState(() {
      username = (snap.data() as Map<String, dynamic>)['username'];
      uid = (snap.data() as Map<String, dynamic>)['uid'];
      profileImage = (snap.data() as Map<String, dynamic>)['photoUrl'];
    });
  }

  void postImage(
    String uid,
    String username,
    String profileImage,
  ) async {
    setState(() {
      _isLoading = true;
    });
    try {
      String res = await FirestoreMethods().uploadPost(
        _descriptionController.text,
        _file!,
        uid,
        username,
        profileImage,
      );

      if (res == 'success') {
        setState(() {
          _isLoading = false;
        });
        showSnackbar('Posted!', context);
        clearImage();
      } else {
        setState(() {
          _isLoading = false;
        });
        showSnackbar(res, context);
      }
    } catch (e) {
      showSnackbar(e.toString(), context);
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
                child: const Text('Take a photo'),
                onPressed: () async {
                  Navigator.of(context).pop();
                  Uint8List file = await pickImage(ImageSource.camera);
                  setState(() {
                    _file = file;
                  });
                },
              ),
              SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text('Choose from gallery'),
                onPressed: () async {
                  Navigator.of(context).pop();
                  Uint8List file = await pickImage(ImageSource.gallery);
                  setState(() {
                    _file = file;
                  });
                },
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

  void clearImage() {
    _file = null;
  }

  @override
  void dispose() {
    super.dispose();
    _descriptionController.dispose();
  }

  // @override
  // void initState() {
  //   super.initState();
  //   addData();
  //   getUserDetails();
  // }

  // addData() async {
  //   UserProvider userProvider =
  //       Provider.of<UserProvider>(context, listen: false);
  //   await userProvider.refreshUser();
  // }

  @override
  Widget build(BuildContext context) {
    // addData();
    // final model.User user = Provider.of<UserProvider>(context).getUser;
    // final User user = Provider.of<UserProvider>(context).getUser;
    return _file == null
        ? Container(
            color: Colors.black,
            child: Center(
              child: IconButton(
                icon: const Icon(
                  Icons.upload,
                  color: Colors.white,
                ),
                onPressed: () => _selectImage(context),
              ),
            ),
          )
        : Scaffold(
            backgroundColor: Colors.black,
            appBar: AppBar(
              backgroundColor: backgroundColor,
              leading: IconButton(
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
                onPressed: () => clearImage(),
              ),
              title: const Text(
                'New post',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              centerTitle: false,
              actions: [
                TextButton(
                  onPressed: () => postImage(
                    uid,
                    username,
                    profileImage,
                  ),
                  child: const Text(
                    'Post',
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
            body: Column(
              children: [
                _isLoading
                    ? const LinearProgressIndicator()
                    : const Padding(
                        padding: EdgeInsets.only(top: 0),
                      ),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(
                        Uri.parse(profileImage).toString(),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: TextField(
                        style: const TextStyle(color: Colors.white),
                        controller: _descriptionController,
                        decoration: const InputDecoration(
                          hintText: 'Write a caption...',
                          border: InputBorder.none,
                          hintStyle: TextStyle(color: Colors.white),
                        ),
                        maxLines: 8,
                      ),
                    ),
                    SizedBox(
                      height: 50,
                      width: 50,
                      child: AspectRatio(
                        aspectRatio: 487 / 451,
                        child: Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: MemoryImage(_file!),
                              fit: BoxFit.fill,
                              alignment: FractionalOffset.topCenter,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          );
  }
}
