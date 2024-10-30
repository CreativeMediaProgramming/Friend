import http.requests.*;
import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;

class WeatherModel {
    PApplet parent;
    String apiKey;
    float lat = 37.56; // Seoul latitude
    float lon = 126.97; // Seoul longitude
    JSONObject weatherData;

    WeatherModel(PApplet parent) {
        this.parent = parent;
        String filePath = parent.sketchPath("weatherconfig.txt");
        this.apiKey = readApiKeyFromFile(filePath);
        fetchWeatherData();
    }

    String readApiKeyFromFile(String filePath) {
        String key = "";
        try {
            BufferedReader reader = new BufferedReader(new FileReader(filePath));
            key = reader.readLine();
            reader.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
        return key;
    }

    void fetchWeatherData() {
        String api = "https://api.openweathermap.org/data/2.5/weather?lat=" + lat + "&lon=" + lon + "&appid=" + apiKey + "&units=metric&lang=en";
        GetRequest get = new GetRequest(api);
        get.send();
        String response = get.getContent();
        if (response != null) {
            weatherData = parent.parseJSONObject(response);
        }
    }

    JSONObject getWeatherData() {
        return weatherData;
    }
}