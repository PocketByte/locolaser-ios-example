ARTIFACT="locolaser-mobile-googlesheet"
VERSION="1.0.0"
CONFIG_FILE="localization_config.json"

cd "`dirname \"$0\"`"

ARTIFACTS_DIR="../DerivedData/LocoLaserTemp/artifacts/"
mkdir -p $ARTIFACTS_DIR

ARTIFACT_FILE="$ARTIFACTS_DIR$ARTIFACT-$VERSION.jar"
if [ -f $ARTIFACT_FILE ]
then
    echo "Artifact already downloaded"
else
    ARTIFACT_URL="http://pocketbyte.ru/artifacts/locolaser/$ARTIFACT-$VERSION.jar"
    curl -o $ARTIFACT_FILE $ARTIFACT_URL
    if [ $? -eq 0 ]
    then
        echo "Artifact downloaded"
    else
        exit $?
    fi
fi

java -jar $ARTIFACT_FILE $CONFIG_FILE --force
