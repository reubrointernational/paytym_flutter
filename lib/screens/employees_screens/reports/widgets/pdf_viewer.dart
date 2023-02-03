import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class PdfViewer extends StatelessWidget {
  final String url;
  const PdfViewer({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    return const PDF(
      enableSwipe: true,
      swipeHorizontal: false,
      autoSpacing: false,
      pageFling: false,
      preventLinkNavigation: true,
    ).cachedFromUrl(
      url,
      placeholder: (progress) => const Center(
        child: SpinKitCubeGrid(
          color: Colors.blue,
          size: 50.0,
        ),
      ),
      errorWidget: (error) => Column(
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
