function extract_log() {
for i in "$1"/*
do
  if [ -e "$i" ]
    then
        ndir="n"
        ndir+="$i"
        head --lines 95 "$i" > "$ndir"
        grep -E "initial|reflect|contract|expand|shrink|Optimization|approximation" "$i" >> "$ndir"
        if [ $(grep -c "Hábrók Cluster" "$i") -eq 1 ]
          then
            tail --lines 50 "$i" >> "$ndir"
          fi
    fi
done
}
