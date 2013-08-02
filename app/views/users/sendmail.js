

    
alert("Your mail just sent!");
$('.right_block').html("<%= escape_javascript render(:partial  => 'mailerbox', :formats => [:html]) %>");


       
          