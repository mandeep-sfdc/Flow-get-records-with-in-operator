global class SObjectIN {
 
    @InvocableMethod(label='Get sObjects' description='Returns the list of sObjects in the list of Ids passed')
    public static List<List<sObject>> fetchSObjects(List<List<String>> sObjIds){
        List<List<SObject>> sObjList = new List<List<SObject>>();
        if(sObjIds.get(0)!=null){
            String sObjName = ((Id)sObjIds.get(0).get(0)).getSobjectType().getDescribe().getName(); 
            Set<String> SobjectFields = Schema.getGlobalDescribe().get(sObjName).getDescribe().fields.getMap().keySet();  
            Set<String> uniqIds = new Set<String>();
            for(String sOID:new Set<String>(sObjIds.get(0)))
                uniqIds.add('\''+sOID+'\'');
            List<SObject> sOs = Database.query(' SELECT ' + String.join(new List<String>(SobjectFields), ',') + 
                                               ' FROM '+ sObjName +
                                               ' WHERE Id IN ('+String.join(new List<String>(uniqIds), ',')+')');
            sObjList.add(sOs);
        } 
        return sObjList;
    }    
}