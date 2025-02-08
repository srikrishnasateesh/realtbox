import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as Path;
import 'dart:io';
import 'package:flutter_pdfview/flutter_pdfview.dart';

class PdfViewerPage extends StatefulWidget {
  final String pdfUrl;

  const PdfViewerPage({super.key, required this.pdfUrl});
  @override
  _PdfViewerPageState createState() => _PdfViewerPageState();
}

class _PdfViewerPageState extends State<PdfViewerPage> {
  late File Pfile;
  bool isLoading = false;
  Future<void> loadNetwork() async {
    setState(() {
      isLoading = true;
    });
    var url = widget.pdfUrl;//'http://www.pdf995.com/samples/pdf.pdf';
    final response = await http.get(Uri.parse(url));
    final bytes = response.bodyBytes;
    final filename = Path.basename(url);
    final dir = await getApplicationDocumentsDirectory();
    var file = File('${dir.path}/$filename');
    await file.writeAsBytes(bytes, flush: true);
    setState(() {
      Pfile = file;
    });

    print(Pfile);
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    loadNetwork();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white
        ),
        centerTitle: Platform.isAndroid ? false : true,
        title: const Text(
          "Back",
          style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Container(
              child: Center(
                child: PDFView(
                  filePath: Pfile.path,
                ),
              ),
            ),
    );
  }
}