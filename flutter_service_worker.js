'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  ".git/COMMIT_EDITMSG": "a82c8676825a14963dc1dbf011919602",
".git/config": "6028a9107caec8cfa1da6e1d2a1279dc",
".git/description": "a0a7c3fff21f2aea3cfa1d0316dd816c",
".git/HEAD": "e4b8c6621840f1717b476b3833af397f",
".git/hooks/applypatch-msg.sample": "ce562e08d8098926a3862fc6e7905199",
".git/hooks/commit-msg.sample": "579a3c1e12a1e74a98169175fb913012",
".git/hooks/fsmonitor-watchman.sample": "ea587b0fae70333bce92257152996e70",
".git/hooks/post-update.sample": "2b7ea5cee3c49ff53d41e00785eb974c",
".git/hooks/pre-applypatch.sample": "054f9ffb8bfe04a599751cc757226dda",
".git/hooks/pre-commit.sample": "305eadbbcd6f6d2567e033ad12aabbc4",
".git/hooks/pre-merge-commit.sample": "39cb268e2a85d436b9eb6f47614c3cbc",
".git/hooks/pre-push.sample": "3c5989301dd4b949dfa1f43738a22819",
".git/hooks/pre-rebase.sample": "56e45f2bcbc8226d2b4200f7c46371bf",
".git/hooks/pre-receive.sample": "2ad18ec82c20af7b5926ed9cea6aeedd",
".git/hooks/prepare-commit-msg.sample": "2b5c047bdb474555e1787db32b2d2fc5",
".git/hooks/update.sample": "7bf1fcc5f411e5ad68c59b68661660ed",
".git/index": "15988600722a1588f0889174abfa2e61",
".git/info/exclude": "036208b4a1ab4a235d75c181e685e5a3",
".git/logs/HEAD": "40f916adbed23aea9e70c8d38eb380a8",
".git/logs/refs/heads/superhost2": "f226e0e06e1d36a1ed6c6c5164a63a96",
".git/logs/refs/remotes/origin/superhost2": "7e9dfba8f34b941550de6891f506f521",
".git/objects/00/b25e7531f29d6e59ee6e50786e3b95fce98565": "7a5ef0637908fbd4e4f006a5ca41b760",
".git/objects/02/932fbd00fee56aa61e40ba9e76c9642e2c17ca": "9c7d4dfb0ebf2eeae87b33ae9ade652f",
".git/objects/03/eaddffb9c0e55fb7b5f9b378d9134d8d75dd37": "87850ce0a3dd72f458581004b58ac0d6",
".git/objects/14/88e546d7c6222bb6076ee9df1fe33bbeb01b08": "96940eac89fdc3b56251fb31a718b43b",
".git/objects/18/0c10bb07c3a30f25a66ac72cc23b9a2f4ec459": "cd80108c4b1d3aa7170b2b3be597a5ff",
".git/objects/1d/46ffdc29e9ca3bc145fa4b1e9e84fcc3fe437c": "e1db29efe197f16d7d42f64f8a2e1938",
".git/objects/1e/fde350d2f58c17d7956fe5964c8d9fc29c9245": "83ce938e652cb3a1042cf25843c1d919",
".git/objects/20/5bb5db271c6d8de8399864c7bb9b917f638893": "c993b22f115d7f3ae6d5b7b212806539",
".git/objects/22/0eb54456ec8211c0c6a0e408af64c50af66b4b": "04cfa1c80d938610c23eeeb0b7af2fda",
".git/objects/26/6a8207ef448f05aeb51d17e0ca04199378400d": "8c85958bb0df334346411cce56720f3e",
".git/objects/31/19fc5095639dbbb55211a275c8394d9eba93ec": "d97e6e1f9ad0b171dd5a232ba3284d5d",
".git/objects/32/46ad559eeae0370195978eaed83f1053ee13fd": "a043dbc0a0bda96ce2127799ccc27506",
".git/objects/35/6064e660aa9d88cada4ff021e876e2f548f000": "882125a11744d67c456dbf68a915464f",
".git/objects/35/6817c84756eb6a6ae90fab1693d69042a9a214": "61a5c8fa9e7018d2c71cc06829132665",
".git/objects/36/0d0ad6c20ba226b4f89ccdd4fc551be4ac4ce3": "f73d51bc3900802ea2045f1b8b26fda2",
".git/objects/38/2a33154dcd4b352091cf0c8ce7e8869fcf127d": "82478b5b37d9157998ff0e1b38ad6afa",
".git/objects/3b/f49976c729649320f493b9fa650a3bf7f70024": "c4c4881f167c79d5324fcc82412b7d18",
".git/objects/3d/9e96a3ae35451f29047a70ca3305a815282d1f": "de00f5b1f5ee3c3bed14d6b381ef3a42",
".git/objects/3d/f6368b37e3307cecf4b870265a63eeedb748d9": "2c90905da14a378b4750f974d4cdc816",
".git/objects/46/4ab5882a2234c39b1a4dbad5feba0954478155": "2e52a767dc04391de7b4d0beb32e7fc4",
".git/objects/4e/c623c3f717a632a8033b59db4ee0f0d6a90fa3": "04b917800d4fad5f81a4bfa88d6771af",
".git/objects/5c/ab464f6ed8c3b0b807e3ff5350e2bf4d4f7ffd": "561040ed014e3f112bed93b7cde01d7c",
".git/objects/5f/1f36db7d8bf6081c282b517298c3d56e8e5ed5": "b1bd0cf6e118b5e5e63d317829bd9750",
".git/objects/67/650467589b0e033cf972ff455c07035ade1d32": "747be135e04b39b4627f4afc33ad15f5",
".git/objects/6d/84c9857b44f3889430f8ef90e84678e3ebac69": "c5751520b674036e3ae7eb5d3d49e0f7",
".git/objects/70/0254201edb5d37605517d58e0f09526eb81d30": "fad5198a86afc46080c2c1bb09bf4dcf",
".git/objects/70/b44568dfcba08de0fdce661d5e98444f273b3c": "3e8786e74ebfbdd0f783227d6cb41131",
".git/objects/79/ba7ea0836b93b3f178067bcd0a0945dbc26b3f": "f3e31aec622d6cf63f619aa3a6023103",
".git/objects/79/ebf0ac582891caa8a7b8b69259c32edc0a47dd": "fdc62ad4b5f0a42b7e7b5da17a38bfb2",
".git/objects/7b/847db92a03193a4b5183b3e2e761f926e1d827": "56e1806ecc6ba554a1d3e3d749f8e3f7",
".git/objects/80/9ec6fee6a0a28231cd5c8d140a36234ff8fc95": "c3c349f87a9af9c8de2c753f104c5a98",
".git/objects/80/c5c29a50ff1cad4cb306f6fb641e86bea4abe8": "8db95f152bf20ff3361692e7f5f79175",
".git/objects/86/236075633e5e6da34866f24e7b17e3620fe098": "fb082f8ee302fe185d85bea0cb700bb6",
".git/objects/87/03b8161eb4626014131af34ae7a6a9f8f16af9": "3c0c4874987bc52f48daafe36c8d8010",
".git/objects/87/7507168af2ee65dd4ca25f4eaec86bdf02b1d6": "7716bf6ba0cac6f1d9e381c897218304",
".git/objects/88/cfd48dff1169879ba46840804b412fe02fefd6": "e42aaae6a4cbfbc9f6326f1fa9e3380c",
".git/objects/8a/aa46ac1ae21512746f852a42ba87e4165dfdd1": "1d8820d345e38b30de033aa4b5a23e7b",
".git/objects/90/6ac5d1e881ed84a82fd59f2d7e9733b5c20e14": "ba6ea8b963282215f741679fb413f046",
".git/objects/9b/bace26d648af3788aad1dfaea1aed5172f1179": "fcdb3f9be189e2a4ab25927ceeba14a5",
".git/objects/a1/3837a12450aceaa5c8e807c32e781831d67a8f": "bfe4910ea01eb3d69e9520c3b42a0adf",
".git/objects/a3/28372ec47c7425a12902c3fc02aa5d58b23134": "3d0d87ae09c2dc2f50cdf2f0b9b2928e",
".git/objects/a3/971e8b3a5f2bdf04c6e7e03fc40a72961934dd": "035a7ef61fd45b6c362cdf80b44a9ee3",
".git/objects/a6/92a750f1254dfe9340cf926a59f3346aa20378": "7c0a0f56a193021a943c795e96f63e03",
".git/objects/a8/beffd3ad4fe54d6cabccf83a05477d6a986cd0": "6677888e4a051c7838b5b240c09f0981",
".git/objects/ab/0e98497a51ead7821d1da35a24968ff314e50f": "557c35fe3928eb2af403d1b3926bb9ba",
".git/objects/b3/967c73fa00da193abab7078828b4160068c33b": "3aaa764bb2aed89bca95f393d951d311",
".git/objects/b7/24d7fdb29618d15b01bec0f44fddd6eef2ff70": "4e29d30a4a638c463766739657e705c4",
".git/objects/b7/49bfef07473333cf1dd31e9eed89862a5d52aa": "36b4020dca303986cad10924774fb5dc",
".git/objects/bb/8d2254ab362d38601029f15931bc18bbcca08f": "288b9a8c4a9654f4f7c39d437ef245a7",
".git/objects/c0/569fa429ffe22bd5435a4f15e1666d806b95c1": "ec2e02358b995f7449a8e1276793a1ee",
".git/objects/c1/79072b4db7cd92ba90dc4a14d7ff17c375017e": "ef657dcbca44ecbfdbdb8b5616a33e0e",
".git/objects/c2/71896e3dd2b439872f8f66c6f9e25dcd0b927b": "3c5b2c77ce14f2d50e8d06cbd661791a",
".git/objects/c7/28676918a351c4b668825b3341793f6b4f2a5c": "e0af66091ea8efdea026f569857e9758",
".git/objects/cd/1c867e91cf4fb177668aa3ad66d02ce8eda9c0": "1389dd184cda968d95065f5e5c051ef9",
".git/objects/d9/88764edad6c138ce93899467c5bce15ba9e0f5": "575ccdde2e95d9a3f2dd771d5b639d0a",
".git/objects/da/3acfab7146ba9a773181927837d0ec137af243": "4653e217451275dc3700fc38c2bcb20b",
".git/objects/e2/081ff84a7f2718668f12a16473238ffcde09d2": "4b24759238695f77bba5d2cafbbd5ef6",
".git/objects/e5/951dfb943474a56e611d9923405cd06c2dd28d": "c6fa51103d8db5478e1a43a661f6c68d",
".git/objects/e8/2ffdf1624bace9779184e87abf8ae98c2b44f1": "d6e77f4ce1803471173a140f59d84505",
".git/objects/fb/6200dd504f1b8db8252c41e3494375689f3a64": "4edde73a2b1ecd5e26a041b463c77818",
".git/objects/fb/b3e4b05dbbacc3d0d5c17fa127672d85719c27": "6863e1a6cfc0f5d39c2944da03dfbf46",
".git/objects/fd/388c078263f3d24c34f2c4c1bc726ca101af22": "338e94b7d4836869560b6552a41d5030",
".git/objects/ff/ac128b89680ac2df181ddee75046effa3ff2a4": "6a5e6f44dc14a47a52c86488460fff7f",
".git/refs/heads/superhost2": "10107f9cc449897ea647c22fc1dccd2c",
".git/refs/remotes/origin/superhost2": "10107f9cc449897ea647c22fc1dccd2c",
"assets/AssetManifest.json": "2efbb41d7877d10aac9d091f58ccd7b9",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/fonts/MaterialIcons-Regular.otf": "4e6447691c9509f7acdbf8a931a85ca1",
"assets/NOTICES": "2a03de37f4c66a9cd2924313ad10d2fb",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "6d342eb68f170c97609e9da345464e5e",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"index.html": "9917a68af9e6f1bd56010b050370ea13",
"/": "9917a68af9e6f1bd56010b050370ea13",
"main.dart.js": "5372251ffe3be4714111e73575acc806",
"manifest.json": "e4272f053ad3b525316aeeb50429bd51",
"version.json": "e0386afcfb600eba6e594aa1ad8c5220"
};

// The application shell files that are downloaded before a service worker can
// start.
const CORE = [
  "/",
"main.dart.js",
"index.html",
"assets/NOTICES",
"assets/AssetManifest.json",
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
        // lazily populate the cache.
        return response || fetch(event.request).then((response) => {
          cache.put(event.request, response.clone());
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
