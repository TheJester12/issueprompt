<?php

	require_once(TOOLKIT . '/class.datasource.php');

	Class datasourcelogged_in_member_issues extends Datasource{

		public $dsParamROOTELEMENT = 'logged-in-member-issues';
		public $dsParamORDER = 'desc';
		public $dsParamPAGINATERESULTS = 'yes';
		public $dsParamLIMIT = '5';
		public $dsParamSTARTPAGE = '1';
		public $dsParamREDIRECTONEMPTY = 'no';
		public $dsParamSORT = 'date-added';
		public $dsParamASSOCIATEDENTRYCOUNTS = 'no';

		public $dsParamFILTERS = array(
				'12' => 'Active',
				'19' => '{$member-id:57685694}',
				'29' => '{$ds-logged-in-member:64556}',
		);

		public $dsParamINCLUDEDELEMENTS = array(
				'issue-name',
				'description',
				'status',
				'priority',
				'tags',
				'date-added',
				'date-modified',
				'project-link',
				'added-by',
				'assigned-to',
				'organization-link'
		);


		public function __construct(&$parent, $env=NULL, $process_params=true){
			parent::__construct($parent, $env, $process_params);
			$this->_dependencies = array('$ds-logged-in-member');
		}

		public function about(){
			return array(
				'name' => 'Logged In Member Issues',
				'author' => array(
					'name' => 'Jesse Sutherland',
					'website' => 'http://localhost/issuetracker4',
					'email' => 'jessesutherland06@gmail.com'),
				'version' => 'Symphony 2.2.5',
				'release-date' => '2012-06-01T03:48:07+00:00'
			);
		}

		public function getSource(){
			return '3';
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
