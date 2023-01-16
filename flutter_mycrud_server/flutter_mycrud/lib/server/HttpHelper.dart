import 'dart:convert';
import 'dart:ffi';
import 'package:flutter_mycrud/model/MyOrderModel.dart';
import 'package:logging/logging.dart';
import 'package:http/http.dart' as http;
class HttpHelper {
  static final log = Logger('HttpService');
  static final String API="http://192.168.1.3:8080";
  static Future<List<MyOrderModel>> get() async {
    log.info("Getting orders on: /orders");
    final response = await http
        .get(Uri.parse('$API/orders'));
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      List<dynamic> orders = jsonDecode(response.body);
      List<MyOrderModel> orderList = [];
      for (var order in orders) {
        orderList.add(MyOrderModel.fromJson(order));
      }
      return orderList;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      log.severe("Get method failed.");
      throw Exception('Failed to load orders');
    }

  }

  static Future<MyOrderModel> create(MyOrderModel order) async {
    log.info("Creating order (${order.toJson()}) on: /orders");
    final response = await http.post(
      Uri.parse('$API/orders'),
      body: json.encode(order.toJson()),
      headers: {"Content-Type": "application/json"},
    );
    if (response.statusCode != 200) {
      log.severe("Post method failed.");
      throw Exception('Failed to create order');
    }
    return MyOrderModel.fromJson(jsonDecode(response.body));
  }

  static Future<void> update(MyOrderModel order) async {
    log.info("Updating order (${order.toJson()}) on: /orders");
    final response = await http.put(
      Uri.parse('$API/orders'),
      body: json.encode(order.toJson()),
      headers: {"Content-Type": "application/json"},
    );
    if (response.statusCode != 200) {
      log.severe("Put method failed.");
      throw Exception('Failed to update order');
    }
  }

  static Future<void> delete(int id) async {
    log.info("Deleting order with id ($id) on: /orders/$id");
    final response = await http.delete(
      Uri.parse('$API/orders/$id'),
    );
    if (response.statusCode != 200) {
      log.severe("Delete method failed.");
      throw Exception('Failed to delete order');
    }
  }
}