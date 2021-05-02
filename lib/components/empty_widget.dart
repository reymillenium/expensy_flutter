// Packages:
import 'package:flutter/material.dart';
import 'dart:math'; // Allows to use: random
import 'dart:convert'; // Allows to use: base64UrlEncode
import 'package:intl/intl.dart'; // Allows to use: DateFormat
import 'package:empty_widget/empty_widget.dart';

// Screens:

// Models:
import 'package:expensy_flutter/models/transaction.dart';

// Components:
import 'package:expensy_flutter/components/transaction_tile.dart';

// Helpers:

// Utilities:

class EmptyWidget extends StatelessWidget {
  // Properties:
  final String image;
  final int packageImage;
  final String title;
  final String subTitle;

  // Constructor:
  EmptyWidget({
    this.image,
    this.packageImage,
    this.title,
    this.subTitle,
  });

  PackageImage getPackageImage(int packageImage) {
    switch (packageImage) {
      case 1:
        return PackageImage.Image_1;
        break;
      case 2:
        return PackageImage.Image_2;
        break;
      case 3:
        return PackageImage.Image_3;
        break;
      case 4:
        return PackageImage.Image_4;
        break;
      default:
        return PackageImage.Image_1;
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return EmptyListWidget(
      image: image,
      packageImage: getPackageImage(packageImage),
      title: title,
      subTitle: subTitle,
      titleTextStyle: TextStyle(
        fontSize: 22,
        color: Color(0xff9da9c7),
        fontWeight: FontWeight.w500,
      ),
      subtitleTextStyle: TextStyle(
        fontSize: 14,
        color: Color(0xffabb8d6),
      ),
    );
  }
}
