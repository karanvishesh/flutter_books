import 'dart:io';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_books/view/BookDetailsScreen/widgets/detail_screen_top_row.dart';
import 'package:flutter_books/view/HomeScreen/homescreen.dart';
import 'package:image_picker/image_picker.dart';

import '../../model/book.dart';

class BookDetailsScreen extends StatefulWidget {
  BookDetailsScreen({Key? key, required this.book}) : super(key: key);
  final Book book;

  @override
  State<BookDetailsScreen> createState() => _BookDetailsScreenState();
}

class _BookDetailsScreenState extends State<BookDetailsScreen>
    with SingleTickerProviderStateMixin {
  late TransformationController _transformationController;
  late AnimationController _animationController;
  final imageStore = FirebaseStorage.instance.ref().child("Books");
  File? pickedimage;
  bool isPickingImage = false;
  Animation<Matrix4>? _animation;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _transformationController = TransformationController();
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200))
      ..addListener(() {
        _transformationController.value = _animation!.value;
      });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _transformationController.dispose();
    _animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Column(children: [
                DetailScreenTopRow(),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
                        padding:
                            EdgeInsets.symmetric(vertical: 40, horizontal: 40),
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Color(widget.book.secondaryColor),
                                width: 1),
                            color: Color(widget.book.primaryColor),
                            borderRadius: BorderRadius.circular(20)),
                        child: Hero(
                          tag: widget.book.title,
                          child: InteractiveViewer(
                            onInteractionEnd: (details) {
                              resetAnimation();
                            },
                            minScale: 0.5,
                            transformationController: _transformationController,
                            maxScale: 2,
                            clipBehavior: Clip.none,
                            child: AspectRatio(
                              aspectRatio: 1,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Carousel(
                                  autoplay: false,
                                  dotBgColor: Colors.transparent,
                                  images: widget.book.images.map((image) {
                                    return Builder(
                                      builder: (BuildContext context) {
                                        return Container(
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 5),
                                          height: 500,
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            image: DecorationImage(
                                              image: NetworkImage(image),
                                              fit: BoxFit.cover,
                                              colorFilter: ColorFilter.mode(
                                                  Colors.black.withOpacity(0.7),
                                                  BlendMode.softLight),
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        widget.book.title,
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "by ${widget.book.author}",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black54),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: Color(widget.book.secondaryColor)),
                          borderRadius: BorderRadius.circular(10),
                          color: Color(widget.book.primaryColor),
                        ),
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                        child: Text(widget.book.genre,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Color(widget.book.secondaryColor),
                            )),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        " " + widget.book.desc,
                        style: TextStyle(fontSize: 18, color: Colors.black87),
                      ),
                    ],
                  ),
                )
              ]),
              isPickingImage
                  ? Positioned(
                      top: MediaQuery.of(context).size.height * 0.5,
                      left: MediaQuery.of(context).size.width * 0.5,
                      child: CircularProgressIndicator(
                        color: Color(widget.book.secondaryColor),
                      ))
                  : Container(),
            ],
          ),
        ),
        floatingActionButton: widget.book.images.length > 2
            ? Container()
            : FloatingActionButton(
                backgroundColor: Color(widget.book.primaryColor),
                onPressed: () {
                  setState(() {
                    isPickingImage = true;
                  });
                  pickImageFromUser().then((image) {
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => HomeScreen()),
                        (Route<dynamic> route) => false);
                  });
                },
                child: Icon(
                  Icons.add_a_photo,
                  color: Color(widget.book.secondaryColor),
                  size: 30,
                ),
              ),
      ),
    );
  }

  void resetAnimation() {
    _animation = Matrix4Tween(
      begin: _transformationController.value,
      end: Matrix4.identity(),
    ).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _animationController.forward(from: 0);
  }

  pickImageFromUser() async {
    try {
      var image = await ImagePicker()
          .pickImage(source: ImageSource.gallery, imageQuality: 70);

      if (image == null) return;
      pickedimage = File(image.path);
      UploadTask uploadTask = imageStore
          .child("${widget.book.title}/images/${pickedimage!.hashCode}")
          .putFile(pickedimage!);
      String url = await (await uploadTask).ref.getDownloadURL();
      FirebaseFirestore.instance
          .collection("books")
          .doc(widget.book.id)
          .update({
        "images": FieldValue.arrayUnion([url])
      });
    } on PlatformException catch (e) {
      print("Platform exception raised in pickimage function $e");
    }
  }
}
