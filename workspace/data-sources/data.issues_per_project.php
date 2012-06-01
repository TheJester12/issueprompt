<?php

	require_once(TOOLKIT . '/class.datasource.php');

	Class datasourceissues_per_project extends Datasource{

		public $dsParamROOTELEMENT = 'issues-per-project';
		public $dsParamORDER = '{$url-order:asc}';
		public $dsParamPAGINATERESULTS = 'yes';
		public $dsParamLIMIT = '10';
		public $dsParamSTARTPAGE = '{$url-p:1}';
		public $dsParamREDIRECTONEMPTY = 'no';
		public $dsParamSORT = '{$url-sort:priority}';
		public $dsParamASSOCIATEDENTRYCOUNTS = 'yes';

		public $dsParamFILTERS = array(
				'12' => '{$url-status:active}',
				'17' => '{$ds-project-view-individual:64893498346}',
				'29' => '{$ds-logged-in-member:4869398}',
				'14' => '{$url-tags}',
				'19' => '{$url-users}',
				'18' => '{$url-creator}',
		);

		public $dsParamINCLUDEDELEMENTS = array(
				'system:pagination',
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
			$this->_dependencies = array('$ds-project-view-individual', '$ds-logged-in-member');
		}

		public function about(){
			return array(
				'name' => 'Issues per Project',
				'author' => array(
					'name' => 'Jesse Sutherland',
					'website' => 'http://localhost/issuetracker4',
					'email' => 'jessesutherland06@gmail.com'),
				'version' => 'Symphony 2.2.5',
				'release-date' => '2012-05-20T04:04:33+00:00'
			);
		}

		public function getSource(){
			return '3';
		}

		public function allowEditorToParse(){
			return false;
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
