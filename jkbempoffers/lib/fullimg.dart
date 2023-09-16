import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';


class ImageBui extends StatelessWidget
{
  final String id,name;
  ImageBui(this.id,this.name);

  @override
  Widget build(BuildContext context) {


   return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
          title: new Text(name,style: TextStyle(color: Colors.white,fontSize: 15))
      ),
      backgroundColor: Colors.black,
      body:
      Hero(tag: id,
        child: PhotoView(
          imageProvider: NetworkImage(
            id
          ),

          minScale: PhotoViewComputedScale.contained*0.8,
          maxScale: PhotoViewComputedScale.covered*2,
          enableRotation: false,
        ),
      ),
    );




  }
}