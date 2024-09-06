# Install

1. Change `config.toml` file according to your settings
2. Change Google forms

## Google Forms Notification

You need to install and configure the addon
<https://www.youtube.com/watch?v=FvZ2tM0m7AY>

## Pages

In this theme, there 3 different types

1. Simple page type (privacy policy)
2. Custom page layout for `/clients/`, `/use-cases/`, `/carreers/`, `/services/` homepage, about.
3. Custom page types for single client, use-case, career, service.

## Styles

You can apply new custom css to main style file here:

`/themes/beaver/static/style.css`

## Data

`companies` get from `data/companies.yaml` file
Technologies could be taken from `data/technologies.yaml`, but Beaver wordpress has a custom layout (probably manually created), so you can't just dump them as is because the design will be different. After moving to a sane theme, feel free to use `data/technologies.yaml` for it. Look how companies are used and make similar.

## Adding new client/career/page/services

### Method 1

Go to `content/clients` and copy the folder then rename it and change content and images accordingly.

### Method 2

Using CLI `hugo new content clients/new-client/index.md`

#### Note from developer

Beaver Builder and Nitro created a lot of CSS and JS files. Also, it created CSS in the page, js in the page and every page has different css, js files. That's why I'm using awkward if else in header partial and footer partial instead of using base of (I don't want to complicate the code more, so custom CSS js will be in header and footer instead of adding them in each page layout).


## Populate Blog with Dev.to Posts

To download all new posts and their updates from `dev.to` need to run

```bash
bin/from_devto -f
```

## How to set custom URLs for posts

1. Open `devto_urls_mapping.csv`
2. Change the URLs that you want to update (you should not change the first number in the line, this is the foreign key for the article on dev.to )
3. Save `devto_urls_mapping.csv`
4. Run `bin/from_devto -f`


## How to create a new post

1. Write a post on `dev.to` under the JetThoughts account. All of the following conditions must be met:
    - [ ] Post under JetThoughts LLC. (You can choose it in the top left corner. To the right of the dev.to logo)
    - [ ] Set tags. Most relevant tags should be first. (2 first tags will be added to URL)

2. Go to [Github Actions page](https://github.com/jetthoughts/jetthoughts.github.io/actions)
3. Click on "Sync all dev.to articles"
4. Open the dropdown with the "Run worflow" label and run it in the master branch.

After the work flow is over, the article should appear on our blog and the canonical url on dev.to should be updated, it will point to the article on our blog.
