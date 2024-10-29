class IntroController {
    IntroModel model;
    IntroView view;
    boolean introComplete = false;
    PApplet parent;

    IntroController(PApplet parent) {
        this.parent = parent;
        view = new IntroView(parent);
    }

    void startIntro() {
        introComplete = false;
        view.currentPrompt = 0;
        for (int i = 0; i < view.responses.length; i++) {
            view.responses[i] = ""; // 응답 배열 초기화
        }
    }

    void keyPressed(char key) {
        if (key == PApplet.ENTER || key == PApplet.RETURN) {
            view.currentPrompt++;
            if (view.currentPrompt >= view.prompts.length) {
                String userName = view.responses[0];
                int userAge = Integer.parseInt(view.responses[1]);
                boolean userSex = view.responses[2].equalsIgnoreCase("M");
                String userMBTI = view.responses[3];
                model = new IntroModel(userName, userAge, userSex, userMBTI);
                saveUserData();
                introComplete = true;
            }
        } else if (key == PApplet.BACKSPACE) {
            if (view.responses[view.currentPrompt].length() > 0) {
                view.responses[view.currentPrompt] = view.responses[view.currentPrompt].substring(0, view.responses[view.currentPrompt].length() - 1);
            }
        } else if (key != PApplet.CODED) {
            view.responses[view.currentPrompt] += key;
        }
    }

    void saveUserData() {
        try {
            PrintWriter writer = parent.createWriter("DATA.txt");
            writer.println(model.getUserName());
            writer.println(model.getUserAge());
            writer.println(model.isUserSex() ? "M" : "F");
            writer.println(model.getUserMBTI());
            writer.flush();
            writer.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    boolean loadUserData() {
        try {
            BufferedReader reader = parent.createReader("DATA.txt");
            String userName = reader.readLine();
            int userAge = Integer.parseInt(reader.readLine());
            boolean userSex = reader.readLine().equalsIgnoreCase("M");
            String userMBTI = reader.readLine();
            model = new IntroModel(userName, userAge, userSex, userMBTI);
            introComplete = true;
            reader.close();
            return true;
        } catch (Exception e) {
            return false;
        }
    }
}