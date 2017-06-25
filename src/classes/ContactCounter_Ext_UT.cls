@IsTest
private class ContactCounter_Ext_UT {

  @isTest
  static void noContacts() {
    Account acc01 = new Account(Name = 'acc01');
    insert acc01;

    Test.startTest();

    ContactCounter_Ext contactCounterExt = new ContactCounter_Ext(new ApexPages.StandardController(acc01));
    System.assertEquals(0, contactCounterExt.numberofContacts);

    Test.stopTest();
  }

  @isTest
  static void xContacts() {
    Account acc01 = new Account(Name = 'acc01');
    insert acc01;

    Integer numberOfContacts = 4;
    List<Contact> accountContacts = new List<Contact>();
    for (Integer i=0; i<numberOfContacts; i++) {
      accountContacts.add(new Contact(
        AccountId = acc01.Id,
        LastName = 'con' + String.valueOf(i)
      ));
    }
    insert accountContacts;

    Test.startTest();

    ContactCounter_Ext contactCounterExt = new ContactCounter_Ext(new ApexPages.StandardController(acc01));
    System.assertEquals(numberOfContacts, contactCounterExt.numberofContacts);

    Test.stopTest();
  }
}