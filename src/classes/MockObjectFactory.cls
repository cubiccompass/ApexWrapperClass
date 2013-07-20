public with sharing class MockObjectFactory {
	public final Account mockAccount;
	public final Order__c mockOrder;
	
	public MockObjectFactory(){
		mockAccount = new Account(Name = 'TestAccount',
				BillingStreet = '123 Oak St.',
				BillingCity = 'San Francisco',
				BillingState = 'CA',
				BillingCountry = 'US');
		insert mockAccount;
		
		mockOrder = new Order__c(Total_Amount__c = 8500.00, 
				Tax_Rate__c = 0.0,
				CustomerAccountId__c = mockAccount.Id);
		insert mockOrder;
	}
}