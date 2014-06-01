# ------------------------------------------------------------------------------
# Create a data URI from a file
# ------------------------------------------------------------------------------

pixmap_datauri() {

    echo "→ Running DataURI Generator"

    local mimeType=""

    if [ -f "$1" ]; then

        mimeType=$(file -b --mime-type "$1")

        if [[ $mimeType == text/* ]]; then

            mimeType="$mimeType;charset=utf-8"

        fi

        printf "data:%s;base64,%s" \
                    "$mimeType" \
                    "$(openssl base64 -in "$1" | tr -d "\n" | pbcopy)"

    else

        echo "'$1' is not a file."

    fi

}
