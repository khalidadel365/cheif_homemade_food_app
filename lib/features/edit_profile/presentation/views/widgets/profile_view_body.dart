import 'package:cached_network_image/cached_network_image.dart';
import 'package:cheif_homemade_food/core/widgets/custom_button.dart';
import 'package:flutter/material.dart';

import '../../../../../constants.dart';
import '../../../../../core/utilities/styles.dart';
import 'build_info_tile.dart';

class ProfileViewBody extends StatefulWidget {
  const ProfileViewBody({super.key});

  @override
  State<ProfileViewBody> createState() => _ProfileViewBodyState();
}

class _ProfileViewBodyState extends State<ProfileViewBody> {
  bool isOnline = false;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(70)),
                  child: Container(
                    height: 120,
                    width: 120,
                    decoration: const BoxDecoration(shape: BoxShape.circle),
                    child: CachedNetworkImage(
                      fit: BoxFit.cover,
                      placeholder:
                          (context, url) => const CircularProgressIndicator(
                            color: kPrimaryColor,
                          ),
                      errorWidget:
                          (context, url, error) => const Icon(Icons.error),
                      imageUrl:
                          'https://cdn.psychologytoday.com/sites/default/files/styles/article-inline-half-caption/public/field_blog_entry_images/2018-09/shutterstock_648907024.jpg?itok=0hb44OrI',
                    ),
                  ),
                ),
                Positioned(
                  bottom: 5,
                  right: 8,
                  child: Container(
                    height: 18,
                    width: 18,
                    decoration: BoxDecoration(
                      color: isOnline ? Colors.green : Colors.red,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 3),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              "Maria's Italian Kitchen",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Styles.textStyle20.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              "by Maria Rossi",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Styles.textStyle14.copyWith(color: Colors.grey),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                "Authentic, homemade Italian dishes crafted with love and the freshest local ingredients. From classic pasta to delicious desserts, every bite is a taste of Italy.",
                textAlign: TextAlign.center,
                maxLines: 5,
                overflow: TextOverflow.ellipsis,
                style: Styles.textStyle14.copyWith(
                  color: Colors.grey[700],
                  height: 1.5,
                ),
              ),
            ),
            const SizedBox(height: 18),
            const Divider(
              endIndent: 15,
              indent: 15,
              thickness: 0.8,
              color: Colors.grey,
            ),
            const SizedBox(height: 16),
            Container(
              width: double.infinity,
              constraints: const BoxConstraints(minHeight: 140),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Chef Status",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(height: 4),
                  SizedBox(
                    height: 40,
                    child: Text(
                      isOnline
                          ? "You are currently online to receive orders."
                          : "You are currently offline. Go online to receive orders.",
                      style: TextStyle(color: Colors.grey[600], fontSize: 14),
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 30,
                    width: 50,
                    child: Transform.scale(
                      scale: 0.9,
                      child: Switch(
                        value: isOnline,
                        trackOutlineColor: WidgetStateProperty.all(
                          Colors.transparent,
                        ),
                        thumbColor: WidgetStateProperty.all(Colors.white),
                        activeTrackColor: kPrimaryColor,
                        inactiveTrackColor: Colors.grey[300],
                        onChanged: (val) {
                          setState(() {
                            isOnline = val;
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: buildInfoTile(
                icon: Icons.location_on_outlined,
                iconColor: kSecondaryColor,
                iconWidgetColor: kPrimaryColor,
                title: "Location",
                trailing: "Rome, Italy",
              ),
            ),
            const SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: buildInfoTile(
                icon: Icons.star_border,
                iconColor: kSecondaryColor,
                iconWidgetColor: kPrimaryColor,
                title: "Customer Rating",
                trailing: "4.9",
              ),
            ),
            const SizedBox(height: 28),
            CustomButton(
              onPressed: () {},
              text: 'Edit Profile',
              textStyle: Styles.textStyle17.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
              backgroundColor: kPrimaryColor,
              borderRadius: 4,
            ),
            const SizedBox(height: 12),
            CustomButton(
              onPressed: () {},
              text: 'Logout',
              elevation: 0.5,
              textStyle: Styles.textStyle17.copyWith(
                color: Colors.grey,
                fontWeight: FontWeight.w600,
              ),
              backgroundColor: Colors.white,
              borderRadius: 4,
            ),
          ],
        ),
      ),
    );
  }
}
