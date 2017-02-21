package core

class MaterialType {

    Integer id
    String name
    String url

    static hasMany = [collects : Collect]

    static constraints = {
        name blank: false, nullable: false, size: 1..20, unique: true
        url blank: true, nullable: true
    }
}
