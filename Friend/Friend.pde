// Friend.pde
import processing.video.*;
import java.io.*;
import processing.core.*;

WebcamController webcamController;
IntroController introController;
VoiceController voiceController;
ChatController chatController;
WeatherController weatherController;

void settings() {
    size(1600, 900, P2D);
}

void setup() {
    webcamController = new WebcamController(this, width, height);
    introController = new IntroController(this);
    chatController = new ChatController(this, width, height);
    voiceController = new VoiceController(this, width, height, chatController);
    weatherController = new WeatherController(this);
    
    chatController.initializeTestChat();

    if (!introController.loadUserData()) {
        introController.startIntro();
    }
}

void draw() {
    if (!introController.introComplete) {
        introController.draw(); // Draw the intro UI
    } else {
        webcamController.draw(); // Draw the webcam after intro is complete
        displayUserInfo();
        voiceController.draw();
        chatController.draw(); // Draw the chat UI
        weatherController.draw(); // Draw the weather UI
    }
}

void mousePressed() {
    if (!introController.introComplete) {
        introController.mousePressed(); // 인트로 입력 처리
    } else {
        voiceController.mousePressed(); // 메인 프로그램 입력 처리
    }
}

void keyPressed() {
    if (!introController.introComplete) {
        introController.keyPressed(key); // 인트로 입력 처리
    }
}

void captureEvent(Capture c) {
    webcamController.captureEvent(c);
}

void displayUserInfo() {
    if (introController.model != null) {
        // 배경 직사각형 색상 및 불투명도 설정 (밝은 회색, 알파 122)
        fill(200, 122);
        // 배경 직사각형 그리기 (위치와 크기는 텍스트에 맞게 조정, 모서리 둥글게)
        rect(10, 10, 300, 120, 20); // 마지막 인자 20은 둥근 모서리의 반지름

        fill(255); // 흰색 글자

        // 날짜와 시간 글씨 크기 조정 
        textSize(30); 
        textAlign(LEFT, TOP); // 왼쪽 위 정렬

        // 현재 날짜와 시간 가져오기
        String dateTime = year() + "-" + nf(month(), 2) + "-" + nf(day(), 2) + " " + nf(hour(), 2) + ":" + nf(minute(), 2) + ":" + nf(second(), 2);

        // 날짜와 시간 출력
        text(dateTime, 20, 20);

        // "Hi, 이름" 글씨 크기 조정 
        textSize(28); 
        text("Hi, " + introController.model.getUserName(), 20, 60);

        // 성별, 나이, MBTI 글씨 크기 조정 
        textSize(18); 

        // 성별, MBTI, 나이를 각각 3등분하여 배치
        String gender = introController.model.isUserSex() ? "Male" : "Female";
        String mbti = introController.model.getUserMBTI();
        String age = "(" + introController.model.getUserAge() + ")";

        // 성별 출력
        text(gender, 20, 100);

        // MBTI 출력
        text(mbti, 140, 100);

        // 나이 출력
        text(age, 260, 100);
    }
}