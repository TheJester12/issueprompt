<?php

	require_once(TOOLKIT . '/class.datasource.php');

	Class datasourcelogged_in_member_organization extends Datasource{

		public $dsParamROOTELEMENT = 'logged-in-member-organization';
		public $dsParamORDER = 'desc';
		public $dsParamPAGINATERESULTS = 'no';
		public $dsParamLIMIT = '2';
		public $dsParamSTARTPAGE = '1';
		public $dsParamREDIRECTONEMPTY = 'no';
		public $dsParamSORT = 'system:id';
		public $dsParamASSOCIATEDENTRYCOUNTS = 'no';

		public $dsParamFILTERS = array(
				'id' => '{$ds-logged-in-member:64556}',
		);

		public $dsParamINCLUDEDELEMENTS = array(
				'organization-name',
				'date-added',
				'website'
		);


		public function __construct(&$parent, $env=NULL, $process_params=true){
			parent::__construct($parent, $env, $process_params);
			$this->_dependencies = array('$ds-logged-in-member');
		}

		public function about(){
			return array(
				'name' => 'Logged In Member Organization',
				'author' => array(
					'name' => 'Jesse Sutherland',
					'website' => 'http://localhost/issuetracker4',
					'email' => 'jessesutherland06@gmail.com'),
				'version' => 'Symphony 2.2.5',
				'release-date' => '2012-06-01T01:37:34+00:00'
			);
		}

		public function getSource(){
			return '5';
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
