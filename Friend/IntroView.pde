class IntroView {
    PApplet parent;
    PImage bg;
    float opacity = 0;
    boolean fadingIn = true;
    String name = "";
    String gender = "";
    String age = "";
    String mbti = "";

    IntroView(PApplet parent) {
        this.parent = parent;
        bg = parent.loadImage("background.jpg");
        parent.textAlign(PApplet.CENTER, PApplet.CENTER);
    }

    void drawBackground() {
        parent.image(bg, 0, 0, parent.width, parent.height);
    }

    void drawText(String text, float x, float y, int size, int alpha) {
        parent.fill(0, 0, 0, alpha);
        parent.textSize(size);
        parent.text(text, x, y);
    }

    void drawInputBox(float x, float y, float w, float h, String text) {
        parent.fill(255);
        parent.rect(x, y, w, h);
        parent.fill(0);
        parent.text(text, x + w / 2, y + h / 2);
    }

    void drawButton(float x, float y, float w, float h, String text) {
        parent.noFill();
        parent.stroke(0);
        parent.rect(x, y, w, h);
        parent.fill(0);
        parent.textSize(30);
        parent.text(text, x + w / 2, y + h / 2);
    }

    // Add more methods to handle specific frames and UI elements
}