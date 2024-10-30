import gifAnimation.*; // GIF 애니메이션 라이브러리 임포트

class WeatherView {
    PApplet parent;
    PFont font;
    Gif gifOverlay; // GIF 객체 선언
    String currentGifFilename = ""; // 현재 GIF 파일 이름을 저장할 변수
    int gifFrame = 0;

    WeatherView(PApplet parent) {
        this.parent = parent;
        font = parent.createFont("Arial Unicode MS", 16);
    }

    void displayWeather(JSONObject data) {
        if (data != null && data.getInt("cod") == 200) {
            parent.textFont(font);
            parent.fill(255);
            parent.textAlign(PApplet.LEFT, PApplet.TOP);

            String description = data.getJSONArray("weather").getJSONObject(0).getString("description");
            float temp = data.getJSONObject("main").getFloat("temp");
            float feels_like = data.getJSONObject("main").getFloat("feels_like");
            float temp_min = data.getJSONObject("main").getFloat("temp_min");
            float temp_max = data.getJSONObject("main").getFloat("temp_max");
            int humidity = data.getJSONObject("main").getInt("humidity");

            String weatherInfo = "Current Weather: " + description + "\n" +
                                 "Temperature: " + temp + "°C\n" +
                                 "Feels Like: " + feels_like + "°C\n" +
                                 "Min: " + temp_min + "°C, Max: " + temp_max + "°C\n" +
                                 "Humidity: " + humidity + "%";

            // Calculate the position to center the text and image
            float textWidth = parent.textWidth(weatherInfo);
            float textHeight = 100; // Approximate height for the text block
            float totalWidth = textWidth + 100; // Assuming GIF width is 100
            float xOffset = (parent.width - totalWidth) / 2;
            float yOffset = 20; // Top margin

            // Display the text
            parent.text(weatherInfo, xOffset, yOffset);

            // Display corresponding weather GIF
            String weatherType = data.getJSONArray("weather").getJSONObject(0).getString("main").toLowerCase();
            String newGifFilename = weatherType + ".gif";
            if (gifOverlay == null || !currentGifFilename.equals(newGifFilename)) {
                try {
                    gifOverlay = new Gif(parent, newGifFilename);
                    gifOverlay.loop(); // GIF 반복 재생 설정
                    currentGifFilename = newGifFilename; // 현재 GIF 파일 이름 업데이트
                } catch (Exception e) {
                    System.out.println("GIF 파일을 로드할 수 없습니다: " + newGifFilename);
                    gifOverlay = null; // GIF 객체를 null로 설정하여 다음에 다시 시도할 수 있도록 함
                }
            }

            // Calculate the new dimensions for the GIF
            if (gifOverlay != null) {
                float gifHeight = textHeight;
                float gifWidth = gifOverlay.width * (gifHeight / gifOverlay.height);

                // Display the GIF
                parent.image(gifOverlay, xOffset + textWidth + 10, yOffset, gifWidth, gifHeight);
            }
        }
    }
}