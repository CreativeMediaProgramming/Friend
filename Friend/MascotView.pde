import gifAnimation.*; // GIF 애니메이션 라이브러리 임포트

class MascotView {
    PApplet parent;
    Gif mascotGif; // GIF 객체 선언
    String currentSpeechBubbleText = ""; // Store the current speech bubble text

    MascotView(PApplet parent) {
        this.parent = parent;
        setupGif(); // GIF 설정 메서드 호출
    }

    void setupGif() {
        mascotGif = new Gif(parent, "mascot.gif"); // GIF 파일 로드
        mascotGif.loop(); // GIF 반복 재생 설정
    }

    void display(float x, float y) {
        try {
            if (mascotGif != null && mascotGif.width > 0 && mascotGif.height > 0) {
                float aspectRatio = (float) mascotGif.height / mascotGif.width; // 비율 계산
                float width = 200; // 가로 크기 설정
                float height = width * aspectRatio; // 세로 크기 설정
                parent.image(mascotGif, x, y, width, height); // 크기 조정하여 이미지 표시
            } else {
                println("Error: GIF is not properly loaded.");
            }
        } catch (ArrayIndexOutOfBoundsException e) {
            println("Error displaying GIF: " + e.getMessage());
        } catch (Exception e) {
            println("Unexpected error: " + e.getMessage());
        }

        if (!currentSpeechBubbleText.isEmpty()) {
            displaySpeechBubble(x, y, currentSpeechBubbleText);
        }
    }

    float getMascotWidth() {
        return 200; // 가로 크기 설정
    }

    float getMascotHeight() {
        float aspectRatio = (float) mascotGif.height / mascotGif.width; // 비율 계산
        return getMascotWidth() * aspectRatio; // 세로 크기 설정
    }

    void displaySpeechBubble(float x, float y, String text) {
        if (text == null || text.isEmpty()) {
            println("Error: Speech bubble text is null or empty.");
            return;
        }

        currentSpeechBubbleText = text; // Update the speech bubble text

        String[] words = text.split(" ");
        StringBuilder wrappedText = new StringBuilder();
        float lineWidth = 0;
        float maxLineWidth = 200; // Set a maximum line width

        for (String word : words) {
            float wordWidth = parent.textWidth(word + " ");
            if (lineWidth + wordWidth > maxLineWidth) {
                wrappedText.append("\n");
                lineWidth = 0;
            }
            wrappedText.append(word).append(" ");
            lineWidth += wordWidth;
        }

        String finalText = wrappedText.toString().trim();

        float bubbleWidth = Math.min(parent.textWidth(finalText) + 30, maxLineWidth + 30);
        float bubbleHeight = (parent.textAscent() + parent.textDescent()) * (finalText.split("\n").length + 1) + 30;
        float maxBubbleHeight = 300;
        bubbleHeight = Math.min(bubbleHeight, maxBubbleHeight);

        float bubbleX = x + 210;
        float bubbleY = y - 50;

        parent.fill(255, 255, 255, 200);
        parent.stroke(0);
        parent.rect(bubbleX, bubbleY, bubbleWidth, bubbleHeight, 10);

    parent.fill(0);
parent.textSize(14);
parent.textAlign(PApplet.LEFT, PApplet.TOP);

try {
    if (finalText != null) {
        parent.text(finalText, bubbleX + 10, bubbleY + 10);
    } else {
        println("Error: finalText is null.");
    }
} catch (NullPointerException e) {
    println("NullPointerException caught: " + e.getMessage());
    // Retry logic
    int retryCount = 0;
    int maxRetries = 3;
    boolean success = false;
    
    while (retryCount < maxRetries && !success) {
        try {
            if (finalText != null) {
                parent.text(finalText, bubbleX + 10, bubbleY + 10);
                success = true;
            } else {
                println("Error: finalText is null on retry.");
            }
        } catch (NullPointerException retryException) {
            println("Retry " + (retryCount + 1) + " failed: " + retryException.getMessage());
        }
        retryCount++;
    }
    
    if (!success) {
        println("Failed to display text after " + maxRetries + " retries.");
    }
}
    }
}