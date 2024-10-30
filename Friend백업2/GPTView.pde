import processing.core.*;

class GPTView {
    PApplet parent;

    GPTView(PApplet parent) {
        this.parent = parent;
    }

    void displayGPTResponse(String gptResponse) {
        parent.fill(0);
        parent.textSize(16);
        parent.text("GPT: " + gptResponse, 10, 90, parent.width - 20, parent.height - 40);
    }
}