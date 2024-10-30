class IntroController {
    IntroModel model;
    boolean introComplete = false;
    PApplet parent;
    PImage bg;
    float opacity = 0;
    boolean fadingIn = true;
    boolean showNameInput = false;
    boolean showGreeting = false;
    boolean showGenderSelection = false;
    boolean showAgeInput = false;
    boolean showMBTIInput = false;
    boolean showReadyFrame = false;
    String name = "";
    String gender = "";
    String age = "";
    String mbti = "";
    String[] validMBTIs = { "istj", "isfj", "infj", "intj", "istp", "isfp", "infp", "intp", 
                            "estp", "esfp", "enfp", "entp", "estj", "esfj", "enfj", "entj" };

    IntroController(PApplet parent) {
        this.parent = parent;
        bg = parent.loadImage("background.jpg"); // 배경 이미지 로드
        parent.textAlign(PApplet.CENTER, PApplet.CENTER); // 텍스트 중앙 정렬
    }

    boolean isValidMBTI(String mbti) {
        mbti = mbti.toLowerCase();
        for (String validMBTI : validMBTIs) {
            if (mbti.equals(validMBTI)) {
                return true;
            }
        }
        return false;
    }

    void draw() {
        parent.image(bg, 0, 0, parent.width, parent.height); // 배경 이미지 설정

        if (!showNameInput && !showGreeting && !showGenderSelection && !showAgeInput && !showMBTIInput && !showReadyFrame) {
            // 첫 번째 프레임 (페이드 인/아웃 텍스트)
            parent.fill(0, 0, 0, opacity);
            parent.textSize(150);
            parent.text("FRIEND", parent.width / 2, parent.height / 2 - 100);
            parent.textSize(50);
            parent.text("FOR YOU, WITH YOU", parent.width / 2, parent.height / 2 + 100);

            if (fadingIn) {
                opacity += 7;
                if (opacity >= 255) {
                    opacity = 255;
                    fadingIn = false;
                }
            } else {
                opacity -= 7;
                if (opacity <= 0) {
                    opacity = 0;
                    showNameInput = true;
                }
            }
        } else if (showNameInput && !showGreeting && !showGenderSelection && !showAgeInput && !showMBTIInput) {
            // 두 번째 프레임 (이름 입력)
            parent.fill(0);
            parent.textSize(50);
            parent.text("Your Name", parent.width / 2, parent.height / 2 - 100);
            
            parent.fill(255);
            parent.rect(parent.width / 2 - 150, parent.height / 2 - 20, 300, 50); // 이름 입력 상자
            parent.fill(0);
            parent.text(name, parent.width / 2, parent.height / 2); // 입력된 이름 표시
            
            parent.noFill();
            parent.stroke(0);
            parent.rect(parent.width / 2 + 180, parent.height / 2 + 100, 100, 50); // NEXT 버튼 테두리
            parent.fill(0);
            parent.textSize(30);
            parent.text("NEXT", parent.width / 2 + 230, parent.height / 2 + 125); // NEXT 버튼 텍스트
        } else if (showGreeting && !showGenderSelection && !showAgeInput && !showMBTIInput) {
            // 세 번째 프레임 (Hello, 이름 페이드 인/아웃)
            parent.fill(0, 0, 0, opacity);
            parent.textSize(100);
            parent.text("Hello,", parent.width / 2, parent.height / 2 - 50);
            parent.text(name, parent.width / 2, parent.height / 2 + 50);

            if (fadingIn) {
                opacity += 7;
                if (opacity >= 255) {
                    opacity = 255;
                    fadingIn = false;
                }
            } else {
                opacity -= 7;
                if (opacity <= 0) {
                    opacity = 0;
                    fadingIn = true; 
                    showGreeting = false;
                    showGenderSelection = true; // 네 번째 프레임으로 전환
                }
            }
        } else if (showGenderSelection && !showAgeInput && !showMBTIInput) {
            // 네 번째 프레임 (성별 선택)
            parent.fill(0);
            parent.textSize(70);
            parent.text("YOU ARE..", parent.width / 2, parent.height / 2 - 100);

            // "MALE" 버튼
            parent.noFill();
            parent.stroke(0);
            parent.rect(parent.width / 2 - 200, parent.height / 2 + 50, 150, 70);
            parent.fill(0);
            parent.textSize(30);
            parent.text("MALE", parent.width / 2 - 125, parent.height / 2 + 85);

            // "FEMALE" 버튼
            parent.noFill();
            parent.stroke(0);
            parent.rect(parent.width / 2 + 50, parent.height / 2 + 50, 150, 70);
            parent.fill(0);
            parent.text("FEMALE", parent.width / 2 + 125, parent.height / 2 + 85);
        } else if (showAgeInput && !showMBTIInput) {
            // 다섯 번째 프레임 (나이 입력)
            parent.fill(0);
            parent.textSize(70);
            parent.text("Your Age..", parent.width / 2, parent.height / 2 - 100);

            // 나이 입력 상자
            parent.fill(255);
            parent.rect(parent.width / 2 - 75, parent.height / 2 - 20, 150, 50);
            parent.fill(0);
            parent.textSize(30);
            parent.text(age, parent.width / 2, parent.height / 2); // 입력된 나이 표시
            
            // NEXT 버튼
            parent.noFill();
            parent.stroke(0);
            parent.rect(parent.width / 2 + 100, parent.height / 2 + 100, 100, 50);
            parent.fill(0);
            parent.text("NEXT", parent.width / 2 + 150, parent.height / 2 + 125);
        } else if (showMBTIInput && !showReadyFrame) {
            // 여섯 번째 프레임 (MBTI 입력)
            parent.fill(0);
            parent.textSize(70);
            parent.text("Your MBTI..", parent.width / 2, parent.height / 2 - 100);

            // MBTI 입력 상자
            parent.fill(255);
            parent.rect(parent.width / 2 - 75, parent.height / 2 - 20, 150, 50);
            parent.fill(0);
            parent.textSize(30);
            parent.text(mbti, parent.width / 2, parent.height / 2); // 입력된 MBTI 표시

            // NEXT 버튼
            parent.noFill();
            parent.stroke(0);
            parent.rect(parent.width / 2 + 100, parent.height / 2 + 100, 100, 50);
            parent.fill(0);
            parent.text("NEXT", parent.width / 2 + 150, parent.height / 2 + 125);
        } else if (showReadyFrame) {
            // 일곱 번째 프레임 (ARE YOU READY WITH FRIEND? 페이드 인)
            parent.fill(0, 0, 0, opacity);
            parent.textSize(70);
            parent.text("ARE YOU READY", parent.width / 2, parent.height / 2 - 50); // 첫 번째 줄
            parent.text("WITH FRIEND?", parent.width / 2, parent.height / 2 + 50); // 두 번째 줄

            if (fadingIn) {
                opacity += 10;
                if (opacity >= 255) {
                    opacity = 255;
                    fadingIn = false;
                }
            }

            // YES 버튼 (텍스트 크기를 줄이고 사각형에 맞춤)
            parent.noFill();
            parent.stroke(0);
            parent.rect(parent.width / 2 + 50, parent.height / 2 + 150, 120, 50); // YES 버튼 테두리 크기 조정
            parent.fill(0);
            parent.textSize(20); // 텍스트 크기 조정
            parent.text("YES!", parent.width / 2 + 110, parent.height / 2 + 175);
        }
    }

    void keyPressed(char key) {
        if (showNameInput && key != PApplet.CODED) {
            if (key == PApplet.BACKSPACE && name.length() > 0) {
                name = name.substring(0, name.length() - 1); // 마지막  제
            } else if (key != PApplet.BACKSPACE && key != PApplet.ENTER && key != PApplet.RETURN) {
                name += key; // 이름에 글자 추가
            }
        } else if (showAgeInput && key != PApplet.CODED) {
            if (key == PApplet.BACKSPACE && age.length() > 0) {
                age = age.substring(0, age.length() - 1); // 마지막 글자 삭제
            } else if (key >= '0' && key <= '9') { // 숫자만 입력 받음
                age += key;
            }
        } else if (showMBTIInput && key != PApplet.CODED) {
            if (key == PApplet.BACKSPACE && mbti.length() > 0) {
                mbti = mbti.substring(0, mbti.length() - 1); // 마지막 글자 삭제
            } else if (key != PApplet.BACKSPACE && key != PApplet.ENTER && key != PApplet.RETURN) {
                mbti += key; // MBTI에 글자 추가
            }
        }
    }

    void mousePressed() {
        // 두 번째 프레임의 "NEXT" 버튼 클릭 체크
        if (showNameInput && parent.mouseX > parent.width / 2 + 180 && parent.mouseX < parent.width / 2 + 280 &&
            parent.mouseY > parent.height / 2 + 100 && parent.mouseY < parent.height / 2 + 150) {
            if (name.length() > 0) { // 이름이 입력되었는지 확인
                if (model == null) {
                    model = new IntroModel(name, 0, false, ""); // 모델 초기화
                }
                model.setUserName(name); // 모델에 이름 저장
                showNameInput = false;
                showGreeting = true;
                opacity = 0; // 세 번째 프레임으로 넘어가면서 페이드 인 초기화
                fadingIn = true; // 페이드 인 시작
            } else {
                println("이름을 입력하세요."); // 이름이 없을 때 알림
            }
        }

        // 네 번째 프레임의 "MALE" 버튼 클릭 체크
        if (showGenderSelection && parent.mouseX > parent.width / 2 - 200 && parent.mouseX < parent.width / 2 - 50 &&
            parent.mouseY > parent.height / 2 + 50 && parent.mouseY < parent.height / 2 + 120) {
            gender = "MALE";
            model.setUserSex(true); // 모델에 성별 저장
            showGenderSelection = false;
            showAgeInput = true; // 나이 입력 프레임으로 전환
        }

        // 네 번째 프레임의 "FEMALE" 버튼 클 체크
        if (showGenderSelection && parent.mouseX > parent.width / 2 + 50 && parent.mouseX < parent.width / 2 + 200 &&
            parent.mouseY > parent.height / 2 + 50 && parent.mouseY < parent.height / 2 + 120) {
            gender = "FEMALE";
            model.setUserSex(false); // 모델에 성별 저장
            showGenderSelection = false;
            showAgeInput = true; // 나이 입력 프레임으로 전환
        }

        // 다섯 번째 프레임의 "NEXT" 버튼 클릭 체크 (나이 입력 프레임)
        if (showAgeInput && parent.mouseX > parent.width / 2 + 100 && parent.mouseX < parent.width / 2 + 200 &&
            parent.mouseY > parent.height / 2 + 100 && parent.mouseY < parent.height / 2 + 150) {
            if (age.length() > 0) { // 나이가 입력되었는지 확인
                model.setUserAge(Integer.parseInt(age)); // 모델에 나이 저장
                showAgeInput = false;
                showMBTIInput = true; // MBTI 입력 프레임으로 전환
            } else {
                println("나이를 입력하세요."); // 나이가 없을 때 알림
            }
        }

        // 여섯 번째 프레임의 "NEXT" 버튼 클릭 체크 (MBTI 입력 프레임)
        if (showMBTIInput && parent.mouseX > parent.width / 2 + 100 && parent.mouseX < parent.width / 2 + 200 &&
            parent.mouseY > parent.height / 2 + 100 && parent.mouseY < parent.height / 2 + 150) {
            if (mbti.length() > 0 && isValidMBTI(mbti)) { // MBTI가 유효한지 검사
                model.setUserMBTI(mbti); // 모델에 MBTI 저장
                showMBTIInput = false;
                showReadyFrame = true; // "ARE YOU READY" 프레임으로 전환
                opacity = 0; // 페이드 인 초기화
                fadingIn = true;
            } else {
                println("유효한 MBTI를 입력하세요. (e.g., INFP, ESTJ 등)"); // 유효하지 않은 MBTI 알림
                mbti = ""; // 잘못된 입력일 경우 초기화
            }
        }

        // 일곱 번째 프레임의 "YES" 버튼 클릭 체크 (READY 프레임)
        if (showReadyFrame && parent.mouseX > parent.width / 2 + 50 && parent.mouseX < parent.width / 2 + 170 &&
            parent.mouseY > parent.height / 2 + 150 && parent.mouseY < parent.height / 2 + 200) {
            introComplete = true; // 인트로 완료 표시
            saveUserData(); // 사용자 데이터 저장
            println("Main Content 시작"); // 메인 콘텐츠 전환
        }
    }

    void startIntro() {
        introComplete = false;
        showNameInput = false;
        showGreeting = false;
        showGenderSelection = false;
        showAgeInput = false;
        showMBTIInput = false;
        showReadyFrame = false;
        name = "";
        gender = "";
        age = "";
        mbti = "";
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
            println("User data saved successfully."); // 데이터 저장 성공 메시지
        } catch (Exception e) {
            e.printStackTrace();
            println("Failed to save user data."); // 데이터 저장 실패 메시지
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