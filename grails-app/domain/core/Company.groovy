package core

class Company extends User{
    String identificationNumber //corporate taxpayer registry, cnpj
    String tradingName
    String segment
    String typeOfCompany
    String phone
    String site
    String zipCode
    String street
    String number
    String neighborhood
    String city
    String state

    static constraints = {
        identificationNumber blank: false, nullable: false, minSize: 18, maxSize: 18 //Ex.: 11.111.111/1111-11
        tradingName blank: false, nullable: false
        segment blank: false, nullable: false
        typeOfCompany blank: false, nullable: false, inList: ["coleta", "parceira"]
        phone blank: false, nullable: false
        site blank: true, nullable: true, url: true
        zipCode blank: true, nullable: true, minSize: 9, maxSize: 9 //Ex.: 11111-111
        street blank: true, nullable: true, minSize: 2, maxSize: 255
        number blank: true, nullable: true
        neighborhood blank: true, nullable: true, minSize: 2, maxSize: 255
        city blank: true, nullable: true, minSize: 2
        state blank: true, nullable: true, minSize: 2
    }
}
