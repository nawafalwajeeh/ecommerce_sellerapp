import 'package:ecommerce_sellerapp/const/const.dart';
import 'package:ecommerce_sellerapp/controllers/products_controller.dart';
import 'package:ecommerce_sellerapp/views/products_screen/components/product_images.dart';
import 'package:ecommerce_sellerapp/views/widgets/custom_textfield.dart';
import 'package:ecommerce_sellerapp/views/widgets/loading_indicator.dart';
import 'package:ecommerce_sellerapp/views/widgets/text_style.dart';

import 'components/product_dropdown.dart';

class AddProduct extends StatelessWidget {
  const AddProduct({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProductsController>();
    return Obx(
      () => Scaffold(
        backgroundColor: purpleColor,
        appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(
                Icons.arrow_back,
              ),
            ),
            title: boldText(text: "Add Product", size: 16.0),
            actions: [
              controller.isloading.value
                  ? loadingIndicator(circleColor: white)
                  : TextButton(
                      onPressed: () async {
                        controller.isloading(true);
                        await controller.uploadImages();
                        await controller.uploadProduct(context);
                        Get.back();
                      },
                      child: boldText(text: save, color: white)),
            ]),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              customTextField(
                  hint: "eg. BMW",
                  label: "Product name",
                  controller: controller.pnameController),
              10.heightBox,
              customTextField(
                  hint: "eg. Nice Product",
                  label: "Description",
                  isDesc: true,
                  controller: controller.pdescController),
              10.heightBox,
              customTextField(
                  hint: "eg. \$100",
                  label: "Price",
                  controller: controller.ppriceController),
              10.heightBox,
              customTextField(
                  hint: "eg. 20",
                  label: "Quantity",
                  controller: controller.pquantityController),
              10.heightBox,
              productDropdown(
                hint: "Category",
                list: controller.categoryList,
                dropvalue: controller.categoryValue,
                controller: controller,
              ),
              10.heightBox,
              productDropdown(
                hint: "Subcategory",
                list: controller.subcategoryList,
                dropvalue: controller.subcategoryValue,
                controller: controller,
              ),
              10.heightBox,
              const Divider(color: white),
              boldText(text: "Choose product images"),
              10.heightBox,
              Obx(
                () => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: List.generate(
                    3,
                    (index) => controller.pImagesList[index] != null
                        ? Image.file(
                            controller.pImagesList[index],
                            width: 100,
                          ).onTap(() {
                            controller.pickImage(index, context);
                          })
                        : productImages(label: "${index + 1}").onTap(() {
                            controller.pickImage(index, context);
                          }),
                  ),
                ),
              ),
              5.heightBox,
              normalText(
                text: "First image will be your display image",
                color: lightGrey,
              ),
              const Divider(color: white),
              10.heightBox,
              boldText(text: "Choose product colors"),
              10.heightBox,
              Obx(
                () => Wrap(
                  spacing: 8.0,
                  runSpacing: 8.0,
                  children: List.generate(
                    9,
                    (index) => Stack(
                      alignment: Alignment.center,
                      children: [
                        VxBox()
                            .color(Vx.randomPrimaryColor)
                            .roundedFull
                            .size(65, 65)
                            .make()
                            .onTap(() {
                          controller.selectedColorIndex.value = index;
                        }),
                        controller.selectedColorIndex.value == index
                            ? const Icon(
                                Icons.done,
                                color: white,
                              )
                            : const SizedBox(),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
