package core

class Collect {

    Integer id
    Date orderDate
    Date collectedDate
    String imageUpload
    Boolean isCollected
    Date scheduleDateCollect
    Double quantityOfCoins
    Collaborator collaborator
    Company company

    Collect(){
        isCollected = false
        quantityOfCoins = 0.0
    }

    static hasMany = [materialTypes : MaterialType]

    static belongsTo = [MaterialType]

    static constraints = {
        orderDate nullable: false
        collectedDate nullable: true
        imageUpload nullable: true, blank: true
        company nullable: true
        collaborator nullable: false
        scheduleDateCollect nullable: true
        quantityOfCoins nullable: false
    }
}
