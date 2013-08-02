(function() {
  $ = jQuery;

  $.fn.extend({
    reinvent: function(options) {
      return this.each(function(input_field) {
        var $this = $(this);
        if (!$this.hasClass("reinvent-done")) {
          return createDropDown($this);
        }
      });
    },
    sync_reinvent: function(options) {
      return this.each(function(input_field) {

        var $this = $(this);        
        var ului = $('dl.dropdown[data-target-id=' + $this.attr('id') + ']');

        if(ului.size() > 0) {
          if ($this.val() == null || $this.val() == "" || $this.attr('should-be-none-for-ie') == 'true') {
            $this.removeAttr('should-be-none-for-ie');
            var prompt_label = ului.attr('data-prompt') ? ului.attr('data-prompt') : $this.find('option').first().text();
            var html = prompt_label + '<span class="value"></span>'
            ului.find("dt a").html(html);
            ului.find("dt a").removeClass('cross');
          } else {
            var selected = $this.find("option[value=" + $this.val() + "]");
            var html = selected.text() + '<span class="value">' + selected.val() + '</span>';
            ului.find("dt a").html(html);
            ului.find("dt a").addClass('cross');
          }
        }

        ului.find("dd ul").hide();
        return $this;
      });
    }
  });
}).call(this);

function createDropDown(source_p){
  var source = source_p;

  var selected = $(source.find("option[selected]"));
  var first_one = $(source.find("option").first());
  var options = $("option[value!=]", source);
  var prompt = source.find("option[value=]").size() > 0 ? source.find("option[value=]").text() : '';
  var need_first = $(source).attr('data-need-first') == 'true';

  var dl = $('<dl class="dropdown" data-target-id="' + source.attr('id') + '"></dl>');
  dl.attr('data-prompt', prompt);
  dl.insertAfter(source);


  dl.append('<dt><a class="cross" href="#"><span class="value"></span></a></dt>');
  dl.append('<dd><ul></ul></dd>');

  if($('optgroup', source).size() > 0) {
      $('optgroup', source).each(function(ind, ele){
          var split = $("<li><span>" + $(ele).attr('label') + "</span></li>");
          $("dd ul", dl).append(split);
          var options = $("option[value!=]", ele);
          options.each(function(){
              var li = ('<li><a href="#">' + 
                  $(this).text() + '<span class="value">' + 
                  $(this).val() + '</span></a></li>');

              $("dd ul", dl).append(li);
          });
      });
  } else {
    options.each(function(ind, _){
      var li = ('<li><a href="#">' + 
          $(this).text() + '<span class="value">' + 
          $(this).val() + '</span></a></li>');
      $("dd ul", dl).append(li);
    });
  }

  $('a', dl).css('width', source.css('width'));
  source.sync_reinvent();
  source.addClass('reinvent-done');
  return dl;
}

$(document).ready(function() {
  $(".dropdown dt a").live('click', function(e) {
    var ului = $(this).parent().parent();
    var target = $('select#' + $(ului).attr('data-target-id'));
    var this_ul = target.get();

    if ($(this).hasClass('cross')) {
      target.find('option').removeAttr('selected');
      target.val('');
      target.attr('should-be-none-for-ie', 'true');
      target.sync_reinvent(); 
    } else {
      ului.find('dd ul').toggle();
    }

    $("dl.dropdown").each(function(_, _ele) {
      var dropdown = $('select#' + $(_ele).attr('data-target-id'));
      if(dropdown.size() > 0) {
        if(!dropdown.is(this_ul)) {
          dropdown.sync_reinvent();
        }
      }
    });

    e.preventDefault();
  });

  $(document).bind('click', function(e) {
    var $clicked = $(e.target);
    if (! $clicked.parents().hasClass("dropdown")) {
      $("dl.dropdown").each(function(_, _ele) {
        var dropdown = $('select#' + $(_ele).attr('data-target-id'));
        if(dropdown.size() > 0) {
          dropdown.sync_reinvent();
        }
      });
    }
  });

  $(".dropdown dd ul li a").live('click', function(e) {
    var source = $(this).parent().parent().parent().parent();
    var target = $('#' + source.attr('data-target-id'));

    target.find('option').removeAttr('selected');
    target.find('option[value=' + $(this).find("span.value").text() + ']').attr('selected', 'selected');
    target.val($(this).find("span.value").text());

    target.sync_reinvent();
    target.trigger('change');

    e.preventDefault();
  });
});