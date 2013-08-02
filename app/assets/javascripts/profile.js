// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

$(document).ready(function(){
  $('.edit_profile ul.brandphotos form.add_tag').live('ajax:success', function(evt, data, status, xhr){
      $(this).prev().html(xhr.responseText);
      $('input[type=text]', this).val('');
  });

  $('.edit_profile ul.brandphotos ul.tag_list a.rm_link').live('ajax:success', function(){
      $(this).parent().remove();
  });

  $('.edit_profile ul.brandphotos a.rm_image_link').live('ajax:success', function(){
      $(this).parent().remove();
  });

  $('.edit_profile .control-group.security input[type=checkbox]').bind('click', function(){
    $('input[type=checkbox]', $(this).parent()).prop("checked", false);
    $(this).prop("checked", true);
  });

  $('.chzn-container.chzn-container-multi.mock a').live('ajax:success', function(){
      $(this).parent().remove();
  });
  
  $('.chzn-container.chzn-container-multi.mock form').live('ajax:success', function(evt, data, status, xhr){
      $('body').html(xhr.responseText);
      $('input').focus();
  });

  $('.chzn-container.chzn-container-multi.mock .add_special_act_btn').live('click', function(evt){
      $.ajax({
          url: '/account/special_acts?',
          data: 'special_act=' + $(this).prev().val(),
          type: 'POST',
          success: function(data) {
              $('.controls.edit_special_acts').html(data);
          }
      });

      evt.preventDefault();
  });

  $('.edit_profile #edit_profile_account form').live('ajax:success', function(evt, data, status, xhr){
      $('#edit_profile_account').html(xhr.responseText);
  });

  $('.edit_profile a#show_term_service').bind('click', function(evt){
      $('.edit_profile .service_terms').fadeIn();
      evt.preventDefault();
  });

  $('.edit_profile .service_terms .clock_term').bind('click', function(evt){
      $('.edit_profile .service_terms').hide();
      evt.preventDefault();
  });

  $('.profile_show .follow_buttons a[data-remote=true]').live('ajax:success', function(evt, data, status, xhr){
      $(this).parent().html(xhr.responseText);
  });
  
  $('.edit_profile .edit_profile_about form').bind('ajax:success', function(evt, data, status, xhr){
    alert('About updated!');  
  });

  $('.edit_profile .step_4 .coupon form').bind('ajax:success', function(evt, data, status, xhr){
    $this = $(this);
    $this.next().html(xhr.responseText);
  });

  $('.profile_show a#hire_me_link').bind('click', function(evt){
    $('#contact_form').fadeIn();
    evt.preventDefault();
  });

  // been here 'add' link ==================
  // load list
  $('.profile_show .been_here.middle_part a.load_visitors, .profile_show .been_here.middle_part a.more_visitors').live('ajax:success', function(evt, data, status, xhr){
    var div = $('.profile_show .been_here.middle_part div.visitors');
    div.html($(xhr.responseText));
  });
  $('.profile_show .been_here.middle_part a.load_visitors').trigger('click');
  $('.profile_show .been_here.middle_part a.add_visitor').bind('ajax:success', function(evt, data, status, xhr){
    var new_li = $('<li class="visitor">' + xhr.responseText + '</li>');
    var ul = $('.profile_show .been_here.middle_part ul.visitors');
    if (ul.children().size() == 0) {
      ul.append(new_li);
    } else {
      new_li.insertBefore(ul.children().first());
    }

    $(this).hide();
  });

  //procomment
  $('.profile_show .procomments.middle_part a.load_procomments, .profile_show .procomments.middle_part a.more_procomments').live('ajax:success', function(evt, data, status, xhr){
    var div = $('.profile_show .procomments.middle_part div.procomments');
    div.html($(xhr.responseText));
  });
  $('.profile_show .procomments.middle_part a.load_procomments').trigger('click');

  $('.profile_show .procomments.middle_part form').live('ajax:success', function(evt, data, status, xhr){
    var ul = $('.profile_show .procomments.middle_part div.procomments ul.procomments');
    var new_li = $('<li class="procomment">' + xhr.responseText + '</li>');
    new_li.hide();
    if (ul.children().size() == 0) {
      ul.append(new_li);
    } else {
      new_li.insertBefore(ul.children().first());
    }
    new_li.fadeIn();
    $(this).find('input[type=text]').val('');
  });

  //profile local nearests=====
  $('.profile_show .partners.middle_part a.load_pronearests, .profile_show .partners.middle_part a.more_pronearests').live('ajax:success', function(evt, data, status, xhr){
    var div = $('.profile_show .partners.middle_part div.users_square_blocks');
    // div.attr('visibility', 'hidden');
    div.html($(xhr.responseText));
    // div.attr('visibility', 'visible');
  });
  $('.profile_show .partners.middle_part a.load_pronearests').trigger('click');

  $('.comment_area form.new_picupdate_comment').bind('ajax:success', function(evt, data, status, xhr){
    var $this = $(this);
    $(this).find('input[type=text]').val('');
    var toadd = $(xhr.responseText);
    toadd.hide();
    $this.parent().find('ul.picupdatecomment_list').append(toadd);
    toadd.fadeIn();
    // console.log(xhr.responseText);
  });

  $('.profile_show ul.picupdate_list a.rm_link').bind('ajax:success', function(evt, data, status, xhr){
    var $this = $(this);
    $this.parent().fadeOut(function(){
      $this.parent().remove();
    });
  });

  // $('.profile_show #select_picupdate_img').bind('click', function(evt){
  //   $(this).hide();
  //   $('.album_setup').fadeIn();
  //   evt.preventDefault();
  // });

  $('.profile_show a.cancel_album_link').bind('click', function(evt){
    $('.album_setup').hide();
    $('.profile_show #select_picupdate_img').fadeIn();

    $("#add_to_feed").prop("checked", true);
    $("#add_to_album").prop("checked", false);
    $('#picupdate_photo').val('');
    $('.album_list').hide();
    evt.preventDefault();
  });

  $('.profile_show #add_to_album').bind('change', function(evt) {
    $('.album_list').toggle();
  });

  $('.profile_show .uploading_photos_div').bind('click', function(evt) {
    evt.preventDefault();
  }).bind('mouseenter', function(evt) {
    $(this).find('ul.sub_menu').fadeIn();
  }).bind('mouseleave', function(evt) {
    $(this).find('ul.sub_menu').fadeOut();
  });

  $('.profile_show a.album').bind('click', function(evt) {
    $('.upload_file_panel').fadeIn();
    $('.bkwrap').fadeIn();
    evt.preventDefault();
  });

  $('.profile_show a.wall').bind('click', function(evt) {
    $('.post_to_wall_panel').fadeIn();
    $('.bkwrap').fadeIn();
    evt.preventDefault();
  });

  $('.upload_file_panel form.album_update').submit(function(){
    var that = $(this);
    $('span.picupdate_id_for_album_update').each(function(inde, ele){
      var to_insert = $('<input type="hidden" name="photo_ids[]" />');
      to_insert.val($(ele).text());
      console.log($(ele).text());
      that.append(to_insert);
    });

    return true;
  });

  $('.post_to_wall_panel form.wall_form').ajaxForm({
    beforeSend: function() {
      var form = $('.post_to_wall_panel form.wall_form');

      var bar = form.find('.color_bar');
      var percent = form.find('.precent');
      var progress = form.find('.progress_bar');

      progress.fadeIn();
      var percentVal = '0%';
      bar.width(percentVal)
      percent.html(percentVal);
    },
    uploadProgress: function(event, position, total, percentComplete) {
      var form = $('.post_to_wall_panel form.wall_form');
      var bar = form.find('.color_bar');
      var percent = form.find('.precent');

      var percentVal = percentComplete + '%';
      bar.width(percentVal)
      percent.html(percentVal);
    },
    complete: function(xhr) {
      console.log(xhr);
      location.reload();
    }
  });

  $('.upload_file_panel form.upload').ajaxForm({
    beforeSend: function() {
      var form = $('.upload_file_panel form.upload');

      var bar = form.find('.color_bar');
      var percent = form.find('.precent');
      var progress = form.find('.progress_bar');
      progress.fadeIn();
      var percentVal = '0%';
      bar.width(percentVal)
      percent.html(percentVal);
    },
    uploadProgress: function(event, position, total, percentComplete) {
      var form = $('.upload_file_panel form.upload');
      var bar = form.find('.color_bar');
      var percent = form.find('.precent');

      var percentVal = percentComplete + '%';
      bar.width(percentVal)
      percent.html(percentVal);
    },
    complete: function(xhr) {
      var form = $('.upload_file_panel form.upload');
      var progress = form.find('.progress_bar');
      progress.hide();

      var new_imgs = $(xhr.responseText);
      new_imgs.hide();
      $('.uploaded_file_group ul.uploaded_files').append(new_imgs);
      form.resetForm();
      form.find('input[type=submit]').removeAttr('disabled');
      form.find('input[type=submit]').val('Upload');

      new_imgs.fadeIn();
    }
  });

  $('.upload_file_panel .cancel_btn').bind('click', function(evt){
    $('.upload_file_panel').hide();
    $('.bkwrap').hide();
    evt.preventDefault();
  });

  $('.post_to_wall_panel .cancel_btn').bind('click', function(evt){
    $('.post_to_wall_panel').hide();
    $('.bkwrap').hide();
    evt.preventDefault();
  });

  $('.upload_file_panel #new_album_link').bind('click', function(evt){
    $('form.album_update').resetForm();

    $('dl.dropdown[data-target-id=album_id]').hide();
    $('.new_album_input').show();
    $('.upload_file_panel #add_to_exist_album_link').show();
    $(this).hide();
    evt.preventDefault();
  });

  $('.upload_file_panel #add_to_exist_album_link').bind('click', function(evt){
    $('form.album_update').resetForm();

    $('dl.dropdown[data-target-id=album_id]').show();
    $('.new_album_input').hide();
    $('.upload_file_panel #new_album_link').show();
    $(this).hide();

    evt.preventDefault();
  });



  $('.avatar_upload_div form.avatar_upload').ajaxForm({
      beforeSend: function() {
          // status.empty();
          // var percentVal = '0%';
          // bar.width(percentVal)
          // percent.html(percentVal);
      },
      uploadProgress: function(event, position, total, percentComplete) {
          // var percentVal = percentComplete + '%';
          // bar.width(percentVal)
          // percent.html(percentVal);
      },
    complete: function(xhr) {
      // status.html(xhr.responseText);
    }
  });

  $('.avatar_upload_div form.avatar_upload').ajaxForm({
    beforeSend: function() {
      var bar = $('.avatar_upload .bar');
      var percent = $('.avatar_upload .percent');
      var status = $('.avatar_upload .status');

      status.empty();
      var percentVal = '0%';
      bar.width(percentVal)
      percent.html(percentVal);
    },
    uploadProgress: function(event, position, total, percentComplete) {
      var bar = $('.avatar_upload .bar');
      var percent = $('.avatar_upload .percent');
      var status = $('.avatar_upload .status');


      var percentVal = percentComplete + '%';
      bar.width(percentVal)
      percent.html(percentVal);
    },
    success: function(xhr) {
      var bar = $('.avatar_upload .bar');
      var percent = $('.avatar_upload .percent');
      var status = $('.avatar_upload .status');

      application.view_model_profiles.reload_profile();
      application.view_model_profiles.chop();
    }
  });

  $('#avat_ready_chop').load(function() {
    to_chop('#avat_ready_chop', [0, 0, 240, 240], 1, true, [200, 200]);
  });
});
