document.querySelectorAll('.js-tab').forEach(el => {
    const container = el.closest('.js-tabs-container');
    el.onclick = function (e) {
        const panel = document.getElementById(e.target.getAttribute('aria-controls'));
        container.querySelectorAll(".tab-panel").forEach(panel => panel.hidden = true);
        panel.hidden = false;
        if (window.innerWidth < 860) {
            panel.scrollIntoView({ behavior: 'smooth', block: 'center' });
            panel.focus();
        }
    }
});