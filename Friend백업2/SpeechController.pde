class SpeechController {
    SpeechModel model;
    SpeechView view;

    SpeechController(PApplet parent) {
        model = new SpeechModel(parent);
        view = new SpeechView(parent);
    }

    void transcribeAndDisplay(String filePath) {
        String transcription = model.transcribeAudio(filePath);
        view.displayTranscription(transcription);
    }
}