class IntroView {
    PApplet parent;
    String[] prompts = {"Enter your name:", "Enter your age:", "Enter your sex (M/F):", "Enter your MBTI:"};
    String[] responses = new String[4];
    int currentPrompt = 0;

    IntroView(PApplet parent) {
        this.parent = parent;
    }

void displayOverlay() {
    parent.fill(0, 150); // 반투명 검정 배경
    parent.rect(0, 0, parent.width, parent.height);
    parent.fill(255);
    parent.textSize(32);
    parent.textAlign(PApplet.CENTER, PApplet.CENTER);
    parent.text(prompts[currentPrompt], parent.width / 2, parent.height / 2 - 60);
    parent.text(responses[currentPrompt], parent.width / 2, parent.height / 2 + 60);
}
}