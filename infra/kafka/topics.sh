#!/bin/bash
# Thesis Kafka Topic Initialization
# All topics partitioned by productId (6 partitions) except audit-log and data-quality-alerts

BOOTSTRAP=localhost:9092

kafka-topics --bootstrap-server $BOOTSTRAP --create --if-not-exists --topic price-events              --partitions 6 --replication-factor 1
kafka-topics --bootstrap-server $BOOTSTRAP --create --if-not-exists --topic price-change-events       --partitions 6 --replication-factor 1
kafka-topics --bootstrap-server $BOOTSTRAP --create --if-not-exists --topic causal-estimates          --partitions 6 --replication-factor 1
kafka-topics --bootstrap-server $BOOTSTRAP --create --if-not-exists --topic forecast-results          --partitions 6 --replication-factor 1
kafka-topics --bootstrap-server $BOOTSTRAP --create --if-not-exists --topic pricing-decisions         --partitions 6 --replication-factor 1
kafka-topics --bootstrap-server $BOOTSTRAP --create --if-not-exists --topic audit-log                 --partitions 1 --replication-factor 1
kafka-topics --bootstrap-server $BOOTSTRAP --create --if-not-exists --topic data-quality-alerts       --partitions 1 --replication-factor 1

echo "All topics created"
kafka-topics --bootstrap-server $BOOTSTRAP --list
