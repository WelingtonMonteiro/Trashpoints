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
        zipCode blank: true, nullable: true, minSize: 8, maxSize: 11, matches: "\\d{5}-\\d{3}|\\d{8}"
        street blank: true, nullable: true, minSize: 2, maxSize: 255
        number blank: true, nullable: true
        neighborhood blank: true, nullable: true, minSize: 2, maxSize: 255
        city blank: true, nullable: true, minSize: 2
        state blank: true, nullable: true, minSize: 2
        latitude nullable: true, min: -90.0F, max: 90.0F
        longitude nullable: true, min: -180.0F, max: 180.0F
    }
}
