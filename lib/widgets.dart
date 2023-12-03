import 'package:flutter/material.dart';

class GradientBackground extends StatelessWidget {
  final Widget childWidget;
  const GradientBackground({super.key, required this.childWidget});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF858AFF), Color(0xFF9492FF), Color(0xFFBFA8FF)],
        ),
      ),
      child: childWidget,
    );
  }
}

class GoBackAppBar extends StatelessWidget implements PreferredSizeWidget {
  const GoBackAppBar({Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      iconTheme: IconThemeData(color: Colors.black),
      elevation: 0,
      shape: const Border(
        bottom: BorderSide(
          color: Colors.black38,
          width: 0.2,
        ),
      ),
    );
  }
}

class TitleAppBar extends StatelessWidget implements PreferredSizeWidget {
  const TitleAppBar({Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      backgroundColor: Colors.white,
      elevation: 0,
      // shape: Border(
      //   bottom: BorderSide(
      //     color: Colors.grey,
      //     width: 0.2,
      //   ),
      // ),
      title: const Text(
        'PuddyBuddy',
        style: TextStyle(
            color: Colors.black,
            fontFamily: 'Inter',
            fontSize: 23,
            fontWeight: FontWeight.w900,
            fontStyle: FontStyle.italic),
      ),
    );
  }
}
