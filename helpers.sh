enable_extension() {
    true
}
add_packages_to_image() {
    true
}
display_alert() {
    echo $*
}

pushd () {
    command pushd "$@" > /dev/null
}

popd () {
    command popd "$@" > /dev/null
}

