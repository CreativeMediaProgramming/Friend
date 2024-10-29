// Friend.pde
import processing.video.*;
import java.io.*;
import processing.core.*;

WebcamController webcamController;
IntroController introController;
VoiceController voiceController;
ChatController chatController;

void settings() {
    size(1600, 900, P2D);
}

void setup() {
    webcamController = new WebcamController(this, width, height);
    introController = new IntroController(this);
    chatController = new ChatController(this, width, height);
    voiceController = new VoiceController(this, width, height, chatController);
    
    chatController.initializeTestChat();

    if (!introController.loadUserData()) {
        introController.startIntro();
    }
}

void draw() {
    webcamController.draw(); // 웹캠을 가장 먼저 그립니다.
    if (!introController.introComplete) {
        introController.view.displayOverlay();
    } else {
        displayUserInfo();
        voiceController.draw();
        chatController.draw(); // 채팅 UI를 그립니다.
    }
}

void mousePressed() {
    voiceController.mousePressed();
}

void keyPressed() {
    if (!introController.introComplete) {
        introController.keyPressed(key);
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