import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mycrud/model/MyOrderModel.dart';


class OrderList extends StatelessWidget {
  OrderList(this.orders, this.onEdit, this.onDelete);

  List<MyOrderModel> orders;
  final void Function(int?) onEdit;
  final void Function(int?) onDelete;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: orders.length,
        itemBuilder: (context, index) {
          MyOrderModel item = orders.elementAt(index);
          return ListTile(
              minVerticalPadding: 15,
              title: Text("Order id :" +item.id.toString(),style: TextStyle(fontSize: 30)),
              tileColor: Colors.blue[10],
              leading: IconButton(onPressed: () {
                onEdit(item.id);
              }, icon: const Icon(Icons.edit)),
              trailing:
              IconButton(onPressed: () {
                onDelete(item.id);
              }, icon: const Icon(Icons.remove_circle_outline)),
              subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.only(top: 5),
                      child: Text("Products:"+item.products,style: TextStyle(fontSize: 20)),
                    ),
                    Container(
                      child: Text("Phone Number:"+item.phone,style: TextStyle(fontSize: 20)),
                    ),
                    Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          Text("Adress: "+item.adress,style: TextStyle(fontSize: 20),)
                        ])
                  ]));
        });
  }
}
