$(document).ready(function() {
  $('.js-mobile-menu-opener, .js-mobile-menu-close').click(function(){
    $('.js-navigation, body').toggleClass('-open');
  })

  if ($(window).width() < 1024) {
    $('.js-sub-menu-opener').click(function(){
      $(this).parent().toggleClass('-open');
    })
  }
});
