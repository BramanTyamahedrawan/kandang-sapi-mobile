import 'package:get_storage/get_storage.dart';

class ReadHowLogin {
  final myStorage = GetStorage();

  String? get role => myStorage.read('role');
}
