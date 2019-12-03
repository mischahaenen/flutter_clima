import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';

const apiKey = '591e7effa4b29f7cbdde8fa0ba49663c';
const baseUrl = 'https://api.openweathermap.org/data/2.5/weather';

class Weather {
  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }

  Future<dynamic> getWeather({double lon, double lat}) async {
    NetworkHelper nh = NetworkHelper(url: '$baseUrl?units=metric&lat=$lat&lon=$lon&appid=$apiKey');
    return await nh.getData();
  }

  Future<dynamic> getCityWeather({String cityName}) async {
    NetworkHelper nh = NetworkHelper(url: '$baseUrl?units=metric&q=$cityName&appid=$apiKey');
    return await nh.getData();
  }

  Future<dynamic> getLocationWeather() async {
    Location location = Location();
    await location.getCurrentLocation();
    Weather weather = Weather();
    return await weather.getWeather(lat: location.latitude, lon: location.longitude);
  }
}
