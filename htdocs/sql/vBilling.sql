

--
-- Database: `vBilling`
--

-- --------------------------------------------------------

--
-- Table structure for table `accounts`
--

CREATE TABLE IF NOT EXISTS `accounts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(250) NOT NULL,
  `password` text NOT NULL,
  `type` varchar(50) NOT NULL,
  `is_customer` tinyint(1) NOT NULL,
  `customer_id` int(11) NOT NULL,
  `enabled` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=7 ;

--
-- Dumping data for table `accounts`
--

INSERT INTO `accounts` (`id`, `username`, `password`, `type`, `is_customer`, `customer_id`, `enabled`)
       VALUES
       (
       1,
       'admin',
       '8051d6ba25ceab9244c28a25523291fc',
       'admin',
       0,
       0,
       1);

-- --------------------------------------------------------

--
-- Table structure for table `accounts_restrictions`
--

CREATE TABLE IF NOT EXISTS `accounts_restrictions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `view_customers` tinyint(1) NOT NULL DEFAULT '0',
  `new_customers` tinyint(1) NOT NULL DEFAULT '0',
  `enable_disable_customers` tinyint(1) NOT NULL DEFAULT '0',
  `edit_customers` tinyint(1) NOT NULL DEFAULT '0',
  `view_customers_cdr` tinyint(1) NOT NULL DEFAULT '0',
  `view_customers_rates` tinyint(1) NOT NULL DEFAULT '0',
  `view_customers_billing` tinyint(1) NOT NULL DEFAULT '0',
  `view_customers_acl` tinyint(1) NOT NULL DEFAULT '0',
  `new_acl` tinyint(1) NOT NULL DEFAULT '0',
  `edit_acl` tinyint(1) NOT NULL DEFAULT '0',
  `delete_acl` tinyint(1) NOT NULL DEFAULT '0',
  `change_type_acl` tinyint(1) NOT NULL DEFAULT '0',
  `view_customers_sip` tinyint(1) NOT NULL DEFAULT '0',
  `new_sip` tinyint(1) NOT NULL DEFAULT '0',
  `delete_sip` tinyint(1) NOT NULL DEFAULT '0',
  `enable_disable_sip` tinyint(1) NOT NULL DEFAULT '0',
  `view_customers_balance` tinyint(1) NOT NULL DEFAULT '0',
  `add_deduct_balance` tinyint(1) NOT NULL DEFAULT '0',
  `view_carriers` tinyint(1) NOT NULL DEFAULT '0',
  `new_carriers` tinyint(1) NOT NULL DEFAULT '0',
  `edit_carriers` tinyint(1) NOT NULL DEFAULT '0',
  `enable_disable_carriers` tinyint(1) NOT NULL DEFAULT '0',
  `delete_carriers` tinyint(1) NOT NULL DEFAULT '0',
  `view_rate_groups` tinyint(1) NOT NULL DEFAULT '0',
  `new_rate_groups` tinyint(1) NOT NULL DEFAULT '0',
  `edit_rate_groups` tinyint(1) NOT NULL DEFAULT '0',
  `enable_disable_rate_groups` tinyint(1) NOT NULL DEFAULT '0',
  `delete_rate_groups` tinyint(1) NOT NULL DEFAULT '0',
  `new_rate` tinyint(1) NOT NULL DEFAULT '0',
  `import_csv` tinyint(1) NOT NULL DEFAULT '0',
  `view_cdr` tinyint(1) NOT NULL DEFAULT '0',
  `view_gateway_stats` tinyint(1) NOT NULL DEFAULT '0',
  `view_customer_stats` tinyint(1) NOT NULL DEFAULT '0',
  `view_call_destination` tinyint(1) NOT NULL DEFAULT '0',
  `view_biling` tinyint(1) NOT NULL DEFAULT '0',
  `view_invoices` tinyint(1) NOT NULL DEFAULT '0',
  `generate_invoices` tinyint(1) NOT NULL DEFAULT '0',
  `mark_invoices_paid` tinyint(1) NOT NULL DEFAULT '0',
  `view_profiles` tinyint(1) NOT NULL DEFAULT '0',
  `new_profiles` tinyint(1) NOT NULL DEFAULT '0',
  `delete_profiles` tinyint(1) NOT NULL DEFAULT '0',
  `freeswitch_status` tinyint(1) NOT NULL DEFAULT '0',
  `profile_details` tinyint(1) NOT NULL DEFAULT '0',
  `new_gateway` tinyint(1) NOT NULL DEFAULT '0',
  `delete_gateway` tinyint(1) NOT NULL DEFAULT '0',
  `edit_gateway` tinyint(1) NOT NULL DEFAULT '0',
  `delete_settings` tinyint(1) NOT NULL DEFAULT '0',
  `edit_settings` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `acl_lists`
--

CREATE TABLE IF NOT EXISTS `acl_lists` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `acl_name` varchar(128) NOT NULL,
  `default_policy` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `acl_lists`
--

INSERT INTO `acl_lists` (`id`, `acl_name`, `default_policy`) VALUES
                                                             (
                                                             1,
                                                             'default',
                                                             'deny');

-- --------------------------------------------------------

--
-- Table structure for table `acl_nodes`
--

CREATE TABLE IF NOT EXISTS `acl_nodes` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `customer_id` int(11) NOT NULL,
  `cidr` varchar(45) NOT NULL,
  `type` varchar(16) NOT NULL,
  `list_id` int(10) unsigned NOT NULL,
  `added_by` tinyint(3) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `carriers`
--

CREATE TABLE IF NOT EXISTS `carriers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `carrier_name` varchar(255) DEFAULT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `carrier_gateway`
--

CREATE TABLE IF NOT EXISTS `carrier_gateway` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `carrier_id` int(11) DEFAULT NULL,
  `gateway_name` varchar(250) NOT NULL,
  `carrier_profile_name` varchar(255) NOT NULL,
  `prefix` varchar(255) NOT NULL,
  `suffix` varchar(255) NOT NULL,
  `codec` varchar(255) NOT NULL,
  `prefix_sofia_id` int(11) NOT NULL,
  `priority` int(11) NOT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `carrier_id` (`carrier_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `cdr`
--

