import gab.opencv.*;
import processing.video.*;
import java.awt.*;
import java.util.Calendar; // 시간 표시를 위해 추가
import gifAnimation.*; // GifAnimation 라이브러리 추가
import http.requests.*; // HTTPClient 라이브러리 추가
PFont font; // 폰트 추가
Capture video;
OpenCV opencv;
Gif gifOverlay; // GIF 오버레이 이미지

int windowWidth;
int windowHeight;
String gptResponse = ""; // GPT 응답 저장 변수

void settings() {
  // 화면 해상도 가져오기
  Dimension screenSize = Toolkit.getDefaultToolkit().getScreenSize();
  int screenWidth = screenSize.width;
  int screenHeight = screenSize.height;
  
  // 2/3 비율로 크기 설정
  windowWidth = screenWidth;
  windowHeight = screenHeight;
  
  size(windowWidth, windowHeight, P2D);
}

void setup() {
  video = new Capture(this, windowWidth / 2, windowHeight / 2);
  // set up OpenCV
  opencv = new OpenCV(this, windowWidth / 2, windowHeight / 2);
  opencv.loadCascade(OpenCV.CASCADE_FRONTALFACE);
  video.start();

  // GIF 오버레이 이미지 로드
  gifOverlay = new Gif(this, "/test.gif");
  gifOverlay.loop(); // GIF 애니메이션 반복 재생
}

void draw() {
  // load current video frame to OpenCV
  opencv.loadImage(video);
  image(video, 0, 0, windowWidth, windowHeight); // 크기 조정
  noFill();
  stroke(0, 255, 0);
  strokeWeight(3);
  // detect faces from the video frame
  Rectangle[] faces = opencv.detect();
  // draw a rect around each face
  for (int i = 0; i < faces.length; i++) {
    rect(faces[i].x * 2, faces[i].y * 2, faces[i].width * 2, faces[i].height * 2); // 크기 조정
  }
  
  // 시간 표시
  fill(255); // 하얀색
  textSize(64); // 텍스트 크기 증가
  textAlign(RIGHT, TOP);
  Calendar now = Calendar.getInstance();
  String timeString = String.format("%02d:%02d:%02d", now.get(Calendar.HOUR_OF_DAY), now.get(Calendar.MINUTE), now.get(Calendar.SECOND));
  text(timeString, width - 20, 20); // 오른쪽 위에서 조금 더 떨어지게 설정
  
  // GPT 응답 표시
  textAlign(LEFT, BOTTOM);
  textSize(32);
  text(gptResponse, 20, height - 20); // 화면 아래에 GPT 응답 표시
  
  // GIF 오버레이 이미지 표시
  image(gifOverlay, 50, 50); // 원하는 위치에 오버레이
}

void captureEvent(Capture c) {
  c.read();
}

// GPT API 호출 함수
void callGPT(String inputText) {
  String apiKey = "YOUR_API_KEY"; // OpenAI API 키
  String apiUrl = "https://api.openai.com/v1/engines/davinci-codex/completions";
  
  JSONObject requestBody = new JSONObject();
  requestBody.setString("prompt", inputText);
  requestBody.setInt("max_tokens", 150);
  
  PostRequest post = new PostRequest(apiUrl);
  post.addHeader("Content-Type", "application/json");
  post.addHeader("Authorization", "Bearer " + apiKey);
  post.send(requestBody.toString());
  
  post.onResponse((response) -> {
    if (response.getStatusCode() == 200) {
      JSONObject jsonResponse = response.getContentAsJSONObject();
      gptResponse = jsonResponse.getJSONArray("choices").getJSONObject(0).getString("text");
    } else {
      gptResponse = "Error: " + response.getStatusCode();
    }
  });
}

// 키보드 입력 처리 함수
void keyPressed() {
  if (key == ENTER || key == RETURN) {
    String userInput = "Hello, GPT!"; // 여기에 사용자 입력을 받아서 사용
    callGPT(userInput);
  }
}
