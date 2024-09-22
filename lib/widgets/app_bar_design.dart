import 'package:flutter/material.dart';

class AppBarDesign extends StatelessWidget implements PreferredSizeWidget {
  final List<Widget>? actions;

  const AppBarDesign({super.key, this.actions});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color.fromARGB(255, 30, 44, 78),
      title: const Text(
        "TIG333 TODO",
        style: TextStyle(fontFamily: "Verdana", fontWeight: FontWeight.w700),
      ),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(40.0);
}
