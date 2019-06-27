# ElevioArticlesApi
Simple articles api using Elixir for app.elev.io

## Install

- Create ``.env`` file with ``API_KEY`` and ``TOKEN`` variables
- ``make``
- ``docker-compose up``

## Usage

``http://localhost:8881/articles`` - All articles, args: ``page_num``, ``page_size``, ``keyword``



``http://localhost:8881/articles/:id`` - Concrete article