# Blog

A simple static site generator to convert my articles from markdown to html.

Create a new post using ./new_post.sh
```
./new_post.sh A day in the life
```

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


### Running GHA Locally

```
nix-shell -p act
ACTIONS_RUNTIME_URL=http://host.docker.internal:4322/ act --artifact-server-addr "[::0]" --artifact-server-port 4322 --artifact-server-path out
```
