class MascotModel {
    float x, y; // 마스코트의 현재 위치
    float vx, vy; // 마스코트의 속도

    MascotModel(float startX, float startY, float startVX, float startVY) {
        x = startX;
        y = startY;
        vx = startVX;
        vy = startVY;
    }

    void updatePosition(float width, float height, MascotView view) {
        x += vx;
        y += vy;

        // 마스코트의 크기를 고려하여 벽에 부딪히면 방향을 반대로
        float mascotWidth = view.getMascotWidth(); // 가로 크기
        float mascotHeight = view.getMascotHeight(); // 세로 크기

        if (x < 0 || x + mascotWidth > width) {
            vx *= -1;
        }
        if (y < 0 || y + mascotHeight > height) {
            vy *= -1;
        }
    }
}