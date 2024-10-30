class UIModel {
    boolean isExitButtonPressed(float mouseX, float mouseY) {
        return mouseX >= 10 && mouseX <= 110 && mouseY >= height - 50 && mouseY <= height - 10;
    }
}
