// crop_recommendation.dart

class CropDetails {
  final String name;
  final String idealWeather;
  final double minimumTemperature;
  final double maximumTemperature;
  final double requiredHumidity;

  CropDetails({
    required this.name,
    required this.idealWeather,
    required this.minimumTemperature,
    required this.maximumTemperature,
    required this.requiredHumidity,
  });

  bool matchesConditions(double currentTemperature, double currentHumidity,
      String currentWeather) {
    return currentTemperature >= minimumTemperature &&
        currentTemperature <= maximumTemperature &&
        currentHumidity >= requiredHumidity &&
        idealWeather.contains(currentWeather);
  }
}

class CropSuggestion {
  final List<CropDetails> crops = [
    CropDetails(
      name: "Wheat 🌾",
      idealWeather: "Clear",
      minimumTemperature: 10,
      maximumTemperature: 24,
      requiredHumidity: 50,
    ),
    CropDetails(
      name: "Rice 🌾",
      idealWeather: "Rain",
      minimumTemperature: 25,
      maximumTemperature: 35,
      requiredHumidity: 70,
    ),
    CropDetails(
      name: "Mustard 🌱",
      idealWeather: "Cloud",
      minimumTemperature: 15,
      maximumTemperature: 25,
      requiredHumidity: 60,
    ),
    CropDetails(
      name: "Sugarcane 🍬",
      idealWeather: "Clear",
      minimumTemperature: 20,
      maximumTemperature: 30,
      requiredHumidity: 55,
    ),
    CropDetails(
      name: "Maize 🌽",
      idealWeather: "Clear",
      minimumTemperature: 20,
      maximumTemperature: 35,
      requiredHumidity: 50,
    ),
    CropDetails(
      name: "Cotton 🌿",
      idealWeather: "Clear",
      minimumTemperature: 25,
      maximumTemperature: 35,
      requiredHumidity: 60,
    ),
    CropDetails(
      name: "Soybean 🌱",
      idealWeather: "Rain",
      minimumTemperature: 20,
      maximumTemperature: 30,
      requiredHumidity: 65,
    ),
    CropDetails(
      name: "Barley 🌾",
      idealWeather: "Cloud",
      minimumTemperature: 10,
      maximumTemperature: 22,
      requiredHumidity: 50,
    ),
    CropDetails(
      name: "Peanuts 🥜",
      idealWeather: "Clear",
      minimumTemperature: 20,
      maximumTemperature: 30,
      requiredHumidity: 55,
    ),
    CropDetails(
      name: "Millet 🌾",
      idealWeather: "Clear",
      minimumTemperature: 25,
      maximumTemperature: 35,
      requiredHumidity: 50,
    ),
  ];

  String suggestCrop(double temperature, double humidity, String weather) {
    for (var crop in crops) {
      if (crop.matchesConditions(temperature, humidity, weather)) {
        return "Recommended Crop: ${crop.name}";
      }
    }
    return "No suitable crops match the current conditions.";
  }
}
