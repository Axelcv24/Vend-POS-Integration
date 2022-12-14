@isTest
public class LightspeedCustomerUpdateQueueableTest{

    static HttpResponse response;
    static String successData= 'Success';
    static String failureData= 'Faied';

    public class MockSuccess implements HttpcalloutMock {
        public HTTPResponse respond(HTTPRequest req) {
                    response = new HttpResponse();
                    response.setbody(successData);
                    response.setstatuscode(200);
                    return response;
            }
    }
    
    static testmethod void testForSuccess(){

        List<Contact> contacts = new List<Contact>();
        for (Integer i = 0; i < 5; i++) {
            Contact con = new Contact();
            con.FirstName = 'Test ' + i;
            con.Lastname = 'Test ' + i;
            con.Email = 'Test' + i + '@gmail.com';
            con.Phone = '1234567890';
            con.MailingStreet = 'Test ' + i;
            con.MailingCity = 'Test ' + i;
            con.MailingPostalCode = '12345';
            con.MailingState = 'Test ' + i;
            con.POS_Customer_Id__c = '06326976-9dcb-11ed-fa40-12881f93ed0' + i; 
            contacts.add(con);

        }
        insert contacts;
     
        Test.setMock(HttpCalloutMock.class, new MockSuccess());
        Test.startTest();
        System.enqueueJob( new LightspeedCustomerUpdateQueueable(contacts));
        System.debug('Response::'+response);
        Test.stopTest();
     }
}