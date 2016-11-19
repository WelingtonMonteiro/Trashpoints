package core

class Collect {

    Integer id
    Date orderDate
    Date collectedDate
    String imageUpload
    Boolean isCollected
    Client client
    Company company

    Collect(){
        isCollected = false
    }

    static hasMany = [materialTypes : MaterialType]
    static belongsTo = [MaterialType]

    static constraints = {
        orderDate nullable: false
        collectedDate nullable: true
        imageUpload nullable: true, blank: true
        isCollected min: false

        company nullable: true
    }
}
