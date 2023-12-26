import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_sellerapp/const/const.dart';
import 'package:ecommerce_sellerapp/controllers/auth_controller.dart';
import 'package:ecommerce_sellerapp/controllers/profile_controller.dart';
import 'package:ecommerce_sellerapp/services/store_services.dart';
import 'package:ecommerce_sellerapp/views/auth_screen/login_screen.dart';
import 'package:ecommerce_sellerapp/views/messages_screen/messages_screen.dart';
import 'package:ecommerce_sellerapp/views/profile_screen/edit_profile_screen.dart';
import 'package:ecommerce_sellerapp/views/shop_screen/shop_settings_screen.dart';
import 'package:ecommerce_sellerapp/views/widgets/loading_indicator.dart';
import 'package:ecommerce_sellerapp/views/widgets/text_style.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProfileController());
    return Scaffold(
      backgroundColor: purpleColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: boldText(text: settings, size: 16.0),
        actions: [
          IconButton(
              onPressed: () {
                Get.to(
                  () => EditProfileScreen(
                    username: controller.snapshotData['vendor_name'],
                  ),
                );
              },
              icon: const Icon(Icons.edit)),
          TextButton(
              onPressed: () async {
                await Get.find<AuthController>().signoutMethod(context);
                Get.offAll(() => const LoginScreen());
              },
              child: normalText(text: logout)),
        ],
      ),
      body: FutureBuilder(
        future: StoreServices.getProfile(currentUser!.uid),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return loadingIndicator(circleColor: white);
          } else if (snapshot.data!.docs.isEmpty) {
            return loadingIndicator(circleColor: white);
          } else {
            controller.snapshotData = snapshot.data!.docs[0];
            return Column(
              children: [
                ListTile(
                  leading: controller.snapshotData['imageUrl'] == ''
                      ? Image.asset(
                          imgProduct,
                          width: 100,
                          fit: BoxFit.cover,
                        )
                          .box //     .box
                          .roundedFull
                          .clip(Clip.antiAlias)
                          .make()
                      : Image.network(
                          controller.snapshotData['imageUrl'],
                          width: 100,
                        )
                          .box //     .box
                          .roundedFull
                          .clip(Clip.antiAlias)
                          .make(),
                  // Image.asset(imgProduct)

                  title: boldText(
                      text: "${controller.snapshotData['vendor_name']}"),
                  subtitle:
                      normalText(text: "${controller.snapshotData['email']}"),
                ),
                const Divider(),
                10.heightBox,
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: List.generate(
                        profileButtonsIcons.length,
                        (index) => ListTile(
                              onTap: () {
                                switch (index) {
                                  case 0:
                                    Get.to(() => const ShopSettings());
                                    break;
                                  case 1:
                                    Get.to(() => const MessagesScreen());
                                    break;
                                  default:
                                }
                              },
                              leading: Icon(profileButtonsIcons[index],
                                  color: white),
                              title:
                                  normalText(text: profileButtonsTitles[index]),
                            )),
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
