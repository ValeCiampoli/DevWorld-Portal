import 'package:flutter/material.dart';
import 'package:portal/commons/utils.dart';
import 'package:portal/data/models/document_model.dart';
import 'package:portal/presentations/state_management/document_provider.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:html' as html;

class DocumentItem extends StatelessWidget {
  final DocumentModel document;
  const DocumentItem({super.key, required this.document});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(
            width: 24,
          ),
          SizedBox(
              width: MediaQuery.of(context).size.width * 0.22,
              child: Text(formattedDate(document.date))),
          SizedBox(
              width: MediaQuery.of(context).size.width * 0.22,
              child: Text(document.name)),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.22,
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                  onTap: () {
                    var doc = document.url;
                    if (doc.isNotEmpty) {
                      html.window.open(doc, "");
                    }
                  },
                  child: const Text(
                    'Link',
                    style: TextStyle(
                      color: Colors.blue,
                    ),
                  )),
            ),
          ),
          GestureDetector(
            onTap: () async {
              await context
                  .read<DocumentListProvider>()
                  .deleteDocument(document);
            },
            child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.22,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    MaterialButton(
                      color: Colors.red,
                      onPressed: () async {
                        await context
                            .read<DocumentListProvider>()
                            .deleteDocument(document);
                      },
                      child: const Icon(
                        Icons.delete,
                        color: Colors.white,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: MaterialButton(
                        color: Colors.blue,
                        onPressed: () async {
                          await context
                              .read<DocumentListProvider>()
                              .deleteDocument(document);
                        },
                        child: const Icon(
                          Icons.edit,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    MaterialButton(
                      color: Colors.green,
                      onPressed: () async {
                        var doc = document.url;
                        if (doc.isNotEmpty) {
                          html.window.open(doc, "");
                        }
                      },
                      child: const Icon(
                        Icons.download,
                        color: Colors.white,
                      ),
                    ),
                  ],
                )),
          ),
        ],
      ),
    );
  }

  void launchURL(String firebaseUrl) async {
    final url = Uri.encodeFull(firebaseUrl);
    await launchUrl(Uri.parse(url));
  }
}
