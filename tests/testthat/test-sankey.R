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

  it("contains a 'data' entry", {
    sk = sankey(test_data$data, test_data$steps)

    expect_true("data" %in% names(sk$x))
  })

  it("has a 'data' entry that is the 'steps'-defined subset of 'data'", {
    sk = sankey(test_data$data, test_data$steps)

    expect_equal(sk$x$data, test_data$data[test_data$steps])
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
