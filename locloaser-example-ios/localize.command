# Copyright © 2017 Denis Shurygin. All rights reserved.
# Licensed under the Apache License, Version 2.0

ARTIFACTS=(
        "ru.pocketbyte.locolaser:core:1.2.1"
        "ru.pocketbyte.locolaser:platform-mobile:1.2.1"
        "ru.pocketbyte.locolaser:source-googlesheet:1.2.1"
    )
CONFIG_FILE="localization_config.json"

TEMP_DIR="../DerivedData/LocoLaserTemp"
ARTIFACTS_DIR="$TEMP_DIR/artifacts"
REPOSITORY="https://bintray.com/pocketbyte/maven"

function loadArtifact() {
    local ARTIFACT=$1

    local artifact_parts=(${ARTIFACT//:/ })

    local GROUP=${artifact_parts[0]}
    local NAME=${artifact_parts[1]}
    local VERSION=${artifact_parts[2]}

    local GROUP_PATH=${GROUP//[.]//}

    local ARTIFACT_FILE="$ARTIFACTS_DIR/$NAME.jar"

    if [ -f $ARTIFACT_FILE ]
    then
        echo "Artifact $ARTIFACT already downloaded"
    else
        ARTIFACT_URL="$REPOSITORY/download_file?file_path=$GROUP_PATH/$NAME/$VERSION/$NAME-$VERSION.jar"
        echo "Loading: $ARTIFACT_URL"
        curl -L -o $ARTIFACT_FILE $ARTIFACT_URL
        if [ $? -eq 0 ]
        then
            echo "Artifact downloaded"
        else
            return $?
        fi
    fi
}

cd "`dirname \"$0\"`"
mkdir -p $ARTIFACTS_DIR/

# Check script modification
SCRIPT_DATE="$TEMP_DIR/script_date"
if [ -f $SCRIPT_DATE ]
then
    SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd -P )"
    if [ $SCRIPTPATH -nt $SCRIPT_DATE ]
    then
        echo "Script modified. Remove artifacts."
        rm -rf $ARTIFACTS_DIR/
        mkdir -p $ARTIFACTS_DIR/
    fi
fi

# Load artifacts
for artifact in ${ARTIFACTS[*]}
do
    loadArtifact $artifact
done

# Run jar's
jar_files=($ARTIFACTS_DIR/*.jar)
jar_files_str=$( IFS=$':'; echo "${jar_files[*]}" )

java -cp $jar_files_str ru.pocketbyte.locolaser.Main $CONFIG_FILE $1

# Save date of execution
echo "" > $SCRIPT_DATE
