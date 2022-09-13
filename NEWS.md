# utVizSankey 0.3.2 *2022-09-13*

- All columns in the 'data' argument to `sankey(data, steps, ...)` are now included in the data
  field passed to the htmlwidget.
- Show how to specify the size of the output widget using `height` / `weight` arguments in the
  vignette.

# utVizSankey 0.3.1 *2022-09-09*

- New feature: User can set `color`, `hover_color` and `color_overrides` for a sankey() chart using
  either hex, rgb or R's named colors.

# utVizSankey 0.3.0 *2022-09-06*

- New feature: user can add template strings to customize the content of node & link popups via
  the `node_template` and `link_template` arguments for `sankey()`.
- Use updated version of utviz JS library `3c8d1e` v1.0.1.

# utVizSankey 0.2.0 *2022-09-02*

- New feature: allow shiny users to access Sankey node-data by defining an alt-click handler.
- Add a shiny app that demonstrates accessing node-data from JS.
- New function `run_shiny_example()` to run the example apps
- New Input-Handler for shiny that converts the node-data (an array of JS objects) to a
  data.frame

# utVizSankey 0.1.3 *2022-09-02*

- Fix: prevent multiple widgets being added to the same HTML element

# utVizSankey 0.1.2 *2022-08-30*

- Use updated version of utviz JS library `#3bb665d` that allows length-1 color palettes in
  Sunburst charts

# utVizSankey 0.1.1 *2022-08-23*

- Use MIT license

# utVizSankey 0.1.0 *2022-08-16*

- Add methods to create a simple sankey diagram.
- Add examples to vignette and function documentation to demonstrate how a simple sankey diagram can
  be created.
- Adds more tests for the `sankey` function.

# utVizSankey 0.0.6 *2022-08-16*

- Store the JS dependencies of the sankey() widget in the package (handlebars 4.7.7; utviz
  `#cdc8842`)
- Define the JS dependencies used by sankey() in its .yaml file

# utVizSankey 0.0.5 *2022-08-15*

- Add an example "admissions" dataset to the package, for use in example code in the vignette.

# utVizSankey 0.0.4 *2022-08-15*

- Add a sankey htmlwidget skeleton

# utVizSankey 0.0.3 *2022-08-15*

- Add precommit settings for the project.

# utVizSankey 0.0.2 *2022-08-15*

- Add vignette for demonstrating how to use the package, and how it meets the client requirements.

# utVizSankey 0.0.1 *2022-08-15*

- Initialise package structure using pm-init
- Add CODEOWNERS
- Ensure the bare package passes pm-check / rcmd-check / linting
- Add dummy function and test
