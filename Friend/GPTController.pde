class GPTController {
    GPTModel model;
    GPTView view;
    ChatController chatController;
    MascotModel mascotModel;
    boolean isRequestPending = false;

    GPTController(PApplet parent, ChatController chatController, MascotModel mascotModel) {
        model = new GPTModel(parent);
        view = new GPTView(parent);
        this.chatController = chatController;
        this.mascotModel = mascotModel;
    }

    void processTranscription(String transcription) {
        if (!isRequestPending) {
            isRequestPending = true;
            String gptResponse = model.getResponseFromGPT(transcription);
            // Display GPT response as a speech bubble above the mascot
            chatController.mascotView.displaySpeechBubble(mascotModel.x, mascotModel.y, gptResponse);
            isRequestPending = false;
        }
    }
}