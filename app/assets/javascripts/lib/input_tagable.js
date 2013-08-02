(function() {
  $ = jQuery;

  $.fn.extend({
    input_tagable: function(options) {
      return this.each(function(input_field) {
        var $this = $(this);
        if (!$this.hasClass("tagable-done")) {
          return createInputTagable($this);
        }
      });
    }
  });
}).call(this);

function createInputTagable(tagable_input) {
  var container_box = $('<div class="input-tagable-container-box"></div>');
  container_box.insertBefore(tagable_input);

  var input_append = $('<div class="input-append"></div>');
  input_append.append(tagable_input);
  var add_btn = $('<button class="btn btn1">Add</button>');
  add_btn.css('height', input_append.css('height'));
  input_append.append('<button class="btn btn1">ADD</button>');
  container_box.append(input_append);

  container_box.append($('<ul class="tag_list"></ul>'));
  $input = $(tagable_input);
  container_box.append($('<input type="hidden" name="' + $input.attr('name') + '">'));
  $input.removeAttr('name');
  $input.addClass('tagable-done');
}
$(document).ready(function(){
	$('input.tagable').input_tagable();

	$('input.tagable').live('keydown', function(evt) {
		if (evt.which == 13 || evt.which == 188) {
			input_tagable_add_to_list($(this));
			evt.preventDefault();
		}
	});

	$('input.tagable').live('keypress', function(evt) {
		if (evt.which == 13) {
			evt.preventDefault();
		}
	});

	$('.input-tagable-container-box .input-append button').live('click', function(evt){
		$this = $(this).prev();
		if($this.val()) {
			input_tagable_add_to_list($this);
		}
		$this.focus();
		evt.preventDefault();
	});

	$('.input-tagable-container-box ul.tag_list span.del_tag_link').live('click', function(evt) {
		var li = $(this).parent();
		li.fadeOut(function(){
			var input = $('input.tagable', li.parent().parent());
			li.remove();	
			input_tagable_set_values(input);
		});

		evt.preventDefault();
	});

	$('input.tagable').live('blur', function(evt) {
		// $(this).next().trigger('click');
		$this = $(this);
		if($this.val()) {
			input_tagable_add_to_list($this);
		}
		input_tagable_set_values($this);
	});

});

// Add value into the list.
function input_tagable_add_to_list($this) {
	if(input_tagable_get_values($this).size() >= 5) {
		alert('You can at most add 5 services/products.');
		return;
	}

	var content = $this.val();
  var tag_ul = $this.parent().parent().parent().find('ul.tag_list');
	tag_ul.append($('<li><span class="del_tag_link">x</span><span class="value">' + content + '</span><span class="surfix"></span></li>'));

	$this.removeAttr('value');
}

// Get joined values from the list
function input_tagable_get_values($this) {
	var values = $('ul.tag_list span.value', $this.parent().parent()).map(function(ind, ele){			
		return $(ele).text();
	});
	return values;
}

// Set hidden field value from the list
function input_tagable_set_values($this) {
	var values = input_tagable_get_values($this);

	console.log(values.get().join(','));
	$('input[type=hidden]', $this.parent().parent()).val(values.get().join(','));
}

function input_tagable_remove_tag() {

}
