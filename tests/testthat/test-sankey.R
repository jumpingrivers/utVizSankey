describe("The sankey function", {
  it("creates a sankey/htmlwidget object", {
    sk = sankey("some data")

    expect_s3_class(sk, "sankey")
    expect_s3_class(sk, "htmlwidget")
  })
})
