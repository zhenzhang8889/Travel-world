$(document).ready(function(){
  $('.profile_show .trigger_content .text-hide-content-for-scrollbar').each(function(){
    $this = $(this);
    var $text = $this.next();

    if ($this.height() < 400) {
      $text.css('height', $this.height() + 2);
    } else {
      $text.css('height', 400);
    }
    
  });
});