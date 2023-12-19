while inotifywait -q --recursive --event modify --exclude "build|output|.git|watcher.sh" .; do
    mix build
done
