document.addEventListener("DOMContentLoaded", function() {
   document.querySelectorAll('.js-mobile-menu-opener, .js-mobile-menu-close').addEventListener('click', function (e) {
    document.querySelector('.js-navigation, body').toggle('-open');
  }, false);

  if (document.querySelector(window).width() < 1024) {
    document.querySelectorAll('.js-sub-menu-opener').addEventListener('click', function (e) {
      document.querySelector(this).parent().toggle('-open');
    })
  }
});
