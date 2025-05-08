import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class BookReadScreen extends StatelessWidget {
  final String title;
  final String content;
  final bool fromFile; // yeni parametre

  const BookReadScreen({
    super.key,
    required this.title,
    required this.content,
    this.fromFile = false, // default: false (eski davranış)
  });

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context);
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 50, // AppBar yüksekliği
          title: Text(
            title,
            style: TextStyle(
              color: Color.fromARGB(255, 255, 255, 255),
              fontWeight: FontWeight.bold,
            ),
          ),

          backgroundColor: const Color.fromARGB(255, 246, 124, 1),
          iconTheme: const IconThemeData(
            color: Color.fromARGB(255, 255, 255, 255),
          ),
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Color.fromARGB(
              255,
              191,
              97,
              1,
            ), // Bildirim çubuğu rengi (koyu turuncu)
            statusBarIconBrightness:
                Brightness.light, // Bildirim çubuğu simgeleri beyaz olsun
          ),
        ),
        body:
            fromFile
                ? SfPdfViewer.file(File(content)) // cihazdan PDF
                : SfPdfViewer.network(content), // internetten PDF
      ),
    );
  }
}
