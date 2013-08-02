$('.right_mail').html("<%= escape_javascript render(:partial  => 'mailsettings', :formats => [:html]) %>");
