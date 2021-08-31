import CableReady from "cable_ready";
import consumer from "./consumer";

const quotes_channel = consumer.subscriptions.create("QuotesChannel", {
  connected() {
    this.followCurrentQuote();
    this.installPageCallback();
  },
  received(data) {
    const tickerElement = document.getElementById("current_ticker");
    const receivedDataTicker = data.operations.textContent[0].ticker;
    if (tickerElement && tickerElement.dataset.ticker == receivedDataTicker) {
      if (data.cableReady) CableReady.perform(data.operations);
      this.perform("quotes_received", { ticker: receivedDataTicker });
    }
  },
  followCurrentQuote() {
    const tickerElement = document.getElementById("current_ticker");
    if (tickerElement) {
      const ticker = tickerElement.dataset.ticker;
      quotes_channel.perform("subscribed_quotes", { ticker: ticker });
    } else {
      quotes_channel.perform('unsubscribed_quotes');
    }
  },
  installPageCallback() {
    console.log("callback instal func");
    if (!this.installedPageCallback) {
      this.installedPageCallback = true;
      document.addEventListener(
        "turbolinks:load",
        quotes_channel.followCurrentQuote
      );
    }
  },
});
