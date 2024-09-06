(function ($) {
  class PPAdvancedMenu {
    constructor (settings) {
      this.settingsId = settings.id
      this.nodeClass = ""
      this.wrapperClass = `${this.nodeClass} .pp-advanced-menu`
      this.type = settings.type
      this.mobileToggle = settings.mobile
      this.mobileBelowRow = settings.menuPosition === "below"
      this.breakpoints = settings.breakpoints
      this.mobileBreakpoint = settings.mobileBreakpoint
      this.mediaBreakpoint = settings.mediaBreakpoint
      this.mobileMenuType = settings.mobileMenuType
      this.offCanvasDirection = settings.offCanvasDirection
      this.postId = settings.postId
      this.isBuilderActive = settings.isBuilderActive
      this.currentBrowserWidth = window.innerWidth
      this.fullScreenMenu = null
      this.offCanvasMenu = null
      this.$submenus = null

      this._initMenu = this._initMenu.bind(this)
      this._clickOrHover = this._clickOrHover.bind(this)

      $(this._initMenu)
      $(window).on("resize", (e) => {
        const width = window.innerWidth
        if (width !== this.currentBrowserWidth) {
          this._initMenu()
          this._clickOrHover()
          this.currentBrowserWidth = width
        }
      })

      $("body").on("click", (e) => {
        if (typeof FLBuilderConfig !== "undefined") return
        if ($(this.wrapperClass).find(".pp-advanced-menu-mobile-toggle").hasClass("pp-active") && this.mobileToggle !== "expanded") {
          if ($(e.target).parents(".fl-module-pp-advanced-menu").length > 0) return
          if ($(e.target).is("input") && $(e.target).parents(".pp-advanced-menu").length > 0) return
          if ($(e.target).hasClass("pp-menu-close-btn")) return
          $(this.wrapperClass).find(".pp-advanced-menu-mobile-toggle").trigger("click")
        }
        $(this.wrapperClass).find(".pp-has-submenu").removeClass("focus pp-active")
        $(this.wrapperClass).find(".pp-has-submenu .sub-menu").removeClass("focus")
        $(this.wrapperClass).find(".pp-has-submenu-container").removeClass("focus")
        $(this.wrapperClass).find(".pp-menu-toggle").attr("aria-expanded", false)
      })

      $(document).on("keyup", (e) => {
        if (e.which === 27) {
          $(this.wrapperClass).find(".pp-has-submenu").removeClass("focus pp-active")
          $(this.wrapperClass).find(".pp-has-submenu .sub-menu").removeClass("focus")
          $(this.wrapperClass).find(".pp-has-submenu-container").removeClass("focus")
          $(this.wrapperClass).find(".pp-menu-toggle").attr("aria-expanded", false)
          if ($(this.wrapperClass).find(".pp-menu-toggle.focus").is(":visible")) {
            $(this.wrapperClass).find(".pp-menu-toggle.focus").delay(100).trigger("focus")
          }
        }
      })
    }

    _isMobile () {
      return window.innerWidth <= this.breakpoints.small
    }

    _isMedium () {
      return window.innerWidth <= this.breakpoints.medium
    }

    _isLarge () {
      return window.innerWidth <= this.breakpoints.large
    }

    _isCustom () {
      return window.innerWidth <= this.breakpoints.custom
    }

    _isTouch () {
      const prefixes = " -webkit- -moz- -o- -ms- ".split(" ")
      const mq = (query) => window.matchMedia(query).matches
      if ("ontouchstart" in window || (window.DocumentTouch && document instanceof DocumentTouch)) {
        return true
      }
      const query = ["(", prefixes.join("touch-enabled),("), "heartz", ")"].join("")
      return mq(query)
    }

    _isMenuToggle () {
      return (this.mobileBreakpoint === "always" || (this._isMobile() && this.mobileBreakpoint === "mobile") || (this._isMedium() && this.mobileBreakpoint === "medium-mobile") || (this._isCustom() && this.mobileBreakpoint === "custom"))
    }

    _initMenu () {
      this._setupSubmenu()
      this._menuOnFocus()
      this._submenuOnClick()
      if ($(this.nodeClass).length && this.type === "horizontal") {
        this._initMegaMenus()
      }
      if (this.type === "horizontal" || this.type === "vertical") {
        $(this.wrapperClass).find(".pp-has-submenu-container").on("click", (e) => {
          if (this.mobileMenuType !== "off-canvas" && this.mobileMenuType !== "full-screen") {
            if (self._isTouch()) {
              if (!$(this).hasClass("first-click")) {
                e.preventDefault()
                $(this).addClass("first-click")
              }
            }
          }
        })
        $(this.wrapperClass).find("li.pp-has-submenu a").on("keyup", (e) => {
          if ($(e.target).hasClass("pp-menu-toggle") && !$(this.nodeClass).find(".pp-advanced-menu-mobile-toggle").is(":visible")) {
            if (e.which == 1 || e.which == 13 || e.which == undefined) {
              e.preventDefault()
              e.stopPropagation()
              $(e.target).parents("li.pp-has-submenu").toggleClass("pp-active")
              if ($(e.target).parents("li.pp-has-submenu").hasClass("pp-active")) {$(e.target).attr("aria-expanded", true)} else {$(e.target).attr("aria-expanded", false)}
            }
          }
        })
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
        if (this.mobileMenuType === "off-canvas") {
          this._initOffCanvas()
        }
        if (this.mobileMenuType === "full-screen") {
          this._initFullScreen()
        }
      }
      $(this.wrapperClass).find("li:not(.menu-item-has-children)").on("click", "a", (e) => {
        if ($(e.target).closest(".pp-menu-search-item").length > 0) return
        $(this.nodeClass).find(".pp-advanced-menu").removeClass("menu-open")
        $(this.nodeClass).find(".pp-advanced-menu").addClass("menu-close")
        $("html").removeClass("pp-off-canvas-menu-open")
        $("html").removeClass("pp-full-screen-menu-open")
      })
      if ($(this.wrapperClass).find(".pp-menu-search-item").length) {
        this._toggleMenuSearch()
      }
      if ($(this.wrapperClass).find(".pp-menu-cart-item").length) {
        this._wooUpdateParams()
      }
    }

    _setupSubmenu () {
      $(`${this.wrapperClass} ul.sub-menu`).each(function () {
        $(this).closest("li").attr("aria-haspopup", "true")
      })
    }

    _menuOnFocus () {
      $(this.nodeClass)
        .off("focus")
        .on("focus", "a", (e) => {
          const $menuItem = $(e.target).parents(".menu-item").first()
          const $parents = $(e.target).parentsUntil(this.wrapperClass)
          $(".pp-advanced-menu .focus:not(.pp-menu-toggle)").removeClass("focus")
          $menuItem.addClass("focus")
          $parents.addClass("focus")
        })
        .on("focusout", "a", (e) => {
          if ($(".pp-advanced-menu .focus").hasClass("pp-has-submenu")) {
            $(e.target).parentsUntil(this.wrapperClass).find(".pp-has-submenu-container").removeClass("first-click")
          }
        })
      $(this.nodeClass)
        .off("focus", ".pp-menu-toggle")
        .on("focus", ".pp-menu-toggle", (e) => {
          $(e.target).addClass("focus")
        })
        .off("blur", ".pp-menu-toggle")
        .on("blur", ".pp-menu-toggle", (e) => {
          if ($(e.target).parents("li.pp-has-submenu.pp-active").length === 0 || $(e.target).parents("li.pp-has-submenu.pp-active").parent("ul.menu").length === 0) {
            $(e.target).removeClass("focus")
          }
        })
    }

    _menuOnClick () {
      const self = this
      let $mainItem = ""
      $(this.wrapperClass)
        .off()
        .on("click.pp-advanced-menu keyup", ".pp-has-submenu-container", function (e) {
          const isValidEvent = e.which === 1 || e.which === 13 || e.which === undefined
          if (!isValidEvent) return
          if (e.which === 13 && !$(e.target).hasClass("pp-menu-toggle")) return
          if (self._isTouch()) {
            if (!$(this).hasClass("first-click")) {
              // Additional logic here
            }
          }
          e.stopPropagation()
          const isMainEl = $(e.target).parents(".menu-item").parent().parent().hasClass("pp-advanced-menu")
          if (isMainEl && $mainItem === "") {
            $mainItem = $(e.target).parents(".menu-item")
          }
          const $link = $(e.target).parents(".pp-has-submenu").first()
          const $subMenu = $link.children(".sub-menu").first()
          const $href = $link.children(".pp-has-submenu-container").first().find("> a").attr("href")
          const $subMenuParents = $(e.target).parents(".sub-menu")
          const $activeParent = $(e.target).closest(".pp-has-submenu.pp-active")
          if ($activeParent.length > 0) {
            $activeParent.find(".pp-menu-toggle").first().attr("aria-expanded", true)
          } else {
            $activeParent.find(".pp-menu-toggle").first().attr("aria-expanded", false)
          }
          if (!$subMenu.is(":visible") || $(e.target).hasClass("pp-menu-toggle") || ($subMenu.is(":visible") && (typeof $href === "undefined" || $href === "#"))) {
            // Additional logic here
          } else {
            // Additional logic here
          }
          if ($(this.wrapperClass).hasClass("pp-advanced-menu-accordion-collapse")) {
            if ($link.parents(".menu-item").length && !$link.parents(".menu-item").hasClass("pp-active")) {
              $(".menu .pp-active", this.wrapperClass).not($link).removeClass("pp-active")
            } else if ($link.parents(".menu-item").hasClass("pp-active") && $link.parent(".sub-menu").length) {
              $(".menu .pp-active", this.wrapperClass).not($link).not($activeParent).removeClass("pp-active")
            }
            $(".sub-menu", this.wrapperClass).not($subMenu).not($subMenuParents).slideUp("normal")
          }
          if ($(self.wrapperClass).find(".sub-menu:visible").length > 0) {
            $(self.wrapperClass).find(".sub-menu:visible").parent().addClass("pp-active")
          }
          $subMenu.slideToggle(400, function () {
            $(e.target).parents(".pp-has-submenu-container").parent().parent().find("> .menu-item.pp-active").removeClass("pp-active")
            if ($mainItem !== "") {
              // Additional logic here
            }
            if (!$subMenu.is(":visible")) {
              // Additional logic here
            }
          })
        })
    }

    _submenuOnClick () {
      $(`${this.wrapperClass} .sub-menu`).off().on("click", "a", (e) => {
        if ($(e.target).parent().hasClass("focus")) {
          $(e.target).parentsUntil(this.wrapperClass).removeClass("focus")
        }
      })
    }

    _clickOrHover () {
      this.$submenus = this.$submenus || $(this.wrapperClass).find(".sub-menu")
      const $wrapper = $(this.wrapperClass)
      const $menu = $wrapper.find(".menu")
      const $li = $wrapper.find(".pp-has-submenu")
      if (this._isMenuToggle()) {
        $li.each(function () {
          if (!$(this).hasClass("pp-active")) {
            $(this).find(".sub-menu").fadeOut()
          }
        })
      } else {
        $li.each(function () {
          if (!$(this).hasClass("pp-active")) {
            // Additional logic here
          }
        })
      }
    }

    _submenuOnRight () {
      $(this.wrapperClass)
        .on("mouseenter focus", ".pp-has-submenu", (e) => {
          if ($(e.currentTarget).find(".sub-menu").length === 0) return
          const $link = $(e.currentTarget)
          const $parent = $link.parent()
          const $subMenu = $link.find(".sub-menu")
          const subMenuWidth = $subMenu.width()
          const winWidth = window.innerWidth
          if ($link.closest(".pp-menu-submenu-right").length !== 0) {
            $link.addClass("pp-menu-submenu-right")
          } else if ($("body").hasClass("rtl")) {
            // Additional logic here
          } else {
            // Additional logic here
          }
        })
        .on("mouseleave", ".pp-has-submenu", (e) => {
          $(e.currentTarget).removeClass("pp-menu-submenu-right")
        })
    }

    _submenuRowZindexFix () {
      $(this.wrapperClass)
        .on("mouseenter", "ul.menu > .pp-has-submenu", (e) => {
          if ($(e.currentTarget).find(".sub-menu").length === 0) return
          $(this.nodeClass).closest(".fl-row").find(".fl-row-content").css("z-index", "10")
        })
        .on("mouseleave", "ul.menu > .pp-has-submenu", (e) => {
          $(this.nodeClass).closest(".fl-row").find(".fl-row-content").css("z-index", "")
        })
    }

    _toggleForMobile () {
      let $wrapper = null
      let $menu = null

      $wrapper = $(this.wrapperClass)
      $menu = $wrapper.children(".menu")

      if (this._isMenuToggle()) {
        if (this._isMobileBelowRowEnabled()) {
          // Additional logic here
        }
        if (!$wrapper.find(".pp-advanced-menu-mobile-toggle").hasClass("pp-active") && this.mobileMenuType === "default") {
          $menu.css({ display: "none" })
        }
        $wrapper.on("click", ".pp-advanced-menu-mobile-toggle", (e) => {
          // Additional logic here
        })
        $menu.on("click", ".menu-item > a[href*=\"#\"]", (e) => {
          // Additional logic here
        })
      } else {
        if (this._isMobileBelowRowEnabled()) {
          this._removeMenuFromBelowRow()
        }
        $wrapper.find(".pp-advanced-menu-mobile-toggle").removeClass("pp-active")
        $menu.css({ display: "" })
      }
    }

    _initMegaMenus () {
      const module = $(this.nodeClass)
      const rowContent = module.closest(".fl-row-content")
      const rowWidth = rowContent.width()
      const rowOffset = rowContent.offset().left
      const megas = module.find(".mega-menu")
      const disabled = module.find(".mega-menu-disabled")
      const isToggle = this._isMenuToggle()
      if (isToggle) {
        megas.removeClass("mega-menu").addClass("mega-menu-disabled")
        module.find("li.mega-menu-disabled > ul.sub-menu").css("width", "")
        rowContent.css("position", "")
      } else {
        disabled.removeClass("mega-menu-disabled").addClass("mega-menu")
        module.find("li.mega-menu > ul.sub-menu").css("width", `${rowWidth}px`)
        rowContent.css("position", "relative")
      }
    }

    _initOffCanvas () {
      $("html").addClass("pp-off-canvas-menu-module")
      $("html").addClass(`pp-off-canvas-menu-${this.offCanvasDirection}`)
      if (this.offCanvasMenu === null && $(this.nodeClass).find(".pp-advanced-menu.off-canvas").length > 0) {
        this.offCanvasMenu = $(this.nodeClass).find(".pp-advanced-menu.off-canvas")
      }
      if ($(`#pp-advanced-menu-off-canvas-${this.settingsId}`).length === 0 && this.offCanvasMenu !== null && !this.isBuilderActive) {
        this.offCanvasMenu.appendTo("body").wrap(`<div id="pp-advanced-menu-off-canvas-${this.settingsId}" class="fl-node-${this.settingsId} pp-menu-off-canvas">`)
      }
      this._toggleMenu()
    }

    _initFullScreen () {
      $("html").addClass("pp-full-screen-menu-module")
      if (this.fullScreenMenu === null && $(this.nodeClass).find(".pp-advanced-menu.full-screen").length > 0) {
        this.fullScreenMenu = $(this.nodeClass).find(".pp-advanced-menu.full-screen")
      }
      if ($(`#pp-advanced-menu-full-screen-${this.settingsId}`).length === 0 && this.fullScreenMenu !== null && !this.isBuilderActive) {
        this.fullScreenMenu.appendTo("body").wrap(`<div id="pp-advanced-menu-full-screen-${this.settingsId}" class="fl-node-${this.settingsId} pp-menu-full-screen">`)
      }
      this._toggleMenu()
    }

    _toggleMenu () {
      let singleInstance = true
      if (this.mobileMenuType === "full-screen") {
        let winHeight = window.innerHeight
        $(this.nodeClass).find(".pp-menu-overlay").css("height", `${winHeight}px`)
        $(window).on("resize", () => {
          winHeight = window.innerHeight
          $(this.nodeClass).find(".pp-menu-overlay").css("height", `${winHeight}px`)
        })
      }
      $(this.nodeClass).find(".pp-advanced-menu-mobile-toggle").off("click").on("click", () => {
        if (singleInstance) {
          if ($(".pp-advanced-menu.menu-open").length > 0) {
            // Additional logic here
          }
        }
        if ($(this.nodeClass).find(".pp-advanced-menu").hasClass("menu-open")) {
          // Additional logic here
        } else {
          // Additional logic here
          if (this.mobileMenuType === "off-canvas") {
            // Additional logic here
          }
          if (this.mobileMenuType === "full-screen") {
            // Additional logic here
          }
        }
      })
      $(this.nodeClass).find(".pp-advanced-menu-mobile-toggle").on("keyup", (e) => {
        if (e.keyCode === 13 || e.which === 13) {
          $(this).trigger("click")
        }
      })
      $(this.nodeClass).find(".pp-advanced-menu .pp-menu-close-btn, .pp-clear").on("click", () => {
        $(this.nodeClass).find(".pp-advanced-menu").removeClass("menu-open")
        $(this.nodeClass).find(".pp-advanced-menu").addClass("menu-close")
        $("html").removeClass("pp-off-canvas-menu-open")
        $("html").removeClass("pp-full-screen-menu-open")
        if ($(this.nodeClass).find(".pp-advanced-menu-mobile-toggle").is(":visible")) {
          setTimeout(() => {
            $(this.nodeClass).find(".pp-advanced-menu-mobile-toggle").attr("tabindex", 0).trigger("focus")
          }, 120)
        }
        if (this.offCanvasMenu && this.offCanvasMenu.length > 0) {
          this.offCanvasMenu.find("nav").attr("tabindex", "-1").trigger("blur")
        }
        if (this.fullScreenMenu && this.fullScreenMenu.length > 0) {
          this.fullScreenMenu.find("nav").attr("tabindex", "-1").trigger("blur")
        }
      })
      if (this.isBuilderActive) {
        setTimeout(() => {
          // Additional logic here
          FLBuilder.addHook("settings-form-init", () => {
            // Additional logic here
            if (!$("html").hasClass("pp-full-screen-menu-open") && !$(this.nodeClass).find(".pp-advanced-menu").hasClass("menu-open")) {
              $("html").removeClass("pp-full-screen-menu-open")
            }
            if (!$("html").hasClass("pp-off-canvas-menu-open") && !$(this.nodeClass).find(".pp-advanced-menu").hasClass("menu-open")) {
              $("html").removeClass("pp-off-canvas-menu-open")
            }
          })
        }, 0)
      }
    }

    _isMobileBelowRowEnabled () {
      if (this.mobileMenuType === "default") {
        return this.mobileBelowRow && $(this.nodeClass).closest(".fl-col").length
      }
      return false
    }

    _placeMobileMenuBelowRow () {
      if ($(this.nodeClass + "-clone").length) return
      if ($("html").hasClass("fl-builder-is-showing-toolbar")) return
      const module = $(this.nodeClass)
      const clone = module.clone()
      const col = module.closest(".fl-col")
      module.find("ul.menu").remove()
      clone.addClass((this.nodeClass + "-clone").replace(".", ""))
      clone.find(".pp-advanced-menu-mobile-toggle").remove()
      col.after(clone)
      if (module.hasClass("fl-animation")) clone.removeClass("fl-animation")
      this._menuOnClick()
    }

    _removeMenuFromBelowRow () {
      if (!$(this.nodeClass + "-clone").length) return
      const module = $(this.nodeClass)
      const clone = $(this.nodeClass + "-clone")
      const menu = clone.find("ul.menu")
      module.find(".pp-advanced-menu-mobile-toggle").after(menu)
      clone.remove()
    }

    _toggleMenuSearch () {
      const items = $(this.wrapperClass).find(".pp-menu-search-item")
      items.each((index, item) => {
        const $item = $(item)
        const button = $item.find("> a")
        const form = $item.find(".pp-search-form")
        const input = $item.find(".pp-search-form__input")
        button.on("click", (e) => {
          e.preventDefault()
          $item.toggleClass("pp-search-active")
          if ($item.hasClass("pp-search-active")) {
            setTimeout(() => {
              input.focus()
              this._focusMenuSearch(input)
            }, 100)
          }
          $("body").on("click.pp-menu-search", this._hideMenuSearch.bind(this))
        })
        input.on("focus", () => form.addClass("pp-search-form--focus"))
          .on("blur", () => form.removeClass("pp-search-form--focus"))
      })
    }

    _hideMenuSearch (e) {
      if (e !== undefined && $(e.target).closest(".pp-menu-search-item").length > 0) return
      $(this.wrapperClass).find(".pp-menu-search-item").removeClass("pp-search-active")
      $("body").off("click.pp-menu-search")
    }

    _focusMenuSearch ($el) {
      if ($el[0].setSelectionRange) {
        const len = $el.val().length * 2
        setTimeout(() => $el[0].setSelectionRange(len, len), 1)
      } else {
        $el.val($el.val())
      }
    }

    _wooUpdateParams () {
      if (typeof wc_cart_fragments_params !== "undefined") {
        wc_cart_fragments_params.wc_ajax_url += `&pp-advanced-menu-node=${this.settingsId}&post-id=${this.postId}`
      }
      if (typeof wc_add_to_cart_params !== "undefined") {
        wc_add_to_cart_params.wc_ajax_url += `&pp-advanced-menu-node=${this.settingsId}&post-id=${this.postId}`
      }
    }

    _validClick (e) {
      return e.which === 1 || e.which === 13 || e.which === 32 || e.which === undefined
    }
  }

  new PPAdvancedMenu({
    id: "",
    type: "horizontal",
    mobile: "hamburger",
    menuPosition: "below",
    breakpoints: { large: 1200, medium: 1115, small: 860, custom: 768 },
    mobileBreakpoint: "mobile",
    mediaBreakpoint: "860",
    mobileMenuType: "off-canvas",
    offCanvasDirection: "right",
    fullScreenAnimation: "",
    postId: "588",
    isBuilderActive: false
  })
})(jQuery)
