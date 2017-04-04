# Copyright © 2017 Denis Shurygin. All rights reserved.
# Licensed under the Apache License, Version 2.0

GROUP="ru/pocketbyte/locolaser"
ARTIFACT="locolaser-mobile-googlesheet"
VERSION="1.1.0"
CONFIG_FILE="localization_config.json"

cd "`dirname \"$0\"`"

ARTIFACTS_DIR="../DerivedData/LocoLaserTemp/artifacts/$GROUP/"
mkdir -p $ARTIFACTS_DIR

ARTIFACT_FILE="$ARTIFACTS_DIR$ARTIFACT-$VERSION.jar"
if [ -f $ARTIFACT_FILE ]
then
    echo "Artifact already downloaded"
else
    ARTIFACT_URL="https://bintray.com/pocketbyte/maven/download_file?file_path=$GROUP/$ARTIFACT/$VERSION/$ARTIFACT-$VERSION.jar"
    echo "Loading: $ARTIFACT_URL"
    curl -L -o $ARTIFACT_FILE $ARTIFACT_URL
    if [ $? -eq 0 ]
    then
        echo "Artifact downloaded"
    else
        exit $?
    fi
fi

java -jar $ARTIFACT_FILE $CONFIG_FILE
