# diagram.py
from diagrams import Cluster, Diagram
from diagrams.aws.analytics import KinesisDataStreams
from diagrams.aws.security import KMS

with Diagram("Kinesis", show=False):
    KMS("Encryption Key")  >> KinesisDataStreams("Stream")
