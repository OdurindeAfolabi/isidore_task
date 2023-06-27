import 'package:flutter/material.dart';

import '../widgets/d_loader.dart';

void showLoader(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (_) => const Dialog(
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.zero,
      child: SizedBox(
        width: double.maxFinite,
        height: double.maxFinite,
        child: DLoader(),
      ),
    ),
  );
}
