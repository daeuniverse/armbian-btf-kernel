source "generate_matrix_helpers.sh"

echo "include:"
ls --format single-column config/kernel/ | while read -r fname; do
    # Extract required info.
    BRANCH=$(echo $fname | cut -d. -f1 | rev | cut -d- -f1 | rev )
    boardfamily=${fname##linux-}
    boardfamily=${boardfamily%%-"$BRANCH".*}

    boardname=""
    while read -r boardfname; do
        BOARD=${boardfname%%.*}
        LINUXCONFIG=""
        source "$boardfname"
        # [[ $boardfamily = rockchip64 ]] && echo "YES", "$boardfname", "$BOARDFAMILY" >> debug.log
        LINUXFAMILY="$BOARDFAMILY"
        echo "$KERNEL_TARGET" | grep -q "$BRANCH" || continue
        pushd config/sources
        source families/"$BOARDFAMILY".conf > /dev/null
        popd
        # [[ $boardfamily = rockchip64 ]] && [[ ${boardfname##*/} = clockworkpi-a06.conf ]] && echo "$LINUXCONFIG $BRANCH $LINUXFAMILY" >> debug.log
        [[ -z $LINUXCONFIG ]] && LINUXCONFIG="linux-${LINUXFAMILY}-${BRANCH}"
        # [[ $boardfamily = rockchip64 ]] && [[ ${boardfname##*/} = clockworkpi-a06.conf ]] && echo $fname "$LINUXCONFIG".config >> debug.log
        [[ "$fname" = "$LINUXCONFIG".config ]] && boardname=$BOARD && break
    done <<< $(grep -ril 'config/boards/' -e 'BOARDFAMILY=')
    [ -z "$boardname" ] && >&2 echo "cannot find board with: $boardfamily $BRANCH" && continue
    echo "  - boardfamily: ""$boardfamily"
    echo "    branch: ""$BRANCH"
    echo "    representative: ""$boardname"
done

