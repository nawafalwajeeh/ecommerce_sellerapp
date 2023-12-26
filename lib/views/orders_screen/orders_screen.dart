import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_sellerapp/const/const.dart';
import 'package:ecommerce_sellerapp/services/store_services.dart';
import 'package:ecommerce_sellerapp/views/widgets/appbar_widget.dart';
import 'package:ecommerce_sellerapp/views/widgets/loading_indicator.dart';
import 'package:ecommerce_sellerapp/views/widgets/text_style.dart';
import 'package:ecommerce_sellerapp/controllers/orders_controller.dart';
import 'package:intl/intl.dart' as intl;

import 'order_details.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(OrdersController());

    return Scaffold(
      appBar: appbarWidget(orders),
      body: StreamBuilder(
        stream: StoreServices.getOrder(currentUser!.uid),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return loadingIndicator();
          } else if (snapshot.data!.docs.isEmpty) {
            return "No Orders yet!".text.color(darkGrey).makeCentered();
          } else {
            var data = snapshot.data!.docs;

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: List.generate(
                    data.length,
                    (index) {
                      var time = data[index]['order_date'].toDate();
                      if (snapshot.data!.docs.isEmpty) {
                        return loadingIndicator();
                      } else {
                        return ListTile(
                          onTap: () {
                            Get.to(() => OrderDetails(data: data[index]));
                          },
                          tileColor: textfieldGrey,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          title: boldText(
                              text: "${data[index]['order_code']}",
                              color: purpleColor),
                          subtitle: Column(
                            children: [
                              Row(
                                children: [
                                  const Icon(Icons.calendar_month,
                                      color: fontGrey),
                                  10.widthBox,
                                  boldText(
                                    text: intl.DateFormat()
                                        .add_yMd()
                                        .format(time),
                                    color: fontGrey,
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  const Icon(Icons.payment, color: fontGrey),
                                  10.widthBox,
                                  boldText(text: unpaid, color: red),
                                ],
                              ),
                            ],
                          ),
                          trailing: boldText(
                              text: "\$ ${data[index]['total_amount']}",
                              color: purpleColor,
                              size: 16.0),
                        ).box.margin(const EdgeInsets.only(bottom: 4.0)).make();
                      }
                    },
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
