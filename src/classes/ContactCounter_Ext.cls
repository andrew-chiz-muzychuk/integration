public class ContactCounter_Ext {

  public Integer numberOfContacts { get; set; }
  
  private Account currentAccount;

  public ContactCounter_Ext() {
    numberOfContacts = 0;
  }

  public ContactCounter_Ext(ApexPages.StandardController stdController) {
    this();
    Id accountId = stdController.getId();
    if (accountId != null) {
      numberOfContacts = [SELECT count() FROM Contact WHERE AccountId = :accountId];
      currentAccount = new Account(Id = accountId, Number_of_Contacts__c = numberOfContacts);
    }
  }
  
  public PageReference action() {
  	if (currentAccount != null) {
      update currentAccount;
      return new PageReference('./' + currentAccount.Id);
  	} else {
  	  return null;
  	}
  }
}