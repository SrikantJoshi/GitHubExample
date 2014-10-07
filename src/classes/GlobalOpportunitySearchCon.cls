public class GlobalOpportunitySearchCon {
    private final Opportunity opp;
    public List<Opportunity> lOpportunities {get; set;}
    public GlobalOpportunitySearchCon(ApexPages.StandardController stdController) {
        this.opp = (Opportunity)stdController.getRecord();
        lOpportunities = new List<Opportunity> ();
    }
    
    public List<Schema.FieldSetMember> getFields() {
        return SObjectType.Opportunity.FieldSets.SearchPageSet.getFields();
    }

    private List<Opportunity> getOpportunities() {
        String query = 'SELECT Account.Name, ';
        for(Schema.FieldSetMember f : this.getFields()) {
            query += f.getFieldPath() + ', ';
        }
        query += 'Id FROM Opportunity WHERE ';
        
        if(opp.Name != null){
            query += 'Name LIKE \''+opp.Name+'\' AND ';
        }
        
        if(opp.AccountId != null){
            query += 'AccountId = \''+opp.AccountId + '\' AND ';
        }
        
        if(opp.Type != null){
            query += 'Type =\''+opp.Type +'\' AND ';
        }
        
        if(opp.StageName != null){
            query += 'StageName=\'' +opp.StageName +'\' AND ';
        }
        
        if(opp.OwnerId != null){
            query += 'OwnerId =\'' +opp.OwnerId + '\' AND ';
        }
        
        if(opp.Probability != null){
            query += 'Probability ='+opp.Probability +' AND ';
        }
        
        if(query.subString(query.length() - 7, query.length()) == ' WHERE '){
            query = query.substring(0, query.length() - 7);
            system.debug('## '+query);
        } else if(query.subString(query.length() - 5, query.length()) == ' AND '){
            query = query.substring(0, query.length() - 5);
            system.debug('## '+query);
        }
        
        query += ' ORDER BY Account.Name, Name LIMIT 40';
        
        return Database.query(query);
    }
    
    public void searchOpportunities(){
        this.lOpportunities = getOpportunities();
    }
}