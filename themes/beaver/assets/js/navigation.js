document.addEventListener("DOMContentLoaded", function () {
  document.querySelector(".js-mobile-menu-opener").addEventListener(
    "click",
    function (e) {
      document.querySelector(".js-navigation").classList.add("-open");
      document.querySelector("body").classList.add("-open");
    },
    false,
  );

  document.querySelector(".js-mobile-menu-close").addEventListener(
    "click",
    function (e) {
      document.querySelector(".js-navigation").classList.remove("-open");
      document.querySelector("body").classList.remove("-open");
    },
    false,
  );

  if (window.innerWidth < 1024) {
    document
      .querySelector(".js-sub-menu-opener")
      .addEventListener("click", function (e) {
        document.querySelector(this).parent().classList.toggle("-open");
      });
  }
});
