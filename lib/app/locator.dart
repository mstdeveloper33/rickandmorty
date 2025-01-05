import 'package:get_it/get_it.dart';
import 'package:rickyandmorty/services/preferences_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/api_service.dart';


//! Burada getit paketini kullanarak servislerimizi register edeceğiz. Yani Api servislerinin çalışmasını sağlayacağız ama her seferinde oluşturmak yerine bir kere oluşturup her yerden erişebileceğimiz bir yapı oluşturacağız. Get burada aslında bir dependency injection paketi. Dependency injection, bir sınıfın başka bir sınıfı kullanabilmesi için ona bir nesne verilmesi işlemidir. Bu sayede sınıflar arasındaki bağımlılıklar azalır ve sınıfların test edilmesi kolaylaşır. GetIt ise bu işlemi yapmamızı sağlayan bir paket.Ayrıca main.dart dosyamızda bu locator.dart dosyasını import etmeyi unutmamamız gerekiyor.

//Dependency injection
final locator = GetIt.instance;

 Future <void> setupLocator() async {
  final prefs = await SharedPreferences.getInstance();
  locator.registerLazySingleton<PreferencesService>(() => PreferencesService(prefs : prefs));
  locator.registerLazySingleton<ApiService>(() => ApiService());
}