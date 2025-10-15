---
remote_url: https://dev.to/jetthoughts/optimizing-search-performance-with-elastic-searchs-profile-api-5fjl
source: dev_to
remote_id: 2166649
dev_to_id: 2166649
dev_to_url: https://dev.to/jetthoughts/optimizing-search-performance-with-elastic-searchs-profile-api-5fjl
title: Optimizing Search Performance with Elastic Search's Profile API
description: Learn how to optimize search performance using Elastic Search's Profile API, including tips on limiting fields and avoiding wildcard searches.
date: 2024-12-20
created_at: '2024-12-20T09:58:00Z'
edited_at: '2024-12-20T10:30:01Z'
draft: false
tags: []
canonical_url: https://jetthoughts.com/blog/optimizing-search-performance-with-elastic-searchs-profile-api/
cover_image: https://raw.githubusercontent.com/jetthoughts/jetthoughts.github.io/master/content/blog/optimizing-search-performance-with-elastic-searchs-profile-api/cover.jpeg
metatags:
  image: cover.jpeg
slug: optimizing-search-performance-with-elastic-searchs-profile-api
---
Recently, a production application faced significant delays in query times, with some searches taking up to 60 seconds. The application utilizes Elastic Search for customer searches, but as the database has grown over the years, the performance has suffered. This article explores how the Profile API in Elastic Search can be leveraged to diagnose and improve query performance.

### Key Takeaways

*   Elastic Search's Profile API provides detailed insights into query performance.
*   Limiting the number of fields in a query can significantly reduce search times.
*   Avoiding wildcard searches can enhance query efficiency.

### Understanding the Problem

The initial query used for searching customer data was written a decade ago and was designed to search across all fields in the customer index. As the number of documents increased, the time taken to execute these queries also grew, leading to frustrating delays for users.

The original query structure was as follows:

    {
      "query": {
        "bool": {
          "must": [
            {
              "query_string": {
                "query": "Ryan*"
              }
            }
          ],
          "filter": [
            {
              "bool": {
                "must": [
                  {
                    "terms": {
                      "merchant_id": [2]
                    }
                  }
                ]
              }
            }
          ]
        }
      }
    }
    

### Utilizing the Profile API

To diagnose the slow query, the Profile API was employed by adding `profile: true` to the query. This modification allowed for a detailed breakdown of the query's execution, revealing how long each part took to process. The output indicated that the query was searching through an excessive number of fields, which contributed to the slowdown.

### Optimizing the Query

To enhance performance, the number of searchable fields was limited. The revised query focused only on the fields relevant to the user interface, such as first name, last name, and email. The updated query structure looked like this:

    {
      "profile": true,
      "query": {
        "bool": {
          "must": [
            {
              "query_string": {
                "query": "Ryan*",
                "fields": [
                  "first_name",
                  "last_name",
                  "email",
                  "reference",
                  "card_token",
                  "card_number",
                  "public_id"
                ]
              }
            }
          ],
          "filter": [
            {
              "bool": {
                "must": [
                  {
                    "terms": {
                      "merchant_id": [2]
                    }
                  }
                ]
              }
            }
          ]
        }
      }
    }
    

This change resulted in a dramatic reduction in query time, from several seconds to just a few milliseconds.

### Further Improvements

The next step was to evaluate the necessity of using wildcard searches. By removing the wildcard from the query, the performance improved even further. The new query structure was:

    {
      "profile": true,
      "query": {
        "bool": {
          "must": [
            {
              "query_string": {
                "query": "Ryan",
                "fields": [
                  "first_name",
                  "last_name",
                  "email",
                  "reference",
                  "card_token",
                  "card_number",
                  "public_id"
                ]
              }
            }
          ],
          "filter": [
            {
              "bool": {
                "must": [
                  {
                    "terms": {
                      "merchant_id": [2]
                    }
                  }
                ]
              }
            }
          ]
        }
      }
    }
    

This adjustment led to query execution times in the milliseconds range, showcasing the efficiency of Elastic Search when configured correctly.

### Conclusion

The experience highlighted the importance of using the Profile API for diagnosing slow queries in Elastic Search. By limiting the fields searched and avoiding wildcard queries, significant improvements in performance were achieved. This case serves as a valuable lesson for developers looking to optimize their search functionalities in large databases.
