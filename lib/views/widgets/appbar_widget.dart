import 'package:ecommerce_sellerapp/const/const.dart';
import 'package:ecommerce_sellerapp/views/widgets/text_style.dart';
import 'package:intl/intl.dart ' as intl;

AppBar appbarWidget(title) {
  return AppBar(
    backgroundColor: white,
    automaticallyImplyLeading: false,
    title: boldText(text: title, color: fontGrey, size: 16.0),
    actions: [
      Center(
        child: boldText(
          text: intl.DateFormat('EEE, MM d,' 'yy').format(DateTime.now()),
          color: purpleColor,
        ),
      ),
      10.heightBox,
    ],
  );
}
