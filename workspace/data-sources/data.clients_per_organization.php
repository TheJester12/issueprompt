<?php

    require_once(TOOLKIT . '/class.datasource.php');

    Class datasourceClients_per_organization extends Datasource{

        public function about(){
            return array(
                    'name' => 'Clients Per Organization',
                    'author' => array(
                        'name' => 'Nick Dunn',
                        'website' => 'http://nick-dunn.co.uk',
                        'email' => 'nick@nick-dunn.co.uk'),
                    'version' => '1.0',
                    'release-date' => '2008-12-09T12:00:00+00:00');
        }
        
        public function __construct(&$parent, $env=NULL, $process_params=true){
			parent::__construct($parent, $env, $process_params);
			$this->_dependencies = array('$ds-logged-in-member');
		}

        function grab(&$param_pool){

            $result = new XMLElement("clients-per-organization");
            
            $params = $this->_env['env']['pool'];
            $project = ($params['ds-logged-in-member'][0]);

            
            $clients = $this->_Parent->Database->fetch("SELECT sym_entries_data_33.*, COUNT(sym_entries_data_33.handle) AS count, value  
				FROM sym_entries_data_30
				RIGHT JOIN sym_entries_data_33
				ON sym_entries_data_30.entry_id = sym_entries_data_33.entry_id
				WHERE sym_entries_data_30.relation_id = $project GROUP BY handle ORDER BY handle ASC"
			);

            foreach($clients as $client){
                $client_node = new XMLElement("client", General::sanitize($client["value"]));
                $client_node->setAttributeArray(array("handle" => $client["handle"], "count" => $client["count"]));
                $result->appendChild($client_node);
            }

            return $result;
        }
    }

?>