echo "include:"
ls --format single-column config/kernel/ | while read -r fname; do
    # Extract required info.
    branch=$(echo $fname | cut -d. -f1 | rev | cut -d- -f1 | rev )
    boardfamily=${fname##linux-}
    boardfamily=${boardfamily%%-"$branch".*}

    boardname=""
    while read -r boardfname; do
        (grep "KERNEL_TARGET=" $boardfname | grep -q $branch) && \
            boardname=$(basename $boardfname | cut -d. -f1) && \
            break
    done <<< $(grep -ril 'config/boards/' -e 'BOARDFAMILY="*'"$boardfamily")
    [ -z "$boardname" ] && >&2 echo "cannot find board with: $boardfamily $branch" && continue
    echo "  - boardfamily: ""$boardfamily"
    echo "    branch: ""$branch"
    echo "    representative: ""$boardname"
done

