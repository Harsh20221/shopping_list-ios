////* This file Contains Widget Screen for the New Item Page///*
import 'dart:convert';
/* mport 'dart:io'; */

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shopping_list/data/categories.dart';
import 'package:shopping_list/models/category.dart';
import 'package:shopping_list/models/grocery_item.dart';

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
  ///////the line final _formkey=GlobalKey<FormState>(); declares a final variable _formkey and initializes it
  /// with a new GlobalKey of type FormState. In Flutter, a GlobalKey is a unique identifier for widgets,
  /// allowing you to access their state and methods. By specifying FormState, this key will be used to interact with a Form widget's state,
  /// such as validating the form or saving its data.
  final _formkey = GlobalKey<FormState>();
  var _enteredname = '';
  var _enteredQuantity = 1;
  var _selectedcategories = categories[Categories.convenience];

  ///?Next, the function _saveItem() is defined. Inside this function, _formkey.currentState!.validate(); is called.
  ///? This line accesses the current state of the form associated with _formkey and calls its validate() method.
  ///?  The validate() method checks each FormField widget within the form and runs its validation logic,
  ///?  returning true if all fields are valid and false otherwise. The use of the exclamation mark (!) after currentState is a null assertion operator,
  ///?  which tells Dart that you are certain currentState is not null at this point.
  void _saveItem() async {
    _formkey.currentState!.validate();
    _formkey.currentState!.save();
    final url = Uri.https(
        'shoppinglist-72341-default-rtdb.asia-southeast1.firebasedatabase.app', //!!Veryimp error--- Make sure no charecter is in the url link after .app 
        ///!! make sure the url is not like .app/ or anything should not be after the .app
         //!!! Make sure you copy the correct url else your data will not get pushed into the firebase server
        'shoppinglist.json');
   final response = await http.post(url,headers: {
      'Content-Type':'application/json'
    },body: json.encode({ ////?This Method Here is REponsible for encoding of the message 
      'name':_enteredname,
      'quantity':_enteredQuantity,
      'category':_selectedcategories?.title,

    }));
    if(!context.mounted){ //?The line if (!context.mounted) { return; } was added to your code 
    ///?to ensure that any subsequent operations are only performed if the widget 
    ///?is still part of the widget tree
      return;
    }
    Navigator.of(context).pop(GroceryItem(
        id: DateTime.now().toString(),
        category: _selectedcategories!,
        quantity: _enteredQuantity,
        name:
            _enteredname)); //? Here we are passing the user Entered values to the form
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Add a new item"),
        ),
        body: Padding(
            padding: const EdgeInsets.all(12),
            child: Form(
                key:
                    _formkey, /////!!!!!! VERY IMPORTANT --- DO NOT FORGET TO ATTACH THE KEY HERE OR ELSE CODE WILL NOT EXECUTE
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment
                      .end, //todo: Do not forget this alignment
                  children: [
                    TextFormField(

                        ///We are using this TextFormField to innovatively Register the user shopping list Text
                        maxLength: 50,
                        decoration: const InputDecoration(label: Text('Name')),
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              value.trim().length <= 1 ||
                              value.trim().length > 50) {
                            return 'Error -- Please Enter a name Between 1-50 Charecters';
                          }
                          return null;

                          ///!! Make sure you write this return null because validator must return null in case of a succcessful execution
                        }, /////## We are adding this ! in _enteredname=value! to tell that value will not be null
                        onSaved: (value) {
                          _enteredname = value!;
                        }),
                    Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
                      //!! Make sure to make crossaxisalignment = crossaxisalignment.end
                      ///!!else the form fields will not align
                      Expanded(
                          child: TextFormField(
                        decoration:
                            const InputDecoration(label: Text("Quantity")),
                        initialValue: _enteredQuantity.toString(),
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              int.tryParse(value) == null ||
                              int.tryParse(value)! <= 0) {
                            return ' Please Enter a Number greater than 0 ';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _enteredQuantity = int.parse(value!);
                        },
                      )), //!! Make sure to use the int.parse function to get the initial value in integer form
                      const SizedBox(width: 8),
                      Expanded(
                          child: DropdownButtonFormField(
                              value: _selectedcategories,
                              items: [
                                for (final category in categories
                                    .entries) //? We need to convert this category items to category.entries to make that iterable
                                  DropdownMenuItem(
                                      value: category.value,
                                      child: Row(
                                        children: [
                                          Container(
                                            //? This container displays the category icon color
                                            width: 16,
                                            height: 16,
                                            color: category.value.color,
                                          ),
                                          const SizedBox(
                                            width: 6,
                                          ),
                                          Text(category.value.title)
                                        ],
                                      ))
                              ],
                              onChanged: (value) {
                                setState(() {
                                  //!! We need to call setstate as the the selectedvalue changes gradually
                                  _selectedcategories = value!;
                                });
                              }))
                    ]),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                            onPressed: () {
                              _formkey.currentState!.reset();
                            },
                            child: const Text("Reset")),
                        ElevatedButton(
                            onPressed: _saveItem, child: const Text("Submit"))
                      ],
                    )
                  ],
                ))));
  }
}
