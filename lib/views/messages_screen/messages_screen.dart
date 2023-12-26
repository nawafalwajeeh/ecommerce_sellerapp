import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_sellerapp/const/const.dart';
import 'package:ecommerce_sellerapp/services/store_services.dart';
import 'package:ecommerce_sellerapp/views/messages_screen/chat_screen.dart';
import 'package:ecommerce_sellerapp/views/widgets/loading_indicator.dart';
import 'package:ecommerce_sellerapp/views/widgets/text_style.dart';
import 'package:intl/intl.dart ' as intl;

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            color: darkGrey,
            onPressed: () {
              Get.back();
            }),
        title: boldText(text: messages, size: 16.0, color: fontGrey),
      ),
      body: StreamBuilder(
        stream: StoreServices.getAllMessages(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: loadingIndicator(circleColor: purpleColor),
            );
          } else if (snapshot.data!.docs.isEmpty) {
            return "No Messages yet!".text.color(darkGrey).makeCentered();
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
                      var t = data[index]['created_on'] == null
                          ? DateTime.now()
                          : data[index]['created_on'].toDate();
                      var time = intl.DateFormat("h:mma").format(t);

                      return ListTile(
                        onTap: () {
                          Get.to(() => const ChatScreen(), arguments: [
                            data[index]['friend_name'],
                            data[index]['fromId']
                          ]);
                        },
                        leading: const CircleAvatar(
                          backgroundColor: purpleColor,
                          child: Icon(
                            Icons.person,
                            color: white,
                          ),
                        ),
                        title: boldText(
                            text: "${data[index]['friend_name']}",
                            color: fontGrey),
                        subtitle: normalText(
                            text: "${data[index]['last_msg']}",
                            color: darkGrey),
                        trailing: normalText(text: time, color: darkGrey),
                      );
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
