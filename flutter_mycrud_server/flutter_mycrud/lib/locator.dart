import 'package:flutter_mycrud/Repo/OrderRepository.dart';
import 'package:flutter_mycrud/Repo/OrderRepositoryImpl.dart';
import 'package:flutter_mycrud/db/OrderDatabase.dart';
import 'package:get_it/get_it.dart';

final GetIt locator = GetIt.instance;
void setupLocator(){
  locator.registerFactory<OrderRepository>(()=>OrderRepositoryImpl());
}