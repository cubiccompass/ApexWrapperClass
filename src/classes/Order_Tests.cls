@IsTest
public with sharing class Order_Tests {		
	
	public static testMethod void withSObjectConstructorTests(){
		MockObjectFactory mockObjects = new MockObjectFactory();
		Order testOrder = new Order().withSObject(mockObjects.mockOrder);
		System.assert(testOrder != null);
		System.assert(testOrder.record != null);
		System.assertEquals(mockObjects.mockOrder.Id, testOrder.Id);
		System.assertEquals(8500.00, testOrder.record.Total_Amount__c);
		System.assertEquals(0.0, testOrder.record.Tax_Rate__c);
		System.assert(testOrder.record.CustomerAccountId__c != null);
	}
	
	public static testMethod void withIDConstructorTests(){
		MockObjectFactory mockObjects = new MockObjectFactory();
		Order testOrder = new Order().withID(mockObjects.mockOrder.Id);
		System.assert(testOrder != null);
		System.assert(testOrder.record != null);
		System.assertEquals(mockObjects.mockOrder.Id, testOrder.Id);
		System.assertEquals(8500.00, testOrder.record.Total_Amount__c);
		System.assertEquals(0.0, testOrder.record.Tax_Rate__c);
		System.assert(testOrder.record.CustomerAccountId__c != null);
	}
	
	public static testMethod void putTests(){
		Order testOrder = new Order().withSObject(new MockObjectFactory().mockOrder);
		testOrder.put('Tax_Rate__c', 5.5).save();
		System.assertEquals(5.5, testOrder.record.Tax_Rate__c);
	}
	
	public static testMethod void saveTests(){
		MockObjectFactory mockObjects = new MockObjectFactory();
		Order testOrder = new Order().withSObject(mockObjects.mockOrder);
		testOrder.record.Tax_Rate__c = 5.0;
		testOrder.save();
		
		testOrder = new Order().withID(mockObjects.mockOrder.Id);
		System.assertEquals(5.0, testOrder.record.Tax_Rate__c);
	}
	
	public static testMethod void removeTests(){
		MockObjectFactory mockObjects = new MockObjectFactory();
		String orderid = mockObjects.mockOrder.Id;
		Order testOrder = new Order().withSObject(mockObjects.mockOrder);
		testOrder.remove();
		
		System.assertEquals(null, testOrder.Id);
		System.assertEquals(null, testOrder.record);
		
		List<Order__c> orderList = [SELECT Id FROM Order__c WHERE Id=:orderid];
		System.assertEquals(0, orderList.size());
	}
	
	public static testMethod void taxRateTests(){
		Order testOrder = new Order().withSObject(new MockObjectFactory().mockOrder);
		System.assertEquals(0.0, testOrder.calculateTaxRate().record.Tax_Rate__c);
		
		testOrder.customerAccount.record.BillingCountry = 'IE';
		testOrder.customerAccount.save();		
		System.assertEquals(12.0, testOrder.calculateTaxRate().record.Tax_Rate__c);
		
		testOrder.customerAccount.record.BillingCountry = 'BR';
		testOrder.customerAccount.save();
		System.assertEquals(6.0, testOrder.calculateTaxRate().record.Tax_Rate__c);
	}
	
	public static testMethod void functionalTests(){
		//Order testOrder = new Order().withSObject(new MockObjectFactory().mockOrder);
	}
}