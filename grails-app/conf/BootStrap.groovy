import core.*

class BootStrap {

    def springSecurityService

    def init = { servletContext ->
        //criando os materiais recicláveis

        def plastic = MaterialType.findByName('PLÁSTICO') ? MaterialType.findByName('PLÁSTICO') : new MaterialType(name: 'PLÁSTICO', url: '/Trashpoints/images/plastico.png')
        def paper = MaterialType.findByName('PAPEL') ? MaterialType.findByName('PAPEL') : new MaterialType(name: 'PAPEL', url: '/Trashpoints/images/papel.png')
        def glasses = MaterialType.findByName('VIDRO') ? MaterialType.findByName('VIDRO') : new MaterialType(name: 'VIDRO', url: '/Trashpoints/images/vidro.png')
        def metal = MaterialType.findByName('METAL') ? MaterialType.findByName('METAL') : new MaterialType(name: 'METAL', url: '/Trashpoints/images/metal.png')
        def organic = MaterialType.findByName('ORGÂNICO') ? MaterialType.findByName('ORGÂNICO') : new MaterialType(name: 'ORGÂNICO', url: '/Trashpoints/images/residuos_organicos.png')
        def chemich = MaterialType.findByName('QUÍMICO') ? MaterialType.findByName('QUÍMICO') : new MaterialType(name: 'QUÍMICO', url: '/Trashpoints/images/residuos_radioativos.png')
        def entulho = MaterialType.findByName('ENTULHO') ? MaterialType.findByName('ENTULHO') : new MaterialType(name: 'ENTULHO', url: '/Trashpoints/images/residuos_nao_reciclaveis.png')

        if(MaterialType.findByName('ALUMÍNIO')) MaterialType.findByName('ALUMÍNIO').delete()

        plastic.url = '/Trashpoints/images/plastico.png'
        paper.url = '/Trashpoints/images/papel.png'
        glasses.url = '/Trashpoints/images/vidro.png'
        metal.url = '/Trashpoints/images/metal.png'
        organic.url = '/Trashpoints/images/organico.png'
        chemich.url = '/Trashpoints/images/residuos_radioativos.png'
        entulho.url = '/Trashpoints/images/residuos_nao_reciclaveis.png'

        plastic.save()
        paper.save()
        glasses.save()
        metal.save()
        organic.save()
        chemich.save()
        entulho.save()

        //criando permissões
        def userRole = Role.findByAuthority('ROLE_COLLABORATOR') ?: new Role('ROLE_COLLABORATOR').save()
        def companyColRole = Role.findByAuthority('ROLE_COMPANY_COLLECT') ?: new Role('ROLE_COMPANY_COLLECT').save()
        def companyPartColRole = Role.findByAuthority('ROLE_COMPANY_PARTNER') ?: new Role('ROLE_COMPANY_PARTNER').save()
        def adminRole = Role.findByAuthority('ROLE_ADMIN') ?: new Role('ROLE_ADMIN').save()

        def collaborator = Collaborator.findByName("welington monteiro") ?:
                new Collaborator(
                        name: "welington monteiro",
                        phone: "(11) 1111-1111",
                        photo: "",
                        isAddressEqual: true,
                        dateOfBirth: new Date(),
                        address: new Address(
                                city: "Lorena",
                                state: "SP",
                                zipCode: "12602-010",
                                latitude: 0,
                                longitude: 0,
                                neighborhood: "Cabelinha",
                                street: "Rua Dr. Paulo Cardoso",
                                number: 457
                        )).save()


        def companyCollect = Company.findByIdentificationNumber("11.111.111/1111-11") ?:
                new Company(
                        companyName: "Empresa Coletora",
                        identificationNumber: "11.111.111/1111-11",
                        tradingName: "Coletora",
                        segment: "reciclagem de lixo",
                        typeOfCompany: "coleta",
                        phone: "(11) 1111-1111",
                        site: "http://www.dsdsds.com.br",
                        address: new Address(
                                city: "Lorena",
                                state: "SP",
                                zipCode: "12602-010",
                                latitude: 0,
                                longitude: 0,
                                neighborhood: "Cabelinha",
                                street: "Rua Dr. Paulo Cardoso",
                                number: 123
                        )).save()


        def companyPartner = Company.findByIdentificationNumber("22.222.222/2222-22") ?:
                new Company(
                        companyName: "Empresa Parceira",
                        identificationNumber: "22.222.222/2222-22",
                        tradingName: "Parceira",
                        segment: "comercio de produtos",
                        typeOfCompany: "parceira",
                        phone: "(22) 2222-2222",
                        site: "http://www.dsdsds.com.br",
                        address: new Address(
                                city: "Lorena",
                                state: "SP",
                                zipCode: "12602-010",
                                latitude: 0,
                                longitude: 0,
                                neighborhood: "Cabelinha",
                                street: "Rua Dr. Paulo Cardoso",
                                number: 456
                        )).save()

        //criando usuários e ralcionando com o tipos
        def user = User.findByUsername('colaborador@trashpoints.com.br') ?
                User.findByUsername('colaborador@trashpoints.com.br') :
                new User('colaborador@trashpoints.com.br', 'colaborador')

        user.collaborator = collaborator
        user.save()

        def cCollect = User.findByUsername('ccoleta@trashpoints.com.br') ?
                User.findByUsername('ccoleta@trashpoints.com.br') :
                new User('ccoleta@trashpoints.com.br', 'coleta')

        cCollect.company = companyCollect
        cCollect.save()

        def cPartner = User.findByUsername('cparceiro@trashpoints.com.br') ?
                User.findByUsername('cparceiro@trashpoints.com.br') :
                new User('cparceiro@trashpoints.com.br', 'parceiro')

        cPartner.company = companyPartner
        cPartner.save()

        def admin = new User('admin@trashpoints.com.br', 'administrator').save()

        //salvando relacionamento entre usuarios e os tipos de usuarios
        companyPartner.user = cPartner
        companyPartner.save()

        companyCollect.user = cCollect
        companyCollect.save()

        collaborator.user = user
        collaborator.save()

        //definindo as permissões para cada usuario
        UserRole.create user, userRole
        UserRole.create cCollect, companyColRole
        UserRole.create cPartner, companyPartColRole
        UserRole.create admin, adminRole


        UserRole.withSession {
            it.flush()
            it.clear()
        }


    }

    def destroy = {
    }
}
