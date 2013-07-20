public with sharing class Order{
	public ID Id;
	public Order__c record;
	public static string SFIELDS = SObjectFields.ORDER_FIELDS;
     	
	public Order withSObject(Order__c r){
		record = r;
		this.Id = r.Id;
		return this;
	}
	
	public Order withID(Id id){
		this.Id = id;
		record = Database.query('SELECT ' + Order.SFIELDS + ' FROM Order__c WHERE Id=:Id LIMIT 1');
		return this;
	}
	
	public Order put(String property, String value){
		record.put(property, value);
		return this;
	}
	
	public Order put(String property, Decimal value){
		record.put(property, value);
		return this;
	}
	
	public Order calculateTaxRate(){
		if(customerAccount.record.BillingCountry == 'IE'){
			this.record.Tax_Rate__c = 12.0;
		} else if(customerAccount.record.BillingCountry == 'BR'){
			this.record.Tax_Rate__c = 6.0;
		} else {
			this.record.Tax_Rate__c = 0.0;
		}
		return this;
	}
	
	private CustomerAccount m_customerAccount = null;
	public CustomerAccount customerAccount{
		get{
			if(m_customerAccount == null){
				m_customerAccount = new CustomerAccount().withId(this.record.CustomerAccountId__c);
			}
			return m_customerAccount;
		}
	}
	
	public Order save(){
		update this.record;
		return this;
	}
	
	public Order remove(){
		delete this.record;
		this.Id 	= null;
		this.record = null;
		return this;
	}
}