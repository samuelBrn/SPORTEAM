import { Controller } from "stimulus";

export default class extends Controller {
  static targets = ["next7Days", "thisWeekend", "tomorrow"];

  toggleFilter() {
    this.filterEvents();
  }

  filterEvents() {
    const next7DaysChecked = this.next7DaysTarget.checked;
    const thisWeekendChecked = this.thisWeekendTarget.checked;
    const tomorrowChecked = this.tomorrowTarget.checked;

    const events = document.querySelectorAll(".event-item");

    events.forEach(event => {
      const eventDate = new Date(event.dataset.date);
      const today = new Date();
      const daysDiff = Math.ceil((eventDate - today) / (1000 * 60 * 60 * 24));

      const showEvent = (next7DaysChecked && daysDiff <= 7) ||
                        (thisWeekendChecked && this.isThisWeekend(eventDate)) ||
                        (tomorrowChecked && daysDiff === 1);

      if (showEvent) {
        event.style.display = "block";
      } else {
        event.style.display = "none";
      }
    });
  }

  isThisWeekend(date) {
    const today = new Date();
    const day = date.getDay();
    return (day === 6 && date > today) || (day === 0 && date >= today);
  }

  search() {
    this.filterEvents();
  }
}
