'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"assets/AssetManifest.bin": "42f54aaaf8f6bd89dc43b612936ee5a4",
"assets/AssetManifest.bin.json": "ea5fb2c616880eaf274658dc3cd4e4cd",
"assets/AssetManifest.json": "f8faa62a417583a35e7bed3c02577078",
"assets/assets/fonts/Acidic-Regular.otf": "f63b17b681f1fc6482c0c7b2eb3d8a3f",
"assets/assets/fonts/Custom.ttf": "49b859532686341431124adabb761a3d",
"assets/assets/fonts/PPNeueMontreal-Regular.otf": "f366d0cc73854e67fc6790690668dcd2",
"assets/assets/images/model12.gif": "0872a87a4e570848013c726e227a9795",
"assets/assets/images/model8.gif": "7771f78634bbb46986911a7cd9881f2e",
"assets/assets/images/noise.gif": "b71fb95c36fca3a1840ae0c6eff86409",
"assets/assets/images/splash_background.png": "f53b1b04c6ba7e4a4c4e985904fff780",
"assets/assets/images/splash_logo.png": "f24cc82b04ac57b3fab1e0cb2c357f93",
"assets/assets/images/wave.json": "0c110d3cd77bbcb6720c330f53c8b1b1",
"assets/FontManifest.json": "c4efb21aec564d19f86370b6c7496f3d",
"assets/fonts/MaterialIcons-Regular.otf": "094ba959012f046b050a0f1bd69e9472",
"assets/NOTICES": "ac3f1fdc94c0a6e576e38abaf700f518",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "33b7d9392238c04c131b6ce224e13711",
"assets/packages/syncfusion_flutter_pdfviewer/assets/fonts/RobotoMono-Regular.ttf": "5b04fdfec4c8c36e8ca574e40b7148bb",
"assets/packages/syncfusion_flutter_pdfviewer/assets/icons/dark/highlight.png": "2aecc31aaa39ad43c978f209962a985c",
"assets/packages/syncfusion_flutter_pdfviewer/assets/icons/dark/squiggly.png": "68960bf4e16479abb83841e54e1ae6f4",
"assets/packages/syncfusion_flutter_pdfviewer/assets/icons/dark/strikethrough.png": "72e2d23b4cdd8a9e5e9cadadf0f05a3f",
"assets/packages/syncfusion_flutter_pdfviewer/assets/icons/dark/underline.png": "59886133294dd6587b0beeac054b2ca3",
"assets/packages/syncfusion_flutter_pdfviewer/assets/icons/light/highlight.png": "2fbda47037f7c99871891ca5e57e030b",
"assets/packages/syncfusion_flutter_pdfviewer/assets/icons/light/squiggly.png": "9894ce549037670d25d2c786036b810b",
"assets/packages/syncfusion_flutter_pdfviewer/assets/icons/light/strikethrough.png": "26f6729eee851adb4b598e3470e73983",
"assets/packages/syncfusion_flutter_pdfviewer/assets/icons/light/underline.png": "a98ff6a28215341f764f96d627a5d0f5",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"canvaskit/canvaskit.js": "86e461cf471c1640fd2b461ece4589df",
"canvaskit/canvaskit.js.symbols": "68eb703b9a609baef8ee0e413b442f33",
"canvaskit/canvaskit.wasm": "efeeba7dcc952dae57870d4df3111fad",
"canvaskit/chromium/canvaskit.js": "34beda9f39eb7d992d46125ca868dc61",
"canvaskit/chromium/canvaskit.js.symbols": "5a23598a2a8efd18ec3b60de5d28af8f",
"canvaskit/chromium/canvaskit.wasm": "64a386c87532ae52ae041d18a32a3635",
"canvaskit/skwasm.js": "f2ad9363618c5f62e813740099a80e63",
"canvaskit/skwasm.js.symbols": "80806576fa1056b43dd6d0b445b4b6f7",
"canvaskit/skwasm.wasm": "f0dfd99007f989368db17c9abeed5a49",
"canvaskit/skwasm_st.js": "d1326ceef381ad382ab492ba5d96f04d",
"canvaskit/skwasm_st.js.symbols": "c7e7aac7cd8b612defd62b43e3050bdd",
"canvaskit/skwasm_st.wasm": "56c3973560dfcbf28ce47cebe40f3206",
"favicon.ico": "384f06d594a7ceb20866bfa54359f2bd",
"favicon.png": "613303936a90f46d8b2ce63c377626b4",
"flutter.js": "76f08d47ff9f5715220992f993002504",
"flutter_bootstrap.js": "b1618e5178bb72f383e0757dbe906122",
"icons/apple-touch-icon.png": "fbfc95bb3bd9331d6d8bfac0c2865026",
"icons/icon-192-maskable.png": "884a84d1e153852559ed92e5c029ddc4",
"icons/icon-192.png": "1986fa5a1074b1e42137e4d8713a0e25",
"icons/icon-512-maskable.png": "4360bd9c880ccece37f2ebb61ece552b",
"icons/icon-512.png": "ab38bb892105c992d0f8a060c0a84791",
"index.html": "601af0aca175c1c4818fb8659f094c56",
"/": "601af0aca175c1c4818fb8659f094c56",
"main.dart.js": "6587a9c7370ff9693a8f4a023941b117",
"manifest.json": "67a982f3c92f175bc24eb4080b429476",
"splash/img/dark-1x.png": "f2819c9a2c5aae6edc3ec253c92be23e",
"splash/img/dark-2x.png": "ecec31d1d5d33594e780e123801ce0b7",
"splash/img/dark-3x.png": "4c10ce659dd02dbe1934c693ee4bbbf6",
"splash/img/dark-4x.png": "4f16b0da492319618e8db8c61e27bd85",
"splash/img/light-1x.png": "f2819c9a2c5aae6edc3ec253c92be23e",
"splash/img/light-2x.png": "ecec31d1d5d33594e780e123801ce0b7",
"splash/img/light-3x.png": "4c10ce659dd02dbe1934c693ee4bbbf6",
"splash/img/light-4x.png": "4f16b0da492319618e8db8c61e27bd85",
"splash/img/light-background.png": "f53b1b04c6ba7e4a4c4e985904fff780",
"version.json": "9ee2c79047a1a0939b6d97c8a23a653c"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
