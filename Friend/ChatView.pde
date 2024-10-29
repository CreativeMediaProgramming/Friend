class ChatView {
    PApplet parent;
    int windowWidth, windowHeight;
    int profileHeight = 100; // 프로필 영역 높이 설정
    float scrollOffset = 0; // 스크롤 오프셋
    ArrayList<String> chatMessages; // 채팅 메시지 저장

    ChatView(PApplet parent, int windowWidth, int windowHeight) {
        this.parent = parent;
        this.windowWidth = windowWidth;
        this.windowHeight = windowHeight;
        this.chatMessages = new ArrayList<String>(); // 초기화
    }

    void displayChatUI(ArrayList<String> chatMessages) {
        this.chatMessages = chatMessages; // 인스턴스 변수에 할당
        parent.textSize(20);
        parent.textAlign(PApplet.LEFT, PApplet.TOP);
        int xOffset = 20;
        float currentYOffset = windowHeight - 20 + scrollOffset; // 스크롤 오프셋 적용

        // Display messages from the bottom up
        for (int i = chatMessages.size() - 1; i >= 0; i--) {
            String message = chatMessages.get(i);
            String[] words = message.split(" ");
            StringBuilder formattedMessage = new StringBuilder();
            int spaceCount = 0;

            for (String word : words) {
                formattedMessage.append(word).append(" ");
                spaceCount++;
                if (spaceCount >= 5) {
                    formattedMessage.append("\n");
                    spaceCount = 0;
                }
            }

            String finalMessage = formattedMessage.toString().trim();
            float bubbleWidth = parent.textWidth(finalMessage) + 30;
            float bubbleHeight = (parent.textAscent() + parent.textDescent()) * (finalMessage.split("\n").length + 1) + 20;

            // Check if the message will be visible
            if (currentYOffset - bubbleHeight < profileHeight) {
                break; // Stop drawing if the message would be above the profile area
            }

            if (i % 2 == 0) {
                parent.fill(200, 200, 255);
                parent.rect(xOffset, currentYOffset - bubbleHeight, bubbleWidth, bubbleHeight, 10);
                parent.fill(0);
                parent.text(finalMessage, xOffset + 10, currentYOffset - bubbleHeight + 5);
            } else {
                parent.fill(255, 200, 200);
                parent.rect(windowWidth - bubbleWidth - xOffset, currentYOffset - bubbleHeight, bubbleWidth, bubbleHeight, 10);
                parent.fill(0);
                parent.text(finalMessage, windowWidth - bubbleWidth - xOffset + 10, currentYOffset - bubbleHeight + 5);
            }

            currentYOffset -= (bubbleHeight + 20); // Move up for the next message
        }
    }

    void scroll(float amount) {
        scrollOffset += amount;
        float maxOffset = Math.max(0, chatMessages.size() * 100 - (windowHeight - profileHeight));
        scrollOffset = PApplet.constrain(scrollOffset, -maxOffset, 0); // 스크롤 범위 제한
    }
}