import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="cash"
export default class extends Controller {
  static values = {
    amount: String,
  };
  connect() {
    const cashElement = document.getElementById("cash");
    cashElement.innerText = "Cash: " + this.amountValue;
  }
}
