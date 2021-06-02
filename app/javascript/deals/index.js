

window.addEventListener("load", () => {
  const element = document.querySelector("#new-deal");
  element.addEventListener("ajax:error", () => {
    element.insertAdjacentHTML("beforeend", "<p>ERROR</p>");
  });

});
