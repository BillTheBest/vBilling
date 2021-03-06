<?php 
/*
 * Version: MPL 1.1
 *
 * The contents of this file are subject to the Mozilla Public License
 * Version 1.1 (the "License"); you may not use this file except in
 * compliance with the License. You may obtain a copy of the License at
 * http://www.mozilla.org/MPL/
 * 
 * Software distributed under the License is distributed on an "AS IS"
 * basis, WITHOUT WARRANTY OF ANY KIND, either express or implied. See the
 * License for the specific language governing rights and limitations
 * under the License.
 * 
 * The Original Code is "vBilling - VoIP Billing and Routing Platform"
 * 
 * The Initial Developer of the Original Code is 
 * Digital Linx [<] info at digitallinx.com [>]
 * Portions created by Initial Developer (Digital Linx) are Copyright (C) 2011
 * Initial Developer (Digital Linx). All Rights Reserved.
 *
 * Contributor(s)
 * "Digital Linx - <vbilling at digitallinx.com>"
 *
 * vBilling - VoIP Billing and Routing Platform
 * version 0.1.3
 *
 */

class Customer_model extends CI_Model {

	// list all customers
	function get_all_customers($num, $offset, $filter_account_num, $filter_company, $filter_first_name, $filter_type, $filter_sort, $filter_contents)
	{
		if($offset == ''){$offset='0';}
        
        $order_by = "";
        if($filter_sort == 'name_asc')
        {
            $order_by = "ORDER BY customer_firstname ASC";
        }
        else if($filter_sort == 'name_dec')
        {
            $order_by = "ORDER BY customer_firstname DESC";
        }
        else if($filter_sort == 'balance_asc')
        {
            $order_by = "ORDER BY customer_balance ASC";
        }
        else if($filter_sort == 'balance_dec')
        {
            $order_by = "ORDER BY customer_balance DESC";
        }
        else
        {
            $order_by = "ORDER BY customer_id DESC";
        }
        
        
		$where = '';
		if($filter_contents == 'all') //get all customers and resellers which belongs to him 
        {
            $where .= "WHERE customer_id != '' ";
        }
        else if($filter_contents == 'my') //only get those which are created by him 
        {
            $where .= "WHERE parent_id = '0' ";
        }
        else //show all 
        {
            $where .= "WHERE customer_id != '' ";
        }

		if($filter_account_num != '')
		{
			if(is_numeric($filter_account_num))
			{
				$where .= 'AND customer_acc_num = '.$this->db->escape($filter_account_num).' ';
			}
		}

		if($filter_company != '')
		{
			$where .= "AND customer_company LIKE '%".$this->db->escape_like_str($filter_company)."%' ";
		}

		if($filter_first_name != '')
		{
			$where .= "AND customer_firstname LIKE '%".$this->db->escape_like_str($filter_first_name)."%' ";
		}

		if($filter_type != '')
		{
			if(is_numeric($filter_type))
			{
				$where .= 'AND customer_enabled = '.$this->db->escape($filter_type).' ';
			}
		}

		$sql = "SELECT * FROM customers ".$where." ".$order_by." LIMIT $offset,$num";
		$query = $this->db->query($sql);
		return $query;
	}

	function get_all_customers_count($filter_account_num, $filter_company, $filter_first_name, $filter_type, $filter_contents)
	{
		$where = '';
		if($filter_contents == 'all') //get all customers and resellers which belongs to him 
        {
            $where .= "WHERE customer_id != '' ";
        }
        else if($filter_contents == 'my') //only get those which are created by him 
        {
            $where .= "WHERE parent_id = '0' ";
        }
        else //show all 
        {
            $where .= "WHERE customer_id != '' ";
        }

		if($filter_account_num != '')
		{
			if(is_numeric($filter_account_num))
			{
				$where .= 'AND customer_acc_num = '.$this->db->escape($filter_account_num).' ';
			}
		}

		if($filter_company != '')
		{
			$where .= "AND customer_company LIKE '%".$this->db->escape_like_str($filter_company)."%' ";
		}

		if($filter_first_name != '')
		{
			$where .= "AND customer_firstname LIKE '%".$this->db->escape_like_str($filter_first_name)."%' ";
		}

		if($filter_type != '')
		{
			if(is_numeric($filter_type))
			{
				$where .= 'AND customer_enabled = '.$this->db->escape($filter_type).' ';
			}
		}

		$sql = "SELECT * FROM customers ".$where."";
		$query = $this->db->query($sql);
		$count = $query->num_rows();
		return $count;
	}

