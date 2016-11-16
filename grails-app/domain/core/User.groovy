package core

class User {

    String email
    String password
    static hasOne = [address:Address]

    static constraints = {
        email email: true, blank: false, nullable: false, unique: true
        password blank: false, nullable: false, minSize: 6
    }

}
