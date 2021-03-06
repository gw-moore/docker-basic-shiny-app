FROM r-base:3.5.0

# Update and install
RUN apt-get update && apt-get install -y \
    sudo \
    gdebi-core \
    pandoc \
    pandoc-citeproc \
    libcurl4-gnutls-dev \
    libcairo2-dev \
    libxt-dev \
    wget

# Download and install shiny server
RUN wget --no-verbose https://download3.rstudio.org/ubuntu-14.04/x86_64/VERSION -O "version.txt" && \
    VERSION=$(cat version.txt)  && \
    wget --no-verbose "https://download3.rstudio.org/ubuntu-14.04/x86_64/shiny-server-$VERSION-amd64.deb" -O ss-latest.deb && \
    gdebi -n ss-latest.deb && \
    rm -f version.txt ss-latest.deb && \
    . /etc/environment && \
    R -e "install.packages(c('shiny', 'rmarkdown', 'shinydashboard', 'ggplot2', 'dplyr'), dependencies=TRUE, repos='http://cran.rstudio.com/')" && \
    cp -R /usr/local/lib/R/site-library/shiny/examples/* /srv/shiny-server/

# Expose port 
EXPOSE 3838

# Copy config to the image
COPY shiny-server.sh /usr/bin/shiny-server.sh

# Make all files in /bin excuteable
RUN ["chmod", "+x", "/usr/bin/shiny-server.sh"]

# Copy the app to the image
COPY app /srv/shiny-server/

# Make all app files readable
RUN chmod -R +r /srv/shiny-server/

# Run shiny server
CMD ["/usr/bin/shiny-server.sh"]

