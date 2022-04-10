
import 'package:flutter/material.dart';
import 'package:flutter_books/model/book.dart';
import 'package:flutter_books/view/BookDetailsScreen/book_details_screen.dart';

class BookDisplayWidget extends StatelessWidget {
  const BookDisplayWidget({
    Key? key,
    required this.book,
  }) : super(key: key);
  final Book book;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) {
          return BookDetailsScreen(book: book);
        }),
      ),
      child: Container(
        height: 300,
        child: Stack(
          children: [
            Positioned(
              top: 50,
              child: Container(
                width: 150,
                height: 180,
                decoration: BoxDecoration(
                    border:
                        Border.all(color: Color(book.secondaryColor), width: 1),
                    color: Color(book.primaryColor),
                    borderRadius: BorderRadius.circular(20)),
              ),
            ),
            Positioned(
              left: 25,
              top: 5,
              child: Hero(
                tag: book.title,
                child: Container(
                  width: 100,
                  height: 150,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(book.coverImage), fit: BoxFit.cover),
                  ),
                ),
              ),
            ),
            Positioned(
              left: MediaQuery.of(context).size.width * 0.02,
              top: MediaQuery.of(context).size.height * 0.215,
              child: Container(
                width: 130,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      book.title,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: Color(book.secondaryColor),
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      book.genre,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
