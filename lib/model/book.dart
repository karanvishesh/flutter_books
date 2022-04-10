import 'package:flutter/material.dart';

class Book {
  final String title;
  final String author;
  final String desc;
  final int primaryColor;
  final int secondaryColor;
  final List images;
  final String coverImage;
  final String genre;
  final String id;

  Book(
      {required this.title,
      required this.id,
      required this.author,
      required this.genre,
      required this.desc,
      required this.primaryColor,
      required this.coverImage,
      required this.secondaryColor,
      required this.images});
}

// List<Book> books = [
//   Book(
//       author: "Millie Stewart",
//       title: "Wink Poppie Midnight",
//       desc:
//           """This non solo a più di cinque secoli, ma anche al passaggio alla videoimpaginazione, pervenendoci sostanzialmente inalterato. Fu reso popolare, negli anni ’60, con la diffusione dei fogli di caratteri trasferibili “Letraset”, che contenevano passaggi del Lorem Ipsum, e più recentemente da software di impaginazione come Aldus PageMaker, che includeva versioni del Lorem Ipsum.""",
//       genre: "Mystery",
//       imageUrl: "assets/book1.jpg",
//       primaryColor: Colors.white,
//       secondaryColor: Colors.black),
  // Book(
  //     author: "Sarah Tolmie",
  //     title: "Trio",
  //     desc:
  //         """This non solo a più di cinque secoli, ma anche al passaggio alla videoimpaginazione, pervenendoci sostanzialmente inalterato. Fu reso popolare, negli anni ’60, con la diffusione dei fogli di caratteri trasferibili “Letraset”, che contenevano passaggi del Lorem Ipsum, e più recentemente da software di impaginazione come Aldus PageMaker, che includeva versioni del Lorem Ipsum.""",
  //     imageUrl: "assets/book3.jpg",
  //     genre: "Fantasy",
  //     primaryColor: Color(0xffffc7c7),
  //     secondaryColor: Color(0xffff7474)),
  // Book(
  //     author: "Rudyard Kipling",
  //     title: "The Jungle Book",
  //     desc:
  //         """This non solo a più di cinque secoli, ma anche al passaggio alla videoimpaginazione, pervenendoci sostanzialmente inalterato. Fu reso popolare, negli anni ’60, con la diffusione dei fogli di caratteri trasferibili “Letraset”, che contenevano passaggi del Lorem Ipsum, e più recentemente da software di impaginazione come Aldus PageMaker, che includeva versioni del Lorem Ipsum.""",
  //     imageUrl: "assets/book4.jpg",
  //     genre: "Adventure",
  //     secondaryColor: Color(0xffff7474),
  //     primaryColor: Color(0xfffffdaf)),
  // Book(
  //     author: "Pariac O'Donnel",
  //     title: "The Makers of the Swan",
  //     genre: "Science Fiction",
  //     desc:
  //         """This non solo a più di cinque secoli, ma anche al passaggio alla videoimpaginazione, pervenendoci sostanzialmente inalterato. Fu reso popolare, negli anni ’60, con la diffusione dei fogli di caratteri trasferibili “Letraset”, che contenevano passaggi del Lorem Ipsum, e più recentemente da software di impaginazione come Aldus PageMaker, che includeva versioni del Lorem Ipsum.""",
  //     imageUrl: "assets/book5.jpg",
  //     primaryColor: Colors.white,
  //     secondaryColor: Colors.black),
//   Book(
//       author: "Tamara Bundy",
//       title: "Walking with Miss Millie",
//       desc:
      //     """This non solo a più di cinque secoli, ma anche al passaggio alla videoimpaginazione, pervenendoci sostanzialmente inalterato. Fu reso popolare, negli anni ’60, con la diffusione dei fogli di caratteri trasferibili “Letraset”, che contenevano passaggi del Lorem Ipsum, e più recentemente da software di impaginazione come Aldus PageMaker, che includeva versioni del Lorem Ipsum.""",
      // genre: "Action and Adventure",
      // imageUrl: "assets/book2.jpg",
      // secondaryColor: Color(0xffFFB612),
      // primaryColor: Color(0xfffffdaf)),
// ];
