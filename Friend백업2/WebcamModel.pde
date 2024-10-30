import processing.video.*;

class WebcamModel {
    Capture video;
    int windowWidth, windowHeight;

    WebcamModel(PApplet parent, int windowWidth, int windowHeight) {
        this.windowWidth = windowWidth;
        this.windowHeight = windowHeight;
        video = new Capture(parent, windowWidth, windowHeight);
        video.start();
    }

    void captureEvent(Capture c) {
        if (c.available()) {
            c.read();
        }
    }
}