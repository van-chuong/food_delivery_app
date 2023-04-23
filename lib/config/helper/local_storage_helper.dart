import 'package:hive/hive.dart';

class LocalStorageHelper{
  LocalStorageHelper._internal();
  static LocalStorageHelper _shared = LocalStorageHelper._internal();
  factory LocalStorageHelper(){
    return _shared;
  }
  Box<dynamic> ? hiveBox;
  static initLocalStorageHelper() async{
    _shared.hiveBox = await Hive.openBox('FoodApp');
  }
  static dynamic getValue(String key){
    return _shared.hiveBox?.get(key);
  }
  static setValue(String key, dynamic value){
    _shared.hiveBox?.put(key, value);
  }
}