	//single customer data 
	function get_single_customer($customer_id)
	{
		$sql = "SELECT * FROM customers WHERE customer_id = '".$customer_id."'";
		$query = $this->db->query($sql);
		return $query;
	}

	//any cell 
	function customer_any_cell($customer_id, $col_name)
	{
		$sql = "SELECT * FROM customers WHERE customer_id = '".$customer_id."' ";
		$query = $this->db->query($sql);
		$row = $query->row();

		return $row->$col_name;
	}

	//check customer email already in use
	function check_email_in_use($email)
	{
		$sql = "SELECT * FROM customers WHERE customer_contact_email = '".$email."' ";
		$query = $this->db->query($sql);
		return $query;
	}

	//insert new customer 
	function insert_new_customer($data)
	{
		$current_date = date('Y-m-d');
        $current_date = strtotime($current_date);
        
        $m= date("m");
        $d= date("d");
        $y= date("Y");
        if($data['billing_cycle'] == 'daily')
        {
            $dd =  date('Y-m-d',mktime(0,0,0,$m,($d+1),$y));
            $next_invoice_date = strtotime($dd);
        }
        else if($data['billing_cycle'] == 'weekly')
        {
            $dd =  date('Y-m-d',mktime(0,0,0,$m,($d+7),$y));
            $next_invoice_date = strtotime($dd);
        }
        else if($data['billing_cycle'] == 'bi_weekly')
        {
            $dd =  date('Y-m-d',mktime(0,0,0,$m,($d+14),$y));
            $next_invoice_date = strtotime($dd);
        }
        else if($data['billing_cycle'] == 'monthly')
        {
            $dd =  date('Y-m-d',mktime(0,0,0,$m,($d+30),$y));
            $next_invoice_date = strtotime($dd);
        }
        
        
        $sql = "INSERT INTO customers (customer_acc_num, customer_company, customer_firstname, customer_lastname, customer_contact_email, customer_address, customer_city, customer_state, customer_country, customer_phone_prefix, customer_phone, customer_zip, customer_prepaid, customer_credit_limit, customer_enabled, customer_max_calls, customer_send_cdr, customer_billing_email, customer_timezone, customer_rate_group, customer_billing_cycle, next_invoice_date, reseller_level) VALUES ('".$data['account_no']."', '".$data['companyname']."', '".$data['firstname']."', '".$data['lastname']."', '".$data['email']."', '".$data['address']."', '".$data['city']."', '".$data['state']."', '".$data['country']."', '".$data['prefix']."', '".$data['phone']."', '".$data['zipcode']."', '".$data['account_type']."', '".$data['creditlimit']."', '1', '".$data['maxcalls']."', '".$data['cdr_check']."', '".$data['cdr_email']."', '".$data['timezone']."', '".$data['group']."', '".$data['billing_cycle']."', '".$next_invoice_date."', '".$data['type']."') ";
		$query = $this->db->query($sql);
		return $this->db->insert_id();
	}

