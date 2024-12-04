import 'package:flutter/material.dart';
import 'package:inputs/models/country.dart';
import 'package:inputs/constants/countries.dart';

class TextFieldPage extends StatefulWidget {
  const TextFieldPage({super.key});

  @override
  State<TextFieldPage> createState() => _TextFieldPageState();
}

class _TextFieldPageState extends State<TextFieldPage> {
  late final List<Country> _countries;
  final TextEditingController _textEditingController = TextEditingController();
  String _query = "";

  @override
  void initState() {
    super.initState();
    // final countryList = <Country>[];
    // for (final e in countries){
    //   countryList.add(Country.fromJson(e));
    // }
    // _countries= countryList;

    _countries = countries.map<Country>(Country.fromJson).toList();

  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    
    late final List<Country> filteredList;
    if (_query.isEmpty) {
      filteredList = _countries;
    } else {
      filteredList = _countries
          .where((e) => e.name.toLowerCase().contains(_query.toLowerCase()))
          .toList();
    }

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        backgroundColor: Colors.white,
        title: TextField(
          controller: _textEditingController,
            onChanged: (text) {
              _query = text;
              setState(() {});
            },
            decoration:  InputDecoration(
              // label: Text("search..."),
              hintText: "Search",
              hintStyle: const TextStyle(color: Colors.black26),
              prefixIcon: const Icon(Icons.search),
              suffixIcon: IconButton(onPressed: (){
                _textEditingController.text="";
                _query="";
                FocusScope.of(context).unfocus();
                // setState(() {});
              }, icon: const Icon(Icons.clear)),
                contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                focusedBorder: InputBorder.none,
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.green),
                ),
                disabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(
                  color: Colors.pink,
                )))),
      ),
      body: ListView.builder(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        itemBuilder: (_, index) {
          final country = filteredList[index];
          return ListTile(
            title: Text(country.name),
          );
        },
        itemCount: filteredList.length,
      ),
    );
  }
}
