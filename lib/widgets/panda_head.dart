import 'package:flutter/material.dart';

class PandaHead extends StatelessWidget {
  const PandaHead({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: -19,
      right: 0.0,
      child: Image.network(
        'https://gtswiki.gt-beginners.net/decal/png/16/52/35/7278450332114355216_1.png',
        width: 150,
        height: 72,
        fit: BoxFit.fitWidth,
      ),
    );
  }
}
