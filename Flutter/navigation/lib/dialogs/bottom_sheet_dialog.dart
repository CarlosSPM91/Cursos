import 'package:flutter/material.dart';

Future<void> showBottomSheetDialog(
  BuildContext context,
) {
  return showModalBottomSheet(
    context: context,
    // enableDrag: false,
    // backgroundColor: Colors.transparent,
    // isScrollControlled: true,
    isDismissible: false,
    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.elliptical(20, 10), topRight:  Radius.elliptical(20, 10))),
    constraints: const BoxConstraints(
      maxWidth: 500,
    ),
    builder: (context) => SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            onTap: () {
              Navigator.pop(context);
            },
            leading: const Icon(Icons.photo),
            title: const Text("Photos"),
          ),
          ListTile(
            onTap: () {
              Navigator.pop(context);
            },
            leading: const Icon(Icons.speaker),
            title: const Text("Music"),
          ),
          ListTile(
            onTap: () {
              Navigator.pop(context);
            },
            leading: const Icon(Icons.video_camera_back_outlined),
            title: const Text("Video"),
          ),
        ],
      ),
    ),
  );
}
