import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:navigation/dialogs/bottom_sheet_dialog.dart';
import 'package:navigation/dialogs/cupertino_dialog.dart';
import 'package:navigation/dialogs/custom_dialog.dart';

import '../dialogs/confirm_dialog.dart';

class DialogsPage extends StatelessWidget {
  const DialogsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          ListTile(
            title: const Text("Show info dialog"),
            onTap: () async {
              await showDialog(
                context: context,
                builder: (context) => const DialogContent(),
              );
            },
          ),
          ListTile(
            title: const Text("Show confirm dialog"),
            onTap: () async {
              final isOk =
                  await showConfirmDialog(context, title: "Are you sure?", dismissible: false);
              print("is ok $isOk");
            },
          ),
          ListTile(
            title: const Text("Show cupertino dialog"),
            onTap: () async {
              final value = await showDialogCupertinoStyle(context,
                  title: "i'm cupertino?", content: "aaaAAAAAah!");
              print(value);
            },
          ),
          ListTile(
            title: const Text("Show bottom sheet dialog"),
            onTap: () async {
              showBottomSheetDialog(context);
            },
          ),
          ListTile(
            title: const Text("Show custom dialog"),
            onTap: ()  {
              showCustomDialog(context);
            },
          ),
        ],
      ),
    );
  }
}

class DialogContent extends StatelessWidget {
  const DialogContent({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: const Text("My dialog"),
      actions: [
        MaterialButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text("OK"),
        )
      ],
    );
  }
}
