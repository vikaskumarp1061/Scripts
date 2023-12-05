TIMESTAMP=$(date "+%Y-%m-%d_%H-%M-%S")
CSV_FILENAME="cpu_utilization_${TIMESTAMP}.csv"

START_TIME=$(date -u -d "15 minutes ago" "+%Y-%m-%dT%H:%M:%S")
END_TIME=$(date -u "+%Y-%m-%dT%H:%M:%S")
aws cloudwatch get-metric-statistics \
--namespace AWS/EC2 \
--metric-name CPUUtilization \
--dimensions Name=InstanceId,Value=i-06fcb68e5ccbd4369 \
--statistics Average \
--start-time "$START_TIME" \
--end-time "$END_TIME" \
--period 60 \
--region us-east-1 > /home/biswojit/Downloads/cpu-utilization/$CSV_FILENAME

S3_BUCKET="s3://cpu-utilization-ec2"
LOCAL_DIRECTORY="/home/biswojit/Downloads/cpu-utilization"

aws s3 sync $LOCAL_DIRECTORY $S3_BUCKET
