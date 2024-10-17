echo "== [BASEFLUE made by Minhyeok Park] =="

set -o pipefail
set -e

echo "-- [Super dir] --"
chmod a+rwx $SUPER_DIR
echo $SUPER_DIR

echo "-- [config.conf] --"
base64 -d <<< $CONFIG > /config.conf
cat /config.conf

echo "\n-- [parsers.conf] --"
base64 -d <<< $PARSERS > /parsers.conf
cat /parsers.conf

echo "\n-- [Load FAGATE METADATA] --"
export TASK_ARN=$(curl "$ECS_CONTAINER_METADATA_URI_V4/task" | jq -r ".TaskARN")
export TASK_ID=$(echo "$TASK_ARN" | awk -F/ '{ print $NF }')

echo "TASK_ARN=$TASK_ARN"
echo "TASK_ID=$TASK_ID"

echo "-- [start original entrypoint.sh] ---"
