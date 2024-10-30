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
        // 배경 직사각형 그리기
        parent.fill(50, 50, 50, 150); // 어두운 회색, 약간의 투명도
        float textHeight = 20; // 텍스트 높이
        float padding = 10; // 패딩
        float marginTop = 10; // 위쪽 마진
        float rectWidth = 200; // 직사각형 너비
        float rectHeight = textHeight + 20 + marginTop; // 직사각형 높이
        parent.rect(windowWidth / 4 - padding, marginTop, rectWidth, rectHeight, 10); // 둥근 모서리

        // 빨간 원 그리기
        parent.fill(255, 0, 0); // 빨간색으로 설정
        parent.stroke(0);
        float diameter = (10 + vol * 200) * 2 / 3;
        parent.ellipse(windowWidth / 4 + 150, marginTop + 10 + textHeight / 2, diameter, diameter);
    }

    void displayRecordingStatus(boolean isRecording) {
        // 배경 직사각형 그리기
        parent.fill(50, 50, 50, 150); // 어두운 회색, 약간의 투명도
        float textHeight = 20; // 텍스트 높이
        float padding = 10; // 패딩
        float marginTop = 10; // 위쪽 마진
        float rectWidth = 200; // 직사각형 너비
        float rectHeight = textHeight + 20 + marginTop; // 직사각형 높이
        parent.rect(windowWidth / 4 - padding, marginTop, rectWidth, rectHeight, 10); // 둥근 모서리

        // 텍스트 그리기
        String message = isRecording ? "Listening..." : "Preparing...";
        parent.fill(255);
        parent.textSize(20);
        parent.textAlign(PApplet.LEFT, PApplet.TOP);
        parent.text(message, windowWidth / 4, marginTop + 10);
    }
}