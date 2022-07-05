import { Controller } from "@hotwired/stimulus";
import ApexCharts from "apexcharts";
// Connects to data-controller="chart"

export default class extends Controller {
  static values = {
    id: Number,
  };

  connect() {
    const stockId = this.idValue;
    if (stockId > 0) {
      const url = `/stocks/${stockId}/daily_quotes`;
      fetch(url)
      .then((response) => {
        return response.json();
      })
      .then((data) => {
        let options = {
          chart: {
            type: "candlestick",
          },
          series: [],

          noData: {
            text: "Loading...",
          },
        };
        let chart = new ApexCharts(document.querySelector("#stock_chart"), options);
        chart.render();
        chart.updateSeries([
          {
            name: "Sales",
            data: data,
          },
        ]);
      })
    }
  }
}
