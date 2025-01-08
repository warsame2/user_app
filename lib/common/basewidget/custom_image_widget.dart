import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:user_app/utill/images.dart';

import '../../utill/app_constants.dart';

class CustomImageWidget extends StatelessWidget {
  final String image;
  final double? height;
  final double? width;
  final BoxFit? fit;
  final String? placeholder;
  final String? printt;
  const CustomImageWidget(
      {super.key,
      required this.image,
      this.height,
      this.width,
      this.fit = BoxFit.cover,
      this.placeholder = Images.placeholder, this.printt});

  @override
  Widget build(BuildContext context) {
    if(printt != null) print('image $printt:_______________________ $image ___________');
    return 
    // Image.network(image);
    CachedNetworkImage(
      placeholder: (context, url) => Image.asset(
          placeholder ?? Images.placeholder,
          height: height,
          width: width,
          fit: BoxFit.cover),
      imageUrl: image,
      fit: fit ?? BoxFit.cover,
      height: height,
      width: width,
      errorWidget: (c, o, s) => Image.asset(placeholder ?? Images.placeholder,
          height: height, width: width, fit: BoxFit.cover),
    );
  }
}
