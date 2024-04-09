while inotifywait -q --recursive --event modify --include "posts|lib|assets" .; do
    mix build
done
