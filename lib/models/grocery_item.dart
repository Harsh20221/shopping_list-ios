
import 'package:shopping_list/models/category.dart';
class GroceryItem  { //!!! Make sure to not writethe name GroceryItem as GroceryItems else it'll give errors

const GroceryItem({
required this.id,
required
 this.category, required
this.quantity, required
this.name
});
final String id;
final String name;
final int   quantity;
final Category category;

}