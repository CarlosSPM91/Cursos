import 'package:flutter/cupertino.dart';

Future<int> showDialogCupertinoStyle(
  BuildContext context, {
  String title = "",
  String content = "",
}) async{
final result = await showCupertinoDialog<int>(
    context: context,
    barrierDismissible: true,
    builder: (context) => CupertinoAlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        CupertinoDialogAction(
          child: const Text("ok"),
          onPressed: () {
            Navigator.pop(context, 1);
          },
        ),
        CupertinoDialogAction(
          child: const Text("Sorry"),
          onPressed: () {
            Navigator.pop(context, 2);
          },
        ),
        CupertinoDialogAction(
          child: const Text("Meh!"),
        onPressed: (){
          Navigator.pop(context, 3);
        },)
      ],
    ),
  );
  return result ?? 1;
}
