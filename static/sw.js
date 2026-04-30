// Service Worker for offline functionality
// Bump CACHE_NAME whenever you ship a structural change you want propagated
// to repeat visitors immediately. The registration URL also carries a
// build-time `?v=` cache-buster (see baseof.html), so SW updates whenever
// the surrounding HTML rebuilds.
const CACHE_NAME = 'jetthoughts-v2';
const urlsToCache = ['/'];

self.addEventListener('install', (event) => {
  // Take over from old SW as soon as install completes - no two-tab limbo.
  self.skipWaiting();
  event.waitUntil(caches.open(CACHE_NAME).then(cache => cache.addAll(urlsToCache)));
});

self.addEventListener('activate', (event) => {
  // Drop any cache from a previous CACHE_NAME so stale assets don't survive
  // the version bump, and start controlling open clients immediately.
  event.waitUntil(
    caches.keys().then((keys) => {
      return Promise.all(
        keys.filter((key) => key !== CACHE_NAME).map((key) => caches.delete(key))
      );
    }).then(() => self.clients.claim())
  );
});

self.addEventListener('fetch', (event) => {
  const isNavigation = event.request.mode === 'navigate';

  if (isNavigation) {
    // Network-first for HTML so users see fresh pages on every visit.
    // Fall back to the cached shell only when the network is unavailable.
    event.respondWith(
      fetch(event.request)
        .then((response) => {
          if (response && response.status === 200 && response.type === 'basic') {
            const responseToCache = response.clone();
            caches.open(CACHE_NAME).then((cache) => cache.put(event.request, responseToCache));
          }
          return response;
        })
        .catch(() => caches.match(event.request).then((cached) => cached || caches.match('/')))
    );
    return;
  }

  // Cache-first for JS/CSS (immutable hashed filenames make this safe).
  event.respondWith(
    caches.match(event.request).then((response) => {
      if (response) {
        return response;
      }
      return fetch(event.request).then((response) => {
        if (!response || response.status !== 200 || response.type !== 'basic') {
          return response;
        }

        const url = new URL(event.request.url);
        if (url.pathname.match(/\.(js|css)$/)) {
          const responseToCache = response.clone();
          event.waitUntil(
            caches.open(CACHE_NAME).then((cache) => {
              return cache.put(event.request, responseToCache);
            })
          );
        }

        return response;
      });
    })
  );
});
