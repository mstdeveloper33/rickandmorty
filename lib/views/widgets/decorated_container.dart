// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class DecoratedContainer extends StatelessWidget {
  final Widget child;
  final Widget topChild;
  const DecoratedContainer({
    Key? key,
    required this.child,
    required this.topChild,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/bg-image.png"),
          alignment: Alignment.topCenter,
          fit: BoxFit.fitWidth,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(50),
                ),
              ),
              child: child,
            ),
          ),
        ],
      ),
    );
  }
}
