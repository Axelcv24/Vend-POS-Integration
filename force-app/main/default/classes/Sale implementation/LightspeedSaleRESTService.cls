
@RestResource(urlMapping='/lightSpeedSale')
global without sharing class LightspeedSaleRESTService{

    @HttpPost
    global static String handleHookSales(){
        try {
            RestRequest req = RestContext.request;

            String opportunityId = '';
            String payload = String.valueOf(req.params.get('payload'));

            LightspeedSale sale = LightspeedSale.parse(payload);
            LightspeedSale.Customer customer = sale.customer;
            if(customer != null){
                Contact con = new Contact(
                    FirstName = customer.first_name,
                    LastName = customer.last_name,
                    POS_Customer_Id__c = customer.Id,
                    Email = customer.email
                );

                String contactId = LightspeedCustomerRESTService.getCustomer(con);
                if(contactId != null){
                    opportunityId = upsertOpportunity(con, sale);


                    if(opportunityId != null){
                        registerOpportunityContactRole(opportunityId, contactId);
                        registerOpportunityProducts(opportunityId, sale);

                    }
                }
            }

            return opportunityId;

        } catch (Exception ex) {
            LightspeedPOSErrorHandler.insertErrorLog(ex);
            return null;
        }
    }

    private static String upsertOpportunity(Contact con, LightspeedSale sale){
        try {
            String payType = '';
            for (LightspeedSale.Register_sale_payments var : sale.register_sale_payments) {
                if (payType == '') {
                    payType = var.payment_type.name;
                }
            }
            Decimal taxes = 0;
            Decimal membershipDiscount = 0;
            Decimal totalDiscount = 0;
            Decimal discount = 0;
            for (LightspeedSale.Register_sale_products val : sale.register_sale_products) {
                if (decimal.valueOf(val.discount) != 0) {
                    membershipDiscount += decimal.valueOf(val.discount);
                }
                if (decimal.valueOf(val.discount) == 0 && val.price_set) {
                    discount += decimal.valueOf(val.price);
                }
                if (decimal.valueOf(val.tax) != 0) {
                    taxes += decimal.valueOf(val.tax_total);
                }
            }
            totalDiscount = membershipDiscount + discount;
            Datetime dateCreated = Datetime.valueOf(sale.created_at);
            //Get pricebook
            String standardPriceBookId = '';     
            if(Test.isRunningTest()){
                standardPriceBookId = Test.getStandardPricebookId();
            }else{
                standardPriceBookId = [SELECT Id FROM Pricebook2 WHERE Name = 'Standard Price Book' limit 1].Id;
            }   

            Opportunity opportunity = new Opportunity(
                Name = con.FirstName + ' ' + con.LastName + ' POS Sale ' + dateCreated.format('yyyy-MM-dd'),
                POS_Id__c = sale.Id,
                Amount = decimal.valueOf(sale.totals.total_payment),
                POS_Total_Discount__c = totalDiscount,
                POS_Membership_Discount__c = membershipDiscount,
                POS_Taxes__c = taxes,
                POS_Payment_type__c = payType,
                CloseDate = dateCreated.date(),
                stageName = 'Qualification',
                Pricebook2Id = standardPriceBookId
            );
            upsert opportunity POS_Id__c;
            return opportunity.Id;
        } catch (Exception ex) {
            throw ex;
        }
    }

    private static void registerOpportunityProducts(String opportunity,LightspeedSale sale){
        try {

            //Map of sale id and products ids
            Map<String,String>  saleProductIdMap = saleProductIdMap(sale);
            //List of products registered
            List<Product2> productsList = [SELECT Id,name,POS_Id__c FROM Product2 WHERE POS_Id__c IN : saleProductIdMap.values()];
            //Map POS id and product
            Map<String,Product2> productsIdMap = productsIdMap(productsList);
            List<OpportunityLineItem> lineItems = new List<OpportunityLineItem>();
            String standardPriceBookId = '';     
         

            Decimal discount = 0;
            for (LightspeedSale.Register_sale_products val : sale.register_sale_products) {

                if((val.price_set && Decimal.valueOf(val.price_total) < 0) ){
                    //dummyDebug('discount' + val.price_total);
                    discount+= Decimal.valueOf(val.price_total);
                }else{
                    Product2 prod = productsIdMap.get(val.product_id);
                    OpportunityLineItem item = new OpportunityLineItem(
                        OpportunityId = opportunity,
                        Product2Id  = prod.Id,
                        Discount = 0,
                        Quantity = Integer.valueOf(val.quantity),
                        TotalPrice = Decimal.valueOf(val.price_total)
    
                    );
                    lineItems.add(item);
                }

               
            }
            Decimal taxes = Decimal.valueOf(sale.totals.total_tax);
            if(taxes > 0){
                Product2 prodTax = [SELECT Id FROM Product2 where name = 'Sale Tax' limit 1];
                OpportunityLineItem taxItem = new OpportunityLineItem(
                    OpportunityId = opportunity,
                    Product2Id  = prodTax.Id,
                    Discount = 0,
                    Quantity = 1,
                    TotalPrice = taxes );
                    lineItems.add(taxItem);
     
            }

            if(discount != 0){
                Product2 prodDiscount = [SELECT Id FROM Product2 where name = 'Sale Discount' limit 1];
                OpportunityLineItem discountItem = new OpportunityLineItem(
                    OpportunityId = opportunity,
                    Product2Id  = prodDiscount.Id,
                    Discount = 0,
                    Quantity = 1,
                    TotalPrice = discount );
                    lineItems.add(discountItem);
            }

            
            insert lineItems;
        } catch (Exception ex) {
            throw ex;
        }
    }

    private static void registerOpportunityContactRole(String opportunity, String contact){
        try {
            OpportunityContactRole conRole = new OpportunityContactRole(
                        contactId = contact,
                        OpportunityId = opportunity,
                        isPrimary = true
            );
            insert conRole;
            

        } catch (Exception ex) {
            throw ex;
        } 
    }
   
       
    private static Map<String,String> registerSaleProductsMap(LightspeedSale sale){
        Map<String,String> productsIds = new Map<String,String>();
        for (LightspeedSale.Register_sale_products prod : sale.register_sale_products) {
            //dummyDebug('prod: '+ prod);
            productsIds.put(prod.id,prod.price_total);
            
        }
        return productsIds;
    }

    private static Map<String,String> saleProductIdMap(LightspeedSale sale){
        Map<String,String>  productsIds = new  Map<String,String>();
        for (LightspeedSale.Register_sale_products prod : sale.register_sale_products) {
            //dummyDebug('prod: '+ prod);
            productsIds.put(prod.id,prod.product_id);
            
        }
        return productsIds;
    }

    private static Map<String,Product2> productsIdMap(List<Product2> products){
        Map<String,Product2> productsIdMap = new Map<String,Product2>();
        for (Product2 product : products) {
            productsIdMap.put(product.POS_Id__c, product);
        }
        return productsIdMap;
    }



    public static void dummyDebug(String text){
        Contact con = [SELECT Id,Testing_field__c FROM Contact where id = '0030200000EauFjAAJ' limit 1];
        con.Testing_field__c = con.Testing_field__c != null ? con.Testing_field__c + '\n' + text : text;
        update con;
    }
}