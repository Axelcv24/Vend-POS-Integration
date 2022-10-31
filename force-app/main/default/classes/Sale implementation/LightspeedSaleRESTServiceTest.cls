@isTest
private class LightspeedSaleRESTServiceTest{




   
    @isTest
    static void testHandleHookSales(){
        Test.startTest();
        
        //Insert products
        Product2 prodDiscount = new Product2();
        prodDiscount.name = 'Discount';
        insert prodDiscount;

        Product2 prodTax = new Product2();
        prodTax.name = 'Tax';
        insert prodTax;


        //Insert contact
        Contact contact = new Contact();
        contact.FirstName = 'Test';
        contact.LastName = 'Test';
        contact.POS_Customer_Id__c = '06326976-9dcb-11ed-fa40-0f51cfaef44c';
        insert contact;

        //Insert product
        String json  = '{"active":true,"attributed_cost":null,"base_name":"test product 4","brand":null,"button_order":null,"categories":[],"deleted_at":null,"description":"\u003cp\u003edescription111\u003c/p\u003e","handle":"test-product-3","id":"9f301eda-8eb6-4c99-832b-cc5a5b976f1w",'+ 
        ' "image_thumbnail_url":"https://secure.vendhq.com/images/placeholder/product/no-image-white-thumb.png","image_url":"https://secure.vendhq.com/images/placeholder/product/no-image-white-standard.png","images":[],"inventory":[{"attributed_cost":"10.00","count":0,' + 
        ' "id":"b76b8380-8d28-4f34-bb13-1ae81433686e","outlet_id":"06326976-9d65-11ed-fa40-0f5188030f78","product_id":"9f301eda-8eb6-4c99-832b-cc5a5b976f1b","reorder_point":null,"restock_level":null}],"name":"test product 3","price_book_entries":[{"customer_group_id":"06326976-9d65-11ed-fa40-0f5187f9f67b", ' + 
        ' "customer_group_name":"All Customers","id":"3ebbfd4b-e72a-4ecc-8b47-bf6b9354918c","max_units":null,"min_units":null,"price":"0.00000","product_id":"9f301eda-8eb6-4c99-832b-cc5a5b976f1b","type":"BASE","valid_from":null,"valid_to":null}],"product_type":null,"retailer_id":"06326976-9d65-11ed-fa40-0f5187f82e49",' + 
        ' "sku":"10003","source":"USER","source_id":null,"source_variant_id":null,"supplier":null,"supplier_code":"","supply_price":"0.00","taxes":[{"outlet_id":"06326976-9d65-11ed-fa40-0f5188030f78","tax_id":"06326976-9d65-11ed-fa40-0f5187fbf518"}],"variant_options":[],"variant_parent_id":null,"version":23694974686}';

        RestRequest request = new RestRequest();
        request.requestUri = 'https://exonos--vend.sandbox.my.salesforce-sites.com/products/services/apexrest/lightSpeedProduct';
        request.httpMethod = 'POST';
        request.addHeader('Content-Type', 'application/json');
        request.addParameter('payload', json);
        RestContext.request = request;
        
        String id = LightspeedProductRESTService.handleHookProducts();

        List<Product2> products = [Select id,name,POS_Id__c from Product2];
        System.debug('products: ' + products);


        //Insert sale
        json = '{"created_at":"2022-08-03 20:50:16","customer":{"balance":"0.00000","company_name":null,"contact_first_name":"test","contact_last_name":"test","created_at":"2022-07-29 15:19:16","custom_field_1":null,"custom_field_2":null,"custom_field_3":null,"custom_field_4":null,"customer_code":"test-6X9A","customer_group_id":"06326976-9d65-11ed-fa40-0f5187f9f67b","date_of_birth":null,"deleted_at":null,"do_not_email":false,"email":"test@gmail.com","enable_loyalty":true,"fax":null,"first_name":"test","id":"06326976-9dcb-11ed-fa40-0f51cfaef44c","last_name":"test","loyalty_balance":"0.00000","mobile":"","note":null,"phone":null,"points":0,"sex":null,"updated_at":"2022-08-03 20:50:16","year_to_date":"198.00000"},"customer_id":"06326976-9dcb-11ed-fa40-0f51cfaef44c","deleted_at":null,"id":"27ac4e56-e6a2-a4bc-11ed-136dac3e160e","invoice_number":"3","note":"","outlet_id":"06326976-9d65-11ed-fa40-0f5188030f78","register_id":"06326976-9d65-11ed-fa40-0f5188047b83","register_sale_payments":[{"amount":99,"id":"27ac4e56-e6a2-a4bc-11ed-136dddcd01a4","payment_date":"2022-08-03T20:50:11Z","payment_type":{"has_native_support":false,"id":"1","name":"Cash"},"payment_type_id":1,"retailer_payment_type":{"config":null,"id":"0d7f976f-d346-4fbb-b918-e990897e4396","name":"Cash","payment_type_id":"1"},"retailer_payment_type_id":"0d7f976f-d346-4fbb-b918-e990897e4396"}],"register_sale_products":[{"discount":"-100.00000","id":"27ac4e56-e6a2-a4bc-11ed-136dd15ec92f","is_return":false,"loyalty_value":"0.00000","note":null,"price":"100.00000","price_set":true,"price_total":"100.00000","product_id":"9f301eda-8eb6-4c99-832b-cc5a5b976f1w","quantity":1,"tax":"10.00000","tax_id":"06326976-9dcb-11ed-fa40-136d18594ed8","tax_total":"10.00000"},{"discount":"0.00000","id":"27ac4e56-e6a2-a4bc-11ed-136dda968ec2","is_return":false,"loyalty_value":"0.00000","note":null,"price":"10.00000","price_set":true,"price_total":"-10.00000","product_id":"9f301eda-8eb6-4c99-832b-cc5a5b976f1w","quantity":-1,"tax":"1.00000","tax_id":"06326976-9dcb-11ed-fa40-136d18594ed8","tax_total":"-1.00000"}],"return_for":null,"sale_date":"2022-08-03T20:50:11Z","short_code":"3CdtA8","source":"USER","source_id":null,"status":"CLOSED","taxes":[{"id":"18592c7c-136d-11ed-ba40-063269769d65","name":"IVA","rate":"0.10000","tax":9}],"totals":{"total_loyalty":"0.00000","total_payment":"99.00000","total_price":"90.00000","total_tax":"9.00000","total_to_pay":"0.00000"},"updated_at":"2022-08-03T20:50:16+00:00","user":{"created_at":"2022-07-29 15:17:16","display_name":"test","email":"test@exonos.us","id":"06326976-9d65-11ed-fa40-0f518804d032","name":"test@gmail.us","target_daily":null,"target_monthly":null,"target_weekly":null,"updated_at":"2022-07-29 15:17:16"},"user_id":"06326976-9d65-11ed-fa40-0f518804d032","version":23778683465}';
        request = new RestRequest();
        request.requestUri = 'https://exonos--vend.sandbox.my.salesforce-sites.com/sales/services/apexrest/lightSpeedSale';
        request.httpMethod = 'POST';
        request.addHeader('Content-Type', 'application/json');
        request.addParameter('payload', json);
        RestContext.request = request;
        
        id = LightspeedSaleRESTService.handleHookSales();
        List<POS_Error_Log__c> errors = [select id,name,StackTrace__c from POS_Error_Log__c];
        System.debug('errors: ' + errors.toString());


     
        Test.stopTest();

    }
}