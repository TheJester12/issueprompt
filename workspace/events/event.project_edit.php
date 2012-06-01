<?php

	require_once(TOOLKIT . '/class.event.php');

	Class eventproject_edit extends Event{

		const ROOTELEMENT = 'project-edit';

		public $eParamFILTERS = array(
			'xss-fail'
		);

		public static function about(){
			return array(
				'name' => 'Project Edit',
				'author' => array(
					'name' => 'Jesse Sutherland',
					'website' => 'http://localhost/issuetracker4',
					'email' => 'jessesutherland06@gmail.com'),
				'version' => 'Symphony 2.2.5',
				'release-date' => '2012-05-10T03:49:51+00:00',
				'trigger-condition' => 'action[project-edit]'
			);
		}

		public static function getSource(){
			return '2';
		}

		public static function allowEditorToParse(){
			return true;
		}

		public static function documentation(){
			return '
        <h3>Success and Failure XML Examples</h3>
        <p>When saved successfully, the following XML will be returned:</p>
        <pre class="XML"><code>&lt;project-edit result="success" type="create | edit">
  &lt;message>Entry [created | edited] successfully.&lt;/message>
&lt;/project-edit></code></pre>
        <p>When an error occurs during saving, due to either missing or invalid fields, the following XML will be returned:</p>
        <pre class="XML"><code>&lt;project-edit result="error">
  &lt;message>Entry encountered errors when saving.&lt;/message>
  &lt;field-name type="invalid | missing" />
  ...
&lt;/project-edit></code></pre>
        <p>The following is an example of what is returned if any options return an error:</p>
        <pre class="XML"><code>&lt;project-edit result="error">
  &lt;message>Entry encountered errors when saving.&lt;/message>
  &lt;filter name="admin-only" status="failed" />
  &lt;filter name="send-email" status="failed">Recipient not found&lt;/filter>
  ...
&lt;/project-edit></code></pre>
        <h3>Example Front-end Form Markup</h3>
        <p>This is an example of the form markup you can use on your frontend:</p>
        <pre class="XML"><code>&lt;form method="post" action="" enctype="multipart/form-data">
  &lt;input name="MAX_FILE_SIZE" type="hidden" value="5242880" />
  &lt;label>Project name
    &lt;input name="fields[project-name]" type="text" />
  &lt;/label>
  &lt;input name="fields[added-by]" type="hidden" value="..." />
  &lt;input name="fields[followed-by]" type="hidden" value="..." />
  &lt;label>Status
    &lt;select name="fields[status]">
      &lt;option value="Active">Active&lt;/option>
      &lt;option value="Inactive">Inactive&lt;/option>
    &lt;/select>
  &lt;/label>
  &lt;label>Date Added
    &lt;input name="fields[date-added]" type="text" />
  &lt;/label>
  &lt;input name="fields[organization-link]" type="hidden" value="..." />
  &lt;input name="action[project-edit]" type="submit" value="Submit" />
&lt;/form></code></pre>
        <p>To edit an existing entry, include the entry ID value of the entry in the form. This is best as a hidden field like so:</p>
        <pre class="XML"><code>&lt;input name="id" type="hidden" value="23" /></code></pre>
        <p>To redirect to a different location upon a successful save, include the redirect location in the form. This is best as a hidden field like so, where the value is the URL to redirect to:</p>
        <pre class="XML"><code>&lt;input name="redirect" type="hidden" value="http://localhost/issuetracker4/success/" /></code></pre>';
		}

		public function load(){
			if(isset($_POST['action']['project-edit'])) return $this->__trigger();
		}

		protected function __trigger(){
			include(TOOLKIT . '/events/event.section.php');
			return $result;
		}

	}
