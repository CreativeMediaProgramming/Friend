// VoiceView.pde
import processing.core.*;

class VoiceView {
    PApplet parent;
    int windowWidth, windowHeight;

    VoiceView(PApplet parent, int windowWidth, int windowHeight) {
        this.parent = parent;
        this.windowWidth = windowWidth;
        this.windowHeight = windowHeight;
    }

    void displayVolume(float vol) {
        parent.fill(127);
        parent.stroke(0);
        parent.ellipse(windowWidth / 2, windowHeight / 2, 10 + vol * 200, 10 + vol * 200);
    }

    void displayRecordingStatus(boolean isRecording) {
        String message = isRecording ? "Recording started..." : "Recording stopped and saved.";
        parent.fill(255);
        parent.textSize(20);
        parent.textAlign(PApplet.CENTER, PApplet.BOTTOM);
        parent.text(message, windowWidth / 2, windowHeight - 30);
    }
}