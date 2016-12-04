package collect

public enum EnumTypeOfCompany {
    COMPANY_COLLECT('coleta'),
    COMPANY_PARTNER('parceira')

    private final String id;

    EnumTypeOfCompany(String id){
        this.id = id;
    }
}