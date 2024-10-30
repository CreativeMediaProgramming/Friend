// ... existing code ...

class UIcontroller {
    UIModel model;
    UIview view;

    UIcontroller(UIModel model, UIview view) {
        this.model = model;
        this.view = view;
    }

    void drawUI() {
        view.drawExitButton();
        view.drawCredits();
    }

    void mousePressed() {
        if (model.isExitButtonPressed(mouseX, mouseY)) {
            exit(); // Exit the program
        }
    }
}

// ... existing code ...
