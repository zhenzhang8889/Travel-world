$(document).ready(function() {
  $('.sidebar .lead_list .show_match_link').live('ajax:success', function(evt, data, status, xhr) {
    $('.match_leads').html(xhr.responseText);
    application.view_match_leads();
  });

  // $('.sidebar .new_lead_generation form.new_lead_form').live('ajax:success', function(evt, data, status, xhr) {
  //   $('.account_leads').html(xhr.responseText);
  //   application.viewLeads();
  // });

  $('.lead_box_div ul.actions li.pause a.pause').live('ajax:success', function(evt){
    $(this).parent().hide();
    $('li.live', $(this).parent().parent()).show();
  });

  $('.lead_box_div ul.actions li.live a.go_live').live('ajax:success', function(evt){
    $(this).parent().hide();
    $('li.pause', $(this).parent().parent()).show();
  });

  $('.new_lead_generation .controls.areas select.first').live('change', function(evt){
    $this = $(this);
    var prev = $this.parent().find('.sub');
    if(prev) {
      $('dl[data-target-id=' + prev.attr('id') + ']').remove();
      prev.remove();
    }

    $.ajax({
        url: '/areas/' + $(this).val() + '/dropdowns',
        // data: 'post_id=' + post_id,
        type: 'GET',
        success: function(data) {
          //console.log(data);
          if($.trim(data).length != 0) {
            var new_sel = $(data);
            $this.parent().append(new_sel);
            new_sel.reinvent();
          }
        }
    });
  })

  // $('.lead_show form.reply_form').live('ajax:success', function(evt, data, status, xhr) {
  //   var new_reply = $('<li class="reply">' + xhr.responseText + '</li>');
  //   new_reply.hide();
  //   new_reply.insertBefore($(this).parent().parent().parent());
  //   new_reply.fadeIn();

  //   $(this).find('textarea').val('');
  // });

  $('.lead_show .need_collapse').live('click', function(evt){
    $(this).removeClass('need_collapse');
    $(this).addClass('can_collapse');
  });

  $('.lead_show .can_collapse').live('click', function(evt){
    $(this).removeClass('can_collapse');
    $(this).addClass('need_collapse');
  });

  // $('.lead_show li.reply_user').live('mouseenter', function(evt){
  //   var new_noti = $(this).find('.new_replies_noti');
  //   if(new_noti) {
  //     $(new_noti).find('a').trigger('click');
  //   }
  // });

  $('.lead_show li.reply_user .new_replies_noti a').live('ajax:success', function(evt, data, status, xhr) {
    var $this = $(this);
    $this.parent().fadeOut(function(){
      $this.parent().remove();
    });$(document).ready(function() {
  $('.sidebar .lead_list .show_match_link').live('ajax:success', function(evt, data, status, xhr) {
    $('.match_leads').html(xhr.responseText);
    application.view_match_leads();
  });

  // $('.sidebar .new_lead_generation form.new_lead_form').live('ajax:success', function(evt, data, status, xhr) {
  //   $('.account_leads').html(xhr.responseText);
  //   application.viewLeads();
  // });

  $('.lead_box_div ul.actions li.pause a.pause').live('ajax:success', function(evt){
    $(this).parent().hide();
    $('li.live', $(this).parent().parent()).show();
  });

  $('.lead_box_div ul.actions li.live a.go_live').live('ajax:success', function(evt){
    $(this).parent().hide();
    $('li.pause', $(this).parent().parent()).show();
  });

  $('.new_lead_generation .controls.areas select.first').live('change', function(evt){
    $this = $(this);
    var prev = $this.parent().find('.sub');
    if(prev) {
      $('dl[data-target-id=' + prev.attr('id') + ']').remove();
      prev.remove();
    }

    $.ajax({
        url: '/areas/' + $(this).val() + '/dropdowns',
        // data: 'post_id=' + post_id,
        type: 'GET',
        success: function(data) {
          //console.log(data);
          if($.trim(data).length != 0) {
            var new_sel = $(data);
            $this.parent().append(new_sel);
            new_sel.reinvent();
          }
        }
    });
  })

  // $('.lead_show form.reply_form').live('ajax:success', function(evt, data, status, xhr) {
  //   var new_reply = $('<li class="reply">' + xhr.responseText + '</li>');
  //   new_reply.hide();
  //   new_reply.insertBefore($(this).parent().parent().parent());
  //   new_reply.fadeIn();

  //   $(this).find('textarea').val('');
  // });

  $('.lead_show .need_collapse').live('click', function(evt){
    $(this).removeClass('need_collapse');
    $(this).addClass('can_collapse');
  });

  $('.lead_show .can_collapse').live('click', function(evt){
    $(this).removeClass('can_collapse');
    $(this).addClass('need_collapse');
  });

  // $('.lead_show li.reply_user').live('mouseenter', function(evt){
  //   var new_noti = $(this).find('.new_replies_noti');
  //   if(new_noti) {
  //     $(new_noti).find('a').trigger('click');
  //   }
  // });

  $('.lead_show li.reply_user .new_replies_noti a').live('ajax:success', function(evt, data, status, xhr) {
    var $this = $(this);
    $this.parent().fadeOut(function(){
      $this.parent().remove();
    });$(document).ready(function() {
  $('.sidebar .lead_list .show_match_link').live('ajax:success', function(evt, data, status, xhr) {
    $('.match_leads').html(xhr.responseText);
    application.view_match_leads();
  });

  // $('.sidebar .new_lead_generation form.new_lead_form').live('ajax:success', function(evt, data, status, xhr) {
  //   $('.account_leads').html(xhr.responseText);
  //   application.viewLeads();
  // });

  $('.lead_box_div ul.actions li.pause a.pause').live('ajax:success', function(evt){
    $(this).parent().hide();
    $('li.live', $(this).parent().parent()).show();
  });

  $('.lead_box_div ul.actions li.live a.go_live').live('ajax:success', function(evt){
    $(this).parent().hide();
    $('li.pause', $(this).parent().parent()).show();
  });

  $('.new_lead_generation .controls.areas select.first').live('change', function(evt){
    $this = $(this);
    var prev = $this.parent().find('.sub');
    if(prev) {
      $('dl[data-target-id=' + prev.attr('id') + ']').remove();
      prev.remove();
    }

    $.ajax({
        url: '/areas/' + $(this).val() + '/dropdowns',
        // data: 'post_id=' + post_id,
        type: 'GET',
        success: function(data) {
          //console.log(data);
          if($.trim(data).length != 0) {
            var new_sel = $(data);
            $this.parent().append(new_sel);
            new_sel.reinvent();
          }
        }
    });
  })

  // $('.lead_show form.reply_form').live('ajax:success', function(evt, data, status, xhr) {
  //   var new_reply = $('<li class="reply">' + xhr.responseText + '</li>');
  //   new_reply.hide();
  //   new_reply.insertBefore($(this).parent().parent().parent());
  //   new_reply.fadeIn();

  //   $(this).find('textarea').val('');
  // });

  $('.lead_show .need_collapse').live('click', function(evt){
    $(this).removeClass('need_collapse');
    $(this).addClass('can_collapse');
  });

  $('.lead_show .can_collapse').live('click', function(evt){
    $(this).removeClass('can_collapse');
    $(this).addClass('need_collapse');
  });

  // $('.lead_show li.reply_user').live('mouseenter', function(evt){
  //   var new_noti = $(this).find('.new_replies_noti');
  //   if(new_noti) {
  //     $(new_noti).find('a').trigger('click');
  //   }
  // });

  $('.lead_show li.reply_user .new_replies_noti a').live('ajax:success', function(evt, data, status, xhr) {
    var $this = $(this);
    $this.parent().fadeOut(function(){
      $this.parent().remove();
    });$(document).ready(function() {
  $('.sidebar .lead_list .show_match_link').live('ajax:success', function(evt, data, status, xhr) {
    $('.match_leads').html(xhr.responseText);
    application.view_match_leads();
  });

  // $('.sidebar .new_lead_generation form.new_lead_form').live('ajax:success', function(evt, data, status, xhr) {
  //   $('.account_leads').html(xhr.responseText);
  //   application.viewLeads();
  // });

  $('.lead_box_div ul.actions li.pause a.pause').live('ajax:success', function(evt){
    $(this).parent().hide();
    $('li.live', $(this).parent().parent()).show();
  });

  $('.lead_box_div ul.actions li.live a.go_live').live('ajax:success', function(evt){
    $(this).parent().hide();
    $('li.pause', $(this).parent().parent()).show();
  });

  $('.new_lead_generation .controls.areas select.first').live('change', function(evt){
    $this = $(this);
    var prev = $this.parent().find('.sub');
    if(prev) {
      $('dl[data-target-id=' + prev.attr('id') + ']').remove();
      prev.remove();
    }

    $.ajax({
        url: '/areas/' + $(this).val() + '/dropdowns',
        // data: 'post_id=' + post_id,
        type: 'GET',
        success: function(data) {
          //console.log(data);
          if($.trim(data).length != 0) {
            var new_sel = $(data);
            $this.parent().append(new_sel);
            new_sel.reinvent();
          }
        }
    });
  })

  // $('.lead_show form.reply_form').live('ajax:success', function(evt, data, status, xhr) {
  //   var new_reply = $('<li class="reply">' + xhr.responseText + '</li>');
  //   new_reply.hide();
  //   new_reply.insertBefore($(this).parent().parent().parent());
  //   new_reply.fadeIn();

  //   $(this).find('textarea').val('');
  // });

  $('.lead_show .need_collapse').live('click', function(evt){
    $(this).removeClass('need_collapse');
    $(this).addClass('can_collapse');
  });

  $('.lead_show .can_collapse').live('click', function(evt){
    $(this).removeClass('can_collapse');
    $(this).addClass('need_collapse');
  });

  // $('.lead_show li.reply_user').live('mouseenter', function(evt){
  //   var new_noti = $(this).find('.new_replies_noti');
  //   if(new_noti) {
  //     $(new_noti).find('a').trigger('click');
  //   }
  // });

  $('.lead_show li.reply_user .new_replies_noti a').live('ajax:success', function(evt, data, status, xhr) {
    var $this = $(this);
    $this.parent().fadeOut(function(){
      $this.parent().remove();
    });$(document).ready(function() {
  $('.sidebar .lead_list .show_match_link').live('ajax:success', function(evt, data, status, xhr) {
    $('.match_leads').html(xhr.responseText);
    application.view_match_leads();
  });

  // $('.sidebar .new_lead_generation form.new_lead_form').live('ajax:success', function(evt, data, status, xhr) {
  //   $('.account_leads').html(xhr.responseText);
  //   application.viewLeads();
  // });

  $('.lead_box_div ul.actions li.pause a.pause').live('ajax:success', function(evt){
    $(this).parent().hide();
    $('li.live', $(this).parent().parent()).show();
  });

  $('.lead_box_div ul.actions li.live a.go_live').live('ajax:success', function(evt){
    $(this).parent().hide();
    $('li.pause', $(this).parent().parent()).show();
  });

  $('.new_lead_generation .controls.areas select.first').live('change', function(evt){
    $this = $(this);
    var prev = $this.parent().find('.sub');
    if(prev) {
      $('dl[data-target-id=' + prev.attr('id') + ']').remove();
      prev.remove();
    }

    $.ajax({
        url: '/areas/' + $(this).val() + '/dropdowns',
        // data: 'post_id=' + post_id,
        type: 'GET',
        success: function(data) {
          //console.log(data);
          if($.trim(data).length != 0) {
            var new_sel = $(data);
            $this.parent().append(new_sel);
            new_sel.reinvent();
          }
        }
    });
  })

  // $('.lead_show form.reply_form').live('ajax:success', function(evt, data, status, xhr) {
  //   var new_reply = $('<li class="reply">' + xhr.responseText + '</li>');
  //   new_reply.hide();
  //   new_reply.insertBefore($(this).parent().parent().parent());
  //   new_reply.fadeIn();

  //   $(this).find('textarea').val('');
  // });

  $('.lead_show .need_collapse').live('click', function(evt){
    $(this).removeClass('need_collapse');
    $(this).addClass('can_collapse');
  });

  $('.lead_show .can_collapse').live('click', function(evt){
    $(this).removeClass('can_collapse');
    $(this).addClass('need_collapse');
  });

  // $('.lead_show li.reply_user').live('mouseenter', function(evt){
  //   var new_noti = $(this).find('.new_replies_noti');
  //   if(new_noti) {
  //     $(new_noti).find('a').trigger('click');
  //   }
  // });

  $('.lead_show li.reply_user .new_replies_noti a').live('ajax:success', function(evt, data, status, xhr) {
    var $this = $(this);
    $this.parent().fadeOut(function(){
      $this.parent().remove();
    });$(document).ready(function() {
  $('.sidebar .lead_list .show_match_link').live('ajax:success', function(evt, data, status, xhr) {
    $('.match_leads').html(xhr.responseText);
    application.view_match_leads();
  });

  // $('.sidebar .new_lead_generation form.new_lead_form').live('ajax:success', function(evt, data, status, xhr) {
  //   $('.account_leads').html(xhr.responseText);
  //   application.viewLeads();
  // });

  $('.lead_box_div ul.actions li.pause a.pause').live('ajax:success', function(evt){
    $(this).parent().hide();
    $('li.live', $(this).parent().parent()).show();
  });

  $('.lead_box_div ul.actions li.live a.go_live').live('ajax:success', function(evt){
    $(this).parent().hide();
    $('li.pause', $(this).parent().parent()).show();
  });

  $('.new_lead_generation .controls.areas select.first').live('change', function(evt){
    $this = $(this);
    var prev = $this.parent().find('.sub');
    if(prev) {
      $('dl[data-target-id=' + prev.attr('id') + ']').remove();
      prev.remove();
    }

    $.ajax({
        url: '/areas/' + $(this).val() + '/dropdowns',
        // data: 'post_id=' + post_id,
        type: 'GET',
        success: function(data) {
          //console.log(data);
          if($.trim(data).length != 0) {
            var new_sel = $(data);
            $this.parent().append(new_sel);
            new_sel.reinvent();
          }
        }
    });
  })

  // $('.lead_show form.reply_form').live('ajax:success', function(evt, data, status, xhr) {
  //   var new_reply = $('<li class="reply">' + xhr.responseText + '</li>');
  //   new_reply.hide();
  //   new_reply.insertBefore($(this).parent().parent().parent());
  //   new_reply.fadeIn();

  //   $(this).find('textarea').val('');
  // });

  $('.lead_show .need_collapse').live('click', function(evt){
    $(this).removeClass('need_collapse');
    $(this).addClass('can_collapse');
  });

  $('.lead_show .can_collapse').live('click', function(evt){
    $(this).removeClass('can_collapse');
    $(this).addClass('need_collapse');
  });

  // $('.lead_show li.reply_user').live('mouseenter', function(evt){
  //   var new_noti = $(this).find('.new_replies_noti');
  //   if(new_noti) {
  //     $(new_noti).find('a').trigger('click');
  //   }
  // });

  $('.lead_show li.reply_user .new_replies_noti a').live('ajax:success', function(evt, data, status, xhr) {
    var $this = $(this);
    $this.parent().fadeOut(function(){
      $this.parent().remove();
    });$(document).ready(function() {
  $('.sidebar .lead_list .show_match_link').live('ajax:success', function(evt, data, status, xhr) {
    $('.match_leads').html(xhr.responseText);
    application.view_match_leads();
  });

  // $('.sidebar .new_lead_generation form.new_lead_form').live('ajax:success', function(evt, data, status, xhr) {
  //   $('.account_leads').html(xhr.responseText);
  //   application.viewLeads();
  // });

  $('.lead_box_div ul.actions li.pause a.pause').live('ajax:success', function(evt){
    $(this).parent().hide();
    $('li.live', $(this).parent().parent()).show();
  });

  $('.lead_box_div ul.actions li.live a.go_live').live('ajax:success', function(evt){
    $(this).parent().hide();
    $('li.pause', $(this).parent().parent()).show();
  });

  $('.new_lead_generation .controls.areas select.first').live('change', function(evt){
    $this = $(this);
    var prev = $this.parent().find('.sub');
    if(prev) {
      $('dl[data-target-id=' + prev.attr('id') + ']').remove();
      prev.remove();
    }

    $.ajax({
        url: '/areas/' + $(this).val() + '/dropdowns',
        // data: 'post_id=' + post_id,
        type: 'GET',
        success: function(data) {
          //console.log(data);
          if($.trim(data).length != 0) {
            var new_sel = $(data);
            $this.parent().append(new_sel);
            new_sel.reinvent();
          }
        }
    });
  })

  // $('.lead_show form.reply_form').live('ajax:success', function(evt, data, status, xhr) {
  //   var new_reply = $('<li class="reply">' + xhr.responseText + '</li>');
  //   new_reply.hide();
  //   new_reply.insertBefore($(this).parent().parent().parent());
  //   new_reply.fadeIn();

  //   $(this).find('textarea').val('');
  // });

  $('.lead_show .need_collapse').live('click', function(evt){
    $(this).removeClass('need_collapse');
    $(this).addClass('can_collapse');
  });

  $('.lead_show .can_collapse').live('click', function(evt){
    $(this).removeClass('can_collapse');
    $(this).addClass('need_collapse');
  });

  // $('.lead_show li.reply_user').live('mouseenter', function(evt){
  //   var new_noti = $(this).find('.new_replies_noti');
  //   if(new_noti) {
  //     $(new_noti).find('a').trigger('click');
  //   }
  // });

  $('.lead_show li.reply_user .new_replies_noti a').live('ajax:success', function(evt, data, status, xhr) {
    var $this = $(this);
    $this.parent().fadeOut(function(){
      $this.parent().remove();
    });$(document).ready(function() {
  $('.sidebar .lead_list .show_match_link').live('ajax:success', function(evt, data, status, xhr) {
    $('.match_leads').html(xhr.responseText);
    application.view_match_leads();
  });

  // $('.sidebar .new_lead_generation form.new_lead_form').live('ajax:success', function(evt, data, status, xhr) {
  //   $('.account_leads').html(xhr.responseText);
  //   application.viewLeads();
  // });

  $('.lead_box_div ul.actions li.pause a.pause').live('ajax:success', function(evt){
    $(this).parent().hide();
    $('li.live', $(this).parent().parent()).show();
  });

  $('.lead_box_div ul.actions li.live a.go_live').live('ajax:success', function(evt){
    $(this).parent().hide();
    $('li.pause', $(this).parent().parent()).show();
  });

  $('.new_lead_generation .controls.areas select.first').live('change', function(evt){
    $this = $(this);
    var prev = $this.parent().find('.sub');
    if(prev) {
      $('dl[data-target-id=' + prev.attr('id') + ']').remove();
      prev.remove();
    }

    $.ajax({
        url: '/areas/' + $(this).val() + '/dropdowns',
        // data: 'post_id=' + post_id,
        type: 'GET',
        success: function(data) {
          //console.log(data);
          if($.trim(data).length != 0) {
            var new_sel = $(data);
            $this.parent().append(new_sel);
            new_sel.reinvent();
          }
        }
    });
  })

  // $('.lead_show form.reply_form').live('ajax:success', function(evt, data, status, xhr) {
  //   var new_reply = $('<li class="reply">' + xhr.responseText + '</li>');
  //   new_reply.hide();
  //   new_reply.insertBefore($(this).parent().parent().parent());
  //   new_reply.fadeIn();

  //   $(this).find('textarea').val('');
  // });

  $('.lead_show .need_collapse').live('click', function(evt){
    $(this).removeClass('need_collapse');
    $(this).addClass('can_collapse');
  });

  $('.lead_show .can_collapse').live('click', function(evt){
    $(this).removeClass('can_collapse');
    $(this).addClass('need_collapse');
  });

  // $('.lead_show li.reply_user').live('mouseenter', function(evt){
  //   var new_noti = $(this).find('.new_replies_noti');
  //   if(new_noti) {
  //     $(new_noti).find('a').trigger('click');
  //   }
  // });

  $('.lead_show li.reply_user .new_replies_noti a').live('ajax:success', function(evt, data, status, xhr) {
    var $this = $(this);
    $this.parent().fadeOut(function(){
      $this.parent().remove();
    });
  });

  $('div.lead_box_div a.rm_lead').live('ajax:success', function(evt, data, status, xhr) {
    var $this = $(this);
    $this.parent().parent().parent().parent().parent().fadeOut(function(){
      $this.parent().parent().parent().parent().parent().remove();
    });
  });

  // $('ul.box_list').absolute_sort_by_ul(3, 'lead_box', 15);

});
  });

  $('div.lead_box_div a.rm_lead').live('ajax:success', function(evt, data, status, xhr) {
    var $this = $(this);
    $this.parent().parent().parent().parent().parent().fadeOut(function(){
      $this.parent().parent().parent().parent().parent().remove();
    });
  });

  // $('ul.box_list').absolute_sort_by_ul(3, 'lead_box', 15);

});
  });

  $('div.lead_box_div a.rm_lead').live('ajax:success', function(evt, data, status, xhr) {
    var $this = $(this);
    $this.parent().parent().parent().parent().parent().fadeOut(function(){
      $this.parent().parent().parent().parent().parent().remove();
    });
  });

  // $('ul.box_list').absolute_sort_by_ul(3, 'lead_box', 15);

});
  });

  $('div.lead_box_div a.rm_lead').live('ajax:success', function(evt, data, status, xhr) {
    var $this = $(this);
    $this.parent().parent().parent().parent().parent().fadeOut(function(){
      $this.parent().parent().parent().parent().parent().remove();
    });
  });

  // $('ul.box_list').absolute_sort_by_ul(3, 'lead_box', 15);

});
  });

  $('div.lead_box_div a.rm_lead').live('ajax:success', function(evt, data, status, xhr) {
    var $this = $(this);
    $this.parent().parent().parent().parent().parent().fadeOut(function(){
      $this.parent().parent().parent().parent().parent().remove();
    });
  });

  // $('ul.box_list').absolute_sort_by_ul(3, 'lead_box', 15);

});
  });

  $('div.lead_box_div a.rm_lead').live('ajax:success', function(evt, data, status, xhr) {
    var $this = $(this);
    $this.parent().parent().parent().parent().parent().fadeOut(function(){
      $this.parent().parent().parent().parent().parent().remove();
    });
  });

  // $('ul.box_list').absolute_sort_by_ul(3, 'lead_box', 15);

});
  });

  $('div.lead_box_div a.rm_lead').live('ajax:success', function(evt, data, status, xhr) {
    var $this = $(this);
    $this.parent().parent().parent().parent().parent().fadeOut(function(){
      $this.parent().parent().parent().parent().parent().remove();
    });
  });

  // $('ul.box_list').absolute_sort_by_ul(3, 'lead_box', 15);

});
  });

  $('div.lead_box_div a.rm_lead').live('ajax:success', function(evt, data, status, xhr) {
    var $this = $(this);
    $this.parent().parent().parent().parent().parent().fadeOut(function(){
      $this.parent().parent().parent().parent().parent().remove();
    });
  });

  // $('ul.box_list').absolute_sort_by_ul(3, 'lead_box', 15);

});