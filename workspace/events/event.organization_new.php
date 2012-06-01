<?php

	require_once(TOOLKIT . '/class.event.php');

	Class eventorganization_new extends Event{

		const ROOTELEMENT = 'organization-new';

		public $eParamFILTERS = array(
			
		);

		public static function about(){
			return array(
				'name' => 'Organization New',
				'author' => array(
					'name' => 'Jesse Sutherland',
					'website' => 'http://localhost/issuetracker4',
					'email' => 'jessesutherland06@gmail.com'),
				'version' => 'Symphony 2.2.5',
				'release-date' => '2012-05-10T03:51:39+00:00',
				'trigger-condition' => 'action[organization-new]'
			);
		}

		public static function getSource(){
			return '5';
		}

		public static function allowEditorToParse(){
			return true;
		}

		public static function documentation(){
			return '
        <h3>Success and Failure XML Examples</h3>
        <p>When saved successfully, the following XML will be returned:</p>
        <pre class="XML"><code>&lt;organization-new result="success" type="create | edit">
  &lt;message>Entry [created | edited] successfully.&lt;/message>
&lt;/organization-new></code></pre>
        <p>When an error occurs during saving, due to either missing or invalid fields, the following XML will be returned:</p>
        <pre class="XML"><code>&lt;organization-new result="error">
  &lt;message>Entry encountered errors when saving.&lt;/message>
  &lt;field-name type="invalid | missing" />
  ...
&lt;/organization-new></code></pre>
        <h3>Example Front-end Form Markup</h3>
        <p>This is an example of the form markup you can use on your frontend:</p>
        <pre class="XML"><code>&lt;form method="post" action="" enctype="multipart/form-data">
  &lt;input name="MAX_FILE_SIZE" type="hidden" value="5242880" />
  &lt;label>Organization Name
    &lt;input name="fields[organization-name]" type="text" />
  &lt;/label>
  &lt;label>Date Added
    &lt;input name="fields[date-added]" type="text" />
  &lt;/label>
  &lt;input name="action[organization-new]" type="submit" value="Submit" />
&lt;/form></code></pre>
        <p>To edit an existing entry, include the entry ID value of the entry in the form. This is best as a hidden field like so:</p>
        <pre class="XML"><code>&lt;input name="id" type="hidden" value="23" /></code></pre>
        <p>To redirect to a different location upon a successful save, include the redirect location in the form. This is best as a hidden field like so, where the value is the URL to redirect to:</p>
        <pre class="XML"><code>&lt;input name="redirect" type="hidden" value="http://localhost/issuetracker4/success/" /></code></pre>';
		}

		public function load(){
			if(isset($_POST['action']['organization-new'])) return $this->__trigger();
		}

		protected function __trigger(){
			include(TOOLKIT . '/events/event.section.php');
			return $result;
		}

	}
