# Blog

A simple static site generator to convert my articles from markdown to html.

## Development

Install the deps, run the initial build and start the watcher.
```
mix deps.get
mix build
./watcher.sh
```

Then, in another terminal, fire up a python server
```
cd output
python3 -m http.server 8000
```

