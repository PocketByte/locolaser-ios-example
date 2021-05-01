# Copyright © 2017 Denis Shurygin. All rights reserved.
# Licensed under the Apache License, Version 2.0

ARTIFACTS=(
        "ru.pocketbyte.locolaser:core:2.1.0"
        "ru.pocketbyte.locolaser:resource-mobile:2.1.0"
        "ru.pocketbyte.locolaser:resource-googlesheet:2.1.0"
    )
CONFIG_FILE="localization_config.json"

TEMP_DIR="../DerivedData/LocoLaserTemp"
ARTIFACTS_DIR="$TEMP_DIR/artifacts"
REPOSITORY="https://repo1.maven.org/maven2"

function artifactFile() {
    local ARTIFACT=$1

    local artifact_parts=(${ARTIFACT//:/ })

    local GROUP=${artifact_parts[0]}
    local NAME=${artifact_parts[1]}
    local VERSION=${artifact_parts[2]}
    
    echo "$ARTIFACTS_DIR/$NAME-$VERSION.jar"
}

function loadArtifact() {
    local ARTIFACT=$1
    local ARTIFACT_FILE=$( artifactFile $ARTIFACT )

    if [ -f $ARTIFACT_FILE ]
    then
        echo "Artifact $ARTIFACT already downloaded"
    else
        local artifact_parts=(${ARTIFACT//:/ })

        local GROUP=${artifact_parts[0]}
        local NAME=${artifact_parts[1]}
        local VERSION=${artifact_parts[2]}

        local GROUP_PATH=${GROUP//[.]//}
    
        ARTIFACT_URL="$REPOSITORY/$GROUP_PATH/$NAME/$VERSION/$NAME-$VERSION.jar"
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
    SCRIPTPATH="${0}"
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
jar_files=()
for artifact in ${ARTIFACTS[*]}
do
    jar_files+=( $( artifactFile $artifact ) )
done

jar_files_str=$( IFS=$':'; echo "${jar_files[*]}" )

java -cp $jar_files_str ru.pocketbyte.locolaser.Main $CONFIG_FILE $1

# Save date of execution
echo "" > $SCRIPT_DATE
