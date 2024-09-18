/**
* The SOQL class serves as a primer into the Salesforce Object Query Language in Apex.
* It covers fundamental aspects such as SELECT statements, WHERE clauses, Relationship queries, and LIMIT keyword.
*
* This class introduces developers to the concept of retrieving data from Salesforce using SOQL. It provides
* a step-by-step guide on how to construct SOQL queries, filter results using WHERE clause, retrieve related
* records, and manage data volume using the LIMIT keyword.
* 
* Topics covered in this class include:
* - Understanding the structure of a SOQL query.
* - Crafting basic SELECT statements in SOQL.
* - Applying filters using the WHERE clause in SOQL.
* - Fetching related records using Relationship queries.
* - Controlling the amount of data retrieved using the LIMIT keyword.
* 
* Users of this class can expect to gain a solid understanding of SOQL in Apex and
* be prepared to handle data retrieval tasks in Salesforce development.
* 
* @author Hind Alaasemi
*/

public with sharing class SOQL {
    
    /**
     * Question 1
     * Update/Uncomment the template code to create a method
     * Returns all leads from Salesforce Org
     * @return List of all leads with Id, LastName, Company, Phone, Email
     * Update the corresponding test class and testGetAllLeads method to cover this method
     */
    public static List<Lead> getAllLeads() {
    //  The body of the method
    return[SELECT Id, LastName, Company, Phone, Email FROM Lead];
    }

    /**
     * Question 2
     * Update/Uncomment the template code to create a method
     * Returns all contacts with first name of John.
     * @return A list of Contact records.
     * Update the corresponding test class and testGetContactsByFirstName method to cover this method
     */
    public static List<Contact> getContactsByFirstName (String firstName) {
    //  The body of the method
    return [SELECT Id, Name, FirstName FROM Contact WHERE FirstName= :firstName];
    }

    /**
     * Question 3
     * Update/Uncomment the template code to create a method
     * Returns the Contact Id for all contacts with last name of Smith or Jones
     * @return A list of Contact Ids.
     * Update the corresponding test class and testGetContactIdsByLastName method to cover this method
     */
    public static List<Id> getContactIdsByLastName() {
        // The body of the method
        List<Contact> contactList = [SELECT Id FROM Contact WHERE LastName IN ('Smith', 'Jones')];
        
        // Return just the Contact IDs
        List<Id> contactIds = new List<Id>();
        if (contactList != null && !contactList.isEmpty()) {
        for (Contact contact : contactList) {
            contactIds.add(contact.Id);
        }
    }
    
        return contactIds;
    }

    /**
     * Question 4
     * Update/Uncomment the template code to create a method
     * Returns List of closed won opportunities for a specific Account.
     * Example: yourMethodName('001XXXXXXXXXXXX') should return the list of closed won opportunities for the Account with the Id
     * @param accountId The ID of the Account.
     * @return A list of Opportunities with important opportunities fields
     * Update the corresponding test class and testGetClosedWonOpportunityCountByAccount method to cover this method
     */
    public static List<Opportunity> GetClosedWonOpportunityCountByAccount (String accountId) {
    //  The body of the method
    List<Opportunity> oppList = [SELECT Id, CloseDate,Name, Amount  , AccountId ,StageName
                                  FROM Opportunity 
                                  WHERE StageName = 'Closed Won' 
                                  AND AccountId = :accountId];
    return OppList;
    }

    /**
     * Question 5
     * Update/Uncomment the template code to create a method
     * Returns the total count of Account records.
     * @return The Integer count of Account records.
     * Update the corresponding test class and testGetAccountCount method to cover this method
     */
   public static Integer GetAccountCount () {
    //  The body of the method
    integer i=0;
    List<Account> allAccountList = [SELECT Id FROM Account];
    if (allAccountList != null && !allAccountList.isEmpty()) {
        for (Account accountList:allAccountList) {
            i++;
        }
    }
    return i;
    }

    /**
     * Question 6
     * Update/Uncomment the template code to create a method
     * Return Key Value pair of Task Id and Task records for any tasks due date within the next 7 days.
     * @return A map of Task Ids to Task records.
     * Update the corresponding test class and testGetTasksDueNextWeek method to cover this method
     */
   public static Map<Id,Task> GetTasksDueNextWeek () {
    //  The body of the method
    List<Task>taskDueNextWeek =[SELECT Id, Subject, ActivityDate FROM Task WHERE ActivityDate =NEXT_N_DAYS:7];
    //create Map
    Map<Id,Task> taskList =new Map<Id,Task>();
    //Populate the map with Task Id and Records
    for (task task:taskDueNextWeek) {
      taskList.put(task.Id, task);
    }
    return taskList;
    }

    /**
     * Question 7
     * Update/Uncomment the template code to create a method
     * Retrieves all Contacts that have a example.com domain in their Email.
     * @return A list of Contact records.
     * Update the corresponding test class and testGetContactsByEmailDomain method to cover this method
     */
    public static List<Contact> GetContactsByEmailDomain() {
    //  The body of the method
    List<Contact> contactList = [SELECT Id,Name, Email FROM Contact WHERE Email LIKE '%@example.com'];
    return contactList;
    }

    /**
     * Question 8
     * Retrieves all Opportunities that have a specific keyword in their Name.
     * Example: getOpportunitiesByNameKeyword('keyword') should return all Opportunities that have 'keyword' in their Name.
     * @param keyword The keyword to search for in the Opportunity Name.
     * @return A list of Opportunity records.
     */
    public static List<Opportunity> getOpportunitiesByNameKeyword(String keyword) {
        //Ensure Keyword is not null or empty
        if (string.isBlank(keyword)) {
            return new List<Opportunity>();
        }
        List<Opportunity> oppList =[SELECT Id,Name FROM Opportunity WHERE Name LIKE :('%' + keyword + '%')];
        return oppList; // Replace null with the variable you used to store the result
    }

    /**
     * Question 9
     * Retrieves all Cases that Case Origin is not Web or Email or Blank
     * @return A list of Case records.
     */
    public static List<Case> getFilterCaseOrigins() {
        List<Case> caseList=[SELECT Id ,Origin FROM Case WHERE Origin != 'Web' AND Origin != 'Email' AND Origin !='' ];
        return caseList; // Replace null with the variable you used to store the result
    }

    /**
     * Question 10
     * Update/Uncomment the template code to create a method
     * Retrieves all Leads that have a specific Lead Source or contain a specific keyword in their Title.
     * Example: yourMethodName('Web', 'Engineer') should return all Leads that have 'Web' in their Lead Source or 'Engineer' in their Title.
     * @param leadSource The Lead Source to search for.
     * @param keyword The keyword to search for in the Lead Title.
     * @return A list of Lead records.
     * Update the corresponding test class and testGetLeadsBySourceOrTitle method to cover this method
     */
   public static List<Lead> GetLeadsBySourceOrTitle (String leadSource, String keyword) {
    //  The body of the method
    if (leadSource == null && string.isBlank(keyword)) {
    return new List<Lead>();
    }
    List<Lead> leadList = [SELECT Id,LastName ,Company ,Phone ,Email,LeadSource,Title FROM Lead WHERE LeadSource =:leadSource OR Title LIKE :('%' + keyword + '%') ];
    return leadList;
    }    

    /**
     * Question 11
     * Returns the names of all Contacts associated with an Account.
     * Example: getContactNamesByAccount('001XXXXXXXXXXXX') should return the list of Contact LastNames for the Account with the Id
     * @param accountId The ID of the Account.
     * @return A list of Contact LastName.
     */
    public static List<String> getContactNamesByAccount(Id accountId) {
        // Create a list to hold the Contact LastNames
        List<String> conatctLastName = new List<String>();
        // Query the Contacts
        List<Contact> contactList =[SELECT LastName, Id, AccountId FROM Contact WHERE AccountId =:accountId];
        // Loop through each Contact and add the LastName to the list
        for (Contact C:contactList) {
           conatctLastName.add(c.LastName);
        }

        // Return the list of Contact LastNames
        return conatctLastName; // Replace null with the variable you used to store the result
    }

    /**
     * Question 12
     * Returns the total revenue for all Opportunities in a specific Stage or if the amount is greater than 10000.
     * Example: getTotalRevenueByStage('Closed Won') should return the total revenue for all Opportunities in the 'Closed Won' Stage.
     * @param stage The Stage value to filter Opportunities.
     * @return The total revenue.
     */
    public static Decimal getTotalRevenueByStage(String stage) {
        // Use AggregateQuery to get the total revenue
         Decimal totalRevenue= 0; 
         AggregateResult[] results = [
            SELECT SUM(Amount) totalRevenue
            FROM Opportunity
            WHERE StageName = :stage OR Amount > 10000
        ];
         // Retrieve the total revenue from the query result
    if (!results.isEmpty()) {
        totalRevenue = (Decimal) results[0].get('totalRevenue');
    }
        // Return the total revenue
        return totalRevenue; // Replace null with the variable you used to store the result
    }

    /**
     * Question 13
     * Retrieves the first 10 Accounts ordered by Name.
     * @return A list of the first 10 Accounts ordered by Name.
     */
    public static List<Account> getFirstTenAccounts() {
        List<Account> accountList = new List<Account>([SELECT Id, Name FROM Account Order by Name Limit 10]);
        return accountList; // Replace null with the variable you used to store the result
    }
    
    /**
     * Question 14
     * Retrieves the Opportunities with an Amount greater than 100,000, ordered by CloseDate, and limited to 5 records.
     * @return A list of Opportunities with an Amount greater than 100,000, ordered by CloseDate, and limited to 5 records.
     */
    public static List<Opportunity> getHighValueOpportunities() {
        List<Opportunity> oppList =new List<Opportunity> ([SELECT Id,AMOUNT,CloseDate FROM Opportunity WHERE Amount > 100000 Order by CloseDate limit 5]);
        return oppList; // Replace null with the variable you used to store the result
    }
    
    /**
     * Question 15
     * Retrieves the Contacts with the most recent Birthdate, ordered by Birthdate, and limited to 3 records.
     * @return A list of Contacts
     */
    public static List<Contact> getBirthdateContacts() {
        List<Contact> contactList = new List<Contact> ([SELECT Id, Name, Birthdate FROM Contact Order by Birthdate DESC Limit 3]);
        return contactList; // Replace null with the variable you used to store the result
    }
    
    /**
     * Question 16
     * Retrieves the Cases in the Open Status, ordered by CreatedDate, and limited to 10 records with an offset of 5.
     * @return A list of Cases
     */
    public static List<Case> getCasesWithStatus() {
        List<Case> caseList =new List<Case>([SELECT Id, Subject,Status,CreatedDate FROM Case WHERE Status ='Open' Order By CreatedDate limit 10 Offset 5]);
        return caseList; // Replace null with the variable you used to store the result
    }

    /**
     * Question 17
     * Returns Set of Case Ids for a specific Account.
     * Example: getCaseIdsByAccount('001XXXXXXXXXXXX') should return the set of Case Ids for the Account with the Id
     * @param accountId The ID of the Account.
     * @return A set of Case Ids.
     */
    public static Set<Id> getCaseIdsByAccount(Id accountId) {
        // Create a set to hold the Case Ids
      Set<Id> caseId = new Set<Id>();
        // Query the Cases
        List<Case> caseList =new List<Case> ([SELECT Id, Subject, AccountId FROM Case WHERE AccountId = :accountId]);
        // Loop through each Case and add the Id to the set
        for(Case C :caseList) {
        caseId.add(c.Id);
        }

        return caseId; // Replace null with the variable you used to store the result
    }

    /**
     * Question 18
     * Return Map of Account Ids to Account Names Not in a specific Country.
     * Example: getAccountIdsToNamesNotInCountry('United States') should return the map of Account Ids to Account Names for Accounts that are not in the United States.
     * @param country The country to filter Accounts.
     * @return A map of Account Ids to Account Names.
     */
    public static Map<Id, String> getAccountIdsToNamesNotInCountry(String country) {
        // Create a map to hold the Account Ids to Account Names
        Map<Id, String> accountIdsToNames = new Map<Id, String>();
        // Query the Accounts
        List<Account> accountList = new List<Account>([SELECT Id,BillingCountry, Name FROM Account WHERE BillingCountry!= :country]);
        // Loop through each Account and add the Id and Name to the map
         for (Account c : accountList) {
            accountIdsToNames.put(c.Id, c.Name);
         }
        return accountIdsToNames; // Replace null with the variable you used to store the result
    }

    /**
     * Question 19
     * Retrieves the Account Name for a given Contact.
     * Example: getAccountNameForContact('003XXXXXXXXXXXX') should return the Account Name for the Contact with the Id
     * @param contactId The Id of the Contact.
     * @return The Account Name of the Contact.
     */
    public static String getAccountNameForContact(String contactId) {
        List<Contact> contacts =new List<Contact>([SELECT Id, AccountId, Account.Name FROM Contact WHERE Id = :contactId]);
        String accountName = contacts[0].Account.Name;
        return accountName; // Replace null with the variable you used to store the result
    }    

    /**
     * Question 20
     * Returns single Account that has related opportunities in the same query
     * Example: getAccountAndOpportunitiesFromAccountId('001XXXXXXXXXXXX') should return the Account Name for the Account with the Id and all related Opportunities
     * @param accountId The ID of the Account.
     * @return An Account record with related Opportunities.
     */
    public static Account getAccountAndOpportunitiesFromAccountId(Id accountId) {
        Account accountWithOpps = [
            SELECT Id, Name, 
                   (SELECT Id, Name, StageName, Amount FROM Opportunities) 
            FROM Account 
            WHERE Id = :accountId
        ];
    
        // Return the queried account with its related opportunities
        return accountWithOpps;
    }

    /**
     * Question 21
     * Retrieves all contacts that have the Mailing State similar to the Account Billing State.
     * Example: getAccountsWithContactsByState('001XXXXXXXXXXXX') should return a list of Contacts that have the same Mailing State as the Account with the Id
     * @param Account Id
     * @return List of contacts with the same Mailing State as the Account Billing State
     */
    public static List<Contact> getAccountsWithContactsByState(Id accountId) {
        // Query the Account 
        List<Account> accounts = new List<Account>([Select BillingState FROM Account WHERE Id = :accountId]);
        // Store the Account's BillingState
        String billingState =accounts[0].BillingState;
        // Query the Contacts
        List<Contact> contacts =new List<Contact>([SELECT Id, MailingState FROM Contact WHERE MailingState =:billingState]);
        return contacts; // Replace null with the variable you used to store the result
    }

    /**
     * Question 22
     * Extracts email domains from them leads, then finds Accounts with matching website domains
     * If Lead Email = test@test.com return account with website = www.test.com
     * Example: findAccountsByLeadEmailDomains([set of lead ids]) should return a list of Accounts with matching email domains
     * @param A set of Lead Ids.
     * @return A list of Accounts with matching email domains.
     */
    public static List<Account> findAccountsByLeadEmailDomains(Set<Id> leadIds) {
        // Query the Leads
        List<Lead> leadlist = new List<Lead>([SELECT Email FROM Lead WHERE Id IN :leadIds]);
        // Create a set of email domains from the Leads
       Set<string> emailDomains = new set<string>();
        // Loop through each Lead
        for (Lead lead :leadlist) {
             // Get the email from the Lead
            String email = lead.Email;
             // Check if the email is not null
            if (email != null && email.contains('@')) {
                string domain = email.split('@')[1];
                 // Add the email domain to the set
                emailDomains.add('www.'+domain);
            }
        }
 // Query the Accounts
    List<Account> accounts = new List<Account>([SELECT Id, Name, Website FROM Account WHERE Website IN :emailDomains ]);
        return accounts; // Replace null with the variable you used to store the result
    }

    /**
     * Question 23
     * Clones and Inserts Opportunity Line Items from an original Opportunity to a list of cloned Opportunities.
     * Adds a randomized number between 1 to 3 to the quantity of each line item.
     * Example: cloneLineItems('001XXXXXXXXXXXX', [list of opportunity ids]) should clone the line items from the Opportunity with the Id to each Opportunity in the list
     * @param Original Opportunity Id
     * @param List of cloned Opportunity Ids
     */
    public static void cloneLineItems(Id origOppId, List<Id> cloneOppIds) {
        // Query the original Opportunity Line Items
         List<OpportunityLineItem> originalLineItems = new List<OpportunityLineItem> ([Select Product2Id, UnitPrice, Quantity, PricebookEntryId
         FROM OpportunityLineItem
         WHERE OpportunityId = :origOppId]);
        // Create a list to hold the new line items
        List<OpportunityLineItem> newLineItems = new List<OpportunityLineItem>();
        // Generate a random number between 1 and 3
        Integer randomNumber = (Integer)Math.floor(Math.random() * 3) + 1;
        // Loop through each cloned Opportunity Id
        for (Id cloneOppId : cloneOppIds) {
            // Loop through each original line item
            for (OpportunityLineItem originalItem : originalLineItems) {
                // Clone the original line item
                OpportunityLineItem clonedItem = new OpportunityLineItem();
                clonedItem.OpportunityId = cloneOppId;
                clonedItem.Product2Id = originalItem.Product2Id;
                clonedItem.UnitPrice = originalItem.UnitPrice;
                clonedItem.PricebookEntryId = originalItem.PricebookEntryId;
                 // Add the random number to the quantity
             clonedItem.Quantity = originalItem.Quantity + randomNumber;

            // Add the cloned item to the list
            newLineItems.add(clonedItem);
        }
    }
        // Insert the new line items
        if (!newLineItems.isEmpty()) {
            insert newLineItems;
        }
    }
    
    /**
     * Question 24
     * Retrieves the Opportunity Name, Account Name, and Owner Name for Opportunities that have a Stage of 'Closed Won'.
     * Example: getOpportunityDetailsForClosedWon()
     * @return A list of filtered Opportunity
     */
    public static List<Opportunity> getOpportunityDetailsForClosedWon() {        
        List<Opportunity> oppList = new List<Opportunity>([SELECT Id, Name, StageName, Account.Name, Owner.Name FROM Opportunity WHERE StageName= 'Closed Won' ]);
        return oppList; // Replace null with the variable you used to store the result
    }

    /**
     * Question 25
     * Sets the 'Primary_Contact__c' field for all Closed Won Opportunities to first Contact on the Account.
     * Example: setPrimaryContact() should set the 'Primary_Contact__c' field for every Opportunity in the org
     */
    public static void setPrimaryContact() {
        //Use the getOpportunityDetailsForClosedWon() method to get the Opportunities

    List<Opportunity> oppList = SOQL.getOpportunityDetailsForClosedWon();
    
    // Create a set of Account Ids from the Opportunities
    Set<Id> accountIds = new Set<Id>();
    for (Opportunity opp : oppList) {
        if (opp.AccountId != null) {
            accountIds.add(opp.AccountId);
        }
    }

    // Query the Contacts, ordering by CreatedDate to get the earliest
    Map<Id, Contact> accountToContactMap = new Map<Id, Contact>();
    List<Contact> contactList = [
        SELECT Id, AccountId 
        FROM Contact 
        WHERE AccountId IN :accountIds 
        ORDER BY CreatedDate ASC, Id ASC
    ];

    // Map each Account to its earliest created Contact
    for (Contact contact : contactList) {
            accountToContactMap.put(contact.AccountId, contact);
    }

    // Loop through each Opportunity and set the primary contact
    List<Opportunity> updatedOpportunities = new List<Opportunity>();
    for (Opportunity opp : oppList) {
        if (accountToContactMap.containsKey(opp.AccountId)) {
            // Set the Primary_Contact__c field to the earliest contact
            opp.Primary_Contact__c = accountToContactMap.get(opp.AccountId).Id;
            updatedOpportunities.add(opp);
        }
        }
    // Update the Opportunities
    if (!updatedOpportunities.isEmpty()) {
            update updatedOpportunities;
        }
    }
}
