import "package:flutter/material.dart";

Future<bool> showConfirmDialog(
  BuildContext context, {
  String title = "",
  bool dismissible = true,
}) async {
  final result = await showDialog<bool>(
      context: context,
      barrierColor: Colors.white.withOpacity(0.4),
      // barrierDismissible: false,
      builder: (context) => PopScope(
            canPop: dismissible,
            onPopInvokedWithResult: (_, __) async => false,
            child: _DialogContent(
              title: title,
            ),
          ));
  return result ?? false;
}

class _DialogContent extends StatelessWidget {
  final String title;
  const _DialogContent({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        title,
        textAlign: TextAlign.center,
      ),
      actionsAlignment: MainAxisAlignment.center,
      elevation: 5,
      shadowColor: Colors.grey,
      backgroundColor: Colors.cyanAccent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      actions: [
        MaterialButton(
          onPressed: () {
            Navigator.pop(context, true);
          },
          child: const Text(
            "YES",
            style: TextStyle(color: Colors.green),
          ),
        ),
        MaterialButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text(
            "NO",
            style: TextStyle(color: Colors.redAccent),
          ),
        ),
      ],
    );
  }
}
