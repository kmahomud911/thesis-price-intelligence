-- V2: price_events hypertable — skeleton, columns evolve after Week 2 EDA
CREATE TABLE IF NOT EXISTS price_events (
                                            id          BIGSERIAL,
                                            product_id  TEXT             NOT NULL,
                                            price       DOUBLE PRECISION NOT NULL,
                                            scraped_at  TIMESTAMPTZ      NOT NULL,
                                            PRIMARY KEY (id, scraped_at)
    );

SELECT create_hypertable(
               'price_events',
               'scraped_at',
               chunk_time_interval => INTERVAL '7 days',
               if_not_exists => TRUE
       );

CREATE INDEX IF NOT EXISTS idx_price_events_product_id
    ON price_events (product_id, scraped_at DESC);