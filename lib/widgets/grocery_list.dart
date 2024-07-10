import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shopping_list/data/categories.dart';
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
  var isloading = true;
  String?error;
  List<GroceryItem> _groceryitems =
      []; //!!! Make sure to store the grocery items entered by user in this list
  @override
  void initState() {
    super.initState();
    _loaditems();
  }

  void _loaditems() async {
    final url = Uri.https(
        'shoppinglist-72341-default-rtdb.asia-southeast1.firebasedatabase.app',
        'shoppinglist.json');
    ///!!! VERY IMPORTANT -- MAKE SURE TO FORMAT THE LINK IN THIS WAY OR ELSE YOU WILL FACE A VARIETY OF ERRORS
    ////!!!!Make sure nothing is before the word 'shoppinglist' there should not be https:// before link and / should not be after .app at the last of the link and also make sure the name should be 'shoppinglist.json' and not 'shopping_list.json'
    final response = await http.get(url);
  if(response.statusCode>=400){
       setState(() {
         error  = 'Cannot Fetch Data Please try Again ';
       });  
      }
    ///!!!!Make sure you await the response elsse it will give error of getter body
    final Map<String, dynamic> listdata = json.decode(response.body);
    final List<GroceryItem> loadedItems = [];
    for (final item in listdata.entries) {
      final category = categories.entries
          .firstWhere(
              (catItem) => catItem.value.title == item.value['category'])
          .value;
      loadedItems.add(GroceryItem(
          id: item.key,
          category: category,
          quantity: item.value['quantity'],
          name: item.value['name']));
    }

    setState(() {
      _groceryitems = loadedItems;
      isloading=false;
    });
  }

  void _removeitem (GroceryItem item) async{
    final index = groceryItems.indexOf(item); //?Here we are storing the index of the item to be removed
    ///*** This Void Function wll help us dismiss list items throug swipe  */
  final url =  Uri.https('shoppinglist-72341-default-rtdb.asia-southeast1.firebasedatabase.app','shoppinglist/${item.id}.json'); //? Here we are storing the url of the item to be removed along with the id of the item
   final response = await http.delete(url); //? Here we are deleting the item from the server
   
   ///**Error Condition  */
   if(response.statusCode>=404){ //? Here we are checking if the status code is greater than 404 then we will return the item back to the list
    setState(() {
     const Text('Failed to delete item'); //? Here we are displaying a message if the item is not deleted
      _groceryitems.insert(index, item);
    });
  if(response.body=='null'){ //? Here we are checking if the body of the response is null then we will return the item back to the list it'll fix infinite loading when we delete all items
    setState(() {
      isloading=false;
    });
  
   }

    setState(() { ///// Whenever we are updating the UI we use setState that's why we have written setState here because we are updating Ui here
      ///!!! Very important to enclose this remove item inside setState else the items will not get actually removed and will give us errors
      _groceryitems.remove(item);
    });
  }}

  void _addItem() async {
   final newItem= await Navigator.of(context)
        .push<GroceryItem>(//!! Here This line newItem=await Navigator.....
            ///!!will be responsible for navigating to next screen and
            ///! will also hold the data  Entered in the next screen
            MaterialPageRoute(builder: (ctx) => const NewItem()));
    /*  if (newItem == null) {
      return;}
    setState(() {
      _groceryitems.add(newItem);
    }); */
    setState(() {
      _groceryitems.add(newItem!);
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget content = const Center(child: Text('No items Added yet'));
    
    if(isloading){
      content=const Center(child: CircularProgressIndicator());
    }


    if(_groceryitems.isNotEmpty){
    content =ListView.builder(
        //? ListView.builder is used to create a scrollable list of items
        itemBuilder: (ctx, index) => Dismissible(
          //!! Make sure to enclose the entire function inside Dismissible
          key: ValueKey(_groceryitems[index]
              .id), //! Do not forget to assign key , this key will be used to track the item
          onDismissed: (direction) => _removeitem(_groceryitems[index]),

          ///!!! Very VERY Imp to write _groceryitems[index] inside the remove method else it will not remove the item
          //? definded in line 19 this function helps us remove list items on swiping the list item right or left
          child: ListTile(

              ///? ListTile is a single fixed-height row that typically contains some text as well as a leading or trailing icon.
              title: Text(_groceryitems[index]
                  .name), //? Text is a widget that displays a string of text with a single style.
              leading: Container(
                width: 24,
                height: 24,
                color: _groceryitems[index].category.color,
              ),
              trailing: Text(_groceryitems[index].quantity.toString())),
        ), //!!Make sure to Manually convert this into string
        itemCount: _groceryitems.length,
      ); //? Here leading will display a little Category Icon for all the Categories

    }
    if(error!=null){
      content= Text('Failed to fetch Data , Please Try AGain Later ');
    }



      return   Scaffold(
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
      body: content);
   // Add this line to ensure a Widget is always returned
}}
