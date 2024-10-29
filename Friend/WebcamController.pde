class WebcamController {
    WebcamModel model;
    WebcamView view;

    WebcamController(PApplet parent, int windowWidth, int windowHeight) {
        model = new WebcamModel(parent, windowWidth, windowHeight);
        view = new WebcamView(parent, windowWidth, windowHeight);
    }

    void draw() {
        if (model.video.available()) {
            model.video.read();
        }
        view.displayVideo(model.video);
    }

    void captureEvent(Capture c) {
        model.captureEvent(c);
    }
}