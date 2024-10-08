% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/waterDepth.R
\name{waterDepth}
\alias{waterDepth}
\title{Function to compute water depths \code{SpatRaster} for characteristic
water levels or selected dates}
\usage{
waterDepth(x, value = NULL, df = NULL, filename = "", ...)
}
\arguments{
\item{x}{has to by type \code{SpatRaster} and has to include both input
raster layers \code{csa} (cross section areas) and \code{dem} (digital
elevation model). To compute water levels along the River Elbe \code{x}
has to be in the coordinate reference system
\href{https://spatialreference.org/ref/epsg/25833/}{ETRS 1989 UTM 33N},
for River Rhine and the estuaries in
\href{https://spatialreference.org/ref/epsg/25832/}{ETRS 1989 UTM 32N}.
Other coordinate reference systems are not permitted.}

\item{value}{an optional value of type \code{c("POSIXct", "POSIXt")},
\code{Date} or \code{character}. For \code{c("POSIXct", "POSIXt")} or
\code{Date} values \code{\link[hyd1d]{waterLevel}}- or
\code{\link[hyd1d]{waterLevelPegelonline}}-function are used internally
for the water level computation. For \code{character} values
\code{\link[hyd1d]{waterLevelFlood2}} or
\code{\link[hyd1d]{waterLevelFlys3}} are used internally. Commonly
available \code{character} values are \code{c("MThw", "MTnw", "HThw",
  "NTnw", "HHW", "NNW", "MNW", "MW", "MHW")} or a column supplied in
\code{df}.}

\item{df}{an optional object of type \code{data.frame}, which must contain
the columns \code{gauging_station}, \code{river}, \code{longitude},
\code{latitude}, \code{km_csa}, \code{pnp} and finally a water level column
named in \code{value}.}

\item{filename}{supplies an optional output filename and has to be type
\code{character}.}

\item{\dots}{additional arguments as for \code{\link[terra]{writeRaster}}.}
}
\value{
\code{SpatRaster} object with a \code{numeric} water depth.
}
\description{
Computes water depths for characteristic water levels or dates
for the active floodplains along the German federal waterways Elbe, Rhine
and the North Sea estuaries based on 1d water levels computed by
\code{\link[hyd1d]{waterLevel}}, \code{\link[hyd1d]{waterLevelPegelonline}},
\code{\link[hyd1d]{waterLevelFlood2}} or
\code{\link[hyd1d]{waterLevelFlys3}} provided by package \pkg{hyd1d}.
}
\details{
For the characteristic water level provided in \code{value} (and
\code{df}) \code{waterDepth()} computes a 1d water
level using \code{\link[hyd1d]{waterLevelFlood2}} along the requested river
section. This 1d water level is transfered to a \code{wl} (water level)
raster layer, which is in fact a copy of the \code{csa} (cross section
areas) layer, and then compared to the \code{dem} (digital elevation model)
layer. Where the \code{wl} layer is higher than the \code{dem}, the
resulting flood extent layer is set to 1.
}
\examples{
\donttest{
  options("hydflood.datadir" = tempdir())
  library(hydflood)
  
  # import the raster data and create a raster stack
  c <- st_crs("EPSG:25833")
  e <- ext(309000, 310000, 5749000, 5750000)
  x <- hydSpatRaster(ext = e, crs = c)
  
  # compute the water depth
  depth <- waterDepth(x = x, value = "MQ")
  
  # plot the product
  plot(depth)
}

}
\seealso{
\code{\link[hyd1d]{waterLevel}},
\code{\link[hyd1d]{waterLevelPegelonline}},
\code{\link[hyd1d]{waterLevelFlood2}},
\code{\link[hyd1d]{waterLevelFlys3}},
\code{\link[terra]{writeRaster}}, \code{\link[terra]{terraOptions}}
}
