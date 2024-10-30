class VoiceController {
    VoiceModel model;
    VoiceView view;
    ChatController chatController;
    SpeechController speechController;
    GPTController gptController;
    boolean isTranscribing = false;

    VoiceController(PApplet parent, int windowWidth, int windowHeight, ChatController chatController) {
        model = new VoiceModel(parent);
        view = new VoiceView(parent, windowWidth, windowHeight);
        this.chatController = chatController;
        speechController = new SpeechController(parent);
        gptController = new GPTController(parent, chatController);
    }

    void mousePressed() {
        if (!model.isRecording) {
            model.startRecording();
            chatController.model.addChatMessage("Recording started...");
        } else {
            model.stopRecording();
            chatController.model.addChatMessage("Recording stopped and saved.");
            chatController.model.addChatMessage("Generating...");
            isTranscribing = true;
            // Use the absolute path for the audio file
            String transcription = speechController.model.transcribeAudio("C:\\Users\\Changhyun\\Desktop\\asdf\\Friend\\Friend\\recording.wav");
            chatController.model.addChatMessage(transcription); // Add transcribed text to chat
            isTranscribing = false;
            gptController.processTranscription(transcription.isEmpty() ? "hello GPT" : transcription); // Use "hello GPT" if transcription is empty
        }
        view.displayRecordingStatus(model.isRecording);
    }

    void draw() {
        view.displayVolume(model.getVolume());
    }
}