CREATE USER 'xpresso_admin'@'localhost' IDENTIFIED with mysql_native_password BY 'XPRESS0_123';
CREATE USER 'xpresso_admin'@'192.168.66.%' IDENTIFIED with mysql_native_password BY 'XPRESS0_123';



CREATE DATABASE s3_management;
GRANT ALL PRIVILEGES ON `s3_management`.* TO 'xpresso_admin'@'localhost'   WITH GRANT OPTION;
GRANT ALL PRIVILEGES ON `s3_management`.* TO 'xpresso_admin'@'192.168.66.%'   WITH GRANT OPTION;



CREATE DATABASE s3_auths;
GRANT ALL PRIVILEGES ON `s3_auths`.* TO 'xpresso_admin'@'localhost'   WITH GRANT OPTION;
GRANT ALL PRIVILEGES ON `s3_auths`.* TO 'xpresso_admin'@'192.168.66.%'   WITH GRANT OPTION;



CREATE DATABASE s3_cdets;
GRANT ALL PRIVILEGES ON `s3_cdets`.* TO 'xpresso_admin'@'localhost'   WITH GRANT OPTION;
GRANT ALL PRIVILEGES ON `s3_cdets`.* TO 'xpresso_admin'@'192.168.66.%'   WITH GRANT OPTION;



CREATE DATABASE s3_communications;
GRANT ALL PRIVILEGES ON `s3_communications`.* TO 'xpresso_admin'@'localhost'   WITH GRANT OPTION;
GRANT ALL PRIVILEGES ON `s3_communications`.* TO 'xpresso_admin'@'192.168.66.%'   WITH GRANT OPTION;



CREATE DATABASE s3_controller;
GRANT ALL PRIVILEGES ON `s3_controller`.* TO 'xpresso_admin'@'localhost'   WITH GRANT OPTION;
GRANT ALL PRIVILEGES ON `s3_controller`.* TO 'xpresso_admin'@'192.168.66.%'   WITH GRANT OPTION;



CREATE DATABASE s3_genie;
GRANT ALL PRIVILEGES ON `s3_genie`.* TO 'xpresso_admin'@'localhost'   WITH GRANT OPTION;
GRANT ALL PRIVILEGES ON `s3_genie`.* TO 'xpresso_admin'@'192.168.66.%'   WITH GRANT OPTION;



CREATE DATABASE s3_groups;
GRANT ALL PRIVILEGES ON `s3_groups`.* TO 'xpresso_admin'@'localhost'   WITH GRANT OPTION;
GRANT ALL PRIVILEGES ON `s3_groups`.* TO 'xpresso_admin'@'192.168.66.%'   WITH GRANT OPTION;



CREATE DATABASE s3_history;
GRANT ALL PRIVILEGES ON `s3_history`.* TO 'xpresso_admin'@'localhost'   WITH GRANT OPTION;
GRANT ALL PRIVILEGES ON `s3_history`.* TO 'xpresso_admin'@'192.168.66.%'   WITH GRANT OPTION;



CREATE DATABASE s3_jenkinsengine;
GRANT ALL PRIVILEGES ON `s3_jenkinsengine`.* TO 'xpresso_admin'@'localhost'   WITH GRANT OPTION;
GRANT ALL PRIVILEGES ON `s3_jenkinsengine`.* TO 'xpresso_admin'@'192.168.66.%'   WITH GRANT OPTION;



CREATE DATABASE s3_laas;
GRANT ALL PRIVILEGES ON `s3_laas`.* TO 'xpresso_admin'@'localhost'   WITH GRANT OPTION;
GRANT ALL PRIVILEGES ON `s3_laas`.* TO 'xpresso_admin'@'192.168.66.%'   WITH GRANT OPTION;



CREATE DATABASE s3_labvpn;
GRANT ALL PRIVILEGES ON `s3_labvpn`.* TO 'xpresso_admin'@'localhost'   WITH GRANT OPTION;
GRANT ALL PRIVILEGES ON `s3_labvpn`.* TO 'xpresso_admin'@'192.168.66.%'   WITH GRANT OPTION;



CREATE DATABASE s3_monitors;
GRANT ALL PRIVILEGES ON `s3_monitors`.* TO 'xpresso_admin'@'localhost'   WITH GRANT OPTION;
GRANT ALL PRIVILEGES ON `s3_monitors`.* TO 'xpresso_admin'@'192.168.66.%'   WITH GRANT OPTION;



