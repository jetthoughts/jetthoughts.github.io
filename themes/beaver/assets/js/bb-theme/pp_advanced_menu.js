(function ($) {
  class PPAdvancedMenu {
    constructor (settings) {
      this.settingsId = settings.id
      this.nodeClass = `.fl-node-${settings.id}`
      this.wrapperClass = `${this.nodeClass} .pp-advanced-menu`
      this.type = settings.type
      this.mobileToggle = settings.mobile
      this.mobileBelowRow = settings.menuPosition === "below"
      this.breakpoints = settings.breakpoints
      this.mobileBreakpoint = settings.mobileBreakpoint
      this.mediaBreakpoint = settings.mediaBreakpoint
      this.mobileMenuType = settings.mobileMenuType
      this.offCanvasDirection = settings.offCanvasDirection
      this.isBuilderActive = settings.isBuilderActive
      this.currentBrowserWidth = window.innerWidth
      this.fullScreenMenu = null
      this.offCanvasMenu = null
      this.$submenus = null

      $(this._initMenu.bind(this))
      window.addEventListener("resize", (e) => {
        const width = window.innerWidth
        if (width !== this.currentBrowserWidth) {
          this._initMenu()
          this._clickOrHover()
          this.currentBrowserWidth = width
        }
      })
      document.body.addEventListener("click", (e) => {
        const wrapper = document.querySelector(this.wrapperClass)
        const mobileToggle = wrapper.querySelector(".pp-advanced-menu-mobile-toggle")

        if (mobileToggle.classList.contains("pp-active") && this.mobileToggle !== "expanded") {
          if (e.target.closest(".fl-module-pp-advanced-menu")) return
          if (e.target.closest(".pp-advanced-menu") && e.target.tagName === "INPUT") return
          if (e.target.classList.contains("pp-menu-close-btn")) return
          mobileToggle.click()
        }

        wrapper.querySelectorAll(".pp-has-submenu").forEach(el => el.classList.remove("focus", "pp-active"))
        wrapper.querySelectorAll(".pp-has-submenu .sub-menu").forEach(el => el.classList.remove("focus"))
        wrapper.querySelectorAll(".pp-has-submenu-container").forEach(el => el.classList.remove("focus"))
        wrapper.querySelectorAll(".pp-menu-toggle").forEach(el => el.setAttribute("aria-expanded", false))
      })

      document.addEventListener("keyup", (e) => {
        if (e.key === "Escape") {
          const wrapper = document.querySelector(this.wrapperClass)
          wrapper.querySelectorAll(".pp-has-submenu").forEach(el => el.classList.remove("focus", "pp-active"))
          wrapper.querySelectorAll(".pp-has-submenu .sub-menu").forEach(el => el.classList.remove("focus"))
          wrapper.querySelectorAll(".pp-has-submenu-container").forEach(el => el.classList.remove("focus"))
          wrapper.querySelectorAll(".pp-menu-toggle").forEach(el => el.setAttribute("aria-expanded", false))
          const focusedToggle = wrapper.querySelector(".pp-menu-toggle.focus")
          if (focusedToggle && focusedToggle.offsetParent !== null) {
            setTimeout(() => focusedToggle.focus(), 100)
          }
        }
      })
    }

    _isMobile () {return window.innerWidth <= this.breakpoints.small}

    _isMedium () {return window.innerWidth <= this.breakpoints.medium}

    _isCustom () {return window.innerWidth <= this.breakpoints.custom}

    _isTouch () {
      let prefixes = " -webkit- -moz- -o- -ms- ".split(" ")
      let mq = function (query) {return window.matchMedia(query).matches}
      if (("ontouchstart" in window) || window.DocumentTouch && document instanceof DocumentTouch) {return true}
      let query = ["(", prefixes.join("touch-enabled),("), "heartz", ")"].join("")
      return mq(query)
    }

    _isMenuToggle () {
      return !!(("always" === this.mobileBreakpoint || (this._isMobile() && "mobile" === this.mobileBreakpoint) || (this._isMedium() && "medium-mobile" === this.mobileBreakpoint) || (this._isCustom() && "custom" == this.mobileBreakpoint)) && ($(this.nodeClass).find(".pp-advanced-menu-mobile-toggle").is(":visible") || "expanded" === this.mobileToggle))

    }

    _initMenu () {
      this._setupSubmenu()
      this._menuOnFocus()
      this._submenuOnClick()
      if ($(this.nodeClass).length && this.type === "horizontal") {this._initMegaMenus()}
      if (this.type === "horizontal" || this.type === "vertical") {
        let self = this
        $(this.wrapperClass).find(".pp-has-submenu-container").on("click", function (e) {
          if (self.mobileMenuType !== "off-canvas" && self.mobileMenuType !== "full-screen") {
            if (self._isTouch()) {
              if (!$(this).hasClass("first-click")) {
                e.preventDefault()
                $(this).addClass("first-click")
              }
            }
          }
        })
        $(this.wrapperClass).find("li.pp-has-submenu a").on("keyup", function (e) {
          if ($(e.target).hasClass("pp-menu-toggle") && !$(this.nodeClass).find(".pp-advanced-menu-mobile-toggle").is(":visible")) {
            if (e.which === 1 || e.which === 13 || e.which === undefined) {
              e.preventDefault()
              e.stopPropagation()
              $(e.target).parents("li.pp-has-submenu").toggleClass("pp-active")
              if ($(e.target).parents("li.pp-has-submenu").hasClass("pp-active")) {$(e.target).attr("aria-expanded", true)} else {$(e.target).attr("aria-expanded", false)}
            }
          }
        }.bind(this))
      }
      if (this._isMenuToggle() || this.type === "accordion") {
        $(this.wrapperClass).off("mouseenter mouseleave")
        this._menuOnClick()
        this._clickOrHover()
      } else {
        $(this.wrapperClass).off("click")
        this._submenuOnRight()
        this._submenuRowZindexFix()
      }
      if (this.mobileToggle !== "expanded") {
        this._toggleForMobile()
        if (this.mobileMenuType === "off-canvas") {this._initOffCanvas()}
        if (this.mobileMenuType === "full-screen") {this._initFullScreen()}
      }
      $(this.wrapperClass).find("li:not(.menu-item-has-children)").on("click", "a", function (e) {
        if ($(e.target).closest(".pp-menu-search-item").length > 0) {return}
        $(this.nodeClass).find(".pp-advanced-menu").removeClass("menu-open")
        $(this.nodeClass).find(".pp-advanced-menu").addClass("menu-close")
        $("html").removeClass("pp-off-canvas-menu-open")
        $("html").removeClass("pp-full-screen-menu-open")
      }.bind(this))
      if ($(this.wrapperClass).find(".pp-menu-search-item").length) {this._toggleMenuSearch()}
    }

    _setupSubmenu () {$(this.wrapperClass + " ul.sub-menu").each(function () {$(this).closest("li").attr("aria-haspopup", "true")})}

    _menuOnFocus () {
      $(this.nodeClass).off("focus").on("focus", "a", function (e) {
        let $menuItem = $(e.target).parents(".menu-item").first(),
          $parents = $(e.target).parentsUntil(this.wrapperClass)
        $(".pp-advanced-menu .focus:not(.pp-menu-toggle)").removeClass("focus")
        $menuItem.addClass("focus")
        $parents.addClass("focus")
      }.bind(this)).on("focusout", "a", function (e) {if ($(".pp-advanced-menu .focus").hasClass("pp-has-submenu")) {$(e.target).parentsUntil(this.wrapperClass).find(".pp-has-submenu-container").removeClass("first-click")}}.bind(this))
      $(this.nodeClass).off("focus", ".pp-menu-toggle").on("focus", ".pp-menu-toggle", function (e) {$(e.target).addClass("focus")}.bind(this)).off("blur", ".pp-menu-toggle").on("blur", ".pp-menu-toggle", function (e) {if ($(e.target).parents("li.pp-has-submenu.pp-active").length === 0 || $(e.target).parents("li.pp-has-submenu.pp-active").parent("ul.menu").length === 0) {$(e.target).removeClass("focus")}}.bind(this))
    }

    _menuOnClick () {
      let self = this
      let $mainItem = ""
      $(this.wrapperClass).off().on("click.pp-advanced-menu keyup", ".pp-has-submenu-container", function (e) {
        let isValidEvent = e.which == 1 || e.which == 13 || e.which == undefined
        if (!isValidEvent) {return}
        if (e.which == 13 && !$(e.target).hasClass("pp-menu-toggle")) {return}
        if (self._isTouch()) {
          if (!$(this).hasClass("first-click")) {
            e.preventDefault()
            $(this).addClass("first-click")
          }
        }
        e.stopPropagation()
        let isMainEl = $(e.target).parents(".menu-item").parent().parent().hasClass("pp-advanced-menu")
        if (isMainEl && $mainItem === "") {$mainItem = $(e.target).parents(".menu-item")}
        let $link = $(e.target).parents(".pp-has-submenu").first(),
          $subMenu = $link.children(".sub-menu").first(),
          $href = $link.children(".pp-has-submenu-container").first().find("> a").attr("href"),
          $subMenuParents = $(e.target).parents(".sub-menu"),
          $activeParent = $(e.target).closest(".pp-has-submenu.pp-active")
        if ($activeParent.length > 0) {$activeParent.find(".pp-menu-toggle").first().attr("aria-expanded", true)} else {$activeParent.find(".pp-menu-toggle").first().attr("aria-expanded", false)}
        if (!$subMenu.is(":visible") || $(e.target).hasClass("pp-menu-toggle") || ($subMenu.is(":visible") && (typeof $href === "undefined" || $href == "#"))) {
          if (!$(this.wrapperClass).hasClass("pp-advanced-menu-accordion-collapse")) {e.preventDefault()}
          if ($(e.target).hasClass("pp-menu-toggle")) {
            e.stopPropagation()
            e.preventDefault()
          }
        } else {
          e.stopPropagation()
          window.location.href = $href
          return
        }
        if ($(this.wrapperClass).hasClass("pp-advanced-menu-accordion-collapse")) {
          if ($link.parents(".menu-item").length && !$link.parents(".menu-item").hasClass("pp-active")) {$(".menu .pp-active", this.wrapperClass).not($link).removeClass("pp-active")} else if ($link.parents(".menu-item").hasClass("pp-active") && $link.parent(".sub-menu").length) {$(".menu .pp-active", this.wrapperClass).not($link).not($activeParent).removeClass("pp-active")}
          $(".sub-menu", this.wrapperClass).not($subMenu).not($subMenuParents).slideUp("normal")
        }
        if ($(self.wrapperClass).find(".sub-menu:visible").length > 0) {$(self.wrapperClass).find(".sub-menu:visible").parent().addClass("pp-active")}
        $subMenu.slideToggle(400, function () {
          $(e.target).parents(".pp-has-submenu-container").parent().parent().find("> .menu-item.pp-active").removeClass("pp-active")
          if ($mainItem !== "") {
            $mainItem.parent().find(".menu-item.pp-active").removeClass("pp-active")
            $(self.wrapperClass).find(".sub-menu").parent().removeClass("pp-active")
            if ($(self.wrapperClass).find(".sub-menu:visible").length > 0) {$(self.wrapperClass).find(".sub-menu:visible").parent().addClass("pp-active")} else {
              $link.toggleClass("pp-active")
              $mainItem.removeClass("pp-active")
            }
          } else {$link.toggleClass("pp-active")}
          if (!$subMenu.is(":visible")) {
            $subMenu.parent().removeClass("pp-active")
            $subMenu.parent().find("> .pp-has-submenu-container .pp-menu-toggle").attr("aria-expanded", false)
          } else {$subMenu.parent().find("> .pp-has-submenu-container .pp-menu-toggle").attr("aria-expanded", true)}
        })
      }.bind(this))
    }

    _submenuOnClick () {$(this.wrapperClass + " .sub-menu").off().on("click", "a", function (e) {if ($(e.target).parent().hasClass("focus")) {$(e.target).parentsUntil(this.wrapperClass).removeClass("focus")}}.bind(this))}

    _clickOrHover () {
      this.$submenus = this.$submenus || $(this.wrapperClass).find(".sub-menu")
      let $wrapper = $(this.wrapperClass), $menu = $wrapper.find(".menu")
      let $li = $wrapper.find(".pp-has-submenu")
      if (this._isMenuToggle()) {$li.each(function () {if (!$(this).hasClass("pp-active")) {$(this).find(".sub-menu").fadeOut()}})} else {
        $li.each(function () {
          if (!$(this).hasClass("pp-active")) {
            $(this).find(".sub-menu").css({
              "display": "",
              "opacity": ""
            })
          }
        })
      }
    }

    _submenuOnRight () {
      $(this.wrapperClass).on("mouseenter focus", ".pp-has-submenu", function (e) {
        if ($(e.currentTarget).find(".sub-menu").length === 0) {return}
        let $link = $(e.currentTarget), $parent = $link.parent(), $subMenu = $link.find(".sub-menu"),
          subMenuWidth = $subMenu.width(), subMenuPos = 0, winWidth = window.innerWidth
        if ($link.closest(".pp-menu-submenu-right").length !== 0) {$link.addClass("pp-menu-submenu-right")} else if ($("body").hasClass("rtl")) {
          subMenuPos = $parent.is(".sub-menu") ? $parent.offset().left - subMenuWidth : $link.offset().left - subMenuWidth
          if (subMenuPos <= 0) {$link.addClass("pp-menu-submenu-right")}
        } else {
          subMenuPos = $parent.is(".sub-menu") ? $parent.offset().left + $parent.width() + subMenuWidth : $link.offset().left + subMenuWidth
          if (subMenuPos > winWidth) {$link.addClass("pp-menu-submenu-right")}
        }
      }.bind(this)).on("mouseleave", ".pp-has-submenu", function (e) {$(e.currentTarget).removeClass("pp-menu-submenu-right")}.bind(this))
    }

    _submenuRowZindexFix (e) {
      $(this.wrapperClass).on("mouseenter", "ul.menu > .pp-has-submenu", function (e) {
        if ($(e.currentTarget).find(".sub-menu").length === 0) {return}
        $(this.nodeClass).closest(".fl-row").find(".fl-row-content").css("z-index", "10")
      }.bind(this)).on("mouseleave", "ul.menu > .pp-has-submenu", function (e) {$(this.nodeClass).closest(".fl-row").find(".fl-row-content").css("z-index", "")}.bind(this))
    }

    _toggleForMobile () {
      let $wrapper = null, $menu = null, self = this
      if (this._isMenuToggle()) {
        if (this._isMobileBelowRowEnabled()) {
          this._placeMobileMenuBelowRow()
          $wrapper = $(this.wrapperClass)
          $menu = $(this.nodeClass + "-clone")
          $menu.find("ul.menu").show()
        } else {
          $wrapper = $(this.wrapperClass)
          $menu = $wrapper.find(".menu")
        }

        if (!$wrapper.find(".pp-advanced-menu-mobile-toggle").hasClass("pp-active") && this.mobileMenuType === "default") {
          $menu.css({ display: "none" })
        }

        $wrapper.on("click", ".pp-advanced-menu-mobile-toggle", function (e) {
          $(this).toggleClass("pp-active")
          $menu.slideToggle()
          e.stopPropagation()
        })

        $menu.on("click", ".menu-item > a[href*=\"#\"]", function (e) {
          let $href = $(this).attr("href"), $targetID = ""
          if ($href !== "#") {
            $targetID = $href.split("#")[1]
            if ($("body").find("#" + $targetID).length > 0) {
              e.preventDefault()
              $(this).toggleClass("pp-active")
              setTimeout(function () {$("html, body").animate({ scrollTop: $("#" + $targetID).offset().top }, 1000, function () {window.location.hash = $targetID})}, 500)
              if (!self._isMenuToggle()) {$menu.slideToggle()}
            }
          }
        })
      } else {
        $wrapper = $(this.wrapperClass), $menu = $wrapper.children(".menu")
        $wrapper.find(".pp-advanced-menu-mobile-toggle").removeClass("pp-active")
        $menu.css({ display: "" })
      }
    }

    _initMegaMenus () {
      let module = $(this.nodeClass), rowContent = module.closest(".fl-row-content"),
        rowWidth = rowContent.width(), rowOffset = rowContent.offset().left, megas = module.find(".mega-menu"),
        disabled = module.find(".mega-menu-disabled"), isToggle = this._isMenuToggle()
      if (isToggle) {
        megas.removeClass("mega-menu").addClass("mega-menu-disabled")
        module.find("li.mega-menu-disabled > ul.sub-menu").css("width", "")
        rowContent.css("position", "")
      } else {
        disabled.removeClass("mega-menu-disabled").addClass("mega-menu")
        module.find("li.mega-menu > ul.sub-menu").css("width", rowWidth + "px")
        rowContent.css("position", "relative")
      }
    }

    _initOffCanvas () {
      $("html").addClass("pp-off-canvas-menu-module")
      $("html").addClass("pp-off-canvas-menu-" + this.offCanvasDirection)
      if (null === this.offCanvasMenu && $(this.nodeClass).find(".pp-advanced-menu.off-canvas").length > 0) {this.offCanvasMenu = $(this.nodeClass).find(".pp-advanced-menu.off-canvas")}
      if ($("#pp-advanced-menu-off-canvas-" + this.settingsId).length === 0 && null !== this.offCanvasMenu && !this.isBuilderActive) {this.offCanvasMenu.appendTo("body").wrap("<div id=\"pp-advanced-menu-off-canvas-" + this.settingsId + "\" class=\"fl-node-" + this.settingsId + " pp-menu-off-canvas\">")}
      this._toggleMenu()
    }

    _initFullScreen () {
      $("html").addClass("pp-full-screen-menu-module")
      if (null === this.fullScreenMenu && $(this.nodeClass).find(".pp-advanced-menu.full-screen").length > 0) {this.fullScreenMenu = $(this.nodeClass).find(".pp-advanced-menu.full-screen")}
      if ($("#pp-advanced-menu-full-screen-" + this.settingsId).length === 0 && null !== this.fullScreenMenu && !this.isBuilderActive) {this.fullScreenMenu.appendTo("body").wrap("<div id=\"pp-advanced-menu-full-screen-" + this.settingsId + "\" class=\"fl-node-" + this.settingsId + " pp-menu-full-screen\">")}
      this._toggleMenu()
    }

    _toggleMenu () {
      let self = this
      let singleInstance = true
      if (self.mobileMenuType === "full-screen") {
        let winHeight = window.innerHeight
        $(self.nodeClass).find(".pp-menu-overlay").css("height", winHeight + "px")
        $(window).on("resize", function () {
          winHeight = window.innerHeight
          $(self.nodeClass).find(".pp-menu-overlay").css("height", winHeight + "px")
        })
      }
      $(self.nodeClass).find(".pp-advanced-menu-mobile-toggle").off("click").on("click", function () {
        if (singleInstance) {
          if ($(".pp-advanced-menu.menu-open").length > 0) {
            $(".pp-advanced-menu").removeClass("menu-open")
            $("html").removeClass("pp-full-screen-menu-open")
          }
        }
        if ($(self.nodeClass).find(".pp-advanced-menu").hasClass("menu-open")) {
          $(self.nodeClass).find(".pp-advanced-menu").removeClass("menu-open")
          $(self.nodeClass).find(".pp-advanced-menu").addClass("menu-close")
          $("html").removeClass("pp-off-canvas-menu-open")
          $("html").removeClass("pp-full-screen-menu-open")
        } else {
          $(self.nodeClass).find(".pp-advanced-menu").addClass("menu-open")
          if (self.mobileMenuType === "off-canvas") {
            $("html").addClass("pp-off-canvas-menu-open")
            self.offCanvasMenu.find("nav").attr("tabindex", "0").trigger("focus")
            $(this).attr("tabindex", "-1").trigger("blur")
          }
          if (self.mobileMenuType === "full-screen") {
            $("html").addClass("pp-full-screen-menu-open")
            self.fullScreenMenu.find("nav").attr("tabindex", "0").trigger("focus")
            $(this).attr("tabindex", "-1").trigger("blur")
          }
        }
      })
      $(self.nodeClass).find(".pp-advanced-menu-mobile-toggle").on("keyup", function (e) {if (13 === e.keyCode || 13 === e.which) {$(this).trigger("click")}})
      $(self.nodeClass).find(".pp-advanced-menu .pp-menu-close-btn, .pp-clear").on("click", function () {
        $(self.nodeClass).find(".pp-advanced-menu").removeClass("menu-open")
        $(self.nodeClass).find(".pp-advanced-menu").addClass("menu-close")
        $("html").removeClass("pp-off-canvas-menu-open")
        $("html").removeClass("pp-full-screen-menu-open")
        if ($(self.nodeClass).find(".pp-advanced-menu-mobile-toggle").is(":visible")) {setTimeout(function () {$(self.nodeClass).find(".pp-advanced-menu-mobile-toggle").attr("tabindex", 0).trigger("focus")}, 120)}
        if (self.offCanvasMenu && self.offCanvasMenu.length > 0) {self.offCanvasMenu.find("nav").attr("tabindex", "-1").trigger("blur")}
        if (self.fullScreenMenu && self.fullScreenMenu.length > 0) {self.fullScreenMenu.find("nav").attr("tabindex", "-1").trigger("blur")}
      })
    }

    _isMobileBelowRowEnabled () {
      if (this.mobileMenuType === "default") {return this.mobileBelowRow && $(this.nodeClass).closest(".fl-col").length}
      return false
    }

    _placeMobileMenuBelowRow () {
      if ($(this.nodeClass + "-clone").length) {return}
      if ($("html").hasClass("fl-builder-is-showing-toolbar")) {return}
      let module = $(this.nodeClass), clone = module.clone(), col = module.closest(".fl-col")
      module.find("ul.menu").remove()
      clone.addClass((this.nodeClass + "-clone").replace(".", ""))
      clone.find(".pp-advanced-menu-mobile-toggle").remove()
      col.after(clone)
      if (module.hasClass("fl-animation")) {clone.removeClass("fl-animation")}
      this._menuOnClick()
    }

    _removeMenuFromBelowRow () {
      if (!$(this.nodeClass + "-clone").length) {return}
      let module = $(this.nodeClass), clone = $(this.nodeClass + "-clone"), menu = clone.find("ul.menu")
      module.find(".pp-advanced-menu-mobile-toggle").after(menu)
      clone.remove()
    }

    _toggleMenuSearch () {
      let items = $(this.wrapperClass).find(".pp-menu-search-item"), self = this
      items.each(function () {
        let item = $(this)
        let button = item.find("> a"), form = item.find(".pp-search-form"),
          input = item.find(".pp-search-form__input")
        button.on("click", function (e) {
          e.preventDefault()
          item.toggleClass("pp-search-active")
          if (item.hasClass("pp-search-active")) {
            setTimeout(function () {
              input.focus()
              self._focusMenuSearch(input)
            }, 100)
          }
          $("body").on("click.pp-menu-search", self._hideMenuSearch.bind(self))
        })
        input.on("focus", function () {form.addClass("pp-search-form--focus")}).on("blur", function () {form.removeClass("pp-search-form--focus")})
      })
    }

    _hideMenuSearch (e) {
      if (e !== undefined) {if ($(e.target).closest(".pp-menu-search-item").length > 0) {return}}
      $(this.wrapperClass).find(".pp-menu-search-item").removeClass("pp-search-active")
      $("body").off("click.pp-menu-search")
    }

    _focusMenuSearch ($el) {
      if ($el[0].setSelectionRange) {
        let len = $el.val().length * 2
        setTimeout(function () {$el[0].setSelectionRange(len, len)}, 1)
      } else {$el.val($el.val())}
    }
  }

  new PPAdvancedMenu({
    id: "menu",
    type: "horizontal",
    mobile: "hamburger",
    menuPosition: "below",
    breakpoints: { large: 1200, medium: 1115, small: 860, custom: 768 },
    mobileBreakpoint: "mobile",
    mediaBreakpoint: "860",
    mobileMenuType: "off-canvas",
    offCanvasDirection: "right",
    fullScreenAnimation: "",
    isBuilderActive: false
  })
})(jQuery)
