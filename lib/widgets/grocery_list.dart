import 'package:flutter/material.dart';
import 'package:shopping_list/data/dummy_items.dart';
import 'package:shopping_list/widgets/new_item.dart';
import 'package:shopping_list/models/grocery_item.dart';

////** Here We are Defining our Widget Class Grocery List*/

class GroceryList extends StatefulWidget {
  ///# TIP- IF you want to change a stateless to a Stateful Widget then click on that small Bulb icon
  const GroceryList({super.key});
  @override
  State<GroceryList> createState() => _GroceryListState();
}

class _GroceryListState extends State<GroceryList> {
  final List<GroceryItem> _groceryitems =
      []; //!!! Make sure to store the grocery items entered by user in this list
  void _addItem() async {
    final newItem = await Navigator.of(context).push<GroceryItem>( //!! Here This line newItem=await Navigator..... 
    ///!!will be responsible for navigating to next screen and 
    ///! will also hold the data  Entered in the next screen 
        MaterialPageRoute(builder: (ctx) => const NewItem()));
    if (newItem == null) {
      return;
    }

    setState(() {
      _groceryitems.add(newItem);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Groceriers"),
        actions: [
          IconButton(
              onPressed: () {
                _addItem();
              },
              icon: const Icon(Icons.shopping_basket))
        ],
      ),
      body: ListView.builder(
        //? ListView.builder is used to create a scrollable list of items
        itemBuilder: (ctx, index) => ListTile(

            ///? ListTile is a single fixed-height row that typically contains some text as well as a leading or trailing icon.
            title: Text(_groceryitems[index]
                .name), //? Text is a widget that displays a string of text with a single style.
            leading: Container(
              width: 24,
              height: 24,
              color: _groceryitems[index].category.color,
            ),
            trailing: Text(_groceryitems[index]
                .quantity
                .toString())), //!!Make sure to Manually convert this into string
        itemCount: _groceryitems.length,
      ), //? Here leading will display a little Category Icon for all the Categories
    );
  }
}
