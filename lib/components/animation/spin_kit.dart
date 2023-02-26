import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

mixin DoubleBouncingAnimation {
  Widget doubleBouncingSpinner() => SpinKitDoubleBounce(
        itemBuilder: (context, index) => const CircleAvatar(
          backgroundColor: Colors.black12,
        ),
      );
}
