import java.util.List;

class ChatView {
    PApplet parent;
    int windowWidth, windowHeight;
    int profileHeight = 200; // 프로필 영역 높이 설정
    ArrayList<String> chatMessages; // 채팅 메시지 저장

    ChatView(PApplet parent, int windowWidth, int windowHeight) {
        this.parent = parent;
        this.windowWidth = windowWidth;
        this.windowHeight = windowHeight;
        this.chatMessages = new ArrayList<String>(); // 초기화
    }

    void displayChatUI(ArrayList<String> chatMessages) {
        if (chatMessages == null) {
            chatMessages = new ArrayList<>(); // Null일 경우 빈 리스트로 초기화
        }
        
        // Only keep the last 12 messages
        int start = Math.max(0, chatMessages.size() - 12);
        List<String> recentMessages = chatMessages.subList(start, chatMessages.size());

        float xOffset = 20;
        float yOffset = profileHeight + 20; // yOffset 초기화
        float rightMargin = 20; // Right margin for the chat bubble
        parent.textSize(16);
        parent.textAlign(PApplet.LEFT, PApplet.TOP);

        for (String message : recentMessages) {
            String[] words = message.split(" ");
            StringBuilder line = new StringBuilder();
            float maxWidth = 280;
            float lineHeight = 20;
            float bubblePadding = 10;
            float bubbleWidth = 0;
            ArrayList<String> lines = new ArrayList<>();

            for (String word : words) {
                if (parent.textWidth(line.toString() + word) > maxWidth) {
                    lines.add(line.toString());
                    bubbleWidth = Math.max(bubbleWidth, parent.textWidth(line.toString()));
                    line = new StringBuilder();
                }
                line.append(word).append(" ");
            }

            // Add the last line
            if (line.length() > 0) {
                lines.add(line.toString());
                bubbleWidth = Math.max(bubbleWidth, parent.textWidth(line.toString()));
            }

            // Draw the bubble for all lines
            float bubbleHeight = lines.size() * lineHeight + 2 * bubblePadding;
            parent.fill(255);
            parent.rect(parent.width - bubbleWidth - 2 * bubblePadding - rightMargin, yOffset, bubbleWidth + 2 * bubblePadding, bubbleHeight, 10);

            // Draw each line of text
            parent.fill(0);
            float textYOffset = yOffset + bubblePadding;
            for (String l : lines) {
                parent.text(l, parent.width - bubbleWidth - bubblePadding - rightMargin, textYOffset);
                textYOffset += lineHeight;
            }

            yOffset += bubbleHeight + 10; // Add spacing between bubbles
        }
    }
}