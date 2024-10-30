import gifAnimation.*; // GIF 애니메이션 라이브러리 임포트

class MascotView {
    PApplet parent;
    Gif mascotGif; // GIF 객체 선언

    MascotView(PApplet parent) {
        this.parent = parent;
        setupGif(); // GIF 설정 메서드 호출
    }

    void setupGif() {
        mascotGif = new Gif(parent, "mascot.gif"); // GIF 파일 로드
        mascotGif.loop(); // GIF 반복 재생 설정
    }

    void display(float x, float y) {
        float aspectRatio = (float) mascotGif.height / mascotGif.width; // 비율 계산
        float width = 200; // 가로 크기 설정
        float height = width * aspectRatio; // 세로 크기 설정
        parent.image(mascotGif, x, y, width, height); // 크기 조정하여 이미지 표시
    }

    float getMascotWidth() {
        return 200; // 가로 크기 설정
    }

    float getMascotHeight() {
        float aspectRatio = (float) mascotGif.height / mascotGif.width; // 비율 계산
        return getMascotWidth() * aspectRatio; // 세로 크기 설정
    }
}