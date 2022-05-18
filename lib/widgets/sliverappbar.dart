import 'package:flutter/material.dart';

class ImageBackgroundAppBar extends StatelessWidget {

  final String name;

  const ImageBackgroundAppBar({
    Key? key,
    required this.name
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlexibleSpaceBar(
      title: Container(
        margin: const EdgeInsets.only(bottom: 20),
        child: Text(name, style: const TextStyle(fontWeight: FontWeight.bold),)
        ),
      centerTitle: true,
      titlePadding: EdgeInsets.zero,
      background: const ImageCustom(),
    );
  }
}

class ImageCustom extends StatelessWidget {
  const ImageCustom({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: double.infinity,
          width: double.infinity,
          color: Colors.purple,
          child: const Image(
            width: double.infinity,
            image: AssetImage('assets/portal.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.black26,
        )
      ],
    );
  }
}