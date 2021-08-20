import CableReady from "cable_ready";
import consumer from "./consumer";

consumer.subscriptions.create("QuotesChannel", {
  connected() {
    this.followCurrentQuote();
  },
  received(data) {
    const tickerElement = document.getElementById("current_ticker");
    const receivedDataTicker = data.operations.textContent[0].ticker
    if (tickerElement && tickerElement.dataset.ticker == receivedDataTicker)
    {
      if (data.cableReady) CableReady.perform(data.operations);
      this.perform("quotes_received", { ticker: receivedDataTicker });
    }
  },
  followCurrentQuote() {
    const tickerElement = document.getElementById("current_ticker");
    if (tickerElement) {
      const ticker = tickerElement.dataset.ticker;
      this.perform("subscribed_quotes", { ticker: ticker });
    }
  }
});
