import 'package:flutter/cupertino.dart';
const  String OrderTable= 'orders';
class OrderFields {
  static final String id="id";
  static final String products="products";
  static final String adress="adress";
  static final String phone="phone";
}
class MyOrderModel extends ChangeNotifier{
   int? id;
   String products;
   String adress;
   String phone;
  MyOrderModel.empty({
    this.id=1,
    required this.products,
    required this.adress,
    required this.phone
  });
   MyOrderModel.all({
     required this.id,
     required this.products,
     required this.adress,
     required this.phone
   });

  void fun(){
    print("Ceva");
  }

  Map<String,Object?>toJson()=>{
    OrderFields.id:id,
    OrderFields.products:products,
    OrderFields.adress:adress,
    OrderFields.phone:phone
};
  MyOrderModel copy({
    int? id,
    String? products,
    String? phone,
    String? adress

  })=>MyOrderModel.empty(
    id: id ?? this.id,
    products: products ?? this.products,
    adress: adress ?? this.adress,
    phone: phone ?? this.phone,
  );
   factory MyOrderModel.fromJson(Map<String, dynamic> json) {
     var order = MyOrderModel.all(
       id: json['id'],
       products: json['products'],
       adress: json['adress'],
       phone: json['phone'],
     );
     return order;
   }
}