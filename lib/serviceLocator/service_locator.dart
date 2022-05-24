import 'package:get_it/get_it.dart';

GetIt serviceLocator = GetIt.instance;

void setupLocator() {
  // register the singleton instances of the class here in this method that the get it will provide lazily
}

// MQTTManager singletonMqttInstance() {
//   //Creates singleton instance of MQTTManager class
//   MQTTManager singletonInstance = servicelocator<MQTTManager>();
//   return singletonInstance;
// }