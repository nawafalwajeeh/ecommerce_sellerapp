import 'package:ecommerce_sellerapp/const/const.dart';
import 'package:ecommerce_sellerapp/controllers/home_controller.dart';
import 'package:ecommerce_sellerapp/views/home_screen/home_screen.dart';
import 'package:ecommerce_sellerapp/views/orders_screen/orders_screen.dart';
import 'package:ecommerce_sellerapp/views/products_screen/products_screen.dart';
import 'package:ecommerce_sellerapp/views/profile_screen/profile_screen.dart';
import 'package:ecommerce_sellerapp/views/widgets/text_style.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(HomeController());

    var navScreen = [
      const HomeScreen(),
      const ProductsScreen(),
      const OrdersScreen(),
      const ProfileScreen()
    ];

    var bottomNavbar = [
      const BottomNavigationBarItem(icon: Icon(Icons.home), label: dashboard),
      BottomNavigationBarItem(
          icon: Image.asset(icProducts, color: darkGrey, width: 24),
          label: products),
      BottomNavigationBarItem(
          icon: Image.asset(icOrders, width: 24, color: darkGrey),
          label: orders),
      BottomNavigationBarItem(
          icon: Image.asset(icGeneralSettings, width: 24, color: darkGrey),
          label: settings),
    ];

    return Scaffold(
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          onTap: (index) {
            controller.navIndex.value = index;
          },
          currentIndex: controller.navIndex.value,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: purpleColor,
          unselectedItemColor: darkGrey,
          items: bottomNavbar,
        ),
      ),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: boldText(text: dashboard, color: fontGrey, size: 18.0),
      ),
      body: Obx(
        () => Column(
          children: [
            Expanded(
              child: navScreen.elementAt(controller.navIndex.value),
            ),
          ],
        ),
      ),
    );
  }
}
