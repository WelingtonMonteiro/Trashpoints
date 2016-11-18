package core

class MaterialType {

    Integer id
    String name
    static hasMany = [collects : Collect]

    static constraints = {
        name blank: false, nullable: false, size: 1..20
    }
}
