FROM rocker/geospatial:4.1.2

RUN install2.r --error \
    RPostgreSQL \
    RSelenium \
    rvest
    
# Clean up
RUN rm -rf /var/lib/apt/lists/*
RUN rm -r /tmp/downloaded_packages