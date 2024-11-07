document.querySelectorAll('.js-tab').forEach(el => {
    const container = el.closest('.js-tabs-container');
    el.onclick = function (e) {
        const targetTab = e.target;
        const panel = document.getElementById(targetTab.getAttribute('aria-controls'));
        container.querySelectorAll(".tab-panel").forEach(panel => panel.hidden = true);
        panel.hidden = false;
        container.querySelectorAll(".js-tab").forEach(tabTitle => tabTitle.setAttribute('aria-selected', 'false'));
        targetTab.setAttribute('aria-selected', 'true');
        if (window.innerWidth < 860) {
            panel.scrollIntoView({behavior: 'smooth', block: 'center'});
            panel.focus();
        }
    }
});

//for keyboard
document.querySelectorAll('.tabs').forEach(tabList => {
    const tabs = tabList.querySelectorAll('.js-tab');
    let tabFocus = 0;
    tabList.addEventListener("keydown", (e) => {
        // Move right
        if (e.key === "ArrowDown" || e.key === "ArrowUp" || e.key === 'Enter' || e.key === ' ') {
            tabs[tabFocus].setAttribute("tabindex", -1);
            if (e.key === "ArrowDown") {
                tabFocus++;
                // If we're at the end, go to the start
                if (tabFocus >= tabs.length) {
                    tabFocus = 0;
                }
                // Move left
            } else if (e.key === "ArrowUp") {
                tabFocus--;
                // If we're at the start, move to the end
                if (tabFocus < 0) {
                    tabFocus = tabs.length - 1;
                }
            } else if (e.key === 'Enter' || e.key === ' ') {
                tabs[tabFocus].click();
            }

            tabs[tabFocus].setAttribute("tabindex", 0);
            tabs[tabFocus].focus();
        }
    });
});
