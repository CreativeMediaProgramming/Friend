class IntroModel {
    private String userName;
    private int userAge;
    private boolean userSex; // true면 MALE, false면 FEMALE
    private String userMBTI;

    IntroModel(String userName, int userAge, boolean userSex, String userMBTI) {
        this.userName = userName;
        this.userAge = userAge;
        this.userSex = userSex;
        this.userMBTI = userMBTI;
    }

    public String getUserName() {
        return userName;
    }

    public int getUserAge() {
        return userAge;
    }

    public boolean isUserSex() {
        return userSex;
    }

    public String getUserMBTI() {
        return userMBTI;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public void setUserAge(int userAge) {
        this.userAge = userAge;
    }

    public void setUserSex(boolean userSex) {
        this.userSex = userSex;
    }

    public void setUserMBTI(String userMBTI) {
        this.userMBTI = userMBTI;
    }
}