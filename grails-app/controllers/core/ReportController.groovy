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

        def totalCollectionsCollectedByYear = selectTotalCollectionsCollectedByYear(currentCompany.id, currentYear)

        def ordersCollectionsByYear = selectOrdersCollectionsByYear(currentYear)

        def response = ["totalCollectionsCollectedByYear": totalCollectionsCollectedByYear, "ordersCollectionsByYear": ordersCollectionsByYear]

        render response as JSON
    }

    def quantityOfMaterialTypesCollectedByYear() {
        User currentUser = springSecurityService.loadCurrentUser()
        Company currentCompany = currentUser.company

        Calendar calendar = Calendar.getInstance();
        Integer currentYear = calendar[calendar.YEAR]

        def hqlQuantityOfMaterialTypesCollectedByYear = """
                    SELECT new map(materialType.name as materialTypeName, COUNT(materialType.name) as quantityCollected)
                    FROM MaterialType as materialType
                    LEFT JOIN materialType.collects as collect
                    WHERE collect.isCollected = true AND collect.company.id = :companyId AND YEAR(collect.collectedDate) = :currentYear
                    GROUP BY materialType.name
                    ORDER BY materialType.name
                  """

        def quantityOfMaterialTypesCollectedByYear = Collect.executeQuery(hqlQuantityOfMaterialTypesCollectedByYear, [companyId: currentCompany.id, currentYear: currentYear])

        def response = ["quantityOfMaterialTypesCollectedByYear": quantityOfMaterialTypesCollectedByYear]

        render response as JSON
    }

    /*
    SELECT new map(m.name as materialTypeName, COUNT(m.name) as quantityCollected)
    FROM MaterialType as m
    LEFT JOIN material_type_collects as mc ON m.id = mc.material_type_id
    INNER JOIN collect as c ON c.id = mc.collect_id
    WHERE c.is_collected = true AND c.company_id = @company_id AND YEAR(c.collected_date) = @currentYear
    GROUP BY m.name
    ORDER BY m.name;
    */

    private String getNameOfMonth(int monthIndex){
        def months = ["Janeiro", "Fevereiro", "Março", "Abril", "Maio", "Junho", "Julho", "Agosto", "Setembro", "Outubro", "Novembro", "Dezembro"]

        return months.get(monthIndex);
    }

    private List<Collect> selectOrdersCollectionsByYear(int currentYear){
        def hqlOrdersCollectionsByYear = """
                    SELECT new map(c.orderDate as orderDate, COUNT(*) as totalOrdersCollections)
                    FROM Collect c
                    GROUP BY YEAR(c.orderDate)
                    HAVING YEAR(c.orderDate) = :currentYear
                  """

        return Collect.executeQuery(hqlOrdersCollectionsByYear, [currentYear: currentYear])
    }

    private List<Collect> selectTotalCollectionsCollectedByYear(long companyId, int currentYear){
        def hqlCollectedByYear = """
                    SELECT new map(c.collectedDate as collectedDate, COUNT(*) as totalCollectedByYear)
                    FROM Collect c
                    WHERE c.isCollected = true and c.company.id = :companyId
                    GROUP BY YEAR(c.collectedDate)
                    HAVING YEAR(c.collectedDate) = :currentYear
                  """

        return Collect.executeQuery(hqlCollectedByYear, [companyId: companyId, currentYear: currentYear])
    }


}

