import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CachedImage extends StatelessWidget {
  final String url;
  const CachedImage({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: url,
      placeholder: (context, url) => const Center(
        child: SpinKitCubeGrid(
          color: Colors.blue,
          size: 50.0,
        ),
      ),
      errorWidget: (context, url, error) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.error_outline_sharp,
            color: Colors.red,
            size: 50,
          ),
          Text(error.toString()),
        ],
      ),
    );
  }
}
