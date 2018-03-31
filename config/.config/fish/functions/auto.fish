function auto
  while true
    inotifywait -e close_write,moved_to,create .
    eval $argv
  end
end