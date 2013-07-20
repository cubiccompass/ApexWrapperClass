public with sharing class CustomerAccount {
	public ID Id;
	public Account record;
	public static string SFIELDS = SObjectFields.ACCOUNT_FIELDS;
    
	public CustomerAccount withSObject(Account acct){
		record = acct;
		this.Id = acct.Id;
		return this;
	}
	
	public CustomerAccount withID(Id id){
		this.Id = id;
		record = Database.query('SELECT ' + CustomerAccount.SFIELDS + ' FROM Account WHERE Id=:Id LIMIT 1');
		return this;
	}
	
	public CustomerAccount put(String property, String value){
		record.put(property, value);
		return this;
	}
	
	public CustomerAccount put(String property, Decimal value){
		record.put(property, value);
		return this;
	}
	
	public String googleMapLink{
		get{
			return 'https://maps.google.com/?q=' + record.BillingStreet + ' ' + record.BillingCity + ' ' + record.BillingState + record.BillingPostalCode;
		}
	}
	
	private List<Contact> m_contacts = null;
	public List<Contact> contacts{
		get{
			if(m_contacts == null){
				m_contacts = [SELECT Id, AccountId, FirstName, LastName FROM Contact WHERE AccountId=:Id];
			}
			return m_contacts;
		}
	}
	
	public CustomerAccount save(){
		update this.record;
		return this;
	}
	
	public CustomerAccount remove(){
		delete this.record;
		this.Id 	= null;
		this.record = null;
		return this;
	}
}