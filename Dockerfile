FROM r-base:4.3.2

COPY . /srv/app

RUN apt-get update && apt-get install -y libgit2-dev

RUN R -e 'install.packages("devtools")'
RUN R -e "devtools::install_deps(dependencies = TRUE)"

CMD ["R", "-e", "shiny::runApp('/srv/app', host = '0.0.0.0', port = 3838)"]


