FROM rocker/geospatial:4.1.2

RUN install2.r --error \
    RPostgreSQL \
    RSelenium \
    rvest
    
CMD ["/init"]