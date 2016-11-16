package core

class Client  extends User{
    String name
    String phone
    String photo
    Date dateOfBirthday
    Boolean isAddressEqual

    static hasMany = [addresses: Address, collects: Collect]

    static constraints = {
        name blank: false, nullable: false, minSize: 5, maxSize: 60
        phone blank: false, nullable: false, matches: "\\(\\d{2}\\)\\s\\d{4}-?\\d{4}"
        photo blank: true, nullable: true
        dateOfBirthday nullable: false
        isAddressEqual nullable: false, min: true
    }
}
