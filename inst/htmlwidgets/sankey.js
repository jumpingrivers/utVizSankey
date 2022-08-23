HTMLWidgets.widget({

  name: 'sankey',

  type: 'output',

  factory: function(el, width, height) {

    // TODO: define shared variables for this instance

    return {

      renderValue: function(x) {

        const sankey = utviz
          .createSankey(x.data, x.steps)
          .render();

        el.appendChild(sankey.viz);

      },

      resize: function(width, height) {

        // TODO: code to re-render the widget with a new size

      }

    };
  }
});
