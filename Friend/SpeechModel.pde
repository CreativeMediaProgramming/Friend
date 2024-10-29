import http.requests.*;
import java.io.File;
import config;

class SpeechModel {
    String apiKey = GPT_API_KEY;
    String transcriptionText = "";

    String transcribeAudio(String filePath) {
        File audioFile = new File(filePath);
        println("Checking file path: " + audioFile.getAbsolutePath()); // Debugging output
        if (!audioFile.exists()) {
            println("Audio file not found at: " + audioFile.getAbsolutePath()); // Debugging output
            return "Audio file not found.";
        }

        PostRequest post = new PostRequest("https://api.openai.com/v1/audio/transcriptions");
        post.addHeader("Authorization", "Bearer " + apiKey);
        post.addFile("file", filePath);
        post.addData("model", "whisper-1");
        post.addData("response_format", "text");
        post.send();

        if (post.getContent() != null) {
            transcriptionText = post.getContent();
        } else {
            transcriptionText = "Failed to transcribe audio.";
        }
        return transcriptionText;
    }
}