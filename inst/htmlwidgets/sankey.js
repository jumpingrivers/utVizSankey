HTMLWidgets.widget({

  name: 'sankey',

  type: 'output',

  factory: function(el, width, height) {

    const sankey = utviz.createSankey();
    el.appendChild(sankey.viz);

    return {

      renderValue: function(x) {

        sankey.data(x.data);
        sankey.steps(x.steps);
        sankey.render();

      },

      resize: function(width, height) {

        // TODO: code to re-render the widget with a new size

      }

    };
  }
});
