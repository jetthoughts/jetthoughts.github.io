# Install

1. Change config.toml file acording to your settings
2. Change Google forms

## About

This is ported version of beaver builder wordpress website, that's why it has different css, js for every page.

Requirement was to port design exactly as is and I'm not very good at css, so here we go. That's why it has qudrillion of files from wordpress. Some of them are not needed.
After moving to more sane theme hopefully they will be deleted.

## Google forms

In `config.toml` change google forms input names and action

## How to find Google form input names and action

1. Open google form to fill out in a private window
2. Go to the developer console (ctr+shift+i) or (right mouse button, inspect element)
3. Go to the network tab
4. Set the operating mode to offline, if you do not want the test recording to be included in the results
5. Click send form
6. Check the request and copy values

![](google_forms_get_names.png)

![](google_forms_get_url.png)

## Google Forms Notification

You need to install and configure addon
<https://www.youtube.com/watch?v=FvZ2tM0m7AY>

## Pages

In this theme there 3 different types

1. Simple page type (privacy policy)
2. Custom page layout for `/clients/`, `/use-cases/`, `/carreers/`, `/services/` homepage, about.
3. Custom page types for single client, use-case, career, service.

## Styles

You can apply new custom css to main style file here:

`/themes/beaver/static/style.css`

## Data

`companies` are get from `data/companies.yaml` file
Technologies could be taken from `data/technologies.yaml` but beaver wordpress has custom layout (probably manullay created), so you can't just dump them as is because design will be different. After moving to sane theme feel free to use `data/technologies.yaml` for it. Look how companies are used and make similar.

## Adding new client/career/page/services

### Method 1

Go to `content/clients` and copy folder then rename it and change content and images accordingly

### Method 2

Using cli `hugo new content clients/new-client/index.md`

#### Note from developer

Beaver builder and nitro created a lot of css and js files. Also, it created css in the page, js in the page and every page has different css, js files. That's why I'm using awkward if else in header partial, footer partial instead of using baseof (don't want to complicate the code more, so custom css js will be in header and footer instead of adding them in each page layout).


## Populate Blog with Dev.to Posts

To download all new posts and their updates from dev.to need to run

```bash
bin/from_devto -f
```

## How to set custom urls for posts

1. Open `devto_urls_mapping.csv`
2. Change the URLs that you want to update (you should not change the first number in the line, this is the foreign key for the article on dev.to )
3. Save `devto_urls_mapping.csv`
4. Run `bin/from_devto -f`


## How create new post

1. Write post on dev.to under JetThoughts account. All of the following conditions must be met:
    - [ ] Post under JetThoughts LLC. (You can choose it in top left corner. To the right of the dev.to logo)
    - [ ] Set tags. Most relevant tags should be first. (2 first tags will be added to url)

2. Go to [Github Actions page](https://github.com/jetthoughts/jetthoughts.github.io/actions)
3. Click on "Sync all dev.to articles"
4. Open dropdown with "Run worflow" label and run it in master branch.

After the work flow is over, the article should appear on our blog and the canonical url on dev.to should be updated, it will point to the article on our blog.
