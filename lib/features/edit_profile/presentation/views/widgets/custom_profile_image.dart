import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../../constants.dart';

class CustomProfileImage extends StatelessWidget {
  const CustomProfileImage({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(70)),
      child: Container(
        height: 110,
        width: 110,
        decoration: const BoxDecoration(shape: BoxShape.circle),
        child: CachedNetworkImage(
          fit: BoxFit.cover,
          placeholder:
              (context, url) =>
                  const CircularProgressIndicator(color: kPrimaryColor),
          errorWidget: (context, url, error) => const Icon(Icons.error),
          imageUrl:
              'https://cdn.psychologytoday.com/sites/default/files/styles/article-inline-half-caption/public/field_blog_entry_images/2018-09/shutterstock_648907024.jpg?itok=0hb44OrI',
        ),
      ),
    );
  }
}
