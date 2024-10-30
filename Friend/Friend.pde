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
    
    // Initialize MascotModel and MascotView before ChatController
    MascotModel mascotModel = new MascotModel(width / 2, height / 2, 2, 3);
    MascotView mascotView = new MascotView(this); // PApplet instance passed

    chatController = new ChatController(this, width, height, mascotView); // Pass mascotView
    voiceController = new VoiceController(this, width, height, chatController, mascotModel, mascotView); // Pass mascotModel and mascotView
    weatherController = new WeatherController(this);

    if (!introController.loadUserData()) {
        introController.startIntro();
    }

    mascotController = new MascotController(mascotModel, mascotView);

    // Initialize GPTController with mascotModel
    GPTController gptController = new GPTController(this, chatController, mascotModel);
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
        introController.mousePressed(); // Handle intro input
    } else {
        voiceController.mousePressed(); // Handle main program input
    }
}

void keyPressed() {
    if (!introController.introComplete) {
        introController.keyPressed(key); // Handle intro input
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
