import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_books/model/splash_page_data.dart';
class PageCard extends StatelessWidget {
  final PageData page;
  const PageCard({
    Key? key,
    required this.page,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 30.0,
      ),
      child: Column(
//        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _buildPicture(context),
          SizedBox(height: 30),
          _buildText(context),
        ],
      ),
    );
  }

  Widget _buildText(BuildContext context) {
    return Text(
      page.title!,
      style: TextStyle(fontSize: 30),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildPicture(
    BuildContext context, {
    double size = 190,
    double iconSize = 170,
  }) {
    return Center(
      child: Container(
        width: 280,
        height: 400,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  page.image!,
                ),
                fit: BoxFit.cover)),
      ),
    );
  }
}
