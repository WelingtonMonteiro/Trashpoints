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
        identificationNumber blank: false, nullable: false, minSize: 18, maxSize: 18, matches: "\\d{2}.\\d{3}.\\d{3}[/]\\d{4}-\\d{2}"
        tradingName blank: false, nullable: false
        segment blank: false, nullable: false
        typeOfCompany blank: false, nullable: false, inList: ["coleta", "parceira"]
        phone blank: false, nullable: false, matches: "\\(\\d{2}\\)\\s\\d{4}-?\\d{4}"
        site blank: true, nullable: true, url: true
        zipCode blank: true, nullable: true, minSize: 9, maxSize: 9, matches: "\\d{5}-\\d{3}"
        street blank: true, nullable: true, minSize: 2, maxSize: 255
        number blank: true, nullable: true
        neighborhood blank: true, nullable: true, minSize: 2, maxSize: 255
        city blank: true, nullable: true, minSize: 2
        state blank: true, nullable: true, minSize: 2
    }
}
