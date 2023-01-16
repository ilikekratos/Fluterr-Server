import 'package:flutter_mycrud/model/MyOrderModel.dart';

abstract class OrderRepository {
  Future<List<MyOrderModel>>getRepo();
  void incrementId();
  Future<MyOrderModel> addOrder(MyOrderModel orderModel);
  Future<void> deleteOrder(int? id);
  Future<void> updateOrder(MyOrderModel order);
  Future<MyOrderModel>findById(int? id);
  Future<void> populate(List<MyOrderModel> items);
}