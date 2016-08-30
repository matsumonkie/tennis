(
  declare -i p
  trap 'kill "$p"' EXIT
  while true; do
    clear
    stack exec api-exe & p=$!
    inotifywait -q -e create .stack-work/install/*/*/*/bin/
    sleep 1
    kill "$p"
  done
)
