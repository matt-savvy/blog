while inotifywait -q --recursive --event modify --exclude "build|data|.git|logfile|watcher.sh" .; do
    mix build
done
