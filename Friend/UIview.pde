class UIview {
    void drawExitButton() {
        fill(255, 100, 100); // Lighter red color for the exit button
        rect(10, height - 50, 100, 40, 10); // Rounded corners
        fill(255); // White text
        textSize(16);
        textAlign(CENTER, CENTER);
        text("Exit", 60, height - 30); // Centered text on the button
    }

    void drawCreditsButton() {
        fill(100, 100, 255); // Lighter blue color for the credits button
        rect(10, height - 100, 100, 40, 10); // Rounded corners, positioned above the exit button
        fill(255); // White text
        textSize(16);
        textAlign(CENTER, CENTER);
        text("Credits", 60, height - 80); // Centered text on the button
    }

    void drawCreditsModal() {
        fill(0, 0, 0, 200); // Semi-transparent black background
        rect(width / 2 - 350, height / 2 - 250, 700, 500, 20); // Larger modal with rounded corners
        fill(255); // White text
        textSize(32); // Larger text size
        textAlign(CENTER, TOP);
        text("24-2 Creativemedia\nProcessing team 8 project", width / 2, height / 2 - 210); // Wrapped title

        textSize(28); // Larger text size for team members
        text("\n\nTeam:\nChanghyun Nam\nEun Seong Lim\nHo Hoang My\nKim Seon Woo", width / 2, height / 2 - 130);

        // Draw the close button (X)
        fill(255, 0, 0); // Red color for the close button
        textSize(40); // Larger text size for the close button
        text("X", width / 2 + 340, height / 2 - 240); // Adjusted position
    }
}