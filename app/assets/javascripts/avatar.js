var jcrop;
function to_chop(ele, sel, ratio, resize, minsize) {
  if(jcrop) {
    jcrop.destroy();
  }

  sel = sel || [ 30, 30, 210, 210 ];
  ratio = ratio || 1;
  resize = resize == 'undefined' ? true : resize;
  minsize = minsize || [180, 180];
  $(ele).Jcrop({
    bgColor: 'black',
    bgFade: true,
    bgOpacity: .6,
    setSelect: sel,
    aspectRatio: ratio,
    allowSelect: true,
    allowResize: resize,
    onChange: captureCoords,
    onSelect: captureCoords,
    minSize: minsize
  }, function(){
    jcrop = this;
    // jcrop.disable();
  });  
}

function showPreview(coords) {
  var rx = 120.0 / coords.w;
  var ry = 120.0 / coords.h;

  // console.log(rx);
  // console.log(ry);
  // console.log($('.real_pic').width());
  if($('#preview')) {
    $('#preview').css({
      width: Math.round(rx * $('.real_pic').width()),
      height: Math.round(ry * $('.real_pic').height()),
      marginLeft: '-' + Math.round(rx * coords.x) + 'px',
      marginTop: '-' + Math.round(ry * coords.y) + 'px'
    });
  }
}

function captureCoords(c) {
  $('#chop_x').val(c.x);
  $('#chop_y').val(c.y);
  $('#chop_w').val(c.w);
  $('#chop_h').val(c.h);

  showPreview(c);
}

$(document).ready(function() {
  $('.photo').bind('click', function(){
    $('.update_form').fadeIn();
  });
  
  $('div.cover').bind('click', function(){
    $('.update_cover').fadeIn();
  });
  $('.muti_covers').bind('click', function(){
    $('.update_muti_cover').fadeIn();
  });

  // $('.photo, .cover, .muti_covers').bind('mouseover', function() {
  //   $('.hint', this).show();
  //   $('.photo_header ul.mode').show();
  // }).bind('mouseout', function() {
  //   $('.hint', this).hide();
  //   $('.photo_header ul.mode').hide();
  // });
  // 
  // $('.photo_header ul.mode').bind('mouseover', function() {
  //   $(this).show();
  // });
  // $('.photo_header ul.mode').bind('mouseout', function() {
  //   $(this).hide();
  // });


  $('.photo_header input[type=submit]').live('click', function(){
    $(this).next().fadeIn();
  });

  $('.photo_header ul.mode li.inactive').live('click', function(){
    var real_this = this;
    $.ajax({
      url: '/mine/profile/cover_type?',
      data: 'type=' + $(this).attr('data-type'),
      type: "PUT",
      success: function(data) {
        $('li', $(real_this).parent()).removeClass('active');
        $('li', $(real_this).parent()).addClass('inactive');
        $(real_this).addClass('active');
        
        $('.photo_header div[data-type]').hide();
        $('.photo_header div[data-type=' + $(real_this).attr('data-type') + ']').fadeIn();
      }
    });
  });
  
  $('.photo_header .update_muti_cover ul li p').bind('click', function(){
    $('.photo_header .upload_muti').fadeIn();
  });

  $('.photo_header a.close_upload_box').live('click', function(){
    $(this).parent().parent().parent().parent().hide();
  });

});
