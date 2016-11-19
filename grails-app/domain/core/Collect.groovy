package core

class Collect {

    Integer id
    Date orderDate
    Date collectedDate
    String imageUpload
    Boolean isCollected
    Client client
    Company company

    static hasMany = [materialTypes : MaterialType]
    static belongsTo = [MaterialType]

    static constraints = {
        orderDate nullable: false, min: new Date()
        collectedDate nullable: true
        imageUpload nullable: true
        isCollected min: false

        company nullable: true
    }
}
