$(document).ready(function(){
	
	// Hide tags that already exist
	/*
	var startTags = $('#fields-tags').val();
	//alert(startTags);
	var TagArray = startTags.split(',');
	//alert(TagArray);
	for(var i = 0 ; i < TagArray.length ; i++) {
		//alert(TagArray[i]);
		$('.tags-list li').each(function(){
			//alert($(this).attr('id'));
			if ($(this).attr('id') === "tag-" + TagArray[i]) {
				$(this).hide();
			}
		});
		//$('.tags-list li').text(TagArray[i]).hide();
	}
	*/
	
	$(".change-password").click(function() {
		$(this).parents(".control-group").replaceWith('<div class="control-group"><label class="control-label" for="password">Password</label><div class="controls"><input name="fields[password][password]" id="password" type="password"></div></div><div class="control-group"><label class="control-label" for="passwordagain">Password Again</label><div class="controls"><input name="fields[password][confirm]" id="passwordagain" type="password"></div></div>');
		return false;
	});
	
	$(".chosen").chosen();
	$('.tags-input').tagsInput({
		onAddTag: onAddTag,
   		onRemoveTag: onRemoveTag,
		width:'auto',
		height:'29px'
	});
	$('.tags-list li').on("click", function(){
		var clickedTag = $(this).text();
		alert(clickedTag);
		$('.tags-input').addTag(clickedTag);
		//$(this).hide();
	});
});

function onAddTag(tag) {
	$('.tags-list li').each(function(){
		if ($(this).text() == tag) {
			$(this).remove();
		}
	});
}
function onRemoveTag(tag) {
	$('.tags-list').append("<li id='tag-" + tag + "'>" + tag + "</li>");
}

new WMDEditor({
	input: "fields-description",
	button_bar: "wmd-button-bar",
	//preview: "notes-preview",
	//output: "copy_html",
	buttons: "bold italic link code  ol ul  heading",
	modifierKeys: false,
	autoFormatting: false
});