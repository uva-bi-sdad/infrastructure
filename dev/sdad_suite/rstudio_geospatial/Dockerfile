FROM rocker/geospatial:4.1.2

RUN apt-get update
RUN apt-get -y install libpoppler-cpp-dev libtesseract-dev libleptonica-dev tesseract-ocr-eng

RUN install2.r --error \
    RPostgreSQL \
    RSelenium \
    rvest \
    tigris \
    tidycensus \
    dataverse \
    pdftools \
    tesseract
    
CMD ["/init"]

