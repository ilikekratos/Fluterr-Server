import 'package:flutter/material.dart';
import 'package:flutter_mycrud/viewModels/HomeViewModel.dart';
import 'package:provider/provider.dart';

import 'model/MyOrderModel.dart';
class AddPage extends StatefulWidget {
  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  late HomeViewModel _homeViewModel;
  @override
  void initState() {
    _homeViewModel = Provider.of<HomeViewModel>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _homeViewModel.fetchData();
      for(var i = 0; i < _homeViewModel.orders.length; i++){
        print(i.toString()+_homeViewModel.orders[i].phone);
      }
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {


    final controlProducts=TextEditingController();
    final controlAdress=TextEditingController();
    final controlPhone=TextEditingController();
    return Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(padding: EdgeInsets.only(top: 100),
                  child:
                  Center(
                      child: Text("Add Order",style: TextStyle(color: Colors.black, fontSize: 45))
                      )
              ),
              Padding(padding: EdgeInsets.only(top: 60),
              child:
              Center(
                  child: TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'products',
                    hintText: 'Enter products'),
                    style: TextStyle(fontSize: 30),
                    controller: controlProducts,
              ))
              ),
              Padding(padding: EdgeInsets.only(top: 0),
                  child:
                  Center(
                      child: TextField(
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'phone',
                            hintText: 'Enter phone number'),
                          style: TextStyle(fontSize: 30),
                        controller: controlPhone,
                      ))
              ),
              Padding(padding: EdgeInsets.only(top: 0),
                  child:
                  Center(
                      child: TextField(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'adress',
                              hintText: 'Enter delivery adress'),
                          style: TextStyle(fontSize: 30),
                        controller: controlAdress,
                      ))
              ),
              Container(
                margin: const EdgeInsets.only(
                    left: 15.0, right: 15.0, top: 60, bottom: 0),
                height: 50,
                width: 250,
                decoration: BoxDecoration(
                    color: Colors.blue, borderRadius: BorderRadius.circular(20)),
                child: TextButton(

                  onPressed: () {

                    //print(controlUsername.text=="username"&&controlPassword.text=="parola");
                    if(controlAdress.text==""||controlPhone.text==""||controlProducts=="")
                      showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          title: const Text('Something went wrong'),
                          content: const Text('One of the fields is empty'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () => Navigator.pop(context, 'OK'),
                              child: const Text('OK'),
                            ),
                          ],
                        ),
                      );
                    else
                      if(controlPhone.text.contains(RegExp(r'[^0123456789]')))
                        showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            title: const Text('Something went wrong'),
                            content: const Text('Phone number should contain only numbers'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () => Navigator.pop(context, 'OK'),
                                child: const Text('OK'),
                              ),
                            ],
                          ),
                        );

                      else{
                            _homeViewModel.add(MyOrderModel.empty(products:controlProducts.text,adress: controlAdress.text,phone:controlPhone.text));
                            showDialog<String>(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                title: const Text('Success'),
                                content: const Text('You added an order successfully'),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () => Navigator.pop(context, 'OK'),
                                    child: const Text('OK'),
                                  ),
                                ],
                              ),
                            );
                      }

                    //Navigator.of(context).pushNamedAndRemoveUntil('/home',(Route<dynamic> route) => false);

                  },
                  child: Text(
                    'Add Order',
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                ),
              ),
              Container()
            ],

          ),
        )
    );
  }
}