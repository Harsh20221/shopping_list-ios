import 'package:flutter/material.dart';
import 'package:shopping_list/data/dummy_items.dart';

////** Here We are Defining our Widget Class Grocery List*/

class GroceryList extends StatelessWidget {
  const GroceryList({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Your Groceriers")),
      body: ListView.builder(
        //? ListView.builder is used to create a scrollable list of items
        itemBuilder: (ctx, index) => ListTile(
          ///? ListTile is a single fixed-height row that typically contains some text as well as a leading or trailing icon.
          title: Text(groceryItems[index]
              .name), //? Text is a widget that displays a string of text with a single style.
          leading: Container(
            width: 24,
            height: 24,
            color: groceryItems[index].category.color,
          ),
          trailing: Text(groceryItems[index].quantity.toString())), //!!Make sure to Manually convert this into string
        itemCount: groceryItems.length,
      ), //? Here leading will display a little Category Icon for all the Categories
    );
  }
}
