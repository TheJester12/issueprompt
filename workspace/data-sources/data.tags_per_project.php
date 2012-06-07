<?php

    require_once(TOOLKIT . '/class.datasource.php');

    Class datasourceTags_per_project extends Datasource{
	   
       public function about(){
            return array(
                    'name' => 'Tags Per Project',
                    'author' => array(
                        'name' => 'Nick Dunn',
                        'website' => 'http://nick-dunn.co.uk',
                        'email' => 'nick@nick-dunn.co.uk'),
                    'version' => '1.0',
                    'release-date' => '2008-12-09T12:00:00+00:00');
        }
        
		public function __construct(&$parent, $env=NULL, $process_params=true){
			parent::__construct($parent, $env, $process_params);
			$this->_dependencies = array('$ds-project-view-individual', '$ds-logged-in-member');
		}

        public function grab(&$param_pool){
            
			$result = new XMLElement("tags-per-project");
			      
			$params = $this->_env['env']['pool'];
			$project = ($params['ds-project-view-individual'][0]);
			
			$tags = $this->_Parent->Database->fetch("SELECT sym_entries_data_14.*, COUNT(sym_entries_data_14.handle) AS count, value  
				FROM sym_entries_data_17
				RIGHT JOIN sym_entries_data_14
				ON sym_entries_data_17.entry_id = sym_entries_data_14.entry_id
				WHERE sym_entries_data_17.relation_id = $project GROUP BY handle ORDER BY handle ASC"
			);
                      
           foreach($tags as $tag){
                $tag_node = new XMLElement("tag", General::sanitize($tag["value"]));
                $tag_node->setAttributeArray(array("handle" => $tag["handle"], "count" => $tag["count"]));
                $result->appendChild($tag_node);
           }
	
           return $result;
        }
    }

?>