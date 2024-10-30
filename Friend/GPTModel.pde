import http.requests.*;
import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;

class GPTModel {
    String apiKey;
    String apiUrl = "https://api.openai.com/v1/chat/completions";

    GPTModel() {
        apiKey = loadApiKey();
        println("Loaded API Key: " + apiKey); // Debugging output
    }

    String loadApiKey() {
        String key = null;
        try {
            // Use absolute path if necessary
            String filePath = "C:\\Users\\Changhyun\\Desktop\\asdf\\Friend\\Friend\\config.txt"; // Change to absolute path if needed
            println("Attempting to read API key from: " + filePath); // Debugging output

            BufferedReader reader = new BufferedReader(new FileReader(filePath));
            key = reader.readLine();
            reader.close();

            if (key == null || key.isEmpty()) {
                println("API key is empty or null after reading from file."); // Debugging output
            } else {
                println("Successfully read API key from file."); // Debugging output
            }
        } catch (IOException e) {
            println("Error reading API key: " + e.getMessage());
        }
        return key;
    }

    String getResponseFromGPT(String userInput) {
        if (apiKey == null || apiKey.isEmpty()) {
            return "Error: API key is missing.";
        }

        PostRequest post = new PostRequest(apiUrl);
        post.addHeader("Authorization", "Bearer " + apiKey);
        post.addHeader("Content-Type", "application/json");

        // JSON 형식으로 메시지 구성
        String jsonData = "{\"model\": \"gpt-4o-mini\", \"messages\": ["
                        + "{\"role\": \"system\", \"content\": \"Respond to the user's answer in a conversational manner, using 2-3 sentences.\"},"
                        + "{\"role\": \"user\", \"content\": \"" + escapeJson(userInput) + "\"}]}";
        post.addData(jsonData);

        post.send();

        String responseContent = post.getContent();
        println("Response Content: " + responseContent); // 응답 내용을 출력

        if (responseContent != null) {
            try {
                JSONObject jsonResponse = parseJSONObject(responseContent);
                JSONArray choices = jsonResponse.getJSONArray("choices");
                if (choices != null && choices.size() > 0) {
                    JSONObject firstChoice = choices.getJSONObject(0);
                    JSONObject messageObj = firstChoice.getJSONObject("message");
                    return messageObj.getString("content");
                }
            } catch (Exception e) {
                println("Error parsing JSON response: " + e.getMessage());
            }
        }
        return "Error: No response from GPT.";
    }

    // JSON 문자열 내에 포함된 특수 문자를 이스케이프 처리
    String escapeJson(String text) {
        return text.replace("\\", "\\\\")
                   .replace("\"", "\\\"")
                   .replace("\b", "\\b")
                   .replace("\f", "\\f")
                   .replace("\n", "\\n")
                   .replace("\r", "\\r")
                   .replace("\t", "\\t");
    }
}