	//update customer 
	function update_customer_db($data)
	{
		$sql = "UPDATE customers SET customer_company='".$data['companyname']."', customer_firstname='".$data['firstname']."', customer_lastname='".$data['lastname']."', customer_contact_email='".$data['email']."', customer_address='".$data['address']."', customer_city='".$data['city']."', customer_state='".$data['state']."', customer_country='".$data['country']."', customer_phone_prefix='".$data['prefix']."', customer_phone='".$data['phone']."', customer_zip='".$data['zipcode']."', customer_prepaid='".$data['account_type']."', customer_credit_limit='".$data['creditlimit']."', customer_max_calls='".$data['maxcalls']."', rate_limit_check='".$data['rate_limit_check']."', customer_low_rate_limit='".$data['customer_low_rate_limit']."', customer_flat_rate='".$data['customer_flat_rate']."', 	 customer_high_rate_limit='".$data['customer_high_rate_limit']."', customer_send_cdr='".$data['cdr_check']."', customer_billing_email='".$data['cdr_email']."', customer_timezone='".$data['timezone']."', customer_rate_group='".$data['group']."', customer_billing_cycle='".$data['billing_cycle']."' WHERE customer_id='".$data['customer_id']."'";

		$query = $this->db->query($sql);
	}

	function update_customer_access_limitations($data, $customer_id)
	{
		$sql = "UPDATE customer_access_limitations SET total_sip_accounts = '".$data['tot_sip_acc']."', total_acl_nodes = '".$data['tot_acl_nodes']."' WHERE customer_id ='".$customer_id."' ";
		$query = $this->db->query($sql);
        
        //delete previous sips
        $sql2 = "DELETE FROM customer_sip WHERE customer_id = '".$customer_id."' ";
		$query2 = $this->db->query($sql2);
        
        //insert new sips 
        $sip = $data['sip_ip'];
        if(is_array($sip)){ //multi select box
            if(count($sip) > 0)
            {
                foreach($sip as $row):
                    $explode = explode('|', $row);
                    $domain     = $explode[0];
                    $sofia_id   = $explode[1];
                    
                    $sql = 'INSERT INTO customer_sip (customer_id, domain, domain_sofia_id) VALUES ("'.$customer_id.'", "'.$domain.'", "'.$sofia_id.'") ';
                    $query = $this->db->query($sql);
                    
                endforeach; 
            }
		}
	}

	//insert customer userpanel access
	function insert_customer_user_panel_access($data, $customer_id)
	{
		$type = "customer";
        if($data['type'] != '0')
        {
            $type = "reseller";
        }
        
        $sql = 'INSERT INTO accounts (username, password, type, is_customer, customer_id, enabled) VALUES ('.$data['username'].', "'.$data['password'].'", "'.$type.'", "1", "'.$customer_id.'", "1") ';
		$query = $this->db->query($sql);
        
        //insert blank entry into settings table .. later we will just update it 
        if($data['type'] != '0')
        {
            $sql2 = "INSERT INTO settings (customer_id,company_logo_as_invoice_logo ) VALUES ('".$customer_id."', '0') ";
            $query2 = $this->db->query($sql2);
        }
	}

	function insert_customer_access_limitations($data, $customer_id)
	{
		$sql = 'INSERT INTO customer_access_limitations (customer_id, total_sip_accounts, total_acl_nodes) VALUES ("'.$customer_id.'", "'.$data['tot_sip_acc'].'", "'.$data['tot_acl_nodes'].'") ';
		$query = $this->db->query($sql);
        
        //sip ip 
        $sip = $data['sip_ip'];
        if(is_array($sip)){ //multi select box
            if(count($sip) > 0)
            {
                foreach($sip as $row):
                    $explode = explode('|', $row);
                    $domain     = $explode[0];
                    $sofia_id   = $explode[1];
                    
                    $sql = 'INSERT INTO customer_sip (customer_id, domain, domain_sofia_id) VALUES ("'.$customer_id.'", "'.$domain.'", "'.$sofia_id.'") ';
                    $query = $this->db->query($sql);
                    
                endforeach; 
            }
		}
	}

	function customer_access($customer_id)
	{
		$sql = "SELECT * FROM accounts WHERE customer_id = '".$customer_id."' ";
		$query = $this->db->query($sql);
		return $query;
	}

	function update_customer_username($data)
	{
		$sql = 'UPDATE accounts SET username = '.$data['username'].' WHERE customer_id = "'.$data['customer_id'].'" ';
		$query = $this->db->query($sql);
	}

	function update_customer_password($data)
	{
		$sql = 'UPDATE accounts SET password = "'.$data['password'].'" WHERE customer_id = "'.$data['customer_id'].'" ';
		$query = $this->db->query($sql);
	}

