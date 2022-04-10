import 'package:flutter/material.dart';

class DetailScreenTopRow extends StatelessWidget {
  const DetailScreenTopRow({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        IconButton(
          icon: Icon(
            Icons.keyboard_arrow_left,
            size: 30,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        SizedBox(
          width: 10,
        ),
        Expanded(
          child: Text(
            'Book Detail',
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        IconButton(
          icon: Icon(Icons.more_vert),
          onPressed: () {},
        ),
      ],
    );
  }
}
