import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mycrud/ListView.dart';
import 'package:flutter_mycrud/model/MyOrderModel.dart';
import 'package:flutter_mycrud/viewModels/HomeViewModel.dart';
import 'package:provider/provider.dart';

class ViewPage extends StatefulWidget {
  @override
  _ViewPageState createState() => _ViewPageState();
}

class _ViewPageState extends State<ViewPage> {
  late HomeViewModel _homeViewModel;
  @override
  void initState() {
    _homeViewModel = Provider.of<HomeViewModel>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _homeViewModel.fetchData();
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            SizedBox(height: 25,),
            const Text("My orders",style: TextStyle(fontSize: 35),textAlign: TextAlign.center,),
            SizedBox(height: 25,),
            Expanded(

             child:
              Consumer<HomeViewModel>(builder: (_, model, child) {
                return OrderList(model.orders, (id) {
                Navigator.pushNamed(context, "/edit",
                arguments: id);
                }, (id) {
                  showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      title: const Text('Confirmation'),
                      content: const Text('Are you sure you want to delete?'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () => {_homeViewModel.delete(id!),Navigator.pop(context)},
                          child: const Text('YES'),
                        ),
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('NO'),
                        )
                      ],
                    ),
                  );

                });
                }),




            )

          ]
        ),
      ),
    );
  }

}