	function update_user_username($data)
	{
		$sql = 'UPDATE accounts SET username = '.$data['username'].' WHERE id = "'.$this->session->userdata('user_id').'" ';
		$query = $this->db->query($sql);
	}

	function update_user_password($data)
	{
		$sql = 'UPDATE accounts SET password = "'.$data['password'].'" WHERE id = "'.$this->session->userdata('user_id').'" ';
		$query = $this->db->query($sql);
	}

	function update_restricted_customer_db($data)
	{
		$sql = "UPDATE customers SET customer_company='".$data['companyname']."', customer_firstname='".$data['firstname']."', customer_lastname='".$data['lastname']."', customer_address='".$data['address']."', customer_city='".$data['city']."', customer_state='".$data['state']."', customer_country='".$data['country']."', customer_phone_prefix='".$data['prefix']."', customer_phone='".$data['phone']."', customer_zip='".$data['zipcode']."', customer_timezone='".$data['timezone']."' WHERE customer_id='".$data['customer_id']."'";
		$query = $this->db->query($sql);
	}

	//enable disable customer 
	function enable_disable_customer($data)
	{
		$sql = "UPDATE customers SET customer_enabled = '".$data['status']."' WHERE customer_id = '".$data['customer_id']."'";
		$query = $this->db->query($sql);


		//update customer acl nodes also 
		if($data['status'] == '0')
		{
			$sql2 = "UPDATE acl_nodes SET type='deny' WHERE customer_id ='".$data['customer_id']."' ";
			$query2 = $this->db->query($sql2);
		}
		else
		{
			$sql2 = "UPDATE acl_nodes SET type='allow' WHERE customer_id ='".$data['customer_id']."' ";
			$query2 = $this->db->query($sql2);
		}

		//update customer username from directory table
		if($data['status'] == '0')
		{
			$sql3 = "UPDATE directory SET enabled='0' WHERE customer_id ='".$data['customer_id']."' ";
			$query3 = $this->db->query($sql3);
		}
		else
		{
			$sql3 = "UPDATE directory SET enabled='1' WHERE customer_id ='".$data['customer_id']."' ";
			$query3 = $this->db->query($sql3);
		}

		//update customer access account
		if($data['status'] == '0')
		{
			$sql3 = "UPDATE accounts SET enabled='0' WHERE customer_id ='".$data['customer_id']."' ";
			$query3 = $this->db->query($sql3);
		}
		else
		{
			$sql3 = "UPDATE accounts SET enabled='1' WHERE customer_id ='".$data['customer_id']."' ";
			$query3 = $this->db->query($sql3);
		}
	}

	/*
	//enable disable customer rate
	function enable_disable_customer_rate($data)
	{
	$sql = "UPDATE ".$data['tbl_name']." SET enabled = '".$data['status']."' WHERE id = '".$data['rate_id']."'";
	$query = $this->db->query($sql);
	}
	*/

