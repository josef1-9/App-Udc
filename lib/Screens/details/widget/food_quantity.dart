import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:food_delivery_app/constants/colors.dart';
import 'package:food_delivery_app/Screens/home/widget/food_item.dart';

import 'package:food_delivery_app/models/food.dart';







class Cart {
  // Properties
  List<Food> items = [];
  double total = 0.0;

  //Methods
  void addItem(Food food) {
    items.add(food);
    total += food.price! * food.quantity!;
  }

  void removeItem(int index) {
    total -= items[index].price! * items[index].quantity!;
    items.removeAt(index);
  }

  void clearCart() {
    items.clear();
    total = 0.0;
  }
}

class FoodQuantity extends StatefulWidget {
  final Food? food;
  final Function(int quantity)? onQuantityChanged; // Define named parameter

  const FoodQuantity({Key? key, this.food, this.onQuantityChanged})
      : super(key: key);

  @override
  _FoodQuantityState createState() => _FoodQuantityState();



}

class AddToCartScreen extends StatefulWidget {
  final Food food;
  const AddToCartScreen({Key? key, required this.food}) : super(key: key);


  @override
  _AddToCartScreenState createState() => _AddToCartScreenState();

void _onQuantityChanged(int quantity) {

}




}

class _AddToCartScreenState extends State<AddToCartScreen> {
  final Cart cart = Cart();

  void _onQuantityChanged(int quantity) {
  setState(() {
    widget.food.quantity = quantity;
    cart.total += widget.food.price! * quantity;
  });
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add to Cart'),
      ),
      body: Column(
        children: [
          FoodItem(food: widget.food),
         FoodQuantity(
    food: widget.food,
    onQuantityChanged: _onQuantityChanged,
           ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              cart.addItem(widget.food);
              // show a snackbar to confirm that the item has been added to the cart
              final snackBar = SnackBar(content: Text('Added to cart'));
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            },
            child: Text('Add to Cart'),
          ),
          SizedBox(height: 20),
          Text(
            'Total: \$${cart.total.toStringAsFixed(2)}',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

// class FoodQuantity extends StatefulWidget {
//   final Food? food;
//   const FoodQuantity({
//     Key? key,
//     this.food,
//   }) : super(key: key);

//   @override
//   _FoodQuantityState createState() => _FoodQuantityState();
// }

class _FoodQuantityState extends State<FoodQuantity> {
  int _quantity = 0;
//increment food item
  void _incrementQuantity() {
    setState(() {
      _quantity++;
      widget.food!.quantity = _quantity;
    });
  }

//decrement food item
  void _decrementQuantity() {
    setState(() {
      if (_quantity > 0) _quantity--;
      widget.food!.quantity = _quantity;
    });








    
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.maxFinite,
        height: 40,
        child: Stack(
          children: [
            Align(
              alignment: Alignment(-0.3, 0),
              child: Container(
                height: double.maxFinite,
                width: 120,
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(children: [
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    '\$',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    widget.food!.price!.toString(),
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ]),
              ),
            ),
            Align(
              alignment: Alignment(0.1, 0),
              child: Container(
                height: double.maxFinite,
                width: 200,
                decoration: BoxDecoration(
                  color: kPrimaryColor,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                      onPressed: _decrementQuantity,
                      child: Text(
                        '-',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Colors.white),
                      child: Text(
                        widget.food!.quantity!.toString(),
                      ),
                    ),
                    TextButton(
                      onPressed: _incrementQuantity,
                      child: Text(
                        '+',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}




