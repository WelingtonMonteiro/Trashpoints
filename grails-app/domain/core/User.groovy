package core

class User {

    String name
    String email
    String password

    static constraints = {
        name blank: false, nullable: false, minSize: 2
        email email: true, blank: false, nullable: false, unique: true
        password blank: false, nullable: false, minSize: 6, maxSize: 20
    }

}
