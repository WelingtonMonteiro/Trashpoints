package core

class Client {
    String phone
    String photo

    static constraints = {
        phone blank: false, nullable: false, matches: "\\(\\d{2}\\)\\s\\d{4}-?\\d{4}"
        photo blank: false, nullable: false
    }
}
