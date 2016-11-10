package core

class Company extends User{

    String segment
    String phone
    String site
    String zipCode
    String street
    String number
    String neighborhood
    String city
    String state

    static constraints = {
        segment blank: false, nullable: false
        phone blank: false, nullable: false
        site blank: true, nullable: true, url: true
        zipCode blank: true, nullable: true, minSize: 8, maxSize: 9
        street blank: true, nullable: true, minSize: 2, maxSize: 255
        number blank: true, nullable: true
        neighborhood blank: true, nullable: true, minSize: 2, maxSize: 255
        city blank: true, nullable: true, minSize: 2
        state blank: true, nullable: true, minSize: 2
    }
}
