import 'package:estask/CommonWidgets/appBar.dart';
import 'package:estask/Screens/AddCategory/addCategory.dart';
import 'package:estask/Screens/AddCompany/addCompany.dart';
import 'package:estask/Screens/ProductsListing/productsListing.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CommonAppBar(
        title: "Home",
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
                height: MediaQuery.of(context).size.height / 3 - 60,
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ProductsListing()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      primary: const Color.fromRGBO(109, 112, 114, 1),
                    ),
                    child: const Text(
                      "Products",
                      style: TextStyle(fontSize: 22),
                    ))),
            SizedBox(
                height: MediaQuery.of(context).size.height / 3 - 60,
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AddCategory()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      primary: const Color.fromRGBO(109, 112, 114, 1),
                    ),
                    child: const Text(
                      "Manage Category",
                      style: TextStyle(fontSize: 22),
                    ))),
            SizedBox(
                height: MediaQuery.of(context).size.height / 3 - 60,
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AddCompany()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      primary: const Color.fromRGBO(109, 112, 114, 1),
                    ),
                    child: const Text(
                      "Manage Company",
                      style: TextStyle(fontSize: 22),
                    ))),
          ],
        ),
      ),
    );
  }
}
