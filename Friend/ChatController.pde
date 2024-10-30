class ChatController {
    ChatModel model;
    MascotView mascotView;
    ChatView chatView;
    PApplet parent;

    ChatController(PApplet parent, int windowWidth, int windowHeight, MascotView mascotView) {
        this.parent = parent;
        model = new ChatModel();
        this.mascotView = mascotView;
        this.chatView = new ChatView(parent, windowWidth, windowHeight);
    }

    void draw() {
        // Create a copy of the chat messages to avoid concurrent modification
        ArrayList<String> messagesCopy = new ArrayList<>(model.getChatMessages());

        // Use ChatView to display messages
        chatView.displayChatUI(messagesCopy);
    }
}