CREATE TABLE IF NOT EXISTS `cdr` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `caller_id_name` varchar(255) NOT NULL DEFAULT '',
  `caller_id_number` varchar(255) NOT NULL DEFAULT '',
  `destination_number` varchar(255) NOT NULL DEFAULT '',
  `context` varchar(255) NOT NULL DEFAULT '',
  `duration` varchar(255) NOT NULL DEFAULT '',
  `created_time` varchar(255) NOT NULL DEFAULT '',
  `profile_created_time` varchar(255) NOT NULL DEFAULT '',
  `progress_media_time` varchar(255) NOT NULL DEFAULT '',
  `answered_time` varchar(255) NOT NULL DEFAULT '',
  `bridged_time` varchar(255) NOT NULL DEFAULT '',
  `hangup_time` varchar(255) NOT NULL DEFAULT '',
  `billsec` varchar(255) NOT NULL DEFAULT '',
  `hangup_cause` varchar(255) NOT NULL DEFAULT '',
  `uuid` varchar(255) NOT NULL DEFAULT '',
  `read_codec` varchar(255) NOT NULL DEFAULT '',
  `write_codec` varchar(255) NOT NULL DEFAULT '',
  `network_addr` varchar(255) NOT NULL DEFAULT '',
  `username` varchar(255) NOT NULL DEFAULT '',
  `sip_user_agent` varchar(255) NOT NULL DEFAULT '',
  `sip_hangup_disposition` varchar(255) NOT NULL DEFAULT '',
  `ani` varchar(255) NOT NULL DEFAULT '',
  `customer_group_rate_table` varchar(255) NOT NULL DEFAULT '',
  `customer_prepaid` tinyint(1) NOT NULL,
  `customer_balance` decimal(11,4) NOT NULL,
  `customer_id` int(11) NOT NULL,
  `customer_acc_num` int(10) NOT NULL,
  `cidr` varchar(255) NOT NULL DEFAULT '',
  `sell_rate` decimal(11,4) NOT NULL,
  `cost_rate` decimal(11,4) NOT NULL,
  `buyblock_min_duration` int(3) NOT NULL,
  `sellblock_min_duration` int(3) NOT NULL,
  `buy_initblock` int(3) NOT NULL,
  `sell_initblock` int(3) NOT NULL,
  `total_sell_cost` decimal(11,4) NOT NULL DEFAULT '0.0000',
  `total_admin_sell_cost` decimal(11,4) NOT NULL DEFAULT '0.0000',
  `total_reseller_sell_cost` decimal(11,4) NOT NULL DEFAULT '0.0000',
  `total_buy_cost` decimal(11,4) NOT NULL DEFAULT '0.0000',
  `total_admin_buy_cost` decimal(11,4) NOT NULL DEFAULT '0.0000',
  `total_reseller_buy_cost` decimal(11,4) NOT NULL DEFAULT '0.0000',
  `gateway` varchar(255) NOT NULL,
  `sofia_id` int(11) NOT NULL,
  `country_id` int(11) NOT NULL,
  `rate_id` int(11) NOT NULL,
  `lcr_carrier_id` int(11) NOT NULL,
  `is_multi_gateway` tinyint(1) NOT NULL DEFAULT '0',
  `total_failed_gateways` int(11) NOT NULL DEFAULT '0',
  `parent_id` int(11) NOT NULL DEFAULT '0',
  `parent_reseller_id` int(11) NOT NULL DEFAULT '0',
  `grand_parent_reseller_id` int(11) NOT NULL DEFAULT '0',
  `reseller_level` tinyint(1) NOT NULL DEFAULT '0',
  `admin_rate_group` varchar(50) DEFAULT NULL,
  `admin_rate_id` int(11) NOT NULL DEFAULT '0',
  `reseller_rate_group` varchar(50) DEFAULT NULL,
  `reseller_rate_id` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `check_cdr_time`
--

CREATE TABLE IF NOT EXISTS `check_cdr_time` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `customer_id` int(11) NOT NULL,
  `uuid` varchar(500) NOT NULL,
  `charges` decimal(11,4) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `console_conf`
--

CREATE TABLE IF NOT EXISTS `console_conf` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `param_name` varchar(255) NOT NULL,
  `param_value` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=5 ;

--
-- Dumping data for table `console_conf`
--

INSERT INTO `console_conf` (`id`, `param_name`, `param_value`)
       VALUES
       (
       1,
       'colorize',
       'true'),
(2, 'loglevel', '$${console_loglevel}'),
(3, 'rotate-on-hup', 'true'),
(4, 'uuid', 'true');

-- --------------------------------------------------------

--
-- Table structure for table `countries`
--

