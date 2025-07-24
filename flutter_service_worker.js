'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"assets/AssetManifest.bin": "fff3b96492dda5abe121479f8790fa1f",
"assets/AssetManifest.bin.json": "692c73183cc6309303d372ccfdee107d",
"assets/AssetManifest.json": "e8799c5e77075b1009443b327f6201e4",
"assets/assets/fonts/Acidic-Regular.otf": "f63b17b681f1fc6482c0c7b2eb3d8a3f",
"assets/assets/fonts/PPNeueMontreal-Regular.otf": "f366d0cc73854e67fc6790690668dcd2",
"assets/assets/images/banners/audio_resumer_banner.png": "86d18c189a9b29c8b6fcd7aa67409606",
"assets/assets/images/banners/concentrated_banner.png": "8d46cab8e3686f68e10ec0f3c1cbb255",
"assets/assets/images/banners/draw_over_it_banner.png": "5c6277f2bebbb48bf4bd25a63d45f28b",
"assets/assets/images/banners/events_jo_backend_banner.jpg": "057693c23aa4c78493a7d5735dc1c421",
"assets/assets/images/banners/events_jo_banner.PNG": "95ccb32dfce10303ac5575bfce22698e",
"assets/assets/images/banners/portfolio_banner.png": "5bc9759c0a8bbdec1117033fe3ed81b3",
"assets/assets/images/banners/rapid_rounds_banner.png": "422c1c105e83d16403da7886cb97b27b",
"assets/assets/images/banners/squareo_banner.png": "4d50f3ed0e5908e757d1b703e27ec8f9",
"assets/assets/images/banners/windows_sidebar_banner.png": "85cdef330b50d90c4378e03991227b1a",
"assets/assets/images/coachyou.png": "9f652485926a92e0a9e7b21f03839566",
"assets/assets/images/logos/audio_resumer_logo.png": "78b61b60912ca28f5730101866d1049b",
"assets/assets/images/logos/concentrated_logo.png": "fae97a590cc7e03cfdf5ec67abbd8470",
"assets/assets/images/logos/draw_over_it_logo.png": "4f18038e52bcada4fae9ab5b0be10eda",
"assets/assets/images/logos/events_jo_backend_logo.png": "4175ce02f821284580bd8d1a24e3440b",
"assets/assets/images/logos/events_jo_logo.png": "9d0b767c77b9172f901af3fe60ab73f7",
"assets/assets/images/logos/portfolio_logo.png": "15620438eaec5e7e6a26848107944a3f",
"assets/assets/images/logos/rapid_rounds_logo.png": "d753215c4a414a8b9d527ba49e6f6640",
"assets/assets/images/logos/squareo_logo.png": "8723a31f515d228ec8d8b8a4ca415b9e",
"assets/assets/images/logos/windows_sidebar_logo.png": "e539f728e3832f32346d9538495746ee",
"assets/assets/images/logo_filled_shadow.png": "5f4ef2f81e0f37811cbb49e2e2fffe1a",
"assets/assets/images/logo_inside_app_shadow.png": "5bd4b6294bf8a12b552e34c0828524cf",
"assets/assets/images/model10.gif": "c41589b05758472c8e170f59c8989549",
"assets/assets/images/model11.gif": "2765d9ea7318455129c5a3a68abba3f2",
"assets/assets/images/model8.gif": "7771f78634bbb46986911a7cd9881f2e",
"assets/assets/images/noise.gif": "b71fb95c36fca3a1840ae0c6eff86409",
"assets/assets/images/uni.png": "87c23cf69acb3efc7078378b80c14f3c",
"assets/assets/images/yjif.png": "aeb1c53b92c3820d6e37e7e24e48d7e0",
"assets/FontManifest.json": "ebddd5efb625d5448895431390fb3057",
"assets/fonts/MaterialIcons-Regular.otf": "58e2b633a5e7259e4517cd927469275f",
"assets/NOTICES": "63aeb849a355480283356afe9a817ca9",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "33b7d9392238c04c131b6ce224e13711",
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
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"flutter.js": "76f08d47ff9f5715220992f993002504",
"flutter_bootstrap.js": "449291e2b4f982b3057266f51405a1b4",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"index.html": "ac5b02687ad3284a0be2e29de984c80d",
"/": "ac5b02687ad3284a0be2e29de984c80d",
"main.dart.js": "83a994cc318631facc55211840902093",
"manifest.json": "67a982f3c92f175bc24eb4080b429476",
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
