import 'package:sky_scrapper/header.dart';

class HomeProvider with ChangeNotifier {
  bool isDark = false;
  WetherModel? wetherModel;
  List<String> searchHistory = [];
  List<WetherModel> bookMark = [];
  List<String> bookMarkCity = [];
  String selectedCity = "Surat";

  double temp = 0;
  Future<void> setSearch(var term) async {
    if (term.isNotEmpty && !searchHistory.contains(term)) {
      searchHistory.insert(0, term);
      await WetherHelper.wetherHelper.saveSearchHistory(searchHistory);
      notifyListeners();
    }
  }

  Future<void> removeSearch(var term) async {
    searchHistory.remove(term);
    await WetherHelper.wetherHelper.saveSearchHistory(searchHistory);
    notifyListeners();
  }

  void getSearch() async {
    searchHistory = await WetherHelper.wetherHelper.getSearchHistory();
    notifyListeners();
  }

  void getHistory() {
    getSearch();
    notifyListeners();
  }

  Future<void> getWetherHelper() async {
    wetherModel = await WetherHelper.wetherHelper.getWether(selectedCity);
    // temp = (wetherModel?.main!.temp)!;
    notifyListeners();
  }

  Future<void> bookmarkCity(String city) async {
    await WetherHelper.wetherHelper.saveBookmark(city);
    selectedCity = city;
    notifyListeners();
  }

  void getBookMark() async {
    bookMarkCity.add(wetherModel!.name!);
    bookMarkCity = await WetherHelper.wetherHelper.getBookmark();
    notifyListeners();
  }

  String getTemp(String main) {
    if (main == 'Clouds') {
      return 'assets/gif/cloud.gif';
    } else if (main == 'Thunderstorm') {
      return 'assets/gif/thunder.gif';
    } else {
      return 'assets/gif/sunny.gif';
    }
  }

  String getTempBg(String main) {
    if (main == 'Clouds') {
      return 'assets/images/cloud.jpeg';
    } else if (main == 'Haze') {
      return 'assets/images/cloud.jpeg';
    } else if (main == 'Thunderstorm') {
      return 'assets/images/2.jpg';
    } else if (main == 'Rain') {
      return 'assets/images/rain.jpg';
    } else {
      return 'assets/images/ss.jpeg';
    }
  }

  List days = [
    '',
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday',
  ];
  List months = [
    '',
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'June',
    'July',
    'Aug',
    'Sup',
    'Oct',
    'Nov',
    'Dec',
  ];
  Color getGradientStart(double temp) {
    if (temp < 10) {
      return Colors.blue;
    } else if (temp >= 10 && temp < 25) {
      return Colors.orangeAccent;
    } else {
      return Colors.redAccent;
    }
  }
}
