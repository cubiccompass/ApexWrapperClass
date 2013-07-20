@IsTest
public with sharing class CustomerAccount_Tests {
	
	public static testMethod void withSObjectConstructorTests(){
		MockObjectFactory mockObjects = new MockObjectFactory();
		CustomerAccount testAccount = new CustomerAccount().withSObject(mockObjects.mockAccount);
		System.assert(testAccount != null);
		System.assert(testAccount.record != null);
		System.assertEquals(mockObjects.mockAccount.Id, testAccount.Id);
		System.assertEquals('San Francisco', testAccount.record.BillingCity);
		System.assertEquals('CA', testAccount.record.BillingState);
		System.assertEquals(0, testAccount.contacts.size());
		System.assert(testAccount.googleMapLink != null);
	}
	
	public static testMethod void withIDConstructorTests(){
		MockObjectFactory mockObjects = new MockObjectFactory();
		CustomerAccount testAccount = new CustomerAccount().withID(mockObjects.mockAccount.Id);
		System.assert(testAccount != null);
		System.assert(testAccount.record != null);
		System.assertEquals(mockObjects.mockAccount.Id, testAccount.Id);
		System.assertEquals('San Francisco', testAccount.record.BillingCity);
		System.assertEquals('CA', testAccount.record.BillingState);
		System.assertEquals(0, testAccount.contacts.size());
	}
	
	public static testMethod void putTests(){
		CustomerAccount acct = new CustomerAccount().withSObject(new MockObjectFactory().mockAccount);
		acct.put('BillingCity', 'New York').save();
		System.assertEquals('New York', acct.record.BillingCity);
	}
	
	public static testMethod void saveTests(){
		MockObjectFactory mockObjects = new MockObjectFactory();
		CustomerAccount testAccount = new CustomerAccount().withSObject(mockObjects.mockAccount);
		testAccount.record.BillingCity = 'New York';
		testAccount.record.BillingState = 'NY';
		testAccount.save();
		
		testAccount = new CustomerAccount().withID(mockObjects.mockAccount.Id);
		System.assertEquals('New York', testAccount.record.BillingCity);
		System.assertEquals('NY', testAccount.record.BillingState);
	}
	
	public static testMethod void removeTests(){
		MockObjectFactory mockObjects = new MockObjectFactory();
		String accountid = mockObjects.mockAccount.Id;
		CustomerAccount testAccount = new CustomerAccount().withSObject(mockObjects.mockAccount);
		testAccount.remove();
		
		System.assertEquals(null, testAccount.Id);
		System.assertEquals(null, testAccount.record);
		
		List<Account> accountList = [SELECT Id FROM Account WHERE Id=:accountid];
		System.assertEquals(0, accountList.size());
	}
}