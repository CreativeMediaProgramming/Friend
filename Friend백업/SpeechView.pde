import processing.core.*;

class SpeechView {
    PApplet parent;

    SpeechView(PApplet parent) {
        this.parent = parent;
    }

    void displayTranscription(String transcriptionText) {
        parent.fill(0);
        parent.textSize(16);
        parent.text(transcriptionText, 10, 30, parent.width - 20, parent.height - 40);
    }
}