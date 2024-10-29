import http.requests.*;
import java.io.File;
import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;

class SpeechModel {
    String apiKey;
    String transcriptionText = "";

    SpeechModel() {
        apiKey = loadApiKey();
        println("Loaded API Key: " + apiKey); // Debugging output
    }

    String loadApiKey() {
        try {
            BufferedReader reader = new BufferedReader(new FileReader("C:\\Users\\Changhyun\\Desktop\\asdf\\Friend\\Friend\\config.txt"));
            String key = reader.readLine();
            reader.close();
            return key;
        } catch (IOException e) {
            println("Error reading API key: " + e.getMessage());
            return null;
        }
    }

    String transcribeAudio(String filePath) {
        if (apiKey == null || apiKey.isEmpty()) {
            return "Error: API key is missing.";
        }

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