	//customer rates 
	function customer_rates($num, $offset, $tbl_name, $filter_start_date, $filter_end_date, $filter_carriers, $filter_rate_type, $filter_sort)
	{
		if($offset == ''){$offset='0';}
        
        $order_by = "";
        if($filter_sort == 'startdate_asc')
        {
            $order_by = "ORDER BY date_start ASC";
        }
        else if($filter_sort == 'startdate_dec')
        {
            $order_by = "ORDER BY date_start DESC";
        }
        else if($filter_sort == 'enddate_asc')
        {
            $order_by = "ORDER BY date_end ASC";
        }
        else if($filter_sort == 'enddate_dec')
        {
            $order_by = "ORDER BY date_end DESC";
        }
        else if($filter_sort == 'sellrate_asc')
        {
            $order_by = "ORDER BY sell_rate ASC";
        }
        else if($filter_sort == 'sellrate_dec')
        {
            $order_by = "ORDER BY sell_rate DESC";
        }
        else if($filter_sort == 'costrate_asc')
        {
            $order_by = "ORDER BY cost_rate ASC";
        }
        else if($filter_sort == 'costrate_dec')
        {
            $order_by = "ORDER BY cost_rate DESC";
        }
        else if($filter_sort == 'sellinit_asc')
        {
            $order_by = "ORDER BY sell_initblock ASC";
        }
        else if($filter_sort == 'sellinit_dec')
        {
            $order_by = "ORDER BY sell_initblock DESC";
        }
        else if($filter_sort == 'buyinit_asc')
        {
            $order_by = "ORDER BY buy_initblock ASC";
        }
        else if($filter_sort == 'buyinit_dec')
        {
            $order_by = "ORDER BY buy_initblock DESC";
        }
        else
        {
            $order_by = "ORDER BY id DESC";
        }

		$where = '';
		$where .= "WHERE id != '' ";

		if($filter_start_date != '')
		{
			$where .= "AND date_start >= STR_TO_DATE('".$filter_start_date."', '%Y-%m-%d %H:%i:%s') ";
		}

		if($filter_end_date != '')
		{
			$where .= "AND date_end <= STR_TO_DATE('".$filter_end_date."', '%Y-%m-%d %H:%i:%s') ";
		}

		if($filter_carriers != '')
		{
			if(is_numeric($filter_carriers))
			{
				$where .= 'AND carrier_id = '.$this->db->escape($filter_carriers).' ';
			}
		}

		if($filter_rate_type != '')
		{
			if(is_numeric($filter_rate_type))
			{
				$where .= 'AND enabled = '.$this->db->escape($filter_rate_type).' ';
			}
		}

		$sql = "SELECT * FROM ".$tbl_name." ".$where." ".$order_by." LIMIT $offset,$num";
		$query = $this->db->query($sql);
		return $query;
	}

	function customer_rates_count($customer_group_table, $filter_start_date, $filter_end_date, $filter_carriers, $filter_rate_type)
	{
		$where = '';
		$where .= "WHERE id != '' ";

		if($filter_start_date != '')
		{
			$where .= "AND date_start >= STR_TO_DATE('".$filter_start_date."', '%Y-%m-%d %H:%i:%s') ";
		}

		if($filter_end_date != '')
		{
			$where .= "AND date_end <= STR_TO_DATE('".$filter_end_date."', '%Y-%m-%d %H:%i:%s') ";
		}

		if($filter_carriers != '')
		{
			if(is_numeric($filter_carriers))
			{
				$where .= 'AND carrier_id = '.$this->db->escape($filter_carriers).' ';
			}
		}

		if($filter_rate_type != '')
		{
			if(is_numeric($filter_rate_type))
			{
				$where .= 'AND enabled = '.$this->db->escape($filter_rate_type).' ';
			}
		}

		$sql = "SELECT * FROM ".$customer_group_table." ".$where."";
		$query = $this->db->query($sql);
		$count = $query->num_rows();
		return $count;
	}

	//*********************** CUSTOMER ACL NODES FUNCTION ****************************************//
	function customer_acl_nodes($customer_id = '')
	{
		$sql = "SELECT * FROM acl_nodes WHERE customer_id = '".$customer_id."' ";
		$query = $this->db->query($sql);
		return $query;
	}

	function insert_new_acl_node($customer_id, $ip, $cidr)
	{
		$added_by = 0;
		if($this->session->userdata('user_type') == 'customer')
		{
			$added_by = $this->session->userdata('customer_id');
		}
		// $ip_addr = $ip.'/'.$cidr;
		// We temporarily only allow /32 until CIDR issue is resolved in lua scripts
		$ip_addr = $ip.'/32';
		$sql = "INSERT INTO acl_nodes (customer_id, cidr, type, list_id, added_by) VALUES ('".$customer_id."', '".$ip_addr."', 'allow', '1', '".$added_by."') ";
		$query = $this->db->query($sql);
		return $query;
	}

	function check_acl_node_already_exists($ip_addr)
	{
			$sql = "SELECT cidr FROM acl_nodes WHERE cidr = '".$ip_addr."'";
			$query = $this->db->query($sql);
			$count = $query->num_rows();
			return $count;
	}

