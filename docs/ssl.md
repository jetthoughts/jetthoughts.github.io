Github Pages won't renew the SSL certificate for your site if the DNS entries are proxied (orange-clouded). You have a few options:

Unproxy (grey-cloud) the DNS entries permanently

Unproxy (grey-cloud) the DNS entries temporarily, verify that Github Pages has renewed the SSL certificate, then re-proxy the DNS entries... this will have to be repeated every 3 months

Migrate to Cloudflare Pages, you'll still manage the site via the Github repo but it'll be deployed directly on Cloudflare's servers

Use SSL mode "Full" instead of "Full/Strict" so that Cloudflare won't complain about the expired certificate. Not great from a security perspective. This can be set either globally for the domain or for a specific hostname (such as only the apex domain or only a subdomain) using a Configuration Rule. Note, this does require that Github Pages has generated a SSL certificate at least once; if "Full" (non-strict) doesn't work, grey-cloud your DNS entries temporarily until Github Pages has generated an SSL certificate, then you can re-proxy. The certificate will expire in 3 months and will not be renewed but if you're using "Full" (non-strict) Cloudflare will not complain about the expired certificate.
