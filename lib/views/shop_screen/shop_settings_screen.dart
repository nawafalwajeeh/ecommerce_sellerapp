import 'package:ecommerce_sellerapp/const/const.dart';
import 'package:ecommerce_sellerapp/controllers/profile_controller.dart';
import 'package:ecommerce_sellerapp/views/widgets/custom_textfield.dart';
import 'package:ecommerce_sellerapp/views/widgets/loading_indicator.dart';
import 'package:ecommerce_sellerapp/views/widgets/text_style.dart';

class ShopSettings extends StatelessWidget {
  const ShopSettings({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProfileController>();
    return Scaffold(
      backgroundColor: purpleColor,
      appBar: AppBar(
        title: boldText(text: shopSettings, size: 16.0),
        actions: [
          controller.isLoading.value
              ? loadingIndicator(circleColor: white)
              : TextButton(
                  onPressed: () async {
                    controller.isLoading(true);
                    await controller.updateShop(
                      shopname: controller.shopNameController.text,
                      shopaddress: controller.shopAddressController.text,
                      shopmobile: controller.shopMobileController.text,
                      shopwebsite: controller.shopWebsiteController.text,
                      shopdesc: controller.shopDesController.text,
                    );
                    VxToast.show(context, msg: "Shop updated");
                  },
                  child: normalText(text: save),
                ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            customTextField(
              label: shopName,
              hint: nameHint,
              controller: controller.shopNameController,
            ),
            10.heightBox,
            customTextField(
              label: address,
              hint: shopAddressHint,
              controller: controller.shopAddressController,
            ),
            10.heightBox,
            customTextField(
              label: mobile,
              hint: shopMobileHint,
              controller: controller.shopMobileController,
            ),
            10.heightBox,
            customTextField(
              label: website,
              hint: shopWebsiteHint,
              controller: controller.shopWebsiteController,
            ),
            10.heightBox,
            customTextField(
              label: description,
              hint: shopDescHint,
              isDesc: true,
              controller: controller.shopDesController,
            ),
          ],
        ),
      ),
    );
  }
}
