package com.thesis.ingestion.config;

import org.apache.kafka.clients.admin.NewTopic;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.kafka.config.TopicBuilder;

@Configuration
public class KafkaTopicConfig {

    // 6 partitions — keyed by productId
    @Bean
    public NewTopic priceEvents() {
        return TopicBuilder.name("price-events")
                .partitions(6)
                .replicas(1)
                .build();
    }

    @Bean
    public NewTopic priceChangeEvents() {
        return TopicBuilder.name("price-change-events")
                .partitions(6)
                .replicas(1)
                .build();
    }

    @Bean
    public NewTopic causalEstimates() {
        return TopicBuilder.name("causal-estimates")
                .partitions(6)
                .replicas(1)
                .build();
    }

    @Bean
    public NewTopic forecastResults() {
        return TopicBuilder.name("forecast-results")
                .partitions(6)
                .replicas(1)
                .build();
    }

    @Bean
    public NewTopic pricingDecisions() {
        return TopicBuilder.name("pricing-decisions")
                .partitions(6)
                .replicas(1)
                .build();
    }

    // 1 partition — unkeyed
    @Bean
    public NewTopic auditLog() {
        return TopicBuilder.name("audit-log")
                .partitions(1)
                .replicas(1)
                .build();
    }

    @Bean
    public NewTopic dataQualityAlerts() {
        return TopicBuilder.name("data-quality-alerts")
                .partitions(1)
                .replicas(1)
                .build();
    }
}