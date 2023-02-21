import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:estask/CommonWidgets/appBar.dart';
import 'package:estask/CommonWidgets/customTextField.dart';
import 'package:flutter/material.dart';

class AddCompany extends StatefulWidget {
  const AddCompany({Key? key}) : super(key: key);

  @override
  State<AddCompany> createState() => _AddCompanyState();
}

class _AddCompanyState extends State<AddCompany> {
  var companyName = "";
  final companyNameController = TextEditingController();

  final Stream<QuerySnapshot> companyStream =
      FirebaseFirestore.instance.collection('companies').snapshots();
  CollectionReference companies =
      FirebaseFirestore.instance.collection('companies');
  Future<void> deleteCompany(id) {
    // print("User Deleted $id");
    return companies
        .doc(id)
        .delete()
        .then((value) => print('company Deleted'))
        .catchError((error) => print('Failed to Delete company: $error'));
  }

  Future<void> addCompany() {
    return companies
        .add({
          'companyName': companyName,
        })
        .then((value) => print('companyName Added'))
        .catchError((error) => print('Failed to Add companyName: $error'));
  }

  clearText() {
    companyNameController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: companyStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            print('Something went Wrong');
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
              title: "Company",
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(top: 21.0, left: 16, right: 16),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTextField.textFeild(
                          labelText: "Company Name",
                          controller: companyNameController),
                      Padding(
                        padding: const EdgeInsets.only(top: 21.0),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: 44,
                          child: ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  companyName = companyNameController.text;
                                  addCompany();
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
                          "List of companies",
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
                                  primary:
                                      const Color.fromRGBO(109, 112, 114, 1),
                                ),
                                child: Row(
                                  children: [
                                    Text(
                                      storeDocs[i]['companyName'],
                                      style: const TextStyle(fontSize: 18),
                                    ),
                                    const Spacer(),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(right: 15.4),
                                      child: GestureDetector(
                                          onTap: () {
                                            {
                                              deleteCompany(storeDocs[i]['id']);
                                            }
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
            ),
          );
        });
  }
}
