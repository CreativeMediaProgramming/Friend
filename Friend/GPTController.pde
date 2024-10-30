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
        new Thread(() -> {
            try {
                String gptResponse = model.getResponseFromGPT(transcription);
                chatController.mascotView.displaySpeechBubble(mascotModel.x, mascotModel.y, gptResponse);
            } catch (Exception e) {
                println("Error processing transcription: " + e.getMessage());
            } finally {
                isRequestPending = false;
            }
        }).start();
    }
}
}