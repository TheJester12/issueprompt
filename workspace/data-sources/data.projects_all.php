<?php

	require_once(TOOLKIT . '/class.datasource.php');

	Class datasourceprojects_all extends Datasource{

		public $dsParamROOTELEMENT = 'projects-all';
		public $dsParamORDER = 'desc';
		public $dsParamPAGINATERESULTS = 'yes';
		public $dsParamLIMIT = '10';
		public $dsParamSTARTPAGE = '{$url-p:1}';
		public $dsParamREDIRECTONEMPTY = 'no';
		public $dsParamSORT = 'date-added';
		public $dsParamASSOCIATEDENTRYCOUNTS = 'yes';

		public $dsParamFILTERS = array(
				'33' => '{$url-client}',
				'7' => '{$url-users}',
				'9' => '{$url-status:active}',
				'30' => '{$ds-logged-in-member:64556}',
		);

		public $dsParamINCLUDEDELEMENTS = array(
				'system:pagination',
				'project-name',
				'project-id',
				'client',
				'added-by',
				'participants',
				'status',
				'date-added',
				'organization-link'
		);


		public function __construct(&$parent, $env=NULL, $process_params=true){
			parent::__construct($parent, $env, $process_params);
			$this->_dependencies = array('$ds-logged-in-member');
		}

		public function about(){
			return array(
				'name' => 'Projects All',
				'author' => array(
					'name' => 'Jesse Sutherland',
					'website' => 'http://localhost/issuetracker4',
					'email' => 'jessesutherland06@gmail.com'),
				'version' => 'Symphony 2.2.5',
				'release-date' => '2012-06-03T12:28:42+00:00'
			);
		}

		public function getSource(){
			return '2';
		}

		public function allowEditorToParse(){
			return true;
		}

		public function grab(&$param_pool=NULL){
			$result = new XMLElement($this->dsParamROOTELEMENT);

			try{
				include(TOOLKIT . '/data-sources/datasource.section.php');
			}
			catch(FrontendPageNotFoundException $e){
				// Work around. This ensures the 404 page is displayed and
				// is not picked up by the default catch() statement below
				FrontendPageNotFoundExceptionHandler::render($e);
			}
			catch(Exception $e){
				$result->appendChild(new XMLElement('error', $e->getMessage()));
				return $result;
			}

			if($this->_force_empty_result) $result = $this->emptyXMLSet();

			

			return $result;
		}

	}
