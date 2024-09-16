PPAdvancedTabs = function (settings) {
  this.settings = settings;
  this.nodeClass = "";
  this._init();
};

PPAdvancedTabs.prototype = {
  settings: {},
  nodeClass: "",

  _init: function () {
    $(this.nodeClass + " .pp-tabs-labels .pp-tabs-label").on(
      "click keyup",
      this._labelClick.bind(this),
    );
    $(this.nodeClass + " .pp-tabs-panels .pp-tabs-label").on(
      "click",
      this._responsiveLabelClick.bind(this),
    );
    $(this.nodeClass + " .pp-tabs-labels .pp-tabs-label.pp-tab-active").attr(
      "tabindex",
      "0",
    );
    this._responsiveCollapsed();
    this._bindEvents();
  },
  _bindEvents: function () {
    const tabs = $(this.nodeClass + " .pp-tabs-labels .pp-tabs-label");
    let tabFocus = 0;
    $(this.nodeClass + " .pp-tabs-labels").on("keydown", function (e) {
      const keyCode = e.keyCode || e.which;
      if (38 === keyCode || 40 === keyCode) {
        e.preventDefault();
        tabs[tabFocus].setAttribute("tabindex", -1);
        if (40 === keyCode) {
          tabFocus++;
          if (tabFocus >= tabs.length) {
            tabFocus = 0;
          }
        } else if (38 === keyCode) {
          tabFocus--;
          if (tabFocus < 0) {
            tabFocus = tabs.length - 1;
          }
        }
      }
      tabs[tabFocus].setAttribute("tabindex", 0);
      tabs[tabFocus].focus();
    });
    if ($(this.nodeClass + " .pp-tabs-vertical").length > 0) {
      this._resize();
      $(window).off("resize" + this.nodeClass);
      $(window).on("resize" + this.nodeClass, this._resize.bind(this));
    }
    this._hashChange();
    $(window).on("hashchange", this._hashChange.bind(this));
  },
  _hashChange: function () {
    if (
      location.hash &&
      -1 === location.hash.search("#!") &&
      $(location.hash).length > 0
    ) {
      const element = $(location.hash + ".pp-tabs-label");
      if (element && element.length > 0) {
        const header = $(".fl-theme-builder-header-sticky");
        const offset = header.length > 0 ? header.height() + 32 : 120;
        location.href = "#";
        $("html, body").animate(
          { scrollTop: element.parents(".pp-tabs").offset().top - offset },
          50,
          function () {
            if (!element.hasClass("pp-tab-active")) {
              element.trigger("click");
            }
          },
        );
      }
    }
  },
  _labelClick: function (e) {
    const label = $(e.target).closest(".pp-tabs-label"),
      index = label.data("index"),
      wrap = label.closest(".pp-tabs");
    const showContent =
      "click" === e.type ||
      ("keyup" === e.type && (13 === e.keyCode || 13 === e.which));
    if (!showContent) {
      return;
    }
    label.siblings().attr("aria-selected", false).attr("tabindex", "-1");
    label.attr("aria-selected", true).attr("tabindex", "0").trigger("focus");
    if (wrap.hasClass("pp-tabs-vertical")) {
      const header = $(".fl-theme-builder-header-sticky");
      const offset = header.length > 0 ? header.height() + 32 : 120;
      $("html, body").animate({ scrollTop: wrap.offset().top - offset }, 500);
    }
    wrap
      .find(".pp-tabs-labels:first > .pp-tab-active")
      .removeClass("pp-tab-active");
    wrap
      .find(".pp-tabs-panels:first > .pp-tabs-panel > .pp-tab-active")
      .removeClass("pp-tab-active");
    wrap
      .find(".pp-tabs-panels:first > .pp-tabs-panel > .pp-tabs-label")
      .removeClass("pp-tab-active");
    wrap
      .find(
        '.pp-tabs-labels:first > .pp-tabs-label[data-index="' + index + '"]',
      )
      .addClass("pp-tab-active");
    wrap
      .find(
        '.pp-tabs-panels:first > .pp-tabs-panel > .pp-tabs-panel-content[data-index="' +
          index +
          '"]',
      )
      .addClass("pp-tab-active");
    wrap
      .find(
        '.pp-tabs-panels:first > .pp-tabs-panel > .pp-tabs-label[data-index="' +
          index +
          '"]',
      )
      .addClass("pp-tab-active");
    $(document).trigger("pp-tabs-switched", [
      wrap.find('.pp-tabs-panel-content[data-index="' + index + '"]'),
    ]);
  },
  _responsiveLabelClick: function (e) {
    const label = $(e.target).closest(".pp-tabs-label"),
      wrap = label.closest(".pp-tabs"),
      index = label.data("index"),
      content = label.siblings(".pp-tabs-panel-content"),
      activeContent = wrap.find(".pp-tabs-panel-content.pp-tab-active"),
      activeIndex = activeContent.data("index"),
      allIcons = wrap.find(".pp-tabs-label .fa"),
      icon = label.find(".fa");
    if (index == activeIndex) {
      activeContent.slideUp("normal");
      activeContent.removeClass("pp-tab-active");
      $(this.nodeClass + " .pp-tabs-panels .pp-tabs-label").removeClass(
        "pp-tab-active",
      );
      wrap.removeClass("pp-tabs-animation");
      return;
    }
    if (wrap.hasClass("pp-tabs-animation")) {
      return;
    }
    wrap.addClass("pp-tabs-animation");
    activeContent.slideUp("normal");
    content.slideDown("normal", function () {
      wrap.find(".pp-tab-active").removeClass("pp-tab-active");
      wrap
        .find('.pp-tabs-label[data-index="' + index + '"]')
        .addClass("pp-tab-active");
      content.addClass("pp-tab-active");
      wrap.removeClass("pp-tabs-animation");
      if (
        label.offset().top < $(window).scrollTop() + 100 &&
        !wrap.hasClass("pp-tabs-no-scroll")
      ) {
        $("html, body").animate(
          { scrollTop: label.offset().top - 100 },
          500,
          "swing",
        );
      }
      $(document).trigger("pp-tabs-switched", [content]);
    });
  },
  _resize: function () {
    $(this.nodeClass + " .pp-tabs-vertical").each(
      this._resizeVertical.bind(this),
    );
  },
  _resizeVertical: function (e) {
    const wrap = $(this.nodeClass + " .pp-tabs-vertical"),
      labels = wrap.find(".pp-tabs-labels"),
      panels = wrap.find(".pp-tabs-panels");
    panels.css("min-height", labels.height() + "px");
  },
  _gridLayoutMatchHeight: function () {
    let highestBox = 0;
    let contentHeight = 0;
    $(this.nodeClass)
      .find(".pp-equal-height .pp-content-post")
      .css("height", "")
      .each(function () {
        if ($(this).height() > highestBox) {
          highestBox = $(this).height();
          contentHeight = $(this).find(".pp-content-post-data").outerHeight();
        }
      });
    $(this.nodeClass)
      .find(".pp-equal-height .pp-content-post")
      .height(highestBox);
  },
  _responsiveCollapsed: function () {
    if ($(window).innerWidth() < 769) {
      $(this.nodeClass + " .pp-tabs-panels").css("visibility", "visible");
    }
  },
};

document.addEventListener("DOMContentLoaded", function () {
  new PPAdvancedTabs({});

  if ($(window).width() > 768) {
    $(".pp-tabs-vertical .pp-tabs-panel-content").css(
      "min-height",
      $(".pp-tabs-vertical .pp-tabs-labels").outerHeight() + "px",
    );
  }
  if ($(window).width() <= 768) {
    $(".pp-tabs-label .pp-tab-close").on("click", function () {
      $(this).parents(".pp-tabs-label").removeClass("pp-tab-active");
    });
  }
});
