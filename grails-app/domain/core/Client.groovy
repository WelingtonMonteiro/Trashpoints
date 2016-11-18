package core

class Client  extends User{
    String name
    String phone
    String photo
    Date dateOfBirth
    Boolean isAddressEqual

    static hasMany = [collects: Collect]
    static hasOne = [address:Address]

    static constraints = {
        name blank: false, nullable: false, minSize: 5, maxSize: 60
        phone blank: false, nullable: false, matches: "\\(\\d{2}\\)\\s\\d{4}-?\\d{4}"
        photo blank: true, nullable: true, maxSize: 1024 * 1024 * 2 // Limit upload file size to 2MB
        dateOfBirth nullable: false
        address nullable: false
    }
}
