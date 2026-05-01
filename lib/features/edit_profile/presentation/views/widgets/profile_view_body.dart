import 'package:cheif_homemade_food/core/widgets/custom_button.dart';
import 'package:cheif_homemade_food/features/edit_profile/presentation/views/widgets/profile_info_item.dart';
import 'package:flutter/material.dart';
import '../../../../../constants.dart';
import '../../../../../core/utilities/styles.dart';
import 'custom_profile_image.dart';

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
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Stack(
              children: [
                CustomProfileImage(),
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
            const SizedBox(height: 14),
            Text(
              "Maria's Italian Kitchen",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Styles.textStyle20.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 2),
            Text(
              "emma209@gmail.com",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Styles.textStyle14.copyWith(color: Colors.grey),
            ),
            const SizedBox(height: 12),
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
            const SizedBox(height: 10),
            const Divider(
              endIndent: 15,
              indent: 15,
              thickness: 0.8,
              color: Colors.grey,
            ),
            const SizedBox(height: 10),
            Container(
              width: double.infinity,
              constraints: const BoxConstraints(minHeight: 120),
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
                    height: 25,
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
            const SizedBox(height: 14),
            ProfileInfoItem(
              icon: Icons.location_on_outlined,
              title: "Location",
              trailing: "Rome, Italy",
            ),
            const SizedBox(height: 10),
            ProfileInfoItem(
              title: "Customer Rating",
              trailing: "4.9",
              icon: Icons.star_outline,
            ),
            const SizedBox(height: 10),
            ProfileInfoItem(
              title: "Phone Number",
              trailing: "01150704967",
              icon: Icons.phone_outlined,
            ),
            const SizedBox(height: 24),
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
