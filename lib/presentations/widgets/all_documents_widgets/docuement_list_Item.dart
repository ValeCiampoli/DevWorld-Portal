import 'package:flutter/material.dart';
import 'package:portal/commons/theme.dart';
import 'package:portal/commons/utils.dart';
import 'package:portal/data/models/document_model.dart';
import 'package:portal/presentations/state_management/document_provider.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:html' as html;

class DocumentItem extends StatefulWidget {
  final DocumentModel document;
  const DocumentItem({super.key, required this.document});

  @override
  State<DocumentItem> createState() => _DocumentItemState();
}

class _DocumentItemState extends State<DocumentItem> {
  Offset? _tapPosition;

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(builder: (context, size) {
      return size.deviceScreenType == DeviceScreenType.mobile
          ? Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(
                    width: 24,
                  ),
                  SizedBox(
                      width: MediaQuery.of(context).size.width * 0.25,
                      child: Text(
                        formattedDate(
                          widget.document.date,
                        ),
                        style: DWTextTypography.of(context).text16,
                      )),
                  SizedBox(
                      width: MediaQuery.of(context).size.width * 0.22,
                      child: Text(
                        widget.document.name,
                        style: DWTextTypography.of(context).text16,
                      )),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.20,
                    child: MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                           onTap: () {
                            var doc = widget.document.url;
                            if (doc.isNotEmpty) {
                             html.window.open(doc, "");
                            }
                          },
                          child: Text('Link',
                              style: DWTextTypography.of(context)
                                  .text16
                                  .copyWith(color: Colors.blue))),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.20,
                    child: GestureDetector(
                        onTapDown: _storePosition,
                        onLongPress: () async =>
                            await _showSelectUserToViewPopupMenu(context),
                        child: Icon(
                          Icons.menu,
                          color: Colors.white,
                        )),
                  )
                ],
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(
                    width: 24,
                  ),
                  SizedBox(
                      width: MediaQuery.of(context).size.width * 0.22,
                      child: Text(
                        formattedDate(
                          widget.document.date,
                        ),
                        style: DWTextTypography.of(context).text16,
                      )),
                  SizedBox(
                      width: MediaQuery.of(context).size.width * 0.22,
                      child: Text(
                        widget.document.name,
                        style: DWTextTypography.of(context).text16,
                      )),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.22,
                    child: MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                          onTap: () {
                            var doc = widget.document.url;
                            if (doc.isNotEmpty) {
                              html.window.open(doc, "");
                            }
                          },
                          child: Text('Link',
                              style: DWTextTypography.of(context)
                                  .text16
                                  .copyWith(color: Colors.blue))),
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      await context
                          .read<DocumentListProvider>()
                          .deleteDocument(widget.document);
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
                                    .deleteDocument(widget.document);
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
                                      .deleteDocument(widget.document);
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
                                var doc = widget.document.url;
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
    });
  }

  void _storePosition(TapDownDetails details) {
    _tapPosition = details.globalPosition;
  }

  _showSelectUserToViewPopupMenu(BuildContext context) async {
    final RenderBox overlay =
        Overlay.of(context).context.findRenderObject() as RenderBox;

    await showMenu(
            context: context,
            position: RelativeRect.fromRect(
                _tapPosition! & const Size(40, 40), Offset.zero & overlay.size),
            items: [
              PopupMenuItem<int>(value: 1, child: Text('Elimina')),
              PopupMenuItem<int>(value: 2, child: Text('Apri')),
            ],
            elevation: 8.0)
        .then((value) async {
      if (value != null) {
        switch (value) {
          case 1:
            await context
                .read<DocumentListProvider>()
                .deleteDocument(widget.document);
            break;
          case 2: //todo apri in qualche modo il doc
          default:
        }
      }
    });
  }

  void launchURL(String firebaseUrl) async {
    final url = Uri.encodeFull(firebaseUrl);
    await launchUrl(Uri.parse(url));
  }
}
