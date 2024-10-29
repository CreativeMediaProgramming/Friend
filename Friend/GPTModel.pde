import http.requests.*;

class GPTModel {
    String apiKey = ""; // GPT API key
    String apiUrl = "https://api.openai.com/v1/chat/completions";

    String getResponseFromGPT(String userInput) {
        PostRequest post = new PostRequest(apiUrl);
        post.addHeader("Authorization", "Bearer " + apiKey);
        post.addHeader("Content-Type", "application/json");

        // JSON 형식으로 메시지 구성
        String jsonData = "{\"model\": \"gpt-4o-mini\", \"messages\": ["
                        + "{\"role\": \"system\", \"content\": \"You are a helpful assistant.\"},"
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