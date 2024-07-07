import 'package:flutter/material.dart';
import 'package:shopping_list/data/dummy_items.dart';
import 'package:shopping_list/widgets/new_item.dart';

////** Here We are Defining our Widget Class Grocery List*/

class GroceryList extends StatefulWidget { ///# TIP- IF you want to change a stateless to a Stateful Widget then click on that small Bulb icon 
  const GroceryList({super.key});
  @override
  State<GroceryList> createState() => _GroceryListState();
}

class _GroceryListState extends State<GroceryList> {
  void _addItem(){
  Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=>const NewItem()));
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Your Groceriers"),actions: [IconButton(onPressed: (){}, icon:const Icon(Icons.shopping_basket))],),
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