	function customer_acl_nodes_single($node_id, $customer_id)
	{
		$sql = "SELECT * FROM acl_nodes WHERE id = '".$node_id."' && customer_id = '".$customer_id."' ";
		$query = $this->db->query($sql);
		return $query;
	}

	function update_acl_node_db($node_id, $ip, $cidr)
	{
		// $ip_addr = $ip.'/'.$cidr;
		$ip_addr = $ip.'/32';
		$sql = "UPDATE acl_nodes SET cidr='".$ip_addr."' WHERE id='".$node_id."' ";
		$query = $this->db->query($sql);
		return $query;
	}

	function delete_acl_node($node_id)
	{
		$sql = "DELETE FROM acl_nodes WHERE id = '".$node_id."' LIMIT 1";
		$query = $this->db->query($sql);
		return $query;
	}

	function change_acl_node_type($node_id, $value)
	{
		$sql = "UPDATE acl_nodes SET type='".$value."' WHERE id='".$node_id."' ";
		$query = $this->db->query($sql);
		return $query;
	}

	//********************* CUSTOMER SIP ACCESS FUNCTION ******************************************//

	function customer_sip_access($customer_id)
	{
		$sql = "SELECT a.*, b.directory_id, b.param_name, b.param_value FROM directory AS a LEFT JOIN directory_params AS b ON b.directory_id = a.id WHERE a.customer_id = '".$customer_id."' ORDER BY a.id DESC";
		$query = $this->db->query($sql);
		return $query;
	}

	function single_sip_access_data($id)
	{
		$sql = "SELECT a.*, b.directory_id, b.param_name, b.param_value FROM directory AS a LEFT JOIN directory_params AS b ON b.directory_id = a.id WHERE a.id = '".$id."' ";
		$query = $this->db->query($sql);
		return $query;
	}

	function insert_new_sip_access($customer_id, $username, $password, $domain, $sofia_id, $cid)
	{
		$added_by = 0;

		if($this->session->userdata('user_type') == 'customer')
		{
			$added_by = $this->session->userdata('customer_id');
		}
		$new_password = $username.':'.$domain.':'.$password;
		$new_password = md5($new_password);

		//insert into directory table 
		$sql = "INSERT INTO directory (customer_id, username, domain, domain_sofia_id, added_by, enabled, cid) VALUES ('".$customer_id."', '".$username."', '".$domain."', '".$sofia_id."', '".$added_by."', '1', '".$cid."')";
		$query = $this->db->query($sql);
		$inser_id = $this->db->insert_id();

		//insert into directory_params table 
		$sql = "INSERT INTO directory_params (directory_id, param_name, param_value) VALUES ('".$inser_id."', 'a1-hash', '".$new_password."')";
		$query = $this->db->query($sql); 
	}

