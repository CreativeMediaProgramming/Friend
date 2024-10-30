import gab.opencv.*;
import java.awt.*;

class WebcamView {
    PApplet parent;
    OpenCV opencv;
    int windowWidth, windowHeight;

    WebcamView(PApplet parent, int windowWidth, int windowHeight) {
        this.parent = parent;
        this.windowWidth = windowWidth;
        this.windowHeight = windowHeight;
        opencv = new OpenCV(parent, windowWidth / 2, windowHeight / 2);
        opencv.loadCascade(OpenCV.CASCADE_FRONTALFACE);
    }

    void displayVideo(Capture video) {
        parent.image(video, 0, 0, windowWidth, windowHeight);
    }
}