// Friend.pde
import processing.video.*;
import java.io.*;
import processing.core.*;

WebcamController webcamController;
IntroController introController;
VoiceController voiceController;
ChatController chatController;
WeatherController weatherController;
MascotController mascotController;

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

    MascotModel model = new MascotModel(width / 2, height / 2, 2, 3);
    MascotView view = new MascotView(this); // PApplet 인스턴스를 전달
    mascotController = new MascotController(model, view);
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
        mascotController.update(width, height);
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
        fill(255);
        textSize(24);
        textAlign(LEFT, BOTTOM);
        String userInfo = "Name: " + introController.model.getUserName() + "\n" +
                          "Age: " + introController.model.getUserAge() + "\n" +
                          "Sex: " + (introController.model.isUserSex() ? "Male" : "Female") + "\n" +
                          "MBTI: " + introController.model.getUserMBTI();
        text(userInfo, 20, height - 20);
    }
}