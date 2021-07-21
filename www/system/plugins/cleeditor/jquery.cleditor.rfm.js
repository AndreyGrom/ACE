/**
 @preserve CLEditor Responsive filemanager Image Plugin v1.0.0
 http://www.responsivefilemanager.com/  - amazing file manager from ALBERTO PERIPOLLI (info@albertoperipolli.com)
 http://premiumsoftware.net/cleditor    - 
 requires CLEditor v1.3.0 or later
 
 Copyright 2015, Zoran Cindori
 Select image from server or upload new image.
 
 Usage:	- include this file after jquery.cleditor.min.js in your web site
		- call $.cleditor.set_rfm(path) function to set path to Responsive filemanager root directory where dialog.php exists
			e.g. $.cleditor.set_rfm('libs/responsivefilemanager');
		- and that is all, click on "Insert Image" toolbar button, browse for image(RFM), select image, Submit, and now you have image in you
		  cleditor.
*/

(function($) {
	/* method to set path for responsive file manager and activate plugin */
	$.cleditor.set_rfm = function(path) {

		/* id for input:text field */
		var field_id = "cleditor-input-url";
		/* remove possible trailing slash from path */
		$.cleditor.rfm_url = path.substr(path.length - 1) == '/' ? path.substr(0, path.length - 1) :  path;
		/* we are changing original toolbar button for image insertion */
        $.cleditor.buttons.image.title = 'Добавить изображение';
		$.cleditor.buttons.image.popupClass = 'cleditorPrompt';
		/* new popup code, input field now has specified id=cleditor-input-url, we also add link to click on to display file manager window */
		$.cleditor.buttons.image.popupContent = 'Введите URL изображения<br><input id="' + field_id + '" type="text" value="http://" style="width:300px;cursor:pointer"><br>' +
				  '<hr /><a onclick="$.cleditor.rfm_function(\'' + field_id  + '\')">Открыть файловый менеджер</a><hr /><input type=button value="Вставить">';

    }
	
		
	/* function to display responsive file manager window, type=2 to select only images, popup=1 to close
       filemanager window when we click and select image, field_id="cleditor-input-url" because we need filemanager to fill this field
	   with URL of selected image file, the same field_id, cleditor-input-url, is specified in $.cleditor.buttons.image.popupContent as input field.*/
	$.cleditor.rfm_function = function (field_id) {

		window.open($.cleditor.rfm_url + '/dialog.php?type=2&popup=1&field_id=' + field_id ,  "rfm_cleditr",
			  "status=0, toolbar=0, location=0, menubar=0, directories=0, " +
			  "resizable=0, scrollbars=0, width=900, height=600");  
	}
	/* callback from file manager */
	window.responsive_filemanager_callback = function(field_id){
		/* your code here */
	}
	
})(jQuery);