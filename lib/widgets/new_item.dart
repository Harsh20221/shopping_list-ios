////* This file Contains Widget Screen for the New Item Page
import 'package:flutter/material.dart';

class NewItem extends StatefulWidget {
  const NewItem({super.key});
  @override
  State<NewItem> createState() {
    return _NewItemState();
  }
}

class _NewItemState extends State<NewItem> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Add a new item"),
        ),
        body: Padding(
            padding: EdgeInsets.all(12),
            child: Form(
                child: Column(
              children: [
                TextFormField( ///We are using this TextFormField to innovatively Register the user shopping list Text 
                  maxLength: 50,
                  decoration: const InputDecoration(label: Text('Name')),
                validator:(value){return 'GG';} ,)
              ],
            ))));
  }
}
