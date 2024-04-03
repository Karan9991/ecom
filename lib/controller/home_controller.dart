import 'package:ecom/data/fetchData.dart';
import 'package:get/get.dart';

class HomeController extends GetxController{

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
   // _initialize();
  }

  Future<void> _initialize() async{
    await FetchData().fetchProducts();
    await FetchData().fetchFavourites();
    await FetchData().fetchProductsDocumentId();
    await FetchData().fetchUser();
    await FetchData().fetchCart();
  }

  
}