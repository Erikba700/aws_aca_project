resource "aws_dynamodb_table" "shortened_urls" {
  name           = "ShortenedURLs"
  billing_mode   = "PAY_PER_REQUEST"  # Use On-Demand capacity for minimal usage
  hash_key       = "short_url"        # Partition Key

  attribute {
    name = "short_url"
    type = "S"  # String type for the partition key
  }

  attribute {
    name = "original_url"
    type = "S"  # String type for the sort key (if needed)
  }

  attribute {
    name = "usage_count"
    type = "N"  # Number type for the GSI
  }

  # Provision the GSI for `usage_count`
  global_secondary_index {
    name               = "UsageCountIndex"
    hash_key           = "usage_count"
    projection_type    = "ALL"  # Project all attributes to the GSI
    write_capacity     = 1      # Optional: Adjust for the write throughput if necessary
    read_capacity      = 1      # Optional: Adjust for the read throughput if necessary
  }
    global_secondary_index {
    name               = "OriginalLink"
    hash_key           = "original_url"
    projection_type    = "ALL"  # Project all attributes to the GSI
    write_capacity     = 1      # Optional: Adjust for the write throughput if necessary
    read_capacity      = 1      # Optional: Adjust for the read throughput if necessary
  }

  # Optional: Set TTL (Time-to-Live) for expired URLs
  ttl {
    attribute_name = "expiration_time"
    enabled        = true
  }
}

# Output the DynamoDB table name
output "dynamodb_table_name" {
  value = aws_dynamodb_table.shortened_urls.name
}
