import 'package:flutter/material.dart';

class AppbarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool transparentBackground;
  const AppbarWidget(
      {super.key, required this.title, this.transparentBackground = false});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: transparentBackground ? Colors.transparent : null,
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w500,
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.settings),
          onPressed: () {},
        ),
      ],
    );
  }
  
  @override
  Size get preferredSize => const Size.fromHeight(56); 
}
