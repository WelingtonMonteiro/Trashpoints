package core

class Address {

    String zipCode
    String street
    String number
    String neighborhood
    String city
    String state
    Float longitude
    Float latitude
    Client client
    Company company

    static constraints = {
        zipCode blank: true, nullable: true, minSize: 9, maxSize: 9, matches: "\\d{5}-\\d{3}"
        street blank: true, nullable: true, minSize: 2, maxSize: 255
        number blank: true, nullable: true
        neighborhood blank: true, nullable: true, minSize: 2, maxSize: 255
        city blank: true, nullable: true, minSize: 2
        state blank: true, nullable: true, minSize: 2
        latitude nullable: true, max:180.0F, scale:6
        longitude nullable: true, max:180.0F, scale:6
        client nullable: true
        company nullable: true
    }
}
