import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meditrack_admin/src/core/themes/app_color.dart';

class SelectedFiles extends StatefulWidget {
  final List<String> pathList;
  final IconData iconData;
  final String? fileRemove;
  const SelectedFiles({Key? key, required this.pathList, this.iconData = Icons.cancel_outlined,this.fileRemove,}) : super(key: key);

  @override
  State<SelectedFiles> createState() => _SelectedFilesState();
}

class _SelectedFilesState extends State<SelectedFiles> {
  @override
  Widget build(BuildContext context) {
    return Visibility(
        visible: widget.pathList.isNotEmpty,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: widget.pathList.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                childAspectRatio: 0.75,
              ),
              itemBuilder: (context, index) {
                File file =  File(widget.pathList[index]);
                print('weeee ${widget.pathList.length}');
                String fileName = file.path.split('/').last;
                print('Naresh fileName $fileName');
                return  Column(
                  children: [
                    Stack(
                      children: [
                        Column(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8)),
                              child: Container(
                                height: 100,
                                color: Colors.green[100],
                                width: double.infinity,
                                child:  Image.file(
                                  file,
                                  fit: BoxFit.cover,
                                )
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                              decoration: BoxDecoration(
                                color: Color(0xFF2ECC8B),
                                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(8), bottomRight: Radius.circular(8)),
                              ),
                              child: Text(
                                '${fileName}',
                                style: GoogleFonts.inter(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        Positioned(
                            top: -14,
                            left: 57,
                            child:IconButton(onPressed: (){
                              widget.pathList.remove(widget.pathList[index]);
                              setState(() {

                              });
                            },
                                icon:Icon(Icons.cancel,color: Colors.red,)))
                      ],
                    )

                  ],
                );
              }),
        )
    );
  }
}
