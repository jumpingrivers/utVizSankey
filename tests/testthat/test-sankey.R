test_data = list()

test_data$data = data.frame(
  person_id = letters[1:12],
  student_type = rep(c("x", "y", "z"), each = 4),
  ipeds_race_ethn = rep(c("A", "B", "C", "D"), times = 3),
  college = rep(c("HU", "LR"), each = 6),
  gpa = c("medium", "low"),
  club = c(TRUE, FALSE, FALSE),
  outcome = c("retained", "graduated", "dropped", "stopped")
)
test_data$steps = c("student_type", "ipeds_race_ethn", "college", "gpa", "club", "outcome")

describe("The sankey object", {
  it("creates a sankey/htmlwidget object", {
    sk = sankey(test_data$data, test_data$steps)

    expect_s3_class(sk, "sankey")
    expect_s3_class(sk, "htmlwidget")
  })

  describe("data input", {
    it("contains a 'data' entry that matches the input 'data' argument", {
      sk = sankey(test_data$data, test_data$steps)

      expect_true("data" %in% names(sk$x))
      expect_equal(sk$x$data, test_data$data)
    })

    it("has a 'steps' entry that matches the 'steps' argument", {
      sk = sankey(test_data$data, test_data$steps)

      expect_true("steps" %in% names(sk$x))
      expect_equal(sk$x$steps, test_data$steps)
    })

    it("only allows 'steps' within the colnames of 'data'", {
      expect_error(
        sankey(data = test_data$data, steps = c("not_a_column", "nor_is_this", "", "[a-zA-Z]{+}"))
      )
    })

    it("disallows duplicated 'steps'", {
      expect_error(
        sankey(data = test_data$data, steps = rep(test_data$steps[1], 2))
      )
    })
  })

  describe("color arguments", {
    it("converts colors to hex", {
      sk = sankey(test_data$data, test_data$steps, color = "black")

      expect_equal(sk$x$color, "#000000")
    })

    it("converts hover_color to hex", {
      sk = sankey(test_data$data, test_data$steps, hover_color = "hotpink")

      expect_equal(sk$x$hoverColor, "#FF69B4")
    })

    it("converts color_overrides to hex", {
      overrides = list(
        list(name = "retained", color = "black"),
        list(group = "gpa", color = "hotpink")
      )
      expected = list(
        list(name = "retained", color = "#000000"),
        list(group = "gpa", color = "#FF69B4")
      )
      sk = sankey(test_data$data, test_data$steps, color_overrides = overrides)

      expect_equal(
        sk$x$colorOverrides,
        expected
      )
    })
  })

  describe("pop-up templates", {
    it("appends a template for the node popup", {
      template = "Node {{name}} has {{count}} individuals associated with it."
      sk = sankey(test_data$data, test_data$steps, node_template = template)

      expect_equal(
        sk$x$nodePopupTemplate,
        template
      )
    })

    it("appends a template for the link popup", {
      template = "Link {{sourceName}}-{{targetName}} has {{count}} individuals associated with it."
      sk = sankey(test_data$data, test_data$steps, link_template = template)

      expect_equal(
        sk$x$linkPopupTemplate,
        template
      )
    })
  })
})
