public class ContactCounter_Ext {

  public Integer numberofContacts { get; set; }

  public ContactCounter_Ext() {
    numberofContacts = 0;
  }

  public ContactCounter_Ext(ApexPages.StandardController stdController) {
    this();
    Id accountId = stdController.getId();
    if (accountId != null) {
      numberofContacts = [SELECT count() FROM Contact WHERE AccountId = :accountId];
    }
  }
}