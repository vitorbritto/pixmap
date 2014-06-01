# ------------------------------------------------------------------------------
# Generate a Sprite Map
# ------------------------------------------------------------------------------

# Based ond: http://jaymz.eu/blog/2010/05/building-css-sprites-with-bash-imagemagick/

pixmap_sprite() {

    echo "→ Running Sprite Generator"

    # uses imagemagick to stich together all images in a folder and
    # then writes a css file with the correct offsets along with a
    # test html page for verification that its all good

    if [ $# -gt 0 ] then

        if [ "$4" ] then
            EXT="."$4; # the extension to iterate over for input files
        else
            EXT=".gif"; # the extension to iterate over for input files
        fi

        NAME=$2; # output will be placed in a folder named this

        if [ "$3" ] then
            CLASSNAME=$3"-sprite";
        else
            CLASSNAME=$2"-sprite";
        fi

        CSS="$NAME/$CLASSNAME.css";
        HTML="$NAME/test.html";

        rm -fr $NAME;
        mkdir $NAME;
        touch $CSS $HTML;

        echo "Generating sprite file...";
        convert *$EXT -append $NAME/$CLASSNAME$EXT;
        echo "Sprite complete! - Creating CSS & test output...";

        echo -e "<!doctype html>\n<html>\n<head>\n\t<link rel=\"stylesheet\" href=\"`basename $CSS`\" />\n</head>\n<body>\n\t<h1>Sprite test page</h1>\n" >> $HTML

        echo -e ".$CLASSNAME {\n\tbackground:url('$CLASSNAME$EXT') no-repeat top left; display:inline-block;\n}" >> $CSS;
        COUNTER=0;
        OFFSET=0;
        for FILE in *$EXT do
            WIDTH=`identify -format "%[fx:w]" "$FILE"`;
            HEIGHT=`identify -format "%[fx:h]" "$FILE"`;
            IDNAME=`basename "$FILE" $EXT`;
            CLEAN=${IDNAME// /-}
            echo ".$CLASSNAME#$CLEAN {" >> $CSS;
            echo -e "\tbackground-position:0 -${OFFSET}px;" >> $CSS;
            echo -e "\twidth: ${WIDTH}px;" >> $CSS;
            echo -e "\theight: ${HEIGHT}px;\n}" >> $CSS;

            echo -e "<a href=\"#\" class=\"$CLASSNAME\" id=\"$CLEAN\"></a>\n" >> $HTML;

            let OFFSET+=$HEIGHT;
            let COUNTER+=1;
            echo -e "\t#$COUNTER done";
        done

        echo -e "<h2>Full sprite:</h2>\n<img src=\"$CLASSNAME$EXT\" />" >> $HTML;
        echo -e "</body>\n</html>" >> $HTML;

        echo -e "\nComplete! - $COUNTER sprites created, CSS written & test page output.";

    else

        echo -e "There should be at least 2 arguments!\n\tpixmap.sh sprite [output] [name] [extension]"

    fi

}
