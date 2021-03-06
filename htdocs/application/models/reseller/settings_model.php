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

class Settings_model extends CI_Model {

	function update_settings($column, $value)
    {
        $sql = "UPDATE settings SET ".$column." = '".$value."' WHERE customer_id = '".$this->session->userdata('customer_id')."' ";
        $query = $this->db->query($sql);
    }
    
    function settings_any_cell($column)
    {
        $sql = "SELECT value FROM settings WHERE setting_name = '".$column."' ";
        $query = $this->db->query($sql);
        $row = $query->row();
        return $row->value;
    }
    
    function update_settings_extra_cdr($extra_cdr)
    {
        $comma_seperated_values = '';
        if(is_array($extra_cdr)){
            if(count($extra_cdr) > 1)
            {
                $count = 1;
                foreach($extra_cdr as $row):
                    $comma_seperated_values .= $row;  
                    
                    if($count < count($extra_cdr))
                    {
                        $comma_seperated_values .= ',';  
                    }
                    $count = $count + 1;
                endforeach; 
            }
            else if(count($extra_cdr) == 1)
            {
                foreach($extra_cdr as $row):
                    $comma_seperated_values .= $row;   
                endforeach;               
            }
		}
        
        $sql = "UPDATE settings SET optional_cdr_fields_include = '".$comma_seperated_values."' WHERE customer_id = '".$this->session->userdata('customer_id')."' ";
        $query = $this->db->query($sql);
    }
    
}
?>