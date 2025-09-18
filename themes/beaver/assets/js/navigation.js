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

    const subMenuOpeners = document.querySelectorAll(".js-sub-menu-opener")

    subMenuOpeners.forEach((subMenuOpener) => {
        subMenuOpener.addEventListener("click", function (e) {
            e.preventDefault();
            const parentItem = e.target.parentElement;

            // Close other open menus
            document.querySelectorAll(".navigation .item.-open").forEach(item => {
                if (item !== parentItem) item.classList.remove("-open");
            });

            // Toggle current menu
            parentItem.classList.toggle("-open");
        });
    });
});
