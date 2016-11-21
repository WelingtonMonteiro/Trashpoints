package core

class Collect {

    Integer id
    Date orderDate
    Date collectedDate
    String imageUpload
    Boolean isCollected
    Collaborator collaborator
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
        company nullable: true
        collaborator nullable: false
    }
}
