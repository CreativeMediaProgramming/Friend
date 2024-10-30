class WeatherController {
    WeatherModel model;
    WeatherView view;

    WeatherController(PApplet parent) {
        model = new WeatherModel(parent);
        view = new WeatherView(parent);
    }

    void draw() {
        JSONObject data = model.getWeatherData();
        view.displayWeather(data);
    }
}