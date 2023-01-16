import 'dart:async';
import 'dart:async';

import 'package:flutter_mycrud/Repo/OrderRepository.dart';
import 'package:flutter_mycrud/db/OrderDatabase.dart';

import '../model/MyOrderModel.dart';

class OrderRepositoryImpl implements OrderRepository{
  List<MyOrderModel> orderRepo=[];
  int nextId=0;
  OrderRepositoryImpl(){
    // MyOrderModel localOrder=MyOrderModel.empty(products:"Ex1",adress: "Ex1",phone: "072");
    // localOrder.uid=1;
    // addOrder(localOrder);
    // MyOrderModel localOrder2=MyOrderModel.empty(products: "Ex2",adress: "E1",phone: "0321");
    // localOrder.uid=1;
    // addOrder(localOrder2);
  }


  @override
  void incrementId(){
   nextId++;
  }

  @override
  Future <MyOrderModel> addOrder (MyOrderModel orderModel)async{
   orderModel.id=nextId;
   print("Check ids:$nextId");
   incrementId();
   orderRepo.add(orderModel);
   return orderModel;
  }

  @override
  Future<List<MyOrderModel>> getRepo() async{
    return orderRepo;
  }
  @override
  Future <MyOrderModel> findById(int? id)async{
    if (id == null) {
      throw Exception("Id is null");
    }
    MyOrderModel findOrder=orderRepo.firstWhere((element) => element.id==id);
    var returnOrder=MyOrderModel.empty(id:id,products:findOrder.products, adress:findOrder.adress,phone: findOrder.phone);
    return returnOrder;
  }
  @override
  Future<void> updateOrder(MyOrderModel item) async {
    int index = orderRepo.indexWhere((element) => element.id == item.id);
    orderRepo[index] = item;
  }

  @override
  Future<void> deleteOrder(int? id) async {
    if (id == null) {
      return;
    }
    orderRepo.removeWhere((element) => element.id == id);
  }
  @override
  Future<void> populate(List<MyOrderModel> items) async {
    orderRepo = items;
  }
 }