import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ThreadsIconCDN extends StatelessWidget {
  final double size;
  final Color? backgroundColor;

  const ThreadsIconCDN({Key? key, this.size = 32.0, this.backgroundColor})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bgColor = backgroundColor ?? Colors.transparent;

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(color: bgColor, shape: BoxShape.circle),
      child: ClipOval(
        child: CachedNetworkImage(
          imageUrl: 'https://img.icons8.com/ios-filled/50/threads.png',
          width: size,
          height: size,
          fit: BoxFit.cover,
          placeholder:
              (context, url) => Container(
                width: size,
                height: size,
                color: Colors.grey[300],
                child: Icon(
                  Icons.image,
                  size: size * 0.5,
                  color: Colors.grey[600],
                ),
              ),
          errorWidget:
              (context, url, error) => Container(
                width: size,
                height: size,
                color: Colors.grey[300],
                child: Icon(Icons.error, size: size * 0.5, color: Colors.red),
              ),
        ),
      ),
    );
  }
}