CREATE DATABASE s3_plugins;
GRANT ALL PRIVILEGES ON `s3_plugins`.* TO 'xpresso_admin'@'localhost'   WITH GRANT OPTION;
GRANT ALL PRIVILEGES ON `s3_plugins`.* TO 'xpresso_admin'@'192.168.66.%'   WITH GRANT OPTION;



CREATE DATABASE s3_qmgr;
GRANT ALL PRIVILEGES ON `s3_qmgr`.* TO 'xpresso_admin'@'localhost'   WITH GRANT OPTION;
GRANT ALL PRIVILEGES ON `s3_qmgr`.* TO 'xpresso_admin'@'192.168.66.%'   WITH GRANT OPTION;



CREATE DATABASE s3_registry;
GRANT ALL PRIVILEGES ON `s3_registry`.* TO 'xpresso_admin'@'localhost'   WITH GRANT OPTION;
GRANT ALL PRIVILEGES ON `s3_registry`.* TO 'xpresso_admin'@'192.168.66.%'   WITH GRANT OPTION;



CREATE DATABASE s3_requests;
GRANT ALL PRIVILEGES ON `s3_requests`.* TO 'xpresso_admin'@'localhost'   WITH GRANT OPTION;
GRANT ALL PRIVILEGES ON `s3_requests`.* TO 'xpresso_admin'@'192.168.66.%'   WITH GRANT OPTION;



CREATE DATABASE s3_resources;
GRANT ALL PRIVILEGES ON `s3_resources`.* TO 'xpresso_admin'@'localhost'   WITH GRANT OPTION;
GRANT ALL PRIVILEGES ON `s3_resources`.* TO 'xpresso_admin'@'192.168.66.%'   WITH GRANT OPTION;



CREATE DATABASE s3_results;
GRANT ALL PRIVILEGES ON `s3_results`.* TO 'xpresso_admin'@'localhost'   WITH GRANT OPTION;
GRANT ALL PRIVILEGES ON `s3_results`.* TO 'xpresso_admin'@'192.168.66.%'   WITH GRANT OPTION;



CREATE DATABASE result_service;
GRANT ALL PRIVILEGES ON `result_service`.* TO 'xpresso_admin'@'localhost'   WITH GRANT OPTION;
GRANT ALL PRIVILEGES ON `result_service`.* TO 'xpresso_admin'@'192.168.66.%'   WITH GRANT OPTION;


CREATE DATABASE s3_sessions;
GRANT ALL PRIVILEGES ON `s3_sessions`.* TO 'xpresso_admin'@'localhost'   WITH GRANT OPTION;
GRANT ALL PRIVILEGES ON `s3_sessions`.* TO 'xpresso_admin'@'192.168.66.%'   WITH GRANT OPTION;



CREATE DATABASE s3_testbeds;
GRANT ALL PRIVILEGES ON `s3_testbeds`.* TO 'xpresso_admin'@'localhost'   WITH GRANT OPTION;
GRANT ALL PRIVILEGES ON `s3_testbeds`.* TO 'xpresso_admin'@'192.168.66.%'   WITH GRANT OPTION;



CREATE DATABASE s3_topoman;
GRANT ALL PRIVILEGES ON `s3_topoman`.* TO 'xpresso_admin'@'localhost'   WITH GRANT OPTION;
GRANT ALL PRIVILEGES ON `s3_topoman`.* TO 'xpresso_admin'@'192.168.66.%'   WITH GRANT OPTION;



CREATE DATABASE s3_users;
GRANT ALL PRIVILEGES ON `s3_users`.* TO 'xpresso_admin'@'localhost'   WITH GRANT OPTION;
GRANT ALL PRIVILEGES ON `s3_users`.* TO 'xpresso_admin'@'192.168.66.%'   WITH GRANT OPTION;



CREATE DATABASE s3_aggregator;
GRANT ALL PRIVILEGES ON `s3_aggregator`.* TO 'xpresso_admin'@'localhost'   WITH GRANT OPTION;
GRANT ALL PRIVILEGES ON `s3_aggregator`.* TO 'xpresso_admin'@'192.168.66.%'   WITH GRANT OPTION;
