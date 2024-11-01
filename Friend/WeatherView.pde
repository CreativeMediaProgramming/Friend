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

            // 텍스트와 이미지를 오른쪽 위에 배치하기 위한 위치 계산
            float textWidth = parent.textWidth(weatherInfo);
            float textHeight = parent.textAscent() + parent.textDescent() * 5; // 각 줄의 높이를 고려하여 총 높이 계산
            float additionalHeight = 85; // 추가 여유 공간을 더 크게 설정
            float gifWidth = 100; // GIF 너비를 100으로 가정
            float totalWidth = textWidth + gifWidth + 40; // 텍스트와 GIF 사이의 여백을 늘림
            float xOffset = 1600 - totalWidth - 90; // 오른쪽 여백을 더 줄여서 왼쪽으로 더 많이 이동
            float yOffset = 20; // 상단 여백을 늘려서 전체 UI를 아래로 이동

            // 배경 직사각형 색상 및 불투명도 설정 (밝은 회색, 알파 122)
            parent.fill(200, 122);
            // 배경 직사각형 그리기 (위치와 크기는 텍스트와 GIF에 맞게 조정, 모서리 둥글게)
            parent.rect(xOffset - 10, yOffset - 10, totalWidth + 95, textHeight + additionalHeight + 20, 20);

            // 텍스트 색상 설정 (흰색)
            parent.fill(255);
            // 텍스트 표시
            parent.text(weatherInfo, xOffset, yOffset);

            // 해당 날씨 GIF 표시
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

            // GIF의 새로운 크기 계산
            if (gifOverlay != null) {
                float gifHeight = textHeight + additionalHeight;
                gifWidth = gifOverlay.width * (gifHeight / gifOverlay.height);

                // GIF 표시
                parent.image(gifOverlay, xOffset + textWidth + 10, yOffset, gifWidth, gifHeight);
            }
        }
    }
}