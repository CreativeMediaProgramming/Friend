import http.requests.*;
import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;

class GPTModel {
    String apiKey;
    String apiUrl = "https://api.openai.com/v1/chat/completions";
    String userName;
    int userAge;
    String userGender;
    String userMBTI;
    PApplet parent;
    

    GPTModel(PApplet parent) {
        this.parent = parent;
        apiKey = loadApiKey();
        loadUserData();
        println("Loaded API Key: " + apiKey); // Debugging output
    }

    String loadApiKey() {
        String key = null;
        try {
            // Use absolute path if necessary

String filePath = parent.sketchPath("config.txt");

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

void loadUserData() {
    try {
        // Use parent to get the sketch path for a relative file path
        String filePath = parent.sketchPath("DATA.txt");
        BufferedReader reader = new BufferedReader(new FileReader(filePath));
        userName = reader.readLine();
        userAge = Integer.parseInt(reader.readLine());
        userGender = reader.readLine();
        userMBTI = reader.readLine();
        reader.close();
        
        // 디버깅 출력
        println("UserName: " + userName);
        println("UserAge: " + userAge);
        println("UserGender: " + userGender);
        println("UserMBTI: " + userMBTI);
        
        println("User data loaded: " + userName + ", " + userAge + ", " + userGender + ", " + userMBTI);
    } catch (IOException e) {
        println("Error reading user data: " + e.getMessage());
    } catch (NumberFormatException e) {
        println("Error parsing user age: " + e.getMessage());
    }
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
                        + "{\"role\": \"system\", \"content\": \"Always start your response by addressing the user by their name, " + userName + ". Respond in a conversational manner, using 2-3 sentences. Consider the user's age, gender, and MBTI.\"},"
                        + "{\"role\": \"user\", \"content\": \"Name: " + userName + ", Age: " + userAge + ", Gender: " + userGender + ", MBTI: " + userMBTI + ". " + escapeJson(userInput) + "\"}]}";
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
                   .replace("\t", "\\t")
                   .replace("/", "\\/");
    }
}