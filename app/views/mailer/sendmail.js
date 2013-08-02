alert("Your mail just sent!");
$('.mailnoti').html("<%= escape_javascript render(:partial  => 'mailnoti', :formats => [:html]) %>");
$('.right_block').html("<%= escape_javascript render(:partial  => 'mailinbox', :formats => [:html]) %>");



       
          