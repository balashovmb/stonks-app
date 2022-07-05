import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="price"
export default class extends Controller {
  static values = {
    ticker: String,
  };

  initialize() {
    const ticker = this.tickerValue;
    if (typeof ticker !== "undefined" && ticker.length > 0) {
      fetch(`/stocks/subscribe_on_quotes?ticker=${ticker}`)
    }
  }
}
