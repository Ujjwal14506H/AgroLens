import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'crop_details.dart';
// import 'crop_recommendation.dart'; // Importing the external file

class CropAdvisor extends StatefulWidget {
  @override
  _CropAdvisorState createState() => _CropAdvisorState();
}

class _CropAdvisorState extends State<CropAdvisor>
    with SingleTickerProviderStateMixin {
  String city = "Delhi";
  String temperatureInfo = "Fetching...";
  String weatherInfo = "Fetching...";
  String recommendation = "Analyzing...";
  bool isLoading = true;
  late AnimationController animationController;
  late Animation<double> fadeAnimation;

  final CropSuggestion cropSuggestion = CropSuggestion(); // Create an instance

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1200),
    );
    fadeAnimation =
        CurvedAnimation(parent: animationController, curve: Curves.easeIn);
    retrieveWeatherData();
  }

  Future<void> retrieveWeatherData() async {
    String apiKey = "f698e0e393067c15dbf3a620ecf44a14";
    String apiUrl =
        "https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&units=metric";

    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        var weatherData = json.decode(response.body);
        double currentTemperature = weatherData['main']['temp'];
        String currentCondition = weatherData['weather'][0]['main'];
        double currentHumidity = weatherData['main']['humidity'];

        setState(() {
          temperatureInfo = "${currentTemperature}°C";
          weatherInfo = currentCondition;
          recommendation = cropSuggestion.suggestCrop(
              currentTemperature, currentHumidity, currentCondition);
          isLoading = false;
        });
        animationController.forward();
      } else {
        handleDataError();
      }
    } catch (error) {
      handleDataError();
    }
  }

  void handleDataError() {
    setState(() {
      recommendation = "Unable to fetch data. Check your connection.";
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Smart Crop Advisor",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Location: $city",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Icon(Icons.thermostat_outlined, color: Colors.orange, size: 30),
                SizedBox(width: 10),
                Text(
                  temperatureInfo,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                ),
              ],
            ),
            Row(
              children: [
                Icon(Icons.cloud, color: Colors.blue, size: 30),
                SizedBox(width: 10),
                Text(
                  weatherInfo,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
              ],
            ),
            SizedBox(height: 30),
            Text(
              "Crop Suggestion",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 10),
            isLoading
                ? Center(child: CircularProgressIndicator())
                : FadeTransition(
                    opacity: fadeAnimation,
                    child: Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.green.shade200,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 4,
                            color: Colors.black12,
                          )
                        ],
                      ),
                      child: Center(
                        child: Text(
                          recommendation,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
