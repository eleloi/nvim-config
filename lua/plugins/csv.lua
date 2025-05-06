-- A plugin to manage csv files, I only use for the colorized view and the
-- %ArrangeColumn command

return {
    "cameron-wags/rainbow_csv.nvim",
    config = true,
    ft = {
        "csv",
        "tsv",
        "csv_semicolon",
        "csv_whitespace",
        "csv_pipe",
        "rfc_csv",
        "rfc_semicolon",
    },
    cmd = {
        "RainbowDelim",
        "RainbowDelimSimple",
        "RainbowDelimQuoted",
        "RainbowMultiDelim",
    },
}
