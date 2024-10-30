class UIcontroller {
    UIModel model;
    UIview view;

    UIcontroller(UIModel model, UIview view) {
        this.model = model;
        this.view = view;
    }

    void drawUI() {
        if (model.isModalVisible) {
            view.drawCreditsModal();
        } else {
            view.drawExitButton();
            view.drawCreditsButton();
        }
    }

    void mousePressed() {
        if (model.isModalVisible) {
            if (model.isCloseButtonPressed(mouseX, mouseY)) {
                model.isModalVisible = false; // Close the modal
            }
        } else {
            if (model.isExitButtonPressed(mouseX, mouseY)) {
                exit(); // Exit the program
            } else if (model.isCreditsButtonPressed(mouseX, mouseY)) {
                model.isModalVisible = true; // Show the modal
            }
        }
    }
}