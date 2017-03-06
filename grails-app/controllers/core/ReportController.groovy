package core

import grails.converters.JSON
import grails.plugin.springsecurity.annotation.Secured
import grails.transaction.Transactional
import org.hibernate.criterion.CriteriaSpecification

@Transactional(readOnly = true)
@Secured(['ROLE_COMPANY_COLLECT'])
class ReportController {

    transient springSecurityService

    def CompanyCollections() {
        render(view: "companyCollections")
    }

    def reportByCurrentMonth() {
        User currentUser = springSecurityService.loadCurrentUser()
        Company currentCompany = currentUser.company

        Calendar calendar = Calendar.getInstance();

        calendar.set(Calendar.DATE, calendar.getActualMinimum(Calendar.DATE))
        Date firstDayOfMonth = calendar.getTime();

        calendar.set(Calendar.DATE, calendar.getActualMaximum(Calendar.DATE));
        Date lastDayOfMonth = calendar.getTime();

        def quantityOfCollectByMonth = Collect.createCriteria().get {
            //resultTransformer(CriteriaSpecification.ALIAS_TO_ENTITY_MAP)
            createAlias("company", "comp")

            projections { count() }

            and {
                eq("comp.id", currentCompany.id)
                between("collectedDate", firstDayOfMonth, lastDayOfMonth)
            }
        }

        def response = ["quantityOfCollectByMonth": quantityOfCollectByMonth, "month": getNameOfMonth(firstDayOfMonth[Calendar.MONTH])]

        render response as JSON
    }

    def reportByCurrentYear() {
        User currentUser = springSecurityService.loadCurrentUser()
        Company currentCompany = currentUser.company

        Calendar calendar = Calendar.getInstance();
        Integer currentYear = calendar[calendar.YEAR]

        def hql = """
                    SELECT new map((MONTH(c.collectedDate) - 1) as monthCollect, c.collectedDate as collectedDate, COUNT(*) as quantityByMonth)
                    FROM Collect c
                    WHERE c.isCollected = true and c.company.id = :companyId
                    GROUP BY YEAR(c.collectedDate), MONTH(c.collectedDate)
                    HAVING YEAR(c.collectedDate) = :currentYear
                    ORDER BY MONTH(c.collectedDate)
                  """

        def listQuantityOfCollectByMonths = Collect.executeQuery(hql, [companyId: currentCompany.id, currentYear: currentYear])

        Integer biggerMonth = 0
        //Change index month to name of month
        listQuantityOfCollectByMonths.each { item ->

            biggerMonth = item.get("monthCollect")

            item.putAt("monthCollect", getNameOfMonth(item.get("monthCollect")))
        }

        def response = ["quantityOfCollectByMonths": listQuantityOfCollectByMonths, "biggerMonth": biggerMonth]

        render response as JSON
    }

    def reportTotalCollectedByCurrentYear(){
        User currentUser = springSecurityService.loadCurrentUser()
        Company currentCompany = currentUser.company

        Calendar calendar = Calendar.getInstance();
        Integer currentYear = calendar[calendar.YEAR]

        def hql = """
                    SELECT new map(c.collectedDate as collectedDate, COUNT(*) as totalCollectedByYear)
                    FROM Collect c
                    WHERE c.isCollected = true and c.company.id = :companyId
                    GROUP BY YEAR(c.collectedDate)
                    HAVING YEAR(c.collectedDate) = :currentYear
                  """

        def listInfoCollectedByYear = Collect.executeQuery(hql, [companyId: currentCompany.id, currentYear: currentYear])

        def response = ["listInfoCollectedByYear": listInfoCollectedByYear]

        render response as JSON
    }

    private String getNameOfMonth(int monthIndex){
        def months = ["Janeiro", "Fevereiro", "Março", "Abril", "Maio", "Junho", "Julho", "Agosto", "Setembro", "Outubro", "Novembro", "Dezembro"]

        return months.get(monthIndex);
    }

}

