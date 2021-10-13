import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class PhotoHero extends StatelessWidget {
  const PhotoHero({
    required this.photo,
  });

  final String photo;

  Widget build(BuildContext context) {
    return Scaffold(
      body: InteractiveViewer(
        child: Center(
          child: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Hero(
              tag: photo,
              child: Image.asset(photo),
            ),
          ),
        ),
      ),
    );
  }
}

class PhotoHeroNetwork extends StatelessWidget {
  const PhotoHeroNetwork({
    required this.photo,
  });

  final String photo;

  Widget build(BuildContext context) {
    return Scaffold(
      body: InteractiveViewer(
        child: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Center(
            child: Hero(
              tag: photo,
              child: CachedNetworkImage(
                imageUrl: photo,
                placeholder: (context, url) => Container(
                  height: 80.0,
                  width: 50.0,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
                errorWidget: (context, url, error) => Image.asset(
                  'assets/bsinfo.png',
                  fit: BoxFit.cover,
                  height: 80.0,
                  width: 50.0,
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
