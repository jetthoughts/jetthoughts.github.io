---
dev_to_id: 2053767
title: Own Heroku Review Apps with GitHub Actions and Kamal 2
description: Continuous delivery is vital in modern software development. It ensures that code changes are...
created_at: '2024-10-23T14:23:22Z'
edited_at: '2024-11-25T15:31:50Z'
draft: false
tags:
- devops
- development
- automation
- heroku
canonical_url: https://jetthoughts.com/blog/own-heroku-review-apps-with-github-actions-kamal-2-devops-development/
cover_image: https://raw.githubusercontent.com/jetthoughts/jetthoughts.github.io/master/content/blog/own-heroku-review-apps-with-github-actions-kamal-2-devops-development/cover.jpeg
slug: own-heroku-review-apps-with-github-actions-kamal-2-devops-development
metatags:
  image: cover.jpeg
---
Continuous delivery is vital in modern software development. It ensures that code changes are released quickly and reliably. **Heroku Review Apps** help in this process by creating temporary environments for each pull request. This makes it easy to test changes before merging them into the main branch.

By automatically deploying code changes to a live environment, teams can catch issues early. This prevents bugs from reaching production and improves code quality. To learn more about how Heroku Review Apps prevent delivering bugs to production, check out our detailed post: [Heroku Reviews Apps Prevent Delivering Bugs on Production CI Startup](https://jetthoughts.com/blog/heroku-reviews-apps-prevent-delivering-bugs-on-production-ci-startup/).

However, Heroku Review Apps have limitations. They can be expensive and may not offer the flexibility some teams need. If you use GitHub, Kamal 2, and a VPS, you might want a similar workflow without the downsides. That's where our automated scripts come in.

## The Problem

Heroku Review Apps are useful but have limitations. They can be expensive and may not fit all needs. In our context, we have a limited number of servers and need to use them efficiently. If you use GitHub, Kamal 2, and a VPS, you might want a similar workflow. 

## Overview of the Solution

We will use GitHub Actions to automate server assignment and deployment of Review Apps. When a pull request (PR) is opened, synced, or reopened, a GitHub Action script assigns a server. It then deploys a review environment using Kamal 2.

For a detailed guide on setting up auto-deployment from GitHub Actions with Kamal 2, check out our previous post: [Automate Your Deployments with Kamal 2 and GitHub Actions](https://jetthoughts.com/blog/automate-your-deployments-with-kamal-2-github-actions-devops-development/).

### We'll divide the automation into three steps:

1. Assign a server to each PR.
2. Deploy the Review App.
3. Release the server when the PR is closed.

## Step 1: Assign a Server to Each PR

First, we assign a server to the PR. The `assign-host` job in our GitHub Actions workflow handles this:

```yaml
jobs:
  assign-host:
    runs-on: ubuntu-latest
    if: github.event.action != 'closed'
    outputs:
      host: ${{ steps.assign.outputs.host }}

    steps:
      - name: Checkout code
        uses: actions/checkout@v4

      - name: Set up Ruby
        uses: ruby/setup-ruby@v1
        with:
          ruby-version: 3.3.0
          bundler-cache: true

      - name: Assign review app host
        id: assign
        run: |
          host=$(bundle exec .github/bin/link_review_app)
          echo "host=$host" >> "$GITHUB_OUTPUT"
```

The `link_review_app` script is a Ruby script that interacts with the GitHub API. It assigns an available server to the PR. Here's how it works:

1. Get the list of open PRs.
1. Check which servers have already been assigned.
1. Find an available server from a predefined list (`REVIEW_HOSTS`).
1. Assign the server by adding a label (`Server: <host>`) to the PR.
1. Add a comment to notify the team.

> If no servers are available, it leaves an error comment on the PR.

Here's a simplified version of the `link_review_app` script:

```ruby
#!/usr/bin/env ruby

require "octokit"

repo = ENV["GITHUB_REPOSITORY"]
pr_number = ENV["GITHUB_PR_NUMBER"] ||
  (ENV["GITHUB_EVENT_PATH"] ? JSON.parse(File.read(ENV["GITHUB_EVENT_PATH"]))["number"] : nil)

client = Octokit::Client.new(access_token: ENV["GITHUB_TOKEN"])

pull_request = client.pull_request(repo, pr_number)

pre_assigned_label = pull_request.labels.map(&:name).find { |l| l.start_with?("Server: ") }
linked_host = pre_assigned_label&.sub("Server: ", "")
if linked_host
  puts linked_host
  exit 0
end

open_prs = client.pull_requests(repo, state: "open")
used_servers = open_prs.map do |pr|
  label = pr.labels.find { |l| l.name.start_with?("Server: ") }
  label&.name&.sub("Server: ", "")
end.compact

hosts = ENV["REVIEW_HOSTS"].to_s.split(",").map(&:strip).uniq
available_server = hosts.find { |host| !used_servers.include?(host) }

if available_server.nil?
  puts "No available servers."
  client.add_comment(repo, pr_number, "Error: No available servers.")
  exit 1
end

client.add_labels_to_an_issue(repo, pr_number, ["Server: #{available_server}"])
client.add_comment(repo, pr_number, "Linked to Review Server: #{available_server}")
puts available_server
```

## Step 2: Deploy the Review App

After assigning a server, we deploy the Review App. The `deploy` job does this:

```yaml
jobs:
  deploy:
    runs-on: ubuntu-latest
    needs: [assign-host]

    env:
      DOCKER_BUILDKIT: 1
      RAILS_ENV: production
      BUNDLE_WITHOUT: "default development test production profiling"
      BUNDLE_WITH: tools

    steps:
      - name: Checkout code
        uses: actions/checkout@v4

      - name: Set up Ruby
        uses: ruby/setup-ruby@v1
        with:
          ruby-version: 3.3.0
          bundler-cache: true

      - name: Setup SSH connection
        run: |
          mkdir -p ~/.ssh
          echo "$SSH_PRIVATE_KEY" > ~/.ssh/id_rsa
          chmod 600 ~/.ssh/id_rsa
          eval $(ssh-agent -s)
          ssh-add ~/.ssh/id_rsa
          ssh-keyscan -p 2222 159.69.198.60 >> ~/.ssh/known_hosts
        env:
          SSH_PRIVATE_KEY: ${{ secrets.SSH_PRIVATE_KEY }}

      - run: bin/kamal deploy -h  "${{ needs.assign-host.outputs.host }}"
        env:
          RAILS_MASTER_KEY: ${{ secrets.RAILS_PRODUCTION_MASTER_KEY }}
          KAMAL_REGISTRY_PASSWORD: ${{ secrets.GITHUB_TOKEN }}
          KAMAL_REGISTRY_USERNAME: ${{ github.actor }}
```

In this job: deploy the application using Kamal 2 on the assigned host from the previous job.

## Step 3: Release the Server

When a PR is closed, we release the server. The `release-host` job handles this:

```yaml
jobs:
  release-host:
    runs-on: ubuntu-latest
    if: github.event.action == 'closed'

    steps:
      - name: Checkout code
        uses: actions/checkout@v4

      - name: Set up Ruby
        uses: ruby/setup-ruby@v1
        with:
          ruby-version: 3.3.0
          bundler-cache: true

      - name: Release review app host
        run: bundle exec .github/bin/unlink_review_app
```

The `unlink_review_app` script removes the server label from the PR. This makes the server available for other PRs. Here's how it works:

1. Identify the server label associated with the PR.
1. Remove the label.
1. Add a comment to the PR indicating the server has been released.

Here's a simplified version of the `unlink_review_app` script:

```ruby
#!/usr/bin/env ruby

require "octokit"

repo = ENV["GITHUB_REPOSITORY"]
pr_number = ENV["GITHUB_PR_NUMBER"] ||
  (ENV["GITHUB_EVENT_PATH"] ? JSON.parse(File.read(ENV["GITHUB_EVENT_PATH"]))["number"] : nil)

client = Octokit::Client.new(access_token: ENV["GITHUB_TOKEN"])

pull_request = client.pull_request(repo, pr_number)

server_label = pull_request.labels.find { |l| l.name.start_with?("Server: ") }
if server_label
  client.remove_label(repo, pr_number, server_label.name)
  client.add_comment(repo, pr_number, "Removed server label: #{server_label.name}")
  puts "Removed server label: #{server_label.name} from PR ##{pr_number}"
end
```

## Handling Server Unavailability

Since we have a limited number of servers, there may be times when none are available. A more advanced solution would be to create servers on-demand using tools like Terraform. But for now, we'll stick with this simplest version.

If no servers are available:

1. Remove the `Server: <host>` label from other PRs that no longer need it.
1. Re-run the GitHub Action to link the current PR to the available server.

This manual step helps keep servers available.

## Conclusion

Using GitHub Actions and Kamal 2, we can automate deployment like Heroku Review Apps. While this is the simplest version, more advanced solutions can provision servers on-demand using tools like Terraform. This setup is scalable, cost-effective, and customizable. It integrates your GitHub workflows with your infrastructure.

Automation simplifies your workflow. It lets you focus on developing great features. **Try out these scripts and see how they can improve your development process.**

---


**Paul Keen** is an Open Source Contributor and a Chief Technology Officer at [JetThoughts](https://www.jetthoughts.com). Follow him on [LinkedIn](https://www.linkedin.com/in/paul-keen/) or [GitHub](https://github.com/pftg).
>  *If you enjoyed this story, we recommend reading our[ latest tech stories](https://jetthoughts.com).*