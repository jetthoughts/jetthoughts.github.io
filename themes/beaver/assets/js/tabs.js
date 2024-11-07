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