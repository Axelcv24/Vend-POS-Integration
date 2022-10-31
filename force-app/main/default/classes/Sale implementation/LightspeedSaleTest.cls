@isTest

private class LightspeedSaleTest{

    @isTest
    static void testLightspeedSaleParse(){

        String json = '{"created_at":"2022-08-02 20:47:41","customer":{"balance":"0.00000","company_name":null,"contact_first_name":"Test","contact_last_name":"test","created_at":"2022-08-02 17:25:37","custom_field_1":null,"custom_field_2":null,"custom_field_3":null,"custom_field_4":null,"customer_code":"Test-7RC4","customer_group_id":"06326976-9d65-11ed-fa40-0f5187f9f67b","date_of_birth":null,"deleted_at":null,"do_not_email":true,"email":"test1@gmail.com","enable_loyalty":true,"fax":null,"first_name":"Test","id":"06326976-9dcb-11ed-fa40-12881f93edd5","last_name":"test","loyalty_balance":"0.00000","mobile":"11111111","note":null,"phone":null,"points":0,"sex":"M","updated_at":"2022-08-02 18:04:36","year_to_date":"0.00000"},"customer_id":"06326976-9dcb-11ed-fa40-12881f93edd5","deleted_at":null,"id":"27ac4e56-e6a2-b705-11ed-12a444b5730b","invoice_number":"1","note":"","outlet_id":"06326976-9d65-11ed-fa40-0f5188030f78","register_id":"06326976-9d65-11ed-fa40-0f5188047b83","register_sale_payments":[],"register_sale_products":[{"discount":"0.00000","id":"27ac4e56-e6a2-b705-11ed-12a44e741bdc","is_return":false,"loyalty_value":"0.00000","note":null,"price":"0.00000","price_set":false,"price_total":"0.00000","product_id":"b2fd740b-5492-4f25-983d-c23acc7a168b","quantity":1,"tax":"0.00000","tax_id":"06326976-9d65-11ed-fa40-0f5187fbf518","tax_total":"0.00000"}],"return_for":null,"sale_date":"2022-08-02T20:47:37Z","short_code":"dyginx","source":"USER","source_id":null,"status":"CLOSED","taxes":[{"id":"87fc65bb-0f51-11ed-ba40-063269769d65","name":"No Tax","rate":"0.00000","tax":0}],"totals":{"total_loyalty":"0.00000","total_payment":"0.00000","total_price":"0.00000","total_tax":"0.00000","total_to_pay":"0.00000"},"updated_at":"2022-08-02T20:47:41+00:00","user":{"created_at":"2022-07-29 15:17:16","display_name":"Test","email":"test@gmail.us","id":"06326976-9d65-11ed-fa40-0f518804d032","name":"test@gmail.us","target_daily":null,"target_monthly":null,"target_weekly":null,"updated_at":"2022-07-29 15:17:16"},"user_id":"06326976-9d65-11ed-fa40-0f518804d032","version":23761369370}';
        LightspeedSale sale = LightspeedSale.parse(json);
        System.assertEquals('27ac4e56-e6a2-b705-11ed-12a444b5730b',sale.id);
    }
 
}