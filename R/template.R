## `sql_template()` separates SQL snippets from R code. SQL snippets
## are in inst/sql. They are templated following the 'mustache'
## convention, and the template populated using the {whisker} package.

## @param name the name of the template file, without the '.sql'
##     extension, e.g., `'range_join'`.
##
## @param ... name-value paired used for template substitution
##     following the 'mustache' scheme as implemented by the {whisker}
##     package, e.g., `db_file_name = 'db file name'`.
##
#' @importFrom whisker whisker.render
sql_template <-
    function(name, ...)
{
    language_template("sql", name, ...)
}

js_template <-
    function(name, ...)
{
    language_template("js", name, ...)
}

language_template <-
    function(language, name, ...)
{
    file <- paste0(name, ".", language)
    path <- system.file(package = "AlphaMissenseR", language, file)
    lines <- readLines(path)
    template <- paste(lines, collapse = "\n")
    whisker.render(template, list(...))
}
