import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_mycrud/Repo/OrderRepository.dart';
import 'package:flutter_mycrud/model/MyOrderModel.dart';
import 'package:flutter_mycrud/server/HttpHelper.dart';
import 'package:sqflite/sqflite.dart';
import 'package:logging/logging.dart';
import '../db/OrderDatabase.dart';
import 'dart:developer' as developer;
class HomeViewModel extends ChangeNotifier{
  final log = Logger('HomeViewModel');
  HomeViewModel({required this.orderRepo});
  List<MyOrderModel> orders = [];
  final OrderRepository orderRepo;

  Future<void> fetchData() async {
    log.info("Retrieving orders");
    List<MyOrderModel>? items = [];
    // try {
    //   items = await OrderDatabase.getAll();
    //   if (items == null) {
    //     return;
    //   }
    // } on DatabaseException catch(ex) {
    //   developer.log(ex.toString());
    //   throw Exception("Cannot fetch data");
    // }
    try {
      items = await HttpHelper.get();
    } on Exception catch(ex) {
      log.severe(ex.toString());
      throw Exception("Cannot fetch data");
    }
    await orderRepo.populate(items);
    orders = await orderRepo.getRepo();
    notifyListeners();
  }



  Future<void> add(MyOrderModel order) async {
    log.info("Adding an order: ${order.toJson()}.");
    MyOrderModel createdOrder;
    try {
      createdOrder = await HttpHelper.create(order);
    } on Exception catch(ex) {
      log.severe(ex.toString());
      throw Exception("Cannot add data");
    }
      // try {
      //   int id = await OrderDatabase.add(orderModel);
      //   orderModel.id = id;
      // } on DatabaseException catch(ex) {
      //   developer.log(ex.toString(), name: runtimeType.toString());
      //   throw Exception("Cannot add data");
      // }
    await orderRepo.addOrder(order);
    notifyListeners();
    print("Hey ");
  }
  Future<MyOrderModel> findById(int id) async {
    log.info("Finding order by id: $id.");
    return orderRepo.findById(id);
    // return orderRepo.findById(id);
  }
  Future<void> update(MyOrderModel order) async {
    log.info("Updating an order: ${order.toJson()}.");
    try {
      await HttpHelper.update(order);
    } on Exception catch(ex) {
      log.severe(ex.toString());
      throw Exception("Cannot update order");
    }
    await orderRepo.updateOrder(order);
    int index = orders.indexWhere((element) => element.id == order.id);
    orders[index] = order;
    notifyListeners();
  }
  Future<void> delete(int id) async {
    log.info("Deleting an order with id: $id.");
    try {
      await HttpHelper.delete(id);
    } on Exception catch(ex) {
      log.severe(ex.toString());
      throw Exception("Cannot delete order");
    }
    await orderRepo.deleteOrder(id);
    orders.removeWhere((element) => element.id == id);
    notifyListeners();
  }
}