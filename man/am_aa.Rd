% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/am_aa.R
\name{am_aa_pos}
\alias{am_aa_pos}
\alias{am_aa_pathogenicity}
\title{Common Amino Acid-level Transformations}
\usage{
am_aa_pos(tbl)

am_aa_pathogenicity(tbl)
}
\arguments{
\item{tbl}{a tibble, usually derived from
\code{am_data("aa_substitutions")}, `am_data("hg38"), etc. See
details.}
}
\value{
\code{am_aa_pos()} returns the original table with additional columns
\itemize{
\item \code{aa_pos}: the position of the protein variant,
as an \code{integer()}.
\item \code{aa_ref}: the single-character reference amino acid in the
protein variant.
\item \code{aa_alt}: the single-character alternate amino acid in the
protein variant.
}

\code{am_aa_pathogenicity()} returns a tibble with columns
\itemize{
\item \code{uniprot_id}, \code{aa_pos}, \code{aa_ref}: the UniProt id, and the
position and reference amino acid being summarized
\item \code{aa_pathogenicity_n}, \code{aa_pathogenicity_mean},
\code{aa_pathogenicity_median}, \code{aa_pathogenicity_min},
\code{aa_pathogenicity_max}: the number, average, median, minimum, and
maximum of the pathogenicity scores at each amino acid position.
\item \code{aa_pathogenicity_mode}: the modal \code{am_class} at the amino acid
position, as a factor. Tied mode is assigned to lower
pathogenicity.
}
}
\description{
\code{am_aa_pos()} separates \code{protein_variant} columns into
amino acide 'pos', 'ref', and 'alt' columns.

\code{am_aa_pathogenicity()} summarizes pathogenicity
scores at each protein amino acid position.
}
\details{
\code{tbl} is \code{collect()}ed before computation, so all rows must fit
into memory.

For \code{am_aa_pos()}, \code{tbl} must contain a column \code{protein_variant}
with entries in the form \code{"Q465H"}, as in the AlphaMissense data.

For \code{am_aa_pathogenicity()}, \code{tbl} must contain columns
\code{uniprot_id}, \code{protein_variant}, \code{am_pathogenicity} and
\code{am_class}. If \code{am_pos} and friends are not already calculated,
then \code{am_aa_pos()} is called.
}
\examples{

P35557 <-
    am_data("hg38") |>
    filter(uniprot_id \%in\% "P35557")

am_aa_pos(P35557)

am_aa_pos(P35557) |>
    select(
        uniprot_id, POS, REF, ALT, protein_variant,
        starts_with("aa_"), am_pathogenicity, am_class
    ) |>
    arrange(aa_pos)


am_aa_pathogenicity(P35557)

}
