import 'package:flutter/material.dart';

import '../Screens/AddProducts/addProducts.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final bool? addIcon;
  final Function? addIconPress;

  const CommonAppBar({
    Key? key,
    this.title,
    this.addIcon,
    this.addIconPress,
  }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(50);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color.fromRGBO(109, 112, 114, 1),
      title: Text(title!, style: const TextStyle(fontSize: 24)),
      centerTitle: true,
      actions: <Widget>[
        addIcon == true
            ? IconButton(
                icon: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AddProducts()),
                  );
                },
              )
            : const SizedBox()
      ],
    );
  }
}
