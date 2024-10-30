class GPTController {
    GPTModel model;
    GPTView view;
    ChatController chatController;
    boolean isRequestPending = false;

    GPTController(PApplet parent, ChatController chatController) {
        model = new GPTModel(parent);
        view = new GPTView(parent);
        this.chatController = chatController;
    }

    void processTranscription(String transcription) {
        if (!isRequestPending) {
            isRequestPending = true;
            String gptResponse = model.getResponseFromGPT(transcription);
            chatController.model.addChatMessage("GPT: " + gptResponse);
            view.displayGPTResponse(gptResponse);
            isRequestPending = false;
        }
    }
}