import 'package:flutter/material.dart';

class HeroWidget extends StatelessWidget {
  const HeroWidget({super.key,this.image});
  final String? image;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text('Full Screen'),backgroundColor: Colors.white,elevation: 0,),
      body: Center(
        child: Hero(
          tag: 'Image',
          child: Image.network(
            image.toString(),
          ),
        ),
      ),
    );
  }
}
