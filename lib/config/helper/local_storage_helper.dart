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
    await Hive.openBox('UserData');
  }
  static dynamic getValue(String key){
    return _shared.hiveBox?.get(key);
  }
  static setValue(String key, dynamic value){
    _shared.hiveBox?.put(key, value);
  }
  static createLocalStorageWithBox(String boxName) async{
    await Hive.openBox(boxName);
  }
  static openLocalStorageWithBox(String boxName) async{
    return Hive.box(boxName);
  }
  static dynamic getValueWithBox(String boxName,String key){
    return Hive.box(boxName).get(key);
  }
  static setValueWithBox(String boxName,String key, dynamic value) async {
    await Hive.box(boxName).put(key, value);
  }
}