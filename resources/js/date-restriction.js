document.addEventListener('DOMContentLoaded', function() {
    const dateInputs = document.querySelectorAll('input[type="date"]');

    const today = new Date();
    const year = today.getFullYear();
    const month = String(today.getMonth() + 1).padStart(2, '0');
    const day = String(today.getDate()).padStart(2, '0');
    const todayFormatted = `${year}-${month}-${day}`;

    dateInputs.forEach(function(input) {
        input.setAttribute('min', todayFormatted);

        if (input.value && input.value < todayFormatted) {
            input.value = todayFormatted;
        }

        input.addEventListener('change', function() {
            if (this.value < todayFormatted) {
                this.value = todayFormatted;
                alert("Vous ne pouvez pas sélectionner une date passée. La date a été réinitialisée à aujourd'hui.");
            }
        });
    });
});