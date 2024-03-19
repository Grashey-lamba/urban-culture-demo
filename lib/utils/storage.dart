import 'package:get_storage/get_storage.dart';

void setData(String key, dynamic value) => GetStorage().write(key, value);

dynamic getData(String key) => GetStorage().read(key);

dynamic deleteData(String key) => GetStorage().remove(key);

void clearData() async => GetStorage().erase();
