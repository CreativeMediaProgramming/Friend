class UIview {
    void drawExitButton() {
        fill(255, 0, 0); // Red color for the exit button
        rect(10, height - 50, 100, 40); // Position and size of the button
        fill(255); // White text
        textSize(16);
        textAlign(CENTER, CENTER);
        text("Exit", 60, height - 30); // Centered text on the button
    }

    void drawCredits() {
        fill(0, 0, 0, 150); // Semi-transparent black background
        rect(10, height - 150, 200, 80, 10); // Position, size, and rounded corners
        fill(255); // White text
        textSize(12);
        textAlign(LEFT, TOP);
        text("Credits:\nDeveloper: Your Name\nDesigner: Another Name", 20, height - 140);
    }
}
