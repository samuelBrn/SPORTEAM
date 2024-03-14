import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="sportcheck"
export default class extends Controller {
  connect() {
    // JavaScript pour la sélection des cartes
    const cards = document.querySelectorAll('.gpt-sport-card');

    cards.forEach(card => {
      card.addEventListener('click', () => {
        const checkbox = card.querySelector('.category-input');
        // Marquer visuellement les cartes sélectionnées au chargement
        if (checkbox.checked) {
          checkbox.checked = false;
        } else {
          checkbox.checked = true;
        }
        card.classList.toggle('border-sport-bg')
        card.classList.toggle('border-sport-selected');
      });
    });
  }
}
