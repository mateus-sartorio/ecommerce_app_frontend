import 'package:ecommerce_app/components/shoe_tile.dart';
import 'package:ecommerce_app/models/shoe.dart';
import 'package:ecommerce_app/store/global_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({Key? key}) : super(key: key);

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  // add shoe to cart
  void addShoeToCart(Shoe shoe) {
    Provider.of<GlobalState>(context, listen: false).addItemToCart(shoe);

    // alert the user, shoe successfully added to cart
    showDialog(
        context: context,
        builder: (context) {
          Future.delayed(const Duration(milliseconds: 700), () {
            Navigator.of(context).pop(true);
          });

          return AlertDialog(
            title: const Text(
              "Successfully added",
              style: TextStyle(fontSize: 14),
            ),
            surfaceTintColor: Colors.transparent,
            elevation: 0.0,
            alignment: Alignment.topCenter,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GlobalState>(
      builder: (context, value, child) => Column(
        children: [
          // search bar
          Container(
            padding: const EdgeInsets.all(12),
            margin: const EdgeInsets.symmetric(horizontal: 25),
            decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(8)),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Text("Search"), Icon(Icons.search)],
            ),
          ),

          // message
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 25),
            child: Text(
              "Everyone flies... some fly longer than others.",
              style: TextStyle(fontSize: 12),
            ),
          ),

          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "Hot pics 🔥",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                ),
                Text(
                  "See all",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),

          const SizedBox(
            height: 10,
          ),

          Expanded(
              child: Container(
            margin: const EdgeInsets.only(right: 25),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: value.cart.getShoeList().length,
              itemBuilder: (context, index) => ShoeTile(
                  shoe: value.cart.getShoeList()[index],
                  onTap: () => addShoeToCart(value.cart.getShoeList()[index])),
            ),
          ))

          // hot picks
        ],
      ),
    );
  }
}
