public class LightspeedSale {

	public class Register_sale_products {
		public String discount;
		public String id;
		public String loyalty_value;
		public String price;
		public Boolean price_set;
		public String price_total;
		public String product_id;
		public String quantity;
		public String tax;
		public String tax_id;
		public String tax_total;
	}

	public class User {
		public String created_at;
		public String display_name;
		public String email;
		public String id;
		public String name;
		public String target_daily;
		public String target_monthly;
		public String target_weekly;
		public String updated_at;
	}

	public class Taxes {
		public String id;
		public String name;
		public String rate;
		public String tax;
	}

	public class Customer {
		public String balance;
		public String company_name;
		public String contact_first_name;
		public String contact_last_name;
		public String created_at;
		public String custom_field_1;
		public String custom_field_2;
		public String custom_field_3;
		public String custom_field_4;
		public String customer_code;
		public String customer_group_id;
		public String date_of_birth;
		public String deleted_at;
		public Boolean do_not_email;
		public String email;
		public Boolean enable_loyalty;
		public String fax;
		public String first_name;
		public String id;
		public String last_name;
		public String loyalty_balance;
		public String mobile;
		public String note;
		public String phone;
		public Integer points;
		public String sex;
		public String updated_at;
		public String year_to_date;
	}

	public class Totals {
		public String total_loyalty;
		public String total_payment;
		public String total_price;
		public String total_tax;
		public String total_to_pay;
	}

	public class Register_sale_payments {
		public String amount;
		public String id;
		public String payment_date;
		public Payment_type payment_type;
		public String payment_type_id;
		public Retailer_payment_type retailer_payment_type;
		public String retailer_payment_type_id;
	}

	public class Retailer_payment_type {
		public String config;
		public String id;
		public String name;
		public String payment_type_id;
	}

	public String created_at;
	public Customer customer;
	public String customer_id;
	public String deleted_at;
	public String id;
	public String invoice_number;
	public String note;
	public String register_id;
	public List<Register_sale_payments> register_sale_payments;
	public List<Register_sale_products> register_sale_products;
	public String sale_date;
	public String short_code;
	public String source;
	public String source_id;
	public String status;
	public List<Taxes> taxes;
	public Totals totals;
	public String updated_at;
	public User user;
	public String user_id;
	public Long version;

	public class Payment_type {
		public Boolean has_native_support;
		public String id;
		public String name;
	}

	
	public static LightspeedSale parse(String json) {
		return (LightspeedSale) System.JSON.deserialize(json, LightspeedSale.class);
	}
}