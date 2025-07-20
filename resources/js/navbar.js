document.addEventListener("DOMContentLoaded", function () {
    // Menu Burger
    const burger = document.getElementById("burger");
    const closeMenu = document.getElementById("close-menu");

    burger?.addEventListener("click", function (e) {
        e.stopPropagation();
        // Bascule la variable 'open' d'Alpine.js
        window.Alpine.store('open', !window.Alpine.store('open'));
    });

    closeMenu?.addEventListener("click", function (e) {
        e.stopPropagation();
        // Ferme le menu en mettant 'open' à false
        window.Alpine.store('open', false);
    });

    // Ferme le menu si on clique en dehors
    document.addEventListener("click", (e) => {
        if (window.Alpine.store('open') && !e.target.closest('.mobile-menu') && !e.target.closest('.burger')) {
            window.Alpine.store('open', false);
        }
    });

    // Ferme le menu si la fenêtre est redimensionnée et dépasse 768px
    window.addEventListener("resize", function() {
        if (window.innerWidth >= 768) {
            window.Alpine.store('open', false);
        }
    });
});
