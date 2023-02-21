import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:estask/CommonWidgets/appBar.dart';
import 'package:estask/CommonWidgets/customTextField.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AddProducts extends StatefulWidget {
  const AddProducts({Key? key}) : super(key: key);

  @override
  State<AddProducts> createState() => _AddProductsState();
}

class _AddProductsState extends State<AddProducts> {
  var selectedType = "";
  var productName = "";
  var category = "";
  var companyName = "";
  var description = "";
  var price = "";
  var qty = "";

  final productNameController = TextEditingController();
  final categoryController = TextEditingController();
  final companyNameController = TextEditingController();
  final descriptionController = TextEditingController();
  final priceController = TextEditingController();
  final qtyController = TextEditingController();

  @override
  void dispose() {
    productNameController.dispose();
    categoryController.dispose();
    companyNameController.dispose();
    descriptionController.dispose();
    priceController.dispose();
    qtyController.dispose();

    super.dispose();
  }

  clearText() {
    productNameController.clear();
    categoryController.clear();
    companyNameController.clear();
    descriptionController.clear();
    priceController.clear();
    qtyController.clear();
  }

  CollectionReference products =
      FirebaseFirestore.instance.collection('products');
  final Stream<QuerySnapshot> categoryStream =
      FirebaseFirestore.instance.collection('categories').snapshots();
  CollectionReference categories =
      FirebaseFirestore.instance.collection('categories');

  Future<void> addUser() {
    return products
        .add({
          'productName': productName,
          'category': category,
          'companyName': companyName,
          'description': description,
          'price': price,
          'qty': qty
        })
        .then((value) => print('User Added'))
        .catchError((error) => print('Failed to Add user: $error'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CommonAppBar(
        title: "Add Products",
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16, top: 21),
        child: Column(
          children: [
            CustomTextField.textFeild(
                labelText: "Product Name", controller: productNameController),
            const SizedBox(
              height: 16.3,
            ),
            StreamBuilder<QuerySnapshot>(
                stream: categoryStream,
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
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
                  }).toList();
                  for (var i = 0; i < storedocs.length; i++) {
                    print("objectsssssss");
                    print(storedocs[i]);
                  }
                  return DropdownButton(
                    items: storedocs
                        .map((value) => DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                style:
                                    TextStyle(color: const Color(0xff11b719)),
                              ),
                            ))
                        .toList(),
                    onChanged: (value) {
                      if (kDebugMode) {
                        print('$value');
                      }
                      // setState(() {
                      //   selectedType = value;
                      // });
                    },
                    value: selectedType,
                    isExpanded: false,
                    hint: const Text(
                      'Choose Account Type',
                      style: TextStyle(color: Color(0xff11b719)),
                    ),
                  );
                }),
            CustomTextField.textFeild(
                labelText: "Category", controller: categoryController),
            const SizedBox(
              height: 16.3,
            ),
            CustomTextField.textFeild(
                labelText: "Company Name", controller: companyNameController),
            const SizedBox(
              height: 16.3,
            ),
            CustomTextField.textFeild(
                labelText: "Description",
                maxLines: 6,
                controller: descriptionController),
            const SizedBox(
              height: 16.3,
            ),
            CustomTextField.textFeild(
                labelText: "Price", controller: priceController),
            const SizedBox(
              height: 16.3,
            ),
            CustomTextField.textFeild(
                labelText: "Qty", controller: qtyController),
            const SizedBox(
              height: 16.3,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Upload Image:"),
                Padding(
                  padding: const EdgeInsets.only(top: 5.0, bottom: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        height: 42,
                        width: 80.48,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: const Color.fromRGBO(109, 112, 114, 1),
                            )),
                        child: const Center(child: Icon(Icons.add)),
                      ),
                      Container(
                        height: 42,
                        width: 80.48,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: const Color.fromRGBO(109, 112, 114, 1),
                            )),
                        child: const Center(child: Icon(Icons.add)),
                      ),
                      Container(
                        height: 42,
                        width: 80.48,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: const Color.fromRGBO(109, 112, 114, 1),
                            )),
                        child: const Center(child: Icon(Icons.add)),
                      ),
                      Container(
                        height: 42,
                        width: 80.48,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: const Color.fromRGBO(109, 112, 114, 1),
                            )),
                        child: const Center(child: Icon(Icons.add)),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: const [
                    Text("Minimum 2 Images"),
                  ],
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 26.0),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 44,
                child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        productName = productNameController.text;
                        category = categoryController.text;
                        companyName = companyNameController.text;
                        description = descriptionController.text;
                        price = priceController.text;
                        qty = qtyController.text;
                        addUser();
                        clearText();
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      primary: const Color.fromRGBO(109, 112, 114, 1),
                    ),
                    child: const Text(
                      "Save",
                      style: TextStyle(fontSize: 14),
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
