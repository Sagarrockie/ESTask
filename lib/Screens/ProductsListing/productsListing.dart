import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:estask/CommonWidgets/appBar.dart';
import 'package:estask/Screens/DetailsScreen/detailsScreen.dart';
import 'package:flutter/material.dart';

class ProductsListing extends StatefulWidget {
  const ProductsListing({Key? key}) : super(key: key);

  @override
  State<ProductsListing> createState() => _ProductsListingState();
}

class _ProductsListingState extends State<ProductsListing> {
  Future<void> deleteProduct(id) {
    // print("User Deleted $id");
    return products
        .doc(id)
        .delete()
        .then((value) => print('product Deleted'))
        .catchError((error) => print('Failed to Delete product: $error'));
  }
  final Stream<QuerySnapshot> productsStream =
      FirebaseFirestore.instance.collection('products').snapshots();
  CollectionReference products =
      FirebaseFirestore.instance.collection('products');
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: productsStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            print('Something went Wrong');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final List storedocs = [];
          snapshot.data!.docs.map((DocumentSnapshot document) {
            Map a = document.data() as Map<String, dynamic>;
            storedocs.add(a);
            a['id'] = document.id;
          }).toList();
          return Scaffold(
            appBar: const CommonAppBar(
              title: "Products",
              addIcon: true,
            ),
            body: Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 11),
              child: Column(children: [
                for (var i = 0; i < storedocs.length; i++) ...[
                  SizedBox(
                    height: 109,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DetailsScreen(
                                    categoryName: storedocs[i]['category'],
                                    companyName: storedocs[i]['companyName'],
                                    description: storedocs[i]['description'],
                                    price: storedocs[i]['price'],
                                    productName: storedocs[i]['productName'],
                                    qty: storedocs[i]['qty'],
                                  )),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                      ),
                      child: Row(
                        children: [
                          Container(
                            height: 77,
                            width: 77,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: const Color.fromRGBO(109, 112, 114, 1),
                            ),
                            child: const Center(child: Text("Image")),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 17.0, left: 9),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  storedocs[i]['productName'],
                                  style: const TextStyle(
                                      fontSize: 14,
                                      color: Color.fromRGBO(109, 112, 114, 1)),
                                ),
                                const SizedBox(
                                  height: 2,
                                ),
                                Text(
                                  storedocs[i]['category'],
                                  style: const TextStyle(
                                      fontSize: 9,
                                      color: Color.fromRGBO(109, 112, 114, 1)),
                                ),
                                const SizedBox(
                                  height: 2,
                                ),
                                Text(
                                  "Qty : ${storedocs[i]['qty']}",
                                  style: const TextStyle(
                                      fontSize: 10,
                                      color: Color.fromRGBO(109, 112, 114, 1)),
                                ),
                                const SizedBox(
                                  height: 2,
                                )
                              ],
                            ),
                          ),
                          const Spacer(),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 21.0, bottom: 13, right: 13),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  height: 28,
                                  child: ElevatedButton(
                                      onPressed: () {},
                                      style: ElevatedButton.styleFrom(
                                        primary: const Color.fromRGBO(
                                            109, 112, 114, 1),
                                      ),
                                      child: const Text(
                                        "Edit",
                                        style: TextStyle(fontSize: 14),
                                      )),
                                ),
                                SizedBox(
                                  height: 28,
                                  child: ElevatedButton(
                                      onPressed: () {
                                        deleteProduct(storedocs[i]['id']);

                                      },
                                      style: ElevatedButton.styleFrom(
                                        primary: const Color.fromRGBO(
                                            109, 112, 114, 1),
                                      ),
                                      child: const Text(
                                        "Delete",
                                        style: TextStyle(fontSize: 14),
                                      )),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ]),
            ),
          );
        });
  }
}
