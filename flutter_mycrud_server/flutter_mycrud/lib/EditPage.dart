import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mycrud/model/MyOrderModel.dart';
import 'package:flutter_mycrud/viewModels/HomeViewModel.dart';

import 'package:provider/provider.dart';


class EditPage extends StatefulWidget {
  const EditPage({Key? key}) : super(key: key);

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  final _formKey = GlobalKey<FormState>();

  final _productsController = TextEditingController();
  final _phoneController = TextEditingController();
  final _adressController = TextEditingController();

  late HomeViewModel _homeViewModel;
  MyOrderModel _order = MyOrderModel.empty(products: "", adress: "", phone: "");

  @override
  void initState() {
    _order = MyOrderModel.empty(products: "", adress: "", phone: "");
    _homeViewModel = Provider.of<HomeViewModel>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final id = ModalRoute.of(context)!.settings.arguments as int?;
      if (mounted) {
        var order = await _homeViewModel.findById(id!);
        setState(() {
          _order = order;
          _productsController.value = TextEditingValue(text: _order.products);
          _adressController.value = TextEditingValue(text: _order.adress);
          _phoneController.value = TextEditingValue(text: _order.phone);

        });
      }
    });
    print(_productsController.text);
    super.initState();
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _adressController.dispose();
    _productsController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(padding: EdgeInsets.only(top: 100),
                  child:
                  Center(
                      child: Text("Edit Order",style: TextStyle(color: Colors.black, fontSize: 45))
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
                        controller: _productsController,
                      ))
              ),

              Padding(padding: EdgeInsets.only(top: 15),
                  child:
                  Center(
                      child: TextField(
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'phone',
                            hintText: 'Enter phone number'),
                        style: TextStyle(fontSize: 30),
                        controller: _phoneController,
                      ))
              ),
              Padding(padding: EdgeInsets.only(top: 25),
                  child:
                  Center(
                      child: TextField(
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'adress',
                            hintText: 'Enter delivery adress'),
                        style: TextStyle(fontSize: 30),
                        controller: _adressController,
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
                    if(_adressController.text==""||_phoneController.text==""||_productsController=="")
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
                    if(_phoneController.text.contains(RegExp(r'[^0123456789]')))
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
                      var sendOrder=MyOrderModel.empty(id:_order.id,products:_productsController.text,adress:_adressController.text,phone: _phoneController.text);
                      _homeViewModel.update(sendOrder);
                      showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          title: const Text('Success'),
                          content: const Text('You updated an order successfully'),
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
                    'Update Order',
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