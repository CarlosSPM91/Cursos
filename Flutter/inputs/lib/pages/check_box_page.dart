import 'package:flutter/material.dart';

class CheckBoxPage extends StatefulWidget {
  const CheckBoxPage({super.key});

  @override
  State<CheckBoxPage> createState() => _CheckBoxPageState();
}

class _CheckBoxPageState extends State<CheckBoxPage> {
  bool _checked = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                const Text(
                    "Lorem Ipsum es simplemente el texto de relleno de las imprentas y archivos de texto. Lorem Ipsum ha sido el texto de relleno estándar de las industrias desde el año 1500, cuando un impresor (N. del T. persona que se dedica a la imprenta) desconocido usó una galería de textos y los mezcló de tal manera que logró hacer un libro de textos especimen. No sólo sobrevivió 500 años, sino que tambien ingresó como texto de relleno en documentos electrónicos, quedando esencialmente igual al original. Fue popularizado en los 60s con la creación de las hojas Letraset, las cuales contenian pasajes de Lorem Ipsum, y más recientemente con software de autoedición, como por ejemplo Aldus PageMaker, el cual incluye versiones de Lorem Ipsum."),
                const SizedBox(height: 20,),
                CheckboxListTile(
                  contentPadding: EdgeInsets.zero,
                  value: _checked,
                  controlAffinity: ListTileControlAffinity.leading,
                  visualDensity: VisualDensity.compact,
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        _checked = value;
                      });
                    }
                  },
                  title: const Expanded(
                    child: Text(
                        "Lorem Ipsum es simplemente el texto de relleno de las imprentas y archivos de texto"),
                  ),
                  
                ),
                Checkbox(
                  fillColor: WidgetStateProperty.all(Colors.pink),
                  checkColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(2),
                  ),
                  value: _checked,
                  // tristate: true,
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        _checked = value;
                      });
                    }
                  },
                ),
                const Divider(),
                SwitchListTile(
                  inactiveTrackColor: Colors.amber,
                  controlAffinity: ListTileControlAffinity.trailing,
                  title: const Text("Enable push notifications"),
                  value: _checked,
                  // tristate: true,
                  onChanged: (value) {
                      setState(() {
                        _checked = value;
                      });
                    }
                ),
                const Divider(),
                MaterialButton(
                  onPressed: _checked ? () {} : null,
                  child: const Text("Next"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


// GestureDetector(
//                   onTap: () {
//                     setState(() {
//                       _checked = !_checked;
//                     });
//                   },
//                   child: Row(
//                     children: [
//                       Checkbox(
//                         value: _checked,
//                         // tristate: true,
//                         onChanged: (value) {
//                           if (value != null) {
//                             setState(() {
//                               _checked = value;
//                             });
//                           }
//                         },
//                       ),
//                       const Expanded(
//                         child: Text(
//                             "Lorem Ipsum es simplemente el texto de relleno de las imprentas y archivos de texto"),
//                       ),
//                     ],
//                   ),
//                 ),