	/*function update_sip_access($record_id, $username, $password, $domain)
	{
	$new_password = $username.':'.$domain.':'.$password;
	$new_password = md5($new_password);

//update into directory table 
$sql = "UPDATE directory SET username = '".$username."', domain = '".$domain."' WHERE id = '".$record_id."' ";
$query = $this->db->query($sql);

//update into directory_params table 
$sql = "UPDATE directory_params SET param_value = '".$new_password."' WHERE directory_id = '".$record_id."' ";
$query = $this->db->query($sql); 
}*/

function check_sip_username_existis($username)
{
	$sql = "SELECT * FROM directory WHERE username = '".$username."' ";
	$query = $this->db->query($sql);
	return $query->num_rows();
}

function delete_sip_access($record_id)
{
	$sql = "DELETE FROM directory WHERE id = '".$record_id."' LIMIT 1";
	$query = $this->db->query($sql);

	$sql = "DELETE FROM directory_params WHERE directory_id = '".$record_id."' LIMIT 1";
	$query = $this->db->query($sql);
}

function enable_disable_sip_access($data)
{
    $sql = "UPDATE directory SET enabled = '".$data['status']."' WHERE id = '".$data['id']."' LIMIT 1";
	$query = $this->db->query($sql);
}

//***************************** CDR FUNCTIONS ***************************************//
function customer_cdr($num, $offset, $customer_id, $filter_date_from, $filter_date_to, $filter_phonenum, $filter_caller_ip, $filter_gateways, $filter_call_type, $duration_from, $duration_to, $filter_sort)
{
	if($offset == ''){$offset='0';}
    
    $order_by = "";
        if($filter_sort == 'date_asc')
        {
            $order_by = "ORDER BY created_time ASC";
        }
        else if($filter_sort == 'date_dec')
        {
            $order_by = "ORDER BY created_time DESC";
        }
        else if($filter_sort == 'billduration_asc')
        {
            $order_by = "ORDER BY billsec ASC";
        }
        else if($filter_sort == 'billduration_dec')
        {
            $order_by = "ORDER BY billsec DESC";
        }
        else if($filter_sort == 'failedgateways_asc')
        {
            $order_by = "ORDER BY total_failed_gateways ASC";
        }
        else if($filter_sort == 'failedgateways_dec')
        {
            $order_by = "ORDER BY total_failed_gateways DESC";
        }
        else if($filter_sort == 'sellrate_asc')
        {
            $order_by = "ORDER BY sell_rate ASC";
        }
        else if($filter_sort == 'sellrate_dec')
        {
            $order_by = "ORDER BY sell_rate DESC";
        }
        else if($filter_sort == 'costrate_asc')
        {
            $order_by = "ORDER BY cost_rate ASC";
        }
        else if($filter_sort == 'costrate_dec')
        {
            $order_by = "ORDER BY cost_rate DESC";
        }
        else if($filter_sort == 'sellinit_asc')
        {
            $order_by = "ORDER BY sell_initblock ASC";
        }
        else if($filter_sort == 'sellinit_dec')
        {
            $order_by = "ORDER BY sell_initblock DESC";
        }
        else if($filter_sort == 'buyinit_asc')
        {
            $order_by = "ORDER BY buy_initblock ASC";
        }
        else if($filter_sort == 'buyinit_dec')
        {
            $order_by = "ORDER BY buy_initblock DESC";
        }
        else if($filter_sort == 'totcharges_asc')
        {
            $order_by = "ORDER BY total_sell_cost ASC";
        }
        else if($filter_sort == 'totcharges_dec')
        {
            $order_by = "ORDER BY total_sell_cost DESC";
        }
        else if($filter_sort == 'totcost_asc')
        {
            $order_by = "ORDER BY total_buy_cost ASC";
        }
        else if($filter_sort == 'totcost_dec')
        {
            $order_by = "ORDER BY total_buy_cost DESC";
        }
        else
        {
            $order_by = "ORDER BY created_time DESC";
        }

	$where = '';

	if($filter_date_from != '')
	{
		$date_from = strtotime($filter_date_from) * 1000000; //convert into micro seconds
		$where .= "AND created_time >= '".sprintf("%.0f", $date_from)."' ";
	}

	if($filter_date_to != '')
	{
		$date_to = strtotime($filter_date_to) * 1000000; //convert into micro seconds
		$where .= "AND created_time <= '".sprintf("%.0f", $date_to)."' ";
	}

	if($filter_phonenum != '')
	{
		if(is_numeric($filter_phonenum))
		{
			$where .= 'AND destination_number = '.$this->db->escape($filter_phonenum).' ';
		}
	}

	if($filter_caller_ip != '')
	{
		if ($this->input->valid_ip($filter_caller_ip))
		{
			$where .= 'AND network_addr = '.$this->db->escape($filter_caller_ip).' ';
		}
	}

	if($filter_gateways != '')
	{
		if (strpos($filter_gateways,'|') !== false) {
			$explode = explode('|', $filter_gateways);
			$gateway = $explode[0];
			$profile = $explode[1];
			if(isset($gateway) && isset($profile))
			{
				if(is_numeric($profile))
				{
					$where .= 'AND gateway = '.$this->db->escape($gateway).' AND sofia_id = '.$this->db->escape($profile).' ';
				}
			}
		}
	}

	if($filter_call_type != '')
	{
		$where .= 'AND hangup_cause = '.$this->db->escape($filter_call_type).' ';
	}
    
    if($duration_from != '')
    {
        if(is_numeric($duration_from))
        {
            $where .= 'AND billsec >= '.$duration_from.' ';
        }
    }

    if($duration_to != '')
    {
        if(is_numeric($duration_to))
        {
            $where .= 'AND billsec <= '.$duration_to.' ';
        }
    }

	$sql = "SELECT * FROM cdr WHERE customer_id = '".$customer_id."' AND parent_id = '0' ".$where." ".$order_by." LIMIT $offset,$num";
	$query = $this->db->query($sql);
	return $query;
}

function customer_cdr_count($customer_id, $filter_date_from, $filter_date_to, $filter_phonenum, $filter_caller_ip, $filter_gateways, $filter_call_type, $duration_from, $duration_to)
{
	$where = '';

	if($filter_date_from != '')
	{
		$date_from = strtotime($filter_date_from) * 1000000; //convert into micro seconds
		$where .= "AND created_time >= '".sprintf("%.0f", $date_from)."' ";
	}

	if($filter_date_to != '')
	{
		$date_to = strtotime($filter_date_to) * 1000000; //convert into micro seconds
		$where .= "AND created_time <= '".sprintf("%.0f", $date_to)."' ";
	}

	if($filter_phonenum != '')
	{
		if(is_numeric($filter_phonenum))
		{
			$where .= 'AND destination_number = '.$this->db->escape($filter_phonenum).' ';
		}
	}

	if($filter_caller_ip != '')
	{
		if ($this->input->valid_ip($filter_caller_ip))
		{
			$where .= 'AND network_addr = '.$this->db->escape($filter_caller_ip).' ';
		}
	}

	if($filter_gateways != '')
	{
		if (strpos($filter_gateways,'|') !== false) {
			$explode = explode('|', $filter_gateways);
			$gateway = $explode[0];
			$profile = $explode[1];
			if(isset($gateway) && isset($profile))
			{
				if(is_numeric($profile))
				{
					$where .= 'AND gateway = '.$this->db->escape($gateway).' AND sofia_id = '.$this->db->escape($profile).' ';
				}
			}
		}
	}

	if($filter_call_type != '')
	{
		$where .= 'AND hangup_cause = '.$this->db->escape($filter_call_type).' ';
	}
    
    if($duration_from != '')
    {
        if(is_numeric($duration_from))
        {
            $where .= 'AND billsec >= '.$duration_from.' ';
        }
    }

    if($duration_to != '')
    {
        if(is_numeric($duration_to))
        {
            $where .= 'AND billsec <= '.$duration_to.' ';
        }
    }

	$sql = "SELECT * FROM cdr WHERE customer_id = '".$customer_id."' AND parent_id = '0' ".$where."";
	$query = $this->db->query($sql);
	$count = $query->num_rows();
	return $count;
}

function customer_balance_history($customer_id)
{
	$sql = "SELECT * FROM customer_balance_history WHERE customer_id = '".$customer_id."' ";
	$query = $this->db->query($sql);
	return $query;
}

function add_deduct_balance($customer_id, $balance, $action, $current_balance)
{
	$time = time();

	if($action == 'added')
	{
		$new_balance = $current_balance + $balance;
	}
	else if($action == 'deducted')
	{
		$new_balance = $current_balance - $balance;
	}
	//update customer balance 
	$sql = "UPDATE customers SET customer_balance = '".$new_balance."' WHERE customer_id = '".$customer_id."' ";
	$query = $this->db->query($sql);

	//insert into balance history 
	$sql = "INSERT INTO customer_balance_history (customer_id, balance, action, date) VALUES ('".$customer_id."', '".$balance."', '".$action."', '".$time."') ";
	$query = $this->db->query($sql);
	return $this->db->insert_id();
}

function customer_balance_history_single($id)
{
	$sql = "SELECT * FROM customer_balance_history WHERE id = '".$id."' ";
	$query = $this->db->query($sql);
	return $query;
}
}
?>