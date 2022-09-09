HTMLWidgets.widget({
  name: "sankey",

  type: "output",

  factory: function (el, width, height) {
    const sankey = utviz.createSankey();
    el.appendChild(sankey.viz);

    return {
      renderValue: function (x) {
        sankey.data(x.data);
        sankey.steps(x.steps);

        if ("altClickHandler" in x) {
          sankey.altClickHandler(x.altClickHandler);
        }
        if ("color" in x) {
          sankey.color(x.color);
        }
        if ("hoverColor" in x) {
          sankey.hoverColor(x.hoverColor);
        }
        if ("colorOverrides" in x) {
          sankey.colorOverrides(x.colorOverrides);
        }
        if ("nodePopupTemplate" in x) {
          sankey.nodePopupTemplate(x.nodePopupTemplate);
        }
        if ("linkPopupTemplate" in x) {
          sankey.linkPopupTemplate(x.linkPopupTemplate);
        }
        sankey.render();
      },

      resize: function (width, height) {
        // TODO: code to re-render the widget with a new size
      },
    };
  },
});
