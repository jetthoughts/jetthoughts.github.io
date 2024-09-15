document.addEventListener("DOMContentLoaded", function () {
  if (!window.SDB) {
    SDB = {};
  }
  /*
   * Application Init, everything starts here
   *
   */
  SDB.App = (function () {
    return {
      init: function () {
        // Basic Clickable for .hover-box class
        $(document).on(
          "click",
          "body:not(.fl-builder-edit) .hover-box .fl-col-content",
          function (event) {
            window.location = $(this).find("a").attr("href");
            return false;
          },
        );

        // Basic Clickable for post content
        $(document).on(
          "click",
          "body:not(.fl-builder-edit) .jt-clickable .pp-content-post",
          function (event) {
            window.location = $(this).find("a").attr("href");
            return false;
          },
        );
      }, // CLOSE INIT FUNCTION
    };
  })();

  SDB.App.init();
});
