////* This file Contains Widget Screen for the New Item Page
import 'package:flutter/material.dart';
import 'package:shopping_list/data/categories.dart';
/* import 'package:shopping_list/models/category.dart'; */
/////!!!!!!!!!!!VERY IMPORTANT RULE IN FLUTTER -- MAKE SURE THE TEXT WIDGET IS NOT INSIDE ROW WIDGET
///! Because both stretches indefinately but in case we need to do it then we enclose the other Widget with Expanded
///! Like we did in line 37 and line 43
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
                TextFormField(
                  ///We are using this TextFormField to innovatively Register the user shopping list Text
                  maxLength: 50,
                  decoration: const InputDecoration(label: Text('Name')),
                  validator: (value) {
                    return 'GG';
                  },
                ),
                Row(crossAxisAlignment: CrossAxisAlignment.end,children: [
                  Expanded(
                      child: TextFormField(
                    decoration: InputDecoration(label: Text("Quantity")),
                    initialValue: '1',
                  )),
                  const SizedBox(width: 8),
              Expanded(child:DropdownButtonFormField(items: [
                    for (final category in categories.entries)
                      DropdownMenuItem(
                          value: category.value,

                          ///?
                          child: Row(
                            children: [
                              Container(
                                width: 16,
                                height: 16,
                                color: category.value.color,
                              )
                            ],
                          ))
                  ], onChanged: (value) {}))
                ])
              ],
            ))));
  }
}
