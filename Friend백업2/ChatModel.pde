class ChatModel {
    ArrayList<String> chatMessages = new ArrayList<String>();

    void addChatMessage(String message) {
        chatMessages.add(message);
    }

    ArrayList<String> getChatMessages() {
        return chatMessages;
    }
}