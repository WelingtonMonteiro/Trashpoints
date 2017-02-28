package core

class ContactUs {

    Integer id
    Integer contactType
    String contactText
    Integer userId

    static constraints = {

        contactType nullable: false, notEqual: 0
        contactText nullable: false, blank: false
    }
}
