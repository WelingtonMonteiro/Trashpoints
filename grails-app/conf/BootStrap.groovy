import core.Address
import core.Collaborator
import core.MaterialType
import core.Role
import core.User
import core.UserRole

class BootStrap {

    def springSecurityService

    def init = { servletContext ->
        //criando os materiais recicláveis
        MaterialType.findByName('PLÁSTICO')  ?: new MaterialType(name: 'PLÁSTICO').save()
        MaterialType.findByName('PAPEL')  ?: new MaterialType(name: 'PAPEL').save()
        MaterialType.findByName('VIDRO')  ?: new MaterialType(name: 'VIDRO').save()
        MaterialType.findByName('METAL')  ?: new MaterialType(name: 'METAL').save()
        MaterialType.findByName('ALUMÍNIO')  ?:  new MaterialType(name: 'ALUMÍNIO').save()
        MaterialType.findByName('ORGÂNICO')  ?: new MaterialType(name: 'ORGÂNICO').save()
        MaterialType.findByName('QUÍMICO')  ?: new MaterialType(name: 'QUÍMICO').save()

        //criando permissões
        def userRole = Role.findByAuthority('ROLE_COLLABORATOR')  ?: new Role('ROLE_COLLABORATOR').save()
        def companyColRole = Role.findByAuthority('ROLE_COMPANY_COLLECT')  ?: new Role('ROLE_COMPANY_COLLECT').save()
        def companyPartColRole = Role.findByAuthority('ROLE_COMPANY_PARTNER')  ?: new Role('ROLE_COMPANY_PARTNER').save()
        def adminRole = Role.findByAuthority('ROLE_ADMIN')  ?: new Role('ROLE_ADMIN').save()


        //criand usuários
        def user = new User('colaborador@trashpoints.com.br', 'colaborador').save()
        def cCollect = new User('ccoleta@trashpoints.com.br', 'coleta').save()
        def cPartner = new User('cparceiro@trashpoints.com.br', 'parceiro').save()
        def admin = new User('admin@trashpoints.com.br', 'admin').save()

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
