import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_books/model/book.dart';
import 'package:flutter_books/view/HomeScreen/widgets/book_display_widget.dart';
import 'package:flutter_books/view/HomeScreen/widgets/top_row.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool sortBygenre = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TopRow(),
            SizedBox(
              height: 30,
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    cursorColor: Color(0xffffc7c7),
                    decoration: InputDecoration(
                      isDense: true,
                      focusColor: Colors.white,
                      hoverColor: Colors.white,
                      filled: true,
                      fillColor: Color.fromARGB(15, 163, 161, 160),
                      prefixIcon: Icon(
                        CupertinoIcons.search,
                        color: Colors.black45,
                        size: 25,
                      ),
                      hintText: "Find your favourite book",
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    ),
                  ),
                ),
                IconButton(
                    onPressed: () {
                      setState(() {
                        sortBygenre = !sortBygenre;
                      });
                    },
                    icon: Image.asset(
                      "assets/sort.png",
                      width: 23,
                      color: Colors.black54,
                    ))
              ],
            ),
            SizedBox(
              height: 20,
            ),
            StreamBuilder<QuerySnapshot>(
                stream: sortBygenre
                    ? FirebaseFirestore.instance
                        .collection("books")
                        .orderBy("genre")
                        .snapshots()
                    : FirebaseFirestore.instance
                        .collection("books")
                        .orderBy("title")
                        .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    //implement error screen
                    print('Something went Wrong');
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: const CircularProgressIndicator(
                          color: Color(0xffff7474)),
                    );
                  }
                  return Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: GridView.builder(
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisSpacing: 20,
                                      mainAxisSpacing: 20,
                                      childAspectRatio: (MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              MediaQuery.of(context)
                                                  .size
                                                  .width) *
                                          0.3,
                                      crossAxisCount: 2),
                              itemCount: snapshot.data!.size,
                              itemBuilder: (context, index) {
                                final List booksList = [];
                                snapshot.data!.docs
                                    .map((DocumentSnapshot document) {
                                  Map a =
                                      document.data() as Map<String, dynamic>;
                                  booksList.add(a);
                                  a['id'] = document.id;
                                }).toList();
                                return BookDisplayWidget(
                                    book: Book(
                                        title: booksList[index]["title"],
                                        author: booksList[index]["author"],
                                        genre: booksList[index]["genre"],
                                        desc: booksList[index]["desc"],
                                        id: booksList[index]["id"],
                                        primaryColor: booksList[index]
                                            ["primaryColor"],
                                        secondaryColor: booksList[index]
                                            ["secondaryColor"],
                                            coverImage: booksList[index]["coverImage"],
                                        images: booksList[index]
                                            ["images"]));
                              }),
                        ),
                      ],
                    ),
                  );
                })
          ],
        ),
      )),
    );
  }
}

