class UIModel {
    boolean isModalVisible = false;

    boolean isExitButtonPressed(float mouseX, float mouseY) {
        return mouseX >= 10 && mouseX <= 110 && mouseY >= height - 50 && mouseY <= height - 10;
    }

    boolean isCreditsButtonPressed(float mouseX, float mouseY) {
        return mouseX >= 10 && mouseX <= 110 && mouseY >= height - 100 && mouseY <= height - 60;
    }

    boolean isCloseButtonPressed(float mouseX, float mouseY) {
        // Adjusted coordinates for the "X" button
        return mouseX >= width / 2 + 320 && mouseX <= width / 2 + 360 && mouseY >= height / 2 - 250 && mouseY <= height / 2 - 210;
    }
}