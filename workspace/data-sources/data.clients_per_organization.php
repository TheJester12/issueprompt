<?php

    require_once(TOOLKIT . '/class.datasource.php');

    Class datasourceClients_per_organization extends Datasource{

        function about(){
            return array(
                    'name' => 'Clients Per Organization',
                    'author' => array(
                        'name' => 'Nick Dunn',
                        'website' => 'http://nick-dunn.co.uk',
                        'email' => 'nick@nick-dunn.co.uk'),
                    'version' => '1.0',
                    'release-date' => '2008-12-09T12:00:00+00:00');
        }

        function grab(&$param_pool){

            $client_list_id = "33";
            $result = new XMLElement("clients-per-organization");

            $clients = $this->_Parent->Database->fetch("SELECT DISTINCT(handle), COUNT(handle) AS count, value FROM sym_entries_data_$client_list_id GROUP BY handle ORDER BY handle ASC");

            foreach($clients as $client){
                $client_node = new XMLElement("client", General::sanitize($client["value"]));
                $client_node->setAttributeArray(array("handle" => $client["handle"], "count" => $client["count"]));
                $result->appendChild($client_node);
            }

            return $result;
        }
    }

?>