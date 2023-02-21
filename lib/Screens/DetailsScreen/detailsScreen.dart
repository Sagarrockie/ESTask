import 'package:estask/CommonWidgets/appBar.dart';
import 'package:flutter/material.dart';

class DetailsScreen extends StatelessWidget {
  String? description;
  String? productName;
  String? price;
  String? companyName;
  String? qty;
  String? categoryName;
  DetailsScreen(
      {Key? key,
      this.description,
      this.categoryName,
      this.price,
      this.companyName,
      this.productName,
      this.qty})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CommonAppBar(title: "Detail Screen"),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 150,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color.fromRGBO(109, 112, 114, 1),
                ),
                child: const Center(child: Text("Image")),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(top: 17.0, right: 30, bottom: 27),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Column(
                          children: [
                            Text(
                              productName!,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: Color.fromRGBO(109, 112, 114, 1)),
                            ),
                            const SizedBox(
                              height: 2,
                            ),
                            Text(
                              categoryName!,
                              style: const TextStyle(
                                  fontSize: 9,
                                  color: Color.fromRGBO(109, 112, 114, 1)),
                            ),
                          ],
                        ),
                        const Spacer(),
                        RichText(
                          text: TextSpan(
                            children: <TextSpan>[
                              const TextSpan(
                                text: "Price : ",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    color: Color.fromRGBO(109, 112, 114, 1)),
                              ),
                              TextSpan(
                                text: price!,
                                style: const TextStyle(
                                    fontSize: 14,
                                    color: Color.fromRGBO(109, 112, 114, 1)),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Row(
                        children: [
                          const SizedBox(
                            height: 2,
                          ),
                          Text(
                            companyName!,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: Color.fromRGBO(109, 112, 114, 1)),
                          ),
                          const Spacer(),
                          RichText(
                            text: TextSpan(
                              children: <TextSpan>[
                                const TextSpan(
                                  text: "Qty : ",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                      color: Color.fromRGBO(109, 112, 114, 1)),
                                ),
                                TextSpan(
                                  text: qty,
                                  style: const TextStyle(
                                      fontSize: 14,
                                      color: Color.fromRGBO(109, 112, 114, 1)),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 2,
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              const Text(
                "Description :",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Color.fromRGBO(109, 112, 114, 2)),
              ),
              const SizedBox(
                height: 6,
              ),
              Text(
                description!,
                style: const TextStyle(
                    fontSize: 13, color: Color.fromRGBO(109, 112, 114, 0.5)),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(
                    top: 21.0, bottom: 13, right: 13, left: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: 44,
                      width: MediaQuery.of(context).size.width / 2 - 65,
                      child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            primary: const Color.fromRGBO(109, 112, 114, 1),
                          ),
                          child: const Text(
                            "Edit",
                            style: TextStyle(fontSize: 14),
                          )),
                    ),
                    SizedBox(
                      height: 44,
                      width: MediaQuery.of(context).size.width / 2 - 65,
                      child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            primary: const Color.fromRGBO(109, 112, 114, 1),
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
        ));
  }
}
