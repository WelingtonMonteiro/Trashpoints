package core

import java.awt.CheckboxMenuItem

class Collect {

    Integer id
    Date date
    String image_upload
    static hasMany = [materialTypes : MaterialType]
    static  belongsTo = MaterialType

    static constraints = {

    }
}
