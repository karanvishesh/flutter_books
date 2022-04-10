import 'package:flutter/material.dart';

class TopRow extends StatelessWidget {
  const TopRow({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Hey, Vishesh",
              style:
                  TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              "Explore the world of books",
              style: TextStyle(fontSize: 15),
            ),
          ],
        ),
        Spacer(),
        Container(
          width: 40,
          height: 40,
          child: Image.asset(
            "assets/cart.png",
            color: Color(0xffff7474),
            scale: 5,
          ),
          decoration: BoxDecoration(
              color: Color(0xffffc7c7),
              borderRadius: BorderRadius.circular(10)),
        )
      ],
    );
  }
}
