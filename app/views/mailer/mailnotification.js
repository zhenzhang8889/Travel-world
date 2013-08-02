$('.right_block').html("<%= escape_javascript render(:partial  => 'mailnotification', :formats => [:html]) %>");
$('.mailnoti').html("<%= escape_javascript render(:partial  => 'mailnoti', :formats => [:html]) %>");