CREATE TABLE IF NOT EXISTS `countries` (
  `id` smallint(20) NOT NULL AUTO_INCREMENT,
  `countrycode` char(3) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `alpha2code` char(2) CHARACTER SET utf8 NOT NULL,
  `countryprefix` varchar(10) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `gmttime` varchar(15) CHARACTER SET utf8 NOT NULL,
  `countryname` varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=254 ;

--
-- Dumping data for table `countries`
--

INSERT INTO `countries` (`id`, `countrycode`, `alpha2code`, `countryprefix`, `gmttime`, `countryname`)
       VALUES
       (
       1,
       'AFG',
       'AF',
       '93',
       '',
       'Afghanistan'),
(2, 'ALB', 'AL', '355', 'GMT+01:00', 'Albania'),
(3, 'DZA', 'DZ', '213', 'GMT', 'Algeria'),
(4, 'ASM', 'AS', '684', 'GMT-11:00', 'American Samoa'),
(5, 'AND', 'AD', '376', 'GMT+01:00', 'Andorra'),
(6, 'AGO', 'AO', '244', 'GMT+01:00', 'Angola'),
(7, 'AIA', 'AI', '1264', '', 'Anguilla'),
(8, 'ATA', 'AQ', '672', 'GMT+11:30', 'Antarctica'),
(9, 'ATG', 'AG', '1268', '', 'Antigua And Barbuda'),
(10, 'ARG', 'AR', '54', 'GMT-03:00', 'Argentina'),
(11, 'ARM', 'AM', '374', 'GMT+04:00', 'Armenia'),
(12, 'ABW', 'AW', '297', 'GMT-04:00', 'Aruba'),
(13, 'AUS', 'AU', '61', 'GMT+10:00', 'Australia'),
(14, 'AUT', 'AT', '43', 'GMT+01:00', 'Austria'),
(15, 'AZE', 'AZ', '994', 'GMT+04:00', 'Azerbaijan'),
(16, 'BHS', 'BS', '1242', '', 'Bahamas'),
(17, 'BHR', 'BH', '973', 'GMT+03:00', 'Bahrain'),
(18, 'BGD', 'BD', '880', 'GMT+06:00', 'Bangladesh'),
(19, 'BRB', 'BB', '1246', '', 'Barbados'),
(20, 'BLR', 'BY', '375', 'GMT+03:00', 'Belarus'),
(21, 'BEL', 'BE', '32', 'GMT+01:00', 'Belgium'),
(22, 'BLZ', 'BZ', '501', 'GMT-06:00', 'Belize'),
(23, 'BEN', 'BJ', '229', 'GMT+01:00', 'Benin'),
(24, 'BMU', 'BM', '1441', '', 'Bermuda'),
(25, 'BTN', 'BT', '975', 'GMT+05:30', 'Bhutan'),
(26, 'BOL', 'BO', '591', 'GMT-04:00', 'Bolivia'),
(27, 'BIH', 'BA', '387', 'GMT+01:00', 'Bosnia And Herzegovina'),
(28, 'BWA', 'BW', '267', 'GMT+02:00', 'Botswana'),
(30, 'BRA', 'BR', '55', 'GMT-03:00', 'Brazil'),
(31, 'IOT', 'IO', '1284', '', 'British Indian Ocean Territory'),
(32, 'BRN', 'BN', '673', 'GMT+08:00', 'Brunei Darussalam'),
(33, 'BGR', 'BG', '359', 'GMT+02:00', 'Bulgaria'),
(34, 'BFA', 'BF', '226', 'GMT', 'Burkina Faso'),
(35, 'BDI', 'BI', '257', 'GMT+02:00', 'Burundi'),
(36, 'KHM', 'KH', '855', 'GMT+07:00', 'Cambodia'),
(37, 'CMR', 'CM', '237', 'GMT+01:00', 'Cameroon'),
(38, 'CAN', 'CA', '1', 'GMT-05:00', 'Canada'),
(39, 'CPV', 'CV', '238', 'GMT-01:00', 'Cape Verde'),
(40, 'CYM', 'KY', '1345', '', 'Cayman Islands'),
(41, 'CAF', 'CF', '236', 'GMT+01:00', 'Central African Republic'),
(42, 'TCD', 'TD', '235', 'GMT+01:00', 'Chad'),
(43, 'CHL', 'CL', '56', 'GMT-04:00', 'Chile'),
(44, 'CHN', 'CN', '86', 'GMT+08:00', 'China'),
(45, 'CXR', 'CX', '618', '', 'Christmas Island'),
(46, 'CCK', 'CC', '61', 'GMT+10:00', 'Cocos (Keeling) Islands'),
(47, 'COL', 'CO', '57', 'GMT-05:00', 'Colombia'),
(48, 'COM', 'KM', '269', 'GMT+03:00', 'Comoros'),
(49, 'COG', 'CG', '242', 'GMT+01:00', 'Congo'),
(50, 'COD', 'CD', '243', 'GMT+02:00', 'Congo, The Democratic Republic Of The'),
(51, 'COK', 'CK', '682', 'GMT-10:00', 'Cook Islands'),
(52, 'CRI', 'CR', '506', 'GMT-06:00', 'Costa Rica'),
(54, 'HRV', 'HR', '385', 'GMT+01:00', 'Croatia'),
(55, 'CUB', 'CU', '53', 'GMT-03:00', 'Cuba'),
(56, 'CYP', 'CY', '357', 'GMT+02:00', 'Cyprus'),
(57, 'CZE', 'CZ', '420', 'GMT+01:00', 'Czech Republic'),
(58, 'DNK', 'DK', '45', 'GMT+01:00', 'Denmark'),
(59, 'DJI', 'DJ', '253', 'GMT+03:00', 'Djibouti'),
(60, 'DMA', 'DM', '1767', '', 'Dominica'),
(61, 'DOM', 'DO', '1809', '', 'Dominican Republic'),
(62, 'ECU', 'EC', '593', 'GMT-05:00', 'Ecuador'),
(63, 'EGY', 'EG', '20', 'GMT+02:00', 'Egypt'),
(64, 'SLV', 'SV', '503', 'GMT-06:00', 'El Salvador'),
(65, 'GNQ', 'GQ', '240', 'GMT+01:00', 'Equatorial Guinea'),
(66, 'ERI', 'ER', '291', 'GMT+03:00', 'Eritrea'),
(67, 'EST', 'EE', '372', 'GMT+03:00', 'Estonia'),
(68, 'ETH', 'ET', '251', 'GMT+03:00', 'Ethiopia'),
(69, 'FLK', 'FK', '500', 'GMT-04:00', 'Falkland Islands (Malvinas)'),
(70, 'FRO', 'FO', '298', 'GMT', 'Faroe Islands'),
(71, 'FJI', 'FJ', '679', 'GMT+12:00', 'Fiji'),
(72, 'FIN', 'FI', '358', 'GMT+02:00', 'Finland'),
(73, 'FRA', 'FR', '33', 'GMT+01:00', 'France'),
(74, 'GUF', 'GF', '596', 'GMT-04:00', 'French Guiana'),
(75, 'PYF', 'PF', '594', 'GMT-04:00', 'French Polynesia'),
(76, 'ATF', 'TF', '689', 'GMT-10:00', 'French Southern Territories'),
(77, 'GAB', 'GA', '241', 'GMT+01:00', 'Gabon'),
(78, 'GMB', 'GM', '220', 'GMT', 'Gambia'),
(79, 'GEO', 'GE', '995', 'GMT+04:00', 'Georgia'),
(80, 'DEU', 'DE', '49', 'GMT+01:00', 'Germany'),
(81, 'GHA', 'GH', '233', 'GMT', 'Ghana'),
(82, 'GIB', 'GI', '350', 'GMT+01:00', 'Gibraltar'),
(83, 'GRC', 'GR', '30', 'GMT+02:00', 'Greece'),
(84, 'GRL', 'GL', '299', 'GMT-03:00', 'Greenland'),
(85, 'GRD', 'GD', '1473', '', 'Grenada'),
(86, 'GLP', 'GP', '590', 'GMT-04:00', 'Guadeloupe'),
(87, 'GUM', 'GU', '1671', '', 'Guam'),
(88, 'GTM', 'GT', '502', 'GMT-06:00', 'Guatemala'),
(89, 'GIN', 'GN', '224', 'GMT', 'Guinea'),
(90, 'GNB', 'GW', '245', 'GMT-01:00', 'Guinea-Bissau'),
(91, 'GUY', 'GY', '592', 'GMT-03:00', 'Guyana'),
(92, 'HTI', 'HT', '509', 'GMT-05:00', 'Haiti'),
(95, 'HND', 'HN', '504', '', 'Honduras'),
(96, 'HKG', 'HK', '852', 'GMT+08:00', 'Hong Kong'),
(97, 'HUN', 'HU', '36', 'GMT+01:00', 'Hungary'),
(98, 'ISL', 'IS', '354', 'GMT', 'Iceland'),
(99, 'IND', 'IN', '91', 'GMT+05:30', 'India'),
(100, 'IDN', 'ID', '62', 'GMT+09:00', 'Indonesia'),
(101, 'IRN', 'IR', '98', 'GMT+03:30', 'Iran, Islamic Republic Of'),
(102, 'IRQ', 'IQ', '964', 'GMT+03:00', 'Iraq'),
(103, 'IRL', 'IE', '353', 'GMT', 'Ireland'),
(104, 'ISR', 'IL', '972', 'GMT+02:00', 'Israel'),
(105, 'ITA', 'IT', '39', 'GMT+01:00', 'Italy'),
(106, 'JAM', 'JM', '1876', '', 'Jamaica'),
(107, 'JPN', 'JP', '81', 'GMT+09:00', 'Japan'),
(108, 'JOR', 'JO', '962', 'GMT+02:00', 'Jordan'),
(109, 'KAZ', 'KZ', '7', 'GMT+03:00', 'Kazakhstan'),
(110, 'KEN', 'KE', '254', 'GMT+03:00', 'Kenya'),
(111, 'KIR', 'KI', '686', 'GMT+12:00', 'Kiribati'),
(112, 'PRK', 'KP', '850', '', 'Korea, Democratic People''s Republic Of'),
(113, 'KOR', 'KR', '82', '', 'Korea, Republic of'),
(114, 'KWT', 'KW', '965', 'GMT+03:00', 'Kuwait'),
(115, 'KGZ', 'KG', '996', 'GMT+06:00', 'Kyrgyzstan'),
(116, 'LAO', 'LA', '856', 'GMT+07:00', 'Lao People''s Democratic Republic'),
(117, 'LVA', 'LV', '371', 'GMT+03:00', 'Latvia'),
(118, 'LBN', 'LB', '961', 'GMT+02:00', 'Lebanon'),
(119, 'LSO', 'LS', '266', 'GMT+02:00', 'Lesotho'),
(120, 'LBR', 'LR', '231', 'GMT', 'Liberia'),
(121, 'LBY', 'LY', '218', 'GMT+02:00', 'Libyan Arab Jamahiriya'),
(122, 'LIE', 'LI', '423', 'GMT+01:00', 'Liechtenstein'),
(123, 'LTU', 'LT', '370', 'GMT+02:00', 'Lithuania'),
(124, 'LUX', 'LU', '352', 'GMT+01:00', 'Luxembourg'),
(125, 'MAC', 'MO', '853', 'GMT+08:00', 'Macao'),
(126, 'MKD', 'MK', '389', 'GMT+01:00', 'Macedonia, The Former Yugoslav Republic Of'),
(127, 'MDG', 'MG', '261', 'GMT+03:00', 'Madagascar'),
(128, 'MWI', 'MW', '265', 'GMT+02:00', 'Malawi'),
(129, 'MYS', 'MY', '60', 'GMT+08:00', 'Malaysia'),
(130, 'MDV', 'MV', '960', 'GMT+05:00', 'Maldives'),
(131, 'MLI', 'ML', '223', 'GMT', 'Mali'),
(132, 'MLT', 'MT', '356', 'GMT+01:00', 'Malta'),
(133, 'MHL', 'MH', '692', 'GMT+10:00', 'Marshall islands'),
(134, 'MTQ', 'MQ', '596', 'GMT-04:00', 'Martinique'),
(135, 'MRT', 'MR', '222', '', 'Mauritania'),
(136, 'MUS', 'MU', '230', 'GMT+04:00', 'Mauritius'),
(137, 'MYT', 'YT', '269', 'GMT+03:00', 'Mayotte'),
(138, 'MEX', 'MX', '52', 'GMT-06:00', 'Mexico'),
(139, 'FSM', 'FM', '691', 'GMT+10:00', 'Micronesia, Federated States Of'),
(140, 'MDA', 'MD', '1808', '', 'Moldova, Republic Of'),
(141, 'MCO', 'MC', '377', 'GMT+01:00', 'Monaco'),
(142, 'MNG', 'MN', '976', 'GMT+08:00', 'Mongolia'),
(143, 'MSR', 'MS', '1664', '', 'Montserrat'),
(144, 'MAR', 'MA', '212', 'GMT', 'Morocco'),
(145, 'MOZ', 'MZ', '258', 'GMT+02:00', 'Mozambique'),
(146, 'MMR', 'MM', '95', 'GMT+06:30', 'Myanmar'),
(147, 'NAM', 'NA', '264', 'GMT+02:00', 'Namibia'),
(148, 'NRU', 'NR', '674', 'GMT+12:00', 'Nauru'),
(149, 'NPL', 'NP', '977', 'GMT+05:30', 'Nepal'),
(150, 'NLD', 'NL', '31', 'GMT+01:00', 'Netherlands'),
(151, 'ANT', 'AN', '599', 'GMT-04:00', 'Netherlands Antilles'),
(152, 'NCL', 'NC', '687', 'GMT+11:00', 'New Caledonia'),
(153, 'NZL', 'NZ', '64', 'GMT+12:00', 'New Zealand'),
(154, 'NIC', 'NI', '505', 'GMT-06:00', 'Nicaragua'),
(155, 'NER', 'NE', '227', 'GMT+01:00', 'Niger'),
(156, 'NGA', 'NG', '234', 'GMT+01:00', 'Nigeria'),
(157, 'NIU', 'NU', '683', 'GMT-11:00', 'Niue'),
(158, 'NFK', 'NF', '672', 'GMT+11:30', 'Norfolk Island'),
(159, 'MNP', 'MP', '1670', '', 'Northern Mariana Islands'),
(160, 'NOR', 'NO', '47', 'GMT+01:00', 'Norway'),
(161, 'OMN', 'OM', '968', 'GMT+04:00', 'Oman'),
(162, 'PAK', 'PK', '92', 'GMT+05:00', 'Pakistan'),
(163, 'PLW', 'PW', '680', 'GMT+09:00', 'Palau'),
(164, 'PSE', 'PS', '970', 'GMT+02:00', 'Palestinian Territory, Occupied'),
(165, 'PAN', 'PA', '507', 'GMT-05:00', 'Panama'),
(166, 'PNG', 'PG', '675', 'GMT+10:00', 'Papua New Guinea'),
(167, 'PRY', 'PY', '595', 'GMT-04:00', 'Paraguay'),
(168, 'PER', 'PE', '51', 'GMT-05:00', 'Peru'),
(169, 'PHL', 'PH', '63', 'GMT+08:00', 'Philippines'),
(171, 'POL', 'PL', '48', 'GMT+01:00', 'Poland'),
(172, 'PRT', 'PT', '351', 'GMT+01:00', 'Portugal'),
(173, 'PRI', 'PR', '1787', '', 'Puerto Rico'),
(174, 'QAT', 'QA', '974', 'GMT+03:00', 'Qatar'),
(175, 'REU', 'RE', '262', 'GMT+04:00', 'Reunion'),
(176, 'ROU', 'RO', '40', 'GMT+02:00', 'Romania'),
(177, 'RUS', 'RU', '7', 'GMT+03:00', 'Russian Federation'),
(178, 'RWA', 'RW', '250', 'GMT+02:00', 'Rwanda'),
(179, 'SHN', 'SH', '290', 'GMT', 'SaINT Helena'),
(180, 'KNA', 'KN', '1869', '', 'SaINT Kitts And Nevis'),
(181, 'LCA', 'LC', '1758', '', 'SaINT Lucia'),
(182, 'SPM', 'PM', '508', '', 'SaINT Pierre And Miquelon'),
(183, 'VCT', 'VC', '1784', '', 'SaINT Vincent And The Grenadines'),
(184, 'WSM', 'WS', '685', 'GMT-11:00', 'Samoa'),
(185, 'SMR', 'SM', '378', 'GMT+01:00', 'San Marino'),
(186, 'STP', 'ST', '239', 'GMT', 'Sao Tome and Principe'),
(187, 'SAU', 'SA', '966', 'GMT+03:00', 'Saudi Arabia'),
(188, 'SEN', 'SN', '221', 'GMT', 'Senegal'),
(189, 'SYC', 'SC', '248', 'GMT+04:00', 'Seychelles'),
(190, 'SLE', 'SL', '232', 'GMT', 'Sierra Leone'),
(191, 'SGP', 'SG', '65', 'GMT+08:00', 'Singapore'),
(192, 'SVK', 'SK', '421', 'GMT+01:00', 'Slovakia'),
(193, 'SVN', 'SI', '386', 'GMT+01:00', 'Slovenia'),
(194, 'SLB', 'SB', '677', 'GMT+11:00', 'Solomon Islands'),
(195, 'SOM', 'SO', '252', 'GMT+03:00', 'Somalia'),
(196, 'ZAF', 'ZA', '27', 'GMT+02:00', 'South Africa'),
(198, 'ESP', 'ES', '34', 'GMT+01:00', 'Spain'),
(199, 'LKA', 'LK', '94', 'GMT+05:30', 'Sri Lanka'),
(200, 'SDN', 'SD', '249', 'GMT+02:00', 'Sudan'),
(201, 'SUR', 'SR', '597', 'GMT-03:30', 'Suriname'),
(203, 'SWZ', 'SZ', '268', 'GMT+02:00', 'Swaziland'),
(204, 'SWE', 'SE', '46', 'GMT+01:00', 'Sweden'),
(205, 'CHE', 'CH', '41', 'GMT+01:00', 'Switzerland'),
(206, 'SYR', 'SY', '963', 'GMT+02:00', 'Syrian Arab Republic'),
(207, 'TWN', 'TW', '886', 'GMT+08:00', 'Taiwan, Republic of China'),
(208, 'TJK', 'TJ', '992', 'GMT+06:00', 'Tajikistan'),
(209, 'TZA', 'TZ', '255', 'GMT+03:00', 'Tanzania, United Republic Of'),
(210, 'THA', 'TH', '66', 'GMT+07:00', 'Thailand'),
(211, 'TLS', 'TL', '670', 'GMT+10:00', 'Timor-Leste'),
(212, 'TGO', 'TG', '228', 'GMT', 'Togo'),
(213, 'TKL', 'TK', '690', '', 'Tokelau'),
(214, 'TON', 'TO', '676', 'GMT+13:00', 'Tonga'),
(215, 'TTO', 'TT', '1868', '', 'Trinidad And Tobago'),
(216, 'TUN', 'TN', '216', 'GMT+01:00', 'Tunisia'),
(217, 'TUR', 'TR', '90', 'GMT+02:00', 'Turkey'),
(218, 'TKM', 'TM', '993', 'GMT+05:00', 'Turkmenistan'),
(219, 'TCA', 'TC', '1649', '', 'Turks And Caicos Islands'),
(220, 'TUV', 'TV', '688', 'GMT+12:00', 'Tuvalu'),
(221, 'UGA', 'UG', '256', 'GMT+03:00', 'Uganda'),
(222, 'UKR', 'UA', '380', 'GMT+03:00', 'Ukraine'),
(223, 'ARE', 'AE', '971', 'GMT+04:00', 'United Arab Emirates'),
(224, 'GBR', 'GB', '44', 'GMT', 'United Kingdom'),
(225, 'USA', 'US', '1', 'GMT-05:00', 'United States'),
(227, 'URY', 'UY', '598', 'GMT-03:00', 'Uruguay'),
(228, 'UZB', 'UZ', '998', 'GMT+06:00', 'Uzbekistan'),
(229, 'VUT', 'VU', '678', 'GMT+11:00', 'Vanuatu'),
(230, 'VEN', 'VE', '58', 'GMT-04:00', 'Venezuela'),
(231, 'VNM', 'VN', '84', 'GMT+07:00', 'Vietnam'),
(232, 'VGB', 'VG', '1284', '', 'Virgin Islands, British'),
(233, 'VIR', 'VI', '808', '', 'Virgin Islands, U.S.'),
(234, 'WLF', 'WF', '681', 'GMT+12:00', 'Wallis And Futuna'),
(236, 'YEM', 'YE', '967', 'GMT+03:00', 'Yemen'),
(238, 'ZMB', 'ZM', '260', 'GMT+02:00', 'Zambia'),
(239, 'ZWE', 'ZW', '263', 'GMT+02:00', 'Zimbabwe'),
(241, 'ALA', 'AX', '35818', '', 'Aland Inland'),
(240, 'CIV', 'CI', '225', 'GMT', 'CÃƒÆ’Ã‚Â´te d''Ivoire'),
(248, 'GGY', 'GG', '441481', '', 'Guernsey'),
(249, 'IMN', 'IM', '441624', '', 'Isle of Man'),
(250, 'JEY', 'JE', '441534', '', 'Jersey'),
(252, 'MNE', 'ME', '382', '', 'Montenegro, Republic of'),
(253, 'SRB', 'RS', '381', 'GMT+01:00', 'Serbia, Republic of');

-- --------------------------------------------------------

--
-- Table structure for table `customers`
--

CREATE TABLE IF NOT EXISTS `customers` (
  `customer_id` int(11) NOT NULL AUTO_INCREMENT,
  `customer_acc_num` int(20) NOT NULL,
  `customer_company` varchar(50) CHARACTER SET utf8 DEFAULT NULL,
  `customer_firstname` varchar(50) CHARACTER SET utf8 DEFAULT NULL,
  `customer_lastname` varchar(50) CHARACTER SET utf8 DEFAULT NULL,
  `customer_contact_email` varchar(50) CHARACTER SET utf8 DEFAULT NULL,
  `customer_address` varchar(150) CHARACTER SET utf8 DEFAULT NULL,
  `customer_city` varchar(20) CHARACTER SET utf8 DEFAULT NULL,
  `customer_state` varchar(20) CHARACTER SET utf8 DEFAULT NULL,
  `customer_country` varchar(45) CHARACTER SET utf8 DEFAULT NULL,
  `customer_phone` varchar(45) CHARACTER SET utf8 DEFAULT NULL,
  `customer_phone_prefix` varchar(10) CHARACTER SET utf8 NOT NULL,
  `customer_fax` varchar(45) CHARACTER SET utf8 DEFAULT NULL,
  `customer_zip` varchar(10) CHARACTER SET utf8 DEFAULT NULL,
  `customer_timezone` varchar(10) CHARACTER SET utf8 NOT NULL,
  `customer_rate_group` int(11) NOT NULL,
  `rate_limit_check` tinyint(1) NOT NULL DEFAULT '0',
  `customer_low_rate_limit` decimal(10,4) DEFAULT NULL,
  `customer_high_rate_limit` decimal(10,4) DEFAULT NULL,
  `customer_prepaid` int(11) DEFAULT '1',
  `customer_balance` double(10,4) DEFAULT '0.0000',
  `customer_credit_limit` decimal(10,4) NOT NULL DEFAULT '0.0000',
  `customer_enabled` int(11) DEFAULT '0',
  `customer_max_calls` int(11) NOT NULL DEFAULT '0',
  `customer_send_cdr` int(11) DEFAULT NULL,
  `customer_billing_email` varchar(50) CHARACTER SET utf8 DEFAULT NULL,
  `next_invoice_date` varchar(255) CHARACTER SET utf8 NOT NULL,
  `customer_billing_cycle` varchar(50) CHARACTER SET utf8 NOT NULL,
  `parent_id` int(11) NOT NULL DEFAULT '0',
  `grand_parent_id` int(11) NOT NULL DEFAULT '0',
  `reseller_level` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`customer_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 CHECKSUM=1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `customer_access_limitations`
--

CREATE TABLE IF NOT EXISTS `customer_access_limitations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `customer_id` int(11) NOT NULL,
  `total_sip_accounts` int(11) NOT NULL,
  `total_acl_nodes` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `customer_balance_history`
--

CREATE TABLE IF NOT EXISTS `customer_balance_history` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `customer_id` int(11) DEFAULT NULL,
  `balance` decimal(11,4) DEFAULT '0.0000',
  `action` varchar(20) DEFAULT NULL,
  `date` varchar(250) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `customer_sip`
--

CREATE TABLE IF NOT EXISTS `customer_sip` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `customer_id` int(11) NOT NULL,
  `domain` varchar(255) NOT NULL,
  `domain_sofia_id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `directory`
--

CREATE TABLE IF NOT EXISTS `directory` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `customer_id` int(11) NOT NULL,
  `username` varchar(255) CHARACTER SET utf8 NOT NULL,
  `cid` varchar(255) CHARACTER SET utf8 NOT NULL,
  `domain` varchar(255) CHARACTER SET utf8 NOT NULL,
  `domain_id` int(11) NOT NULL,
  `domain_sofia_id` int(11) NOT NULL,
  `added_by` int(11) NOT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `directory_params`
--

CREATE TABLE IF NOT EXISTS `directory_params` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `directory_id` int(11) DEFAULT NULL,
  `param_name` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `param_value` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `directory_vars`
--

CREATE TABLE IF NOT EXISTS `directory_vars` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `directory_id` int(11) DEFAULT NULL,
  `var_name` varchar(255) DEFAULT NULL,
  `var_value` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `groups`
--

CREATE TABLE IF NOT EXISTS `groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_name` varchar(100) NOT NULL,
  `group_description` varchar(250) NOT NULL,
  `group_rate_table` varchar(50) NOT NULL,
  `enabled` tinyint(1) NOT NULL,
  `created_by` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `hangup_causes`
--

CREATE TABLE IF NOT EXISTS `hangup_causes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `hangup_cause` varchar(250) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=64 ;

--
-- Dumping data for table `hangup_causes`
--

INSERT INTO `hangup_causes` (`id`, `hangup_cause`)
       VALUES
       (
       1,
       'UNSPECIFIED'),
(2, 'UNALLOCATED_NUMBER'),
(4, 'NO_ROUTE_DESTINATION'),
(5, 'CHANNEL_UNACCEPTABLE'),
(7, 'NORMAL_CLEARING'),
(8, 'USER_BUSY'),
(9, 'NO_USER_RESPONSE'),
(10, 'NO_ANSWER'),
(12, 'CALL_REJECTED'),
(13, 'NUMBER_CHANGED'),
(16, 'DESTINATION_OUT_OF_ORDER'),
(17, 'INVALID_NUMBER_FORMAT'),
(18, 'FACILITY_REJECTED'),
(20, 'NORMAL_UNSPECIFIED'),
(21, 'NORMAL_CIRCUIT_CONGESTION'),
(22, 'NETWORK_OUT_OF_ORDER'),
(23, 'NORMAL_TEMPORARY_FAILURE'),
(24, 'SWITCH_CONGESTION'),
(28, 'FACILITY_NOT_SUBSCRIBED'),
(29, 'OUTGOING_CALL_BARRED'),
(31, 'BEARERCAPABILITY_NOTAUTH'),
(32, 'BEARERCAPABILITY_NOTAVAIL'),
(33, 'SERVICE_UNAVAILABLE'),
(34, 'BEARERCAPABILITY_NOTIMPL'),
(35, 'CHAN_NOT_IMPLEMENTED'),
(36, 'FACILITY_NOT_IMPLEMENTED'),
(37, 'SERVICE_NOT_IMPLEMENTED'),
(39, 'INCOMPATIBLE_DESTINATION'),
(47, 'RECOVERY_ON_TIMER_EXPIRE'),
(51, 'ORIGINATOR_CANCEL'),
(58, 'ALLOTTED_TIMEOUT'),
(60, 'MEDIA_TIMEOUT'),
(63, 'PROGRESS_TIMEOUT');

-- --------------------------------------------------------

--
-- Table structure for table `invoices`
--

CREATE TABLE IF NOT EXISTS `invoices` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `invoice_id` varchar(255) NOT NULL,
  `customer_id` int(11) NOT NULL,
  `from_date` varchar(255) NOT NULL,
  `to_date` varchar(255) NOT NULL,
  `total_charges` decimal(11,4) NOT NULL,
  `total_calls` int(11) NOT NULL,
  `total_tax` decimal(11,4) NOT NULL,
  `tax_rate` decimal(11,4) NOT NULL,
  `misc_charges` decimal(11,4) NOT NULL,
  `misc_charges_description` varchar(255) NOT NULL,
  `customer_prepaid` int(11) NOT NULL,
  `invoice_generated_date` varchar(255) NOT NULL,
  `due_date` varchar(255) NOT NULL,
  `status` varchar(50) NOT NULL,
  `parent_id` int(11) NOT NULL DEFAULT '0',
  `grand_parent_id` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `modless_conf`
--

CREATE TABLE IF NOT EXISTS `modless_conf` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `conf_name` varchar(64) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=6 ;

--
-- Dumping data for table `modless_conf`
--

INSERT INTO `modless_conf` (`id`, `conf_name`)
       VALUES
       (
       1,
       'post_load_switch.conf'),
(2, 'post_load_modules.conf'),
(3, 'console.conf'),
(4, 'acl.conf'),
(5, 'switch.conf');

-- --------------------------------------------------------

--
-- Table structure for table `post_load_modules_conf`
--

CREATE TABLE IF NOT EXISTS `post_load_modules_conf` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `module_name` varchar(64) NOT NULL,
  `load_module` tinyint(1) NOT NULL DEFAULT '1',
  `priority` int(10) unsigned NOT NULL DEFAULT '1000',
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_mod` (`module_name`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=15 ;

--
-- Dumping data for table `post_load_modules_conf`
--

INSERT INTO `post_load_modules_conf` (`id`, `module_name`, `load_module`, `priority`)
       VALUES
       (
       1,
       'mod_sofia',
       1,
       2000),
(2, 'mod_xml_cdr', 1, 1000),
(3, 'mod_commands', 1, 1000),
(4, 'mod_dialplan_xml', 1, 150),
(5, 'mod_g723_1', 1, 500),
(6, 'mod_g729', 1, 500),
(7, 'mod_g722', 1, 500),
(8, 'mod_amr', 1, 500),
(9, 'mod_event_socket', 1, 100),
(10, 'mod_dptools', 1, 1500),
(11, 'mod_lua', 1, 1600),
(12, 'mod_db', 1, 1000),
(13, 'mod_hash', 1, 1000),
(14, 'mod_console', 1, 1000);

-- --------------------------------------------------------

--
-- Table structure for table `settings`
--

CREATE TABLE IF NOT EXISTS `settings` (
  `id` int(11) NOT NULL,
  `customer_id` int(11) NOT NULL,
  `company_name` varchar(250) NOT NULL,
  `enable_rate_limits` tinyint(4) NOT NULL DEFAULT '0',
  `logo` varchar(250) NOT NULL,
  `invoice_logo` varchar(250) NOT NULL,
  `invoice_terms` text NOT NULL,
  `company_logo_as_invoice_logo` tinyint(1) NOT NULL,
  `optional_cdr_fields_include` text NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `socket_client_conf`
--

CREATE TABLE IF NOT EXISTS `socket_client_conf` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `param_name` varchar(100) NOT NULL,
  `param_value` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=5 ;

--
-- Dumping data for table `socket_client_conf`
--

INSERT INTO `socket_client_conf` (`id`, `param_name`, `param_value`)
       VALUES
       (
       1,
       'nat-map',
       'false'),
(2, 'listen-ip', '$${event_socket_listen_ip}'),
(3, 'listen-port', '$${event_socket_listen_port}'),
(4, 'password', '$${event_socket_password}');

-- --------------------------------------------------------

--
-- Table structure for table `sofia_conf`
--

CREATE TABLE IF NOT EXISTS `sofia_conf` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `profile_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `sofia_domains`
--

CREATE TABLE IF NOT EXISTS `sofia_domains` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sofia_id` int(11) DEFAULT NULL,
  `domain_name` varchar(255) DEFAULT NULL,
  `parse` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `sofia_gateways`
--

CREATE TABLE IF NOT EXISTS `sofia_gateways` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sofia_id` int(11) DEFAULT NULL,
  `gateway_name` varchar(255) DEFAULT NULL,
  `gateway_param` varchar(255) DEFAULT NULL,
  `gateway_value` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `sofia_gateways_params`
--

CREATE TABLE IF NOT EXISTS `sofia_gateways_params` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `param_name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=28 ;

--
-- Dumping data for table `sofia_gateways_params`
--

INSERT INTO `sofia_gateways_params` (`id`, `param_name`)
       VALUES
       (
       1,
       'username'),
(2, 'register'),
(3, 'password'),
(4, 'proxy'),
(5, 'from-domain'),
(6, 'from-user'),
(7, 'realm'),
(8, 'caller-id-in-from'),
(9, 'extension'),
(10, 'expire-seconds'),
(19, 'auth'),
(12, 'register-transport'),
(13, 'contact-params'),
(14, 'ping'),
(15, 'ping-max'),
(16, 'ping-min'),
(17, 'extension-in-contact'),
(11, 'scheme'),
(20, 'context'),
(21, 'retry-seconds'),
(22, 'timeout-seconds'),
(23, 'contact-host'),
(24, 'register-proxy'),
(25, 'outbound-proxy'),
(26, 'distinct-to'),
(27, 'channels');

-- --------------------------------------------------------

--
-- Table structure for table `sofia_settings`
--

CREATE TABLE IF NOT EXISTS `sofia_settings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sofia_id` int(11) DEFAULT NULL,
  `param_name` varchar(255) DEFAULT NULL,
  `param_value` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `sofia_settings_params`
--

CREATE TABLE IF NOT EXISTS `sofia_settings_params` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` text NOT NULL,
  `param_name` varchar(255) NOT NULL,
  `param_value_type` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=101 ;

--
-- Dumping data for table `sofia_settings_params`
--

INSERT INTO `sofia_settings_params` (`id`, `type`, `param_name`, `param_value_type`)
       VALUES
       (
       1,
       'Basic',
       'alias',
       1),
(2, 'Basic', 'shutdown-on-fail', 3),
(3, 'Basic', 'user-agent-string', 1),
(4, 'Basic', 'debug', 3),
(5, 'Basic', 'sip-trace', 2),
(6, 'Basic', 'context', 1),
(7, 'Basic', 'sip-port', 1),
(8, 'Basic', 'sip-ip', 1),
(9, 'Basic', 'rtp-ip', 1),
(10, 'Basic', 'ext-rtp-ip', 1),
(11, 'Basic', 'ext-sip-ip', 1),
(12, 'Basic', 'dialplan', 1),
(13, 'Media', 'resume-media-on-hold', 1),
(14, 'Media', 'bypass-media-after-att-xfer', 1),
(15, 'Media', 'inbound-bypass-media', 3),
(16, 'Media', 'inbound-proxy-media', 3),
(17, 'Media', 'disable-rtp-auto-adjust', 3),
(18, 'Media', 'ignore-183nosdp', 3),
(19, 'Media', 'enable-soa', 3),
(20, 'Codec', 'inbound-codec-prefs', 1),
(21, 'Codec', 'outbound-codec-prefs', 1),
(22, 'Codec', 'codec-prefs', 1),
(23, 'Codec', 'inbound-codec-negotiation', 1),
(24, 'Codec', 'inbound-late-negotiation', 3),
(25, 'Codec', 'bitpacking', 1),
(26, 'Codec', 'disable-transcoding', 3),
(27, 'STUN', 'ext-rtp-ip', 1),
(28, 'STUN', 'ext-sip-ip', 1),
(29, 'STUN', 'stun-enabled', 3),
(30, 'STUN', 'stun-auto-disable', 3),
(31, 'NAT', 'apply-nat-acl', 1),
(32, 'NAT', 'aggressive-nat-detection', 3),
(33, 'VAD', 'vad', 1),
(34, 'VAD', 'suppress-cng', 3),
(35, 'NDLB', 'NDLB-force-rport', 1),
(36, 'NDLB', 'NDLB-broken-auth-hash', 3),
(37, 'NDLB', 'NDLB-received-in-nat-reg-contact', 3),
(38, 'NDLB', 'NDLB-sendrecv-in-session', 3),
(39, 'NDLB', 'NDLB-allow-bad-iananame', 3),
(40, 'Call_ID', 'inbound-use-callid-as-uuid', 3),
(41, 'Call_ID', 'outbound-use-uuid-as-callid', 3),
(42, 'TLS', 'tls', 1),
(43, 'TLS', 'tls-bind-params', 1),
(44, 'TLS', 'tls-sip-port', 1),
(45, 'TLS', 'tls-cert-dir', 1),
(46, 'TLS', 'tls-version', 1),
(47, 'DTMF', 'rfc2833-pt', 1),
(48, 'DTMF', 'dtmf-duration', 1),
(49, 'DTMF', 'dtmf-type', 1),
(50, 'DTMF', 'pass-rfc2833', 3),
(51, 'DTMF', 'liberal-dtmf', 3),
(52, 'SIP_Options', 'enable-timer', 3),
(53, 'SIP_Options', 'session-timeout', 1),
(54, 'SIP_Options', 'enable-100rel', 3),
(55, 'SIP_Options', 'minimum-session-expires', 1),
(56, 'RTP_Related', 'auto-jitterbuffer-msec', 1),
(57, 'RTP_Related', 'rtp-timer-name', 1),
(58, 'RTP_Related', 'rtp-rewrite-timestamps', 3),
(59, 'RTP_Related', 'rtp-timeout-sec', 1),
(60, 'RTP_Related', 'rtp-hold-timeout-sec', 1),
(61, 'RTP_Related', 'rtp-autoflush-during-bridge', 3),
(62, 'RTP_Related', 'rtp-autoflush', 3),
(63, 'Auth', 'challenge-realm', 1),
(64, 'Auth', 'accept-blind-auth', 3),
(65, 'Auth', 'auth-calls', 1),
(66, 'Auth', 'log-auth-failures', 3),
(67, 'Auth', 'auth-all-packets', 3),
(68, 'Registration', 'disable-register', 3),
(69, 'Registration', 'multiple-registrations', 1),
(70, 'Registration', 'accept-blind-reg', 3),
(71, 'Registration', 'inbound-reg-force-matching-username', 3),
(72, 'Registration', 'force-publish-expires', 3),
(73, 'Registration', 'force-register-domain', 1),
(74, 'Registration', 'force-register-db-domain', 1),
(75, 'Registration', 'send-message-query-on-register', 3),
(76, 'Registration', 'unregister-on-options-fail', 3),
(77, 'Registration', 'nat-options-ping', 3),
(78, 'Registration', 'all-reg-options-ping', 3),
(79, 'Subscription', 'force-subscription-expires', 1),
(80, 'Subscription', 'force-subscription-domain', 1),
(81, 'Presence', 'manage-presence', 3),
(82, 'Presence', 'dbname', 1),
(83, 'Presence', 'presence-hosts', 1),
(84, 'Presence', 'send-presence-on-register', 3),
(85, 'CallerID', 'caller-id-type', 1),
(86, 'CallerID', 'pass-callee-id', 3),
(87, 'Other', 'hold-music', 1),
(88, 'Other', 'disable-hold', 3),
(89, 'Other', 'apply-inbound-acl', 1),
(90, 'Other', 'apply-register-acl', 1),
(91, 'Other', 'apply-proxy-acl', 1),
(92, 'Other', 'record-template', 1),
(93, 'Other', 'max-proceeding', 1),
(94, 'Other', 'bind-params', 1),
(95, 'Other', 'disable-transfer', 3),
(96, 'Other', 'manual-redirect', 3),
(97, 'Other', 'enable-3pcc', 3),
(98, 'Other', 'nonce-ttl', 1),
(99, 'Other', 'sql-in-transactions', 3),
(100, 'Other', 'odbc-dsn', 1);

-- --------------------------------------------------------

--
-- Table structure for table `switch_conf`
--

CREATE TABLE IF NOT EXISTS `switch_conf` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `param_name` varchar(255) NOT NULL,
  `param_value` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=4 ;

--
-- Dumping data for table `switch_conf`
--

INSERT INTO `switch_conf` (`id`, `param_name`, `param_value`)
       VALUES
       (
       1,
       'max-sessions',
       '200'),
(2, 'sessions-per-second', '30'),
(3, 'switchname', 'vBilling');

-- --------------------------------------------------------

--
-- Table structure for table `timezones`
--

CREATE TABLE IF NOT EXISTS `timezones` (
  `id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,
  `timezone_location` varchar(30) NOT NULL DEFAULT '',
  `gmt` varchar(11) NOT NULL DEFAULT '',
  `offset` tinyint(2) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=143 ;

--
-- Dumping data for table `timezones`
--

INSERT INTO `timezones` (`id`, `timezone_location`, `gmt`, `offset`)
       VALUES
       (
       1,
       'International Date Line West',
       '(GMT-12:00)',
       -12),
(2, 'Midway Island', '(GMT-11:00)', -11),
(3, 'Samoa', '(GMT-11:00)', -11),
(4, 'Hawaii', '(GMT-10:00)', -10),
(5, 'Alaska', '(GMT-09:00)', -9),
(6, 'Pacific Time (US & Canada)', '(GMT-08:00)', -8),
(7, 'Tijuana', '(GMT-08:00)', -8),
(8, 'Arizona', '(GMT-07:00)', -7),
(9, 'Mountain Time (US & Canada)', '(GMT-07:00)', -7),
(10, 'Chihuahua', '(GMT-07:00)', -7),
(11, 'La Paz', '(GMT-07:00)', -7),
(12, 'Mazatlan', '(GMT-07:00)', -7),
(13, 'Central Time (US & Canada)', '(GMT-06:00)', -6),
(14, 'Central America', '(GMT-06:00)', -6),
(15, 'Guadalajara', '(GMT-06:00)', -6),
(16, 'Mexico City', '(GMT-06:00)', -6),
(17, 'Monterrey', '(GMT-06:00)', -6),
(18, 'Saskatchewan', '(GMT-06:00)', -6),
(19, 'Eastern Time (US & Canada)', '(GMT-05:00)', -5),
(20, 'Indiana (East)', '(GMT-05:00)', -5),
(21, 'Bogota', '(GMT-05:00)', -5),
(22, 'Lima', '(GMT-05:00)', -5),
(23, 'Quito', '(GMT-05:00)', -5),
(24, 'Atlantic Time (Canada)', '(GMT-04:00)', -4),
(25, 'Caracas', '(GMT-04:00)', -4),
(26, 'La Paz', '(GMT-04:00)', -4),
(27, 'Santiago', '(GMT-04:00)', -4),
(28, 'Newfoundland', '(GMT-03:30)', -3),
(29, 'Brasilia', '(GMT-03:00)', -3),
(30, 'Buenos Aires', '(GMT-03:00)', -3),
(31, 'Georgetown', '(GMT-03:00)', -3),
(32, 'Greenland', '(GMT-03:00)', -3),
(33, 'Mid-Atlantic', '(GMT-02:00)', -2),
(34, 'Azores', '(GMT-01:00)', -1),
(35, 'Cape Verde Is.', '(GMT-01:00)', -1),
(36, 'Casablanca', '(GMT)', 0),
(37, 'Dublin', '(GMT)', 0),
(38, 'Edinburgh', '(GMT)', 0),
(39, 'Lisbon', '(GMT)', 0),
(40, 'London', '(GMT)', 0),
(41, 'Monrovia', '(GMT)', 0),
(42, 'Amsterdam', '(GMT+01:00)', 1),
(43, 'Belgrade', '(GMT+01:00)', 1),
(44, 'Berlin', '(GMT+01:00)', 1),
(45, 'Bern', '(GMT+01:00)', 1),
(46, 'Bratislava', '(GMT+01:00)', 1),
(47, 'Brussels', '(GMT+01:00)', 1),
(48, 'Budapest', '(GMT+01:00)', 1),
(49, 'Copenhagen', '(GMT+01:00)', 1),
(50, 'Ljubljana', '(GMT+01:00)', 1),
(51, 'Madrid', '(GMT+01:00)', 1),
(52, 'Paris', '(GMT+01:00)', 1),
(53, 'Prague', '(GMT+01:00)', 1),
(54, 'Rome', '(GMT+01:00)', 1),
(55, 'Sarajevo', '(GMT+01:00)', 1),
(56, 'Skopje', '(GMT+01:00)', 1),
(57, 'Stockholm', '(GMT+01:00)', 1),
(58, 'Vienna', '(GMT+01:00)', 1),
(59, 'Warsaw', '(GMT+01:00)', 1),
(60, 'West Central Africa', '(GMT+01:00)', 1),
(61, 'Zagreb', '(GMT+01:00)', 1),
(62, 'Athens', '(GMT+02:00)', 2),
(63, 'Bucharest', '(GMT+02:00)', 2),
(64, 'Cairo', '(GMT+02:00)', 2),
(65, 'Harare', '(GMT+02:00)', 2),
(66, 'Helsinki', '(GMT+02:00)', 2),
(67, 'Istanbul', '(GMT+02:00)', 2),
(68, 'Jerusalem', '(GMT+02:00)', 2),
(69, 'Kyev', '(GMT+02:00)', 2),
(70, 'Minsk', '(GMT+02:00)', 2),
(71, 'Pretoria', '(GMT+02:00)', 2),
(72, 'Riga', '(GMT+02:00)', 2),
(73, 'Sofia', '(GMT+02:00)', 2),
(74, 'Tallinn', '(GMT+02:00)', 2),
(75, 'Vilnius', '(GMT+02:00)', 2),
(76, 'Baghdad', '(GMT+03:00)', 3),
(77, 'Kuwait', '(GMT+03:00)', 3),
(78, 'Moscow', '(GMT+03:00)', 3),
(79, 'Nairobi', '(GMT+03:00)', 3),
(80, 'Riyadh', '(GMT+03:00)', 3),
(81, 'St. Petersburg', '(GMT+03:00)', 3),
(82, 'Volgograd', '(GMT+03:00)', 3),
(83, 'Tehran', '(GMT+03:30)', 3),
(84, 'Abu Dhabi', '(GMT+04:00)', 4),
(85, 'Baku', '(GMT+04:00)', 4),
(86, 'Muscat', '(GMT+04:00)', 4),
(87, 'Tbilisi', '(GMT+04:00)', 4),
(88, 'Yerevan', '(GMT+04:00)', 4),
(89, 'Kabul', '(GMT+04:30)', 4),
(90, 'Ekaterinburg', '(GMT+05:00)', 5),
(91, 'Islamabad', '(GMT+05:00)', 5),
(92, 'Karachi', '(GMT+05:00)', 5),
(93, 'Tashkent', '(GMT+05:00)', 5),
(94, 'Chennai', '(GMT+05:30)', 5),
(95, 'Kolkata', '(GMT+05:30)', 5),
(96, 'Mumbai', '(GMT+05:30)', 5),
(97, 'New Delhi', '(GMT+05:30)', 5),
(98, 'Kathmandu', '(GMT+05:45)', 5),
(99, 'Almaty', '(GMT+06:00)', 6),
(100, 'Astana', '(GMT+06:00)', 6),
(101, 'Dhaka', '(GMT+06:00)', 6),
(102, 'Novosibirsk', '(GMT+06:00)', 6),
(103, 'Sri Jayawardenepura', '(GMT+06:00)', 6),
(104, 'Rangoon', '(GMT+06:30)', 6),
(105, 'Bangkok', '(GMT+07:00)', 7),
(106, 'Hanoi', '(GMT+07:00)', 7),
(107, 'Jakarta', '(GMT+07:00)', 7),
(108, 'Krasnoyarsk', '(GMT+07:00)', 7),
(109, 'Beijing', '(GMT+08:00)', 8),
(110, 'Chongqing', '(GMT+08:00)', 8),
(111, 'Hong Kong', '(GMT+08:00)', 8),
(112, 'Irkutsk', '(GMT+08:00)', 8),
(113, 'Kuala Lumpur', '(GMT+08:00)', 8),
(114, 'Perth', '(GMT+08:00)', 8),
(115, 'Singapore', '(GMT+08:00)', 8),
(116, 'Taipei', '(GMT+08:00)', 8),
(117, 'Ulaan Bataar', '(GMT+08:00)', 8),
(118, 'Urumqi', '(GMT+08:00)', 8),
(119, 'Osaka', '(GMT+09:00)', 9),
(120, 'Sapporo', '(GMT+09:00)', 9),
(121, 'Seoul', '(GMT+09:00)', 9),
(122, 'Tokyo', '(GMT+09:00)', 9),
(123, 'Yakutsk', '(GMT+09:00)', 9),
(124, 'Adelaide', '(GMT+09:30)', 9),
(125, 'Darwin', '(GMT+09:30)', 9),
(126, 'Brisbane', '(GMT+10:00)', 10),
(127, 'Canberra', '(GMT+10:00)', 10),
(128, 'Guam', '(GMT+10:00)', 10),
(129, 'Hobart', '(GMT+10:00)', 10),
(130, 'Melbourne', '(GMT+10:00)', 10),
(131, 'Port Moresby', '(GMT+10:00)', 10),
(132, 'Sydney', '(GMT+10:00)', 10),
(133, 'Vladivostok', '(GMT+10:00)', 10),
(134, 'Magadan', '(GMT+11:00)', 11),
(135, 'New Caledonia', '(GMT+11:00)', 11),
(136, 'Solomon Is.', '(GMT+11:00)', 11),
(137, 'Auckland', '(GMT+12:00)', 12),
(138, 'Fiji', '(GMT+12:00)', 12),
(139, 'Kamchatka', '(GMT+12:00)', 12),
(140, 'Marshall Is.', '(GMT+12:00)', 12),
(141, 'Wellington', '(GMT+12:00)', 12),
(142, 'Nuku''alofa', '(GMT+13:00)', 13);

-- --------------------------------------------------------

--
-- Table structure for table `xml_cdr_conf`
--

CREATE TABLE IF NOT EXISTS `xml_cdr_conf` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `param_name` varchar(255) NOT NULL,
  `param_value` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=8 ;

--
-- Dumping data for table `xml_cdr_conf`
--

INSERT INTO `xml_cdr_conf` (`id`, `param_name`, `param_value`)
       VALUES
       (
       1,
       'url',
       '$${vBilling_xml_cdr_url}'),
(2, 'encode', 'true'),
(3, 'log-b-leg', 'false'),
(4, 'prefix-a-leg', 'true'),
(5, 'retries', '2'),
(6, 'delay', '5'),
(7, 'log-http-and-disk', 'false');
