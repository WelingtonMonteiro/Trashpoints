package core

class Notification {

    String header
    String body
    String username;
    Integer wasRead;

    static constraints = {
        header blank: false, nullable: false, maxSize: 100
        body blank: false, nullable: false, maxSize: 1000
        username blank: false, nullable: false
    }
}
