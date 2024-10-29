class ChatController {
    ChatModel model;
    ChatView view;

    ChatController(PApplet parent, int windowWidth, int windowHeight) {
        model = new ChatModel();
        view = new ChatView(parent, windowWidth, windowHeight);
    }

    void initializeTestChat() {
        model.addChatMessage("Hello, how are you?");
        model.addChatMessage("I'm doing well, thank you!");
        model.addChatMessage("What can you do?");
    }

    void draw() {
        view.displayChatUI(model.getChatMessages());
    }
}