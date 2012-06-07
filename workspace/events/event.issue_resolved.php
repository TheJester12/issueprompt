<?php

	require_once(TOOLKIT . '/class.event.php');

	Class eventissue_resolved extends Event{

		const ROOTELEMENT = 'issue-resolved';

		public $eParamFILTERS = array(
			
		);

		public static function about(){
			return array(
				'name' => 'Issue Resolved',
				'author' => array(
					'name' => 'Jesse Sutherland',
					'website' => 'http://localhost/issuetracker4',
					'email' => 'jessesutherland06@gmail.com'),
				'version' => 'Symphony 2.2.5',
				'release-date' => '2012-06-03T11:42:31+00:00',
				'trigger-condition' => 'action[issue-resolved]'
			);
		}

		public static function getSource(){
			return '3';
		}

		public static function allowEditorToParse(){
			return true;
		}

		public static function documentation(){
			return '
        <h3>Success and Failure XML Examples</h3>
        <p>When saved successfully, the following XML will be returned:</p>
        <pre class="XML"><code>&lt;issue-resolved result="success" type="create | edit">
  &lt;message>Entry [created | edited] successfully.&lt;/message>
&lt;/issue-resolved></code></pre>
        <p>When an error occurs during saving, due to either missing or invalid fields, the following XML will be returned:</p>
        <pre class="XML"><code>&lt;issue-resolved result="error">
  &lt;message>Entry encountered errors when saving.&lt;/message>
  &lt;field-name type="invalid | missing" />
  ...
&lt;/issue-resolved></code></pre>
        <h3>Example Front-end Form Markup</h3>
        <p>This is an example of the form markup you can use on your frontend:</p>
        <pre class="XML"><code>&lt;form method="post" action="" enctype="multipart/form-data">
  &lt;input name="MAX_FILE_SIZE" type="hidden" value="5242880" />
  &lt;label>Issue Name
    &lt;input name="fields[issue-name]" type="text" />
  &lt;/label>
  &lt;label>Description
    &lt;textarea name="fields[description]" rows="15" cols="50">&lt;/textarea>
  &lt;/label>
  &lt;label>Status
    &lt;select name="fields[status]">
      &lt;option value="Active">Active&lt;/option>
      &lt;option value="Resolved">Resolved&lt;/option>
      &lt;option value="On Hold">On Hold&lt;/option>
      &lt;option value="Invalid">Invalid&lt;/option>
    &lt;/select>
  &lt;/label>
  &lt;label>Priority
    &lt;select name="fields[priority]">
      &lt;option value="4-No-Priority">4-No-Priority&lt;/option>
      &lt;option value="1-High">1-High&lt;/option>
      &lt;option value="2-Medium">2-Medium&lt;/option>
      &lt;option value="3-Low">3-Low&lt;/option>
    &lt;/select>
  &lt;/label>
  &lt;label>Tags
    &lt;input name="fields[tags]" type="text" />
  &lt;/label>
  &lt;label>Date Added
    &lt;input name="fields[date-added]" type="text" />
  &lt;/label>
  &lt;label>Date Modified
    &lt;input name="fields[date-modified]" type="text" />
  &lt;/label>
  &lt;input name="fields[project-link]" type="hidden" value="..." />
  &lt;input name="fields[added-by]" type="hidden" value="..." />
  &lt;input name="fields[assigned-to]" type="hidden" value="..." />
  &lt;input name="fields[resolved-by]" type="hidden" value="..." />
  &lt;label>Date Resolved
    &lt;input name="fields[date-resolved]" type="text" />
  &lt;/label>
  &lt;input name="fields[organization-link]" type="hidden" value="..." />
  &lt;input name="action[issue-resolved]" type="submit" value="Submit" />
&lt;/form></code></pre>
        <p>To edit an existing entry, include the entry ID value of the entry in the form. This is best as a hidden field like so:</p>
        <pre class="XML"><code>&lt;input name="id" type="hidden" value="23" /></code></pre>
        <p>To redirect to a different location upon a successful save, include the redirect location in the form. This is best as a hidden field like so, where the value is the URL to redirect to:</p>
        <pre class="XML"><code>&lt;input name="redirect" type="hidden" value="http://localhost/issuetracker4/success/" /></code></pre>';
		}

		public function load(){
			if(isset($_POST['action']['issue-resolved'])) return $this->__trigger();
		}

		protected function __trigger(){
			include(TOOLKIT . '/events/event.section.php');
			return $result;
		}

	}
