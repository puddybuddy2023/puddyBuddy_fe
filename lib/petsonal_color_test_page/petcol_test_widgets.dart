import 'package:flutter/material.dart';

class PetcolTestAppBar extends StatelessWidget implements PreferredSizeWidget {
  const PetcolTestAppBar({Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: SizedBox.shrink(),
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: Text(
        'PETSNAL TEST',
        style: TextStyle(
          color: Colors.black,
          fontFamily: 'Inter',
        ),
      ),
      centerTitle: true,
      actions: [
        Padding(
          padding: const EdgeInsets.only(top: 10, bottom: 10, right: 5.0),
          child: ElevatedButton(
            style: ButtonStyle(
              shape: MaterialStateProperty.all<OutlinedBorder>(
                CircleBorder(),
              ),
              minimumSize: MaterialStateProperty.all<Size>(Size(30, 30)),
              backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
            ),
            onPressed: () {
              Navigator.of(context)
                  .popUntil(ModalRoute.withName("/petsnalColorStart"));
              Navigator.pop(context);
            },
            child: Icon(
              Icons.close,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
