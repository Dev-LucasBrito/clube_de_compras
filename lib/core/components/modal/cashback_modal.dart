import 'package:flutter/material.dart';

class CashbackModals {
  static modalWidgetListColumn(context, List<Widget> widget) {
    return showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 200,
          color: Colors.white,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: widget
            ),
          ),
        );
      },
    );
  }
}
