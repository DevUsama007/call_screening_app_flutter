import 'package:flutter/material.dart';

class CustomBottomSheet {
  static Future<void> show({
    required BuildContext context,
    required Widget child,
    bool isDismissible = true,
    bool enableDrag = true,
    double? height,
  }) {
    return showModalBottomSheet(
      context: context,
      isDismissible: isDismissible,
      enableDrag: enableDrag,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) {
        return AnimatedPadding(
          // This padding will adjust automatically when the keyboard opens
          padding: MediaQuery.of(context).viewInsets,
          duration: const Duration(milliseconds: 250),
          curve: Curves.decelerate,
          child: Container(
            height: height ?? MediaQuery.of(context).size.height * 0.8,
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 46, 45, 45),
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            padding: const EdgeInsets.all(16),
            child: child,
          ),
        );
      },
    );
  }
}
