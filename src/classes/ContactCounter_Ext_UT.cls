@IsTest
private class ContactCounter_Ext_UT {

  @isTest
  static void noContacts() {
    Account acc01 = new Account(Name = 'acc01');
    insert acc01;

    Test.startTest();

    ContactCounter_Ext contactCounterExt = new ContactCounter_Ext(new ApexPages.StandardController(acc01));
    System.assertEquals(0, contactCounterExt.numberOfContacts);

    Test.stopTest();
  }

  @isTest
  static void xContacts() {
    Account acc01 = new Account(Name = 'acc01');
    insert acc01;

    Integer numberOfContacts = 8;
    List<Contact> accountContacts = new List<Contact>();
    for (Integer i=0; i<numberOfContacts; i++) {
      accountContacts.add(new Contact(
        AccountId = acc01.Id,
        LastName = 'con' + String.valueOf(i)
      ));
    }
    insert accountContacts;
    acc01 = [SELECT Number_of_Contacts__c FROM Account WHERE Id = :acc01.Id];
    System.assertEquals(null, acc01.Number_of_Contacts__c);

    Test.startTest();

    ContactCounter_Ext contactCounterExt = new ContactCounter_Ext(new ApexPages.StandardController(acc01));
    System.assertEquals(numberOfContacts, contactCounterExt.numberOfContacts);
    acc01 = [SELECT Number_of_Contacts__c FROM Account WHERE Id = :acc01.Id];
    System.assertEquals(null, acc01.Number_of_Contacts__c);
    contactCounterExt.action();
    acc01 = [SELECT Number_of_Contacts__c FROM Account WHERE Id = :acc01.Id];
    System.assertEquals(numberOfContacts, acc01.Number_of_Contacts__c);

    Test.stopTest();
  }
}