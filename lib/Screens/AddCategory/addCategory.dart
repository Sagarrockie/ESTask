import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:estask/CommonWidgets/appBar.dart';
import 'package:estask/CommonWidgets/customTextField.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AddCategory extends StatefulWidget {
  const AddCategory({Key? key}) : super(key: key);

  @override
  State<AddCategory> createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
  var categoryName = "";
  final categoryNameController = TextEditingController();

  final Stream<QuerySnapshot> categoryStream =
      FirebaseFirestore.instance.collection('categories').snapshots();
  CollectionReference categories =
      FirebaseFirestore.instance.collection('categories');
  Future<void> deleteCategory(id) {
    // print("User Deleted $id");
    return categories
        .doc(id)
        .delete()
        .then((value) => print('category Deleted'))
        .catchError((error) => print('Failed to Delete category: $error'));
  }

  Future<void> addCategory() {
    return categories
        .add({
          'categoryName': categoryName,
        })
        .then((value) => print('categoryName Added'))
        .catchError((error) => print('Failed to Add categoryName: $error'));
  }

  clearText() {
    categoryNameController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: categoryStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            if (kDebugMode) {
              print('Something went Wrong');
            }
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final List storeDocs = [];
          snapshot.data!.docs.map((DocumentSnapshot document) {
            Map a = document.data() as Map<String, dynamic>;
            storeDocs.add(a);
            a['id'] = document.id;
          }).toList();
          return Scaffold(
            appBar: const CommonAppBar(
              title: "Category",
            ),
            body: Padding(
              padding: const EdgeInsets.only(top: 21.0, left: 16, right: 16),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTextField.textFeild(
                        labelText: "Category Name",
                        controller: categoryNameController),
                    Padding(
                      padding: const EdgeInsets.only(top: 21.0),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 44,
                        child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                categoryName = categoryNameController.text;
                                addCategory();
                                clearText();
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              primary: const Color.fromRGBO(109, 112, 114, 1),
                            ),
                            child: const Text(
                              "Add",
                              style: TextStyle(fontSize: 18),
                            )),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 41.0),
                      child: Text(
                        "List of categories",
                        style: TextStyle(
                            fontSize: 14,
                            color: Color.fromRGBO(109, 112, 114, 2)),
                      ),
                    ),
                    for (var i = 0; i < storeDocs.length; i++) ...[
                      Padding(
                        padding: const EdgeInsets.only(top: 21.0),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: 44,
                          child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                primary: const Color.fromRGBO(109, 112, 114, 1),
                              ),
                              child: Row(
                                children: [
                                  Text(
                                    storeDocs[i]['categoryName'],
                                    style: TextStyle(fontSize: 18),
                                  ),
                                  const Spacer(),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 15.4),
                                    child: GestureDetector(
                                        onTap: () {
                                          deleteCategory(storeDocs[i]['id']);
                                        },
                                        child: const Icon(Icons.delete)),
                                  ),
                                ],
                              )),
                        ),
                      ),
                    ],
                  ]),
            ),
          );
        });
  }
}
