class VoiceController {
    VoiceModel model;
    VoiceView view;
    ChatController chatController;
    SpeechController speechController;
    GPTController gptController;
    boolean isTranscribing = false;
    PApplet parent;

    VoiceController(PApplet parent, int windowWidth, int windowHeight, ChatController chatController, MascotModel mascotModel, MascotView mascotView) {
        this.parent = parent;
        model = new VoiceModel(parent);
        view = new VoiceView(parent, windowWidth, windowHeight);
        this.chatController = chatController;
        speechController = new SpeechController(parent);
        gptController = new GPTController(parent, chatController, mascotModel);
    }

    void mousePressed() {
        // Check if any UI button is pressed
        if (!uiController.model.isModalVisible && (uiController.model.isExitButtonPressed(parent.mouseX, parent.mouseY) || uiController.model.isCreditsButtonPressed(parent.mouseX, parent.mouseY))) {
            return; // Skip voice recording if a UI button is pressed
        }

        if (!model.isRecording) {
            model.startRecording();
            chatController.model.addChatMessage("Recording started...");
        } else {
            model.stopRecording();
            chatController.model.addChatMessage("Recording stopped and saved.");
            chatController.model.addChatMessage("Generating...");
            isTranscribing = true;

            // Start a new thread for transcription
            new Thread(new Runnable() {
                public void run() {
                    String transcription = speechController.model.transcribeAudio(parent.sketchPath("recording.wav"));
                    chatController.model.addChatMessage(transcription); // Add transcribed text to chat
                    isTranscribing = false;
                    gptController.processTranscription(transcription.isEmpty() ? "hello GPT" : transcription);
                }
            }).start();
        }
        view.displayRecordingStatus(model.isRecording);
    }

    void draw() {
        if (model.isRecording) {
            view.displayVolume(model.getVolume());
        }
        view.displayRecordingStatus(model.isRecording);
    }
}
