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

    static belongsTo = [Collaborator, Company]

    static constraints = {
        zipCode blank: false, nullable: false, minSize: 8, maxSize: 11, matches: "\\d{5}-\\d{3}|\\d{8}"
        street blank: false, nullable: false, minSize: 2, maxSize: 255
        number blank: false, nullable: false
        neighborhood blank: false, nullable: false, minSize: 2, maxSize: 255
        city blank: false, nullable: false, minSize: 2
        state blank: false, nullable: false, minSize: 2
        latitude nullable: true, min: -90.0F, max: 90.0F
        longitude nullable: true, min: -180.0F, max: 180.0F
    }
}
