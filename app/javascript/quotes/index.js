document.addEventListener("turbolinks:load", function () {
  const getData = async () => {
    const url = "/stocks/quote_stream?ticker=AMD";
    const response = await fetch(url);

    if (response.ok) {
      return await response.json();
    } else {
      alert("Ошибка HTTP: " + response.status);
    }
  };
  // const refreshIntervalId = setInterval(getData, 10000);

  getData().amd;
});
