package core

class Company{
    String identificationNumber //corporate taxpayer registry, cnpj
    String companyName
    String tradingName
    String segment
    String typeOfCompany
    String phone
    String site
    Address address

    static hasMany = [collects: Collect]

    static constraints = {
        identificationNumber blank: false, nullable: false, minSize: 18, maxSize: 18, matches: "\\d{2}.\\d{3}.\\d{3}[/]\\d{4}-\\d{2}", unique: true
        companyName blank: false, nullable: false, minSize: 2
        tradingName blank: false, nullable: false
        segment blank: false, nullable: false
        typeOfCompany blank: false, nullable: false, inList: ["coleta", "parceira"]
        phone blank: false, nullable: false, matches: "\\(\\d{2}\\)\\s\\d{4}-?\\d{4}"
        site blank: true, nullable: true, url: true
        address nullable: true
    }
}
