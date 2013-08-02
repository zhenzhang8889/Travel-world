// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require lib/jquery_1_7
//= require jquery_ujs
//= require jquery-ui-1.9.1.custom.min

//= require knockout
//= require private_pub
//= require queryLoader
//= require lib/chosen.jquery
//= require lib/bootstrap
//= require lib/reinvent
//= require lib/input_tagable
//= require lib/nanoscroller-height-fix
//= require lib/jquery.nanoscroller
//= require lib/jquery.form
//= require lib/jquery.Jcrop
//= require lib/excanvas
//= require lib/jquery.knob
//= require lib/scripts

//= require model/lead
//= require model/lead_reply
//= require model/member
//= require model/profile
//= require model/activity
//= require model/post
//= require model/post_reply
//= require model/referto

//= require view_model/data
//= require view_model/leads
//= require view_model/matches
//= require view_model/conversation
//= require view_model/search
//= require view_model/profiles
//= require view_model/home
//= require view_model/posts
//= require view_model/network
//= require view_model/notifications
//= require model

//= require groups
//= require avatar
//= require home
//= require message_thread
//= require messages
//= require quick_message
//= require lead_generations
//= require jquery.lightbox_me

//= require_self
//= require profile
$(document).ready(function() {
  ko.applyBindings(application);
});

$(document).ready(function(){
  $(".chzn-select").chosen();
  $(".reinvent-select").reinvent();
  $(".nano").nanoScroller();
  
  $('.localtourism a').click(function(){
    $('.chat_block_Wrapper, .content_title, .TegO').hide();
    $('.ecotask').show();
    $('.succeed-notice').hide();
    $('.localtask').show();
  });
  $('.ecotourism a').click(function(){
    $('.chat_block_Wrapper, .content_title, .TegO').hide();
    $('.localtask').show();
    $('.succeed-notice').hide();
    $('.ecotask').show();
  });
  $('.home-item').click(function(){
    $('.chat_block_Wrapper, .content_title, .TegO').show();
    $('.localtask').hide();
    $('.succeed-notice').hide();
    $('.ecotask').hide();
  });

  $('#save-note').click(function(){
    var note = $('#task-note').val();
    var id = $('#task-id').val();
    $.ajax({
      url: '/users/update_score',
      type: 'POST',
      data: { task_id: id, task_note: note },
      success: function(data){
        $('.localtask .succeed-notice span').text($('#task-value').val());
        $('.localtask .succeed-notice').show();
        if($('#is-local').val() == 1 ){
          $('#local-score').val( $('#new-percentage').val());
          $('#local-score').trigger('change');
        }else{
          $('#eco-score').val( $('#new-percentage').val());
          $('#eco-score').trigger('change');
        }
        $("#task-note-"+id).val(note);
      }
    });
    $('#note-completing-task').trigger('close')
  });

  $('#update-note').click(function(){
    var note = $('#edit-task-note-popup').val();
    var id = $('#edit-task-id').val();
    $.ajax({
      url: '/users/update_task_note',
      type: 'POST',
      data: { task_id: id, task_note: note },
      success: function(data){
        $("#task-note-"+id).val(note);
      }
    });
    $('#note-edit-task').trigger('close');
  });

  $('#close-note').click(function(){
    $('#note-completing-task').trigger('close');
    var current_task_id = $('#task-id').val();
    $('#'+current_task_id).attr('checked', false);
  });

  $('#close-edit-note').click(function(){
    $('#edit-task-on-note').trigger('close');
  });

  $('.edit-task-note').click(function(){
    var id = $(this).attr("id").split('-')[1];

    var task_name = $("#task-note-"+id).attr("class");
    var task_note = $("#task-note-"+id).val();

    $('#edit-task-on-note').text(task_name);
    $('#edit-task-note-popup').val(task_note);
    $('#edit-task-id').val(id);

    $('#note-edit-task').lightbox_me({
      centered: true,
      onLoad: function() {
        $('#note-edit-task').find('textarea:first').focus()
      }
    });

  })

  $('.localtask input').click(function(){
    var localscore = parseInt($('#local-score').attr('data-localscore'));
    var currentScore = parseInt($('#local-score').val())*localscore/100;
    var point = parseInt($(this).attr("data-point"));

    if($(this).is(":checked")){

      var newScore = currentScore + point;
      var newPercentageLocal = Math.round(newScore/localscore*100);
      var id = $(this).attr("id");

      $('#task-on-note').text($(this).val());
      $('#task-value').val($(this).val());
      $('#task-id').val(id);
      $('#new-percentage').val(newPercentageLocal);
      $('#task-note').val("");
      $('#is-local').val(1);

      $('#note-completing-task').lightbox_me({
        centered: true,
        onLoad: function() {
            $('#note-completing-task').find('textarea:first').focus()
            }
      });
    }else{
      var newScore = currentScore - point;
      var newPercentageLocal = Math.round(newScore/localscore*100);
      var id = $(this).attr("id");
      $.ajax({
        url: '/users/update_score',
        type: 'POST',
        data: { task_id: id, decrease: true },
        success: function(data){
          $('#local-score').val(newPercentageLocal);
          $('#local-score').trigger('change');
        }
      });
    }

  });
  $('.ecotask input').click(function(){
    var ecoscore = parseInt($('#eco-score').attr('data-ecoscore'));
    var currentScore = parseInt($('#eco-score').val())*ecoscore/100;
    var point = parseInt($(this).attr("data-point"));

    if($(this).is(":checked")){
      var newScore = currentScore + point;
      var newPercentageEco = Math.round(newScore/ecoscore*100);
      var id = $(this).attr("id");

      $('#task-on-note').text($(this).val());
      $('#task-value').val($(this).val());
      $('#task-id').val(id);
      $('#new-percentage').val(newPercentageEco);
      $('#task-note').val("");
      $('#is-local').val(0)

      $('#note-completing-task').lightbox_me({
        centered: true,
        onLoad: function() {
          $('#note-completing-task').find('textarea:first').focus()
        }
      });

    }else{
      var newScore = currentScore - point;
      var newPercentageEco = Math.round(newScore/ecoscore*100);
      var id = $(this).attr("id");

      $.ajax({
        url: '/users/update_score',
        type: 'POST',
        data: { task_id: id, decrease: true },
        success: function(data){
         $('#eco-score').val(newPercentageEco);
         $('#eco-score').trigger('change');
        }
      });
    }

  });
});

