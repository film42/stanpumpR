FROM r-base:4.3.2

RUN apt-get update && apt-get install -y \
    build-essential \
    libcurl4-openssl-dev \
    libfontconfig1-dev \
    libfreetype6-dev \
    libfribidi-dev \
    libgit2-dev \
    libharfbuzz-dev \
    libjpeg-dev \
    libcairo2-dev \
    libpng-dev \
    libssl-dev \
    libtiff5-dev \
    libxml2-dev \
    libzmq3-dev \
    libnlopt-dev \
    openjdk-17-jdk \
    libv8-dev

RUN R -e 'install.packages("devtools")'

WORKDIR /src/app
COPY . .

RUN cp config.yml.sample config.yml

RUN R -e "devtools::install_deps(dependencies = TRUE)"
RUN R CMD javareconf
RUN R -e "devtools::install_deps(dependencies = TRUE)"


CMD ["R", "-e", "shiny::runApp(host = '0.0.0.0', port = 3838)"]
