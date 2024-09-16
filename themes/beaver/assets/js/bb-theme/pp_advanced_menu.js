document.querySelector('.js-mobile-menu-opener').
  onclick = function () {
    document.querySelector('.js-navigation').classList.add('-open');
    document.querySelector('body').classList.add('-open');
  }

document.querySelector('.js-mobile-menu-close').
  onclick = function () {
    document.querySelector('.js-navigation').classList.remove('-open');
    document.querySelector('body').classList.remove('-open');
  }

if (document.querySelector(window).width() < 1024) {
  document.querySelector('.js-sub-menu-opener').
    onclick = function () {
      document.querySelector(this).parent().classList.toggle('-open');
    }
}
