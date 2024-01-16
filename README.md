# The Telephone Game

A web application written in Rails for administering and viewing The Telephone Game method of collaborative network art.

For more information about the project:
[http://transmission.satellitepress.org/VOLUME/001/ISSUE/004/telephone/](http://transmission.satellitepress.org/VOLUME/001/ISSUE/004/telephone/)

Or view the live tool now at:
[https://telephone.satellitecollective.org/](https://telephone.satellitecollective.org/)

Or read the New York Times coverage of the project:
[https://www.nytimes.com/2015/04/19/arts/design/telephone-an-international-arts-experiment-by-nathan-langston.html](https://www.nytimes.com/2015/04/19/arts/design/telephone-an-international-arts-experiment-by-nathan-langston.html)

Enjoy!

## Setup & Running Locally

Clone down the repo, install [Docker](https://hub.docker.com/editions/community/docker-ce-desktop-mac/) & run:

```bash
docker-compose build
docker-compose run --rm web /bin/sh -c 'bin/setup'
docker-compose up
```

Then navigate your browser to https://127.0.0.1:3000/ to see your site.
