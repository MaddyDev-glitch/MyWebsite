'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  ".git/COMMIT_EDITMSG": "3e8deb514b42cd27d9fb452376fcccc3",
".git/config": "1401321b2611631819d9ac70f31798bc",
".git/description": "a0a7c3fff21f2aea3cfa1d0316dd816c",
".git/FETCH_HEAD": "3128e07a286f004de337ef4e9e70c8d8",
".git/HEAD": "f1e19b1c9af3795c1509ffe3af5c39cc",
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
".git/index": "2852f4d0d9c5fc64b45a07038ca6f8a1",
".git/info/exclude": "036208b4a1ab4a235d75c181e685e5a3",
".git/logs/HEAD": "9d08410c81dc9c330645068fb59a3e52",
".git/logs/refs/heads/master": "9a2f164aae45db4a82b9a51b39e8a3e9",
".git/logs/refs/heads/newhost": "8efd68d15ca691021901e296cdfe79e5",
".git/logs/refs/remotes/origin/add-license-1": "243101b3f180120ecc43b0490226be09",
".git/logs/refs/remotes/origin/master": "c0e0d428eb85de6c2d001b8b4d0da5b2",
".git/logs/refs/remotes/origin/newhost": "8c0c09c25f4b4817553aefcbf3ab7b9a",
".git/logs/refs/remotes/origin/superhost": "c0e0d428eb85de6c2d001b8b4d0da5b2",
".git/logs/refs/remotes/origin/superhost2": "4a2c2d94557a0101e47b42ff1a7bb0d5",
".git/objects/0c/12a0423292b8a762be84ad36832ab79170f8a0": "91490f186f875e3003f5e9796b10c488",
".git/objects/0d/0df08f7c3e147a8ae36017cf81a96e35b73717": "106e868f28a72727fb6fb0fa71123633",
".git/objects/14/88e546d7c6222bb6076ee9df1fe33bbeb01b08": "96940eac89fdc3b56251fb31a718b43b",
".git/objects/1b/9745376952b3f54e1c4caca6325988f02f5f56": "f382f5a24d775cd38945310cbef5c299",
".git/objects/1d/ab8c0a5a9bb431cc45e27aaf26fd9920df81f1": "f3933844b6bacffcffa62e9a555e0dc0",
".git/objects/20/5bb5db271c6d8de8399864c7bb9b917f638893": "c993b22f115d7f3ae6d5b7b212806539",
".git/objects/22/d5fb97e66ea56e004a5f321845a9174f26ac27": "cd8e5ee57b49e9c7923379f5f92be3d5",
".git/objects/24/b1f14dd348b07c9b8373758bde9ac14d16fd92": "dbf45d6c044044561758a334420e9569",
".git/objects/25/ff83e56186dfb4a31a279b869346a939f7cae4": "fbcb4edd478d675d280a65daf6ca4931",
".git/objects/2d/cf3542c874e33cd8ab86ceb6f0ec444228aa78": "66baad0ae5d874f09b6eee790095bc65",
".git/objects/2f/a525defdd18758ef6e1bc4b7177ccfcea7297a": "48a10a06a9c4266b68e928ed1ca3bba0",
".git/objects/3a/bf18c41c58c933308c244a875bf383856e103e": "30790d31a35e3622fd7b3849c9bf1894",
".git/objects/3c/5f2f26c506427b38a60a3fad649096ee788501": "381f1d455f4f15b62f446d69dfce7137",
".git/objects/4e/89617a3696bd10c155ec378f4a65a9f89e9e3a": "d8056e20bae90d092b619c895129e982",
".git/objects/52/480a63b1f184ea74afb06662aa98fa98864864": "6f8b2cf71be2b4830601f9db57eded45",
".git/objects/5d/8bb52c15f91ca894b297128b33610483f277e8": "a599a15030e17b465f0d4287478fd113",
".git/objects/76/8651b2e249c2517c7b37bdbeea0a5d8bfbb707": "495b1c4fefa633f6afe4dc5840ebe18f",
".git/objects/76/a2b0479a78220b3061d93ef59579e8b86b64d9": "6a410d6f30990a823f5b55ec46ece8af",
".git/objects/79/ba7ea0836b93b3f178067bcd0a0945dbc26b3f": "f3e31aec622d6cf63f619aa3a6023103",
".git/objects/7a/839bf375e0caf875214c02fa2460bfdd17da4d": "a3ea29ac9d3b368b0cd1a1f94b29900a",
".git/objects/7c/2ff30b294ff95767de6d0c2895e2563fdd2536": "0a62edb3a069f5869a62e36ecabf9d37",
".git/objects/88/cfd48dff1169879ba46840804b412fe02fefd6": "e42aaae6a4cbfbc9f6326f1fa9e3380c",
".git/objects/8a/aa46ac1ae21512746f852a42ba87e4165dfdd1": "1d8820d345e38b30de033aa4b5a23e7b",
".git/objects/8b/0ec1bccbfc605f209b6d34f2dfc2e32a925c24": "018019a49b68b1d29442a19d9e64e559",
".git/objects/8d/a19aa3ba470a0b0c5a2f4e15c3b683f3ddb56b": "e3bfdfd1c871777d80e3206965a2f48f",
".git/objects/9a/d2e39eb0db42c4bf5bbe30f6f9ab6255df8218": "6229f2fcba2958764c17c9b767ff2e90",
".git/objects/9b/001a0950fd8c16efcd8a109605758b7b41a83b": "1887f5578fa0fd32c511924a40112235",
".git/objects/9f/8064cb86e82d870e7d42fe0f36453935c7e73b": "29027b8a2ddb53b98b6f815616e4fbb7",
".git/objects/a1/3837a12450aceaa5c8e807c32e781831d67a8f": "bfe4910ea01eb3d69e9520c3b42a0adf",
".git/objects/ab/0e98497a51ead7821d1da35a24968ff314e50f": "557c35fe3928eb2af403d1b3926bb9ba",
".git/objects/ad/da836cf324cf27fa2685df6e193f1070062cd8": "23fc89f3e4fb13ad6308bcbcd73f9922",
".git/objects/ad/dfe1ddbd4e82a21cc8cc9b71ae963481a7b23e": "4c29ed5aa58c04fd18e42110bb986a0a",
".git/objects/b1/697d5b272ab583f8aabba43532b0079c8a145b": "5a0dcd50db3b20d396cafbc55146d013",
".git/objects/b4/9bc8920fcdb0c93a9f02e63641070adbe731f6": "89eac9a76802061690201bb255e4b99a",
".git/objects/b7/49bfef07473333cf1dd31e9eed89862a5d52aa": "36b4020dca303986cad10924774fb5dc",
".git/objects/bb/98fe5a39a305c968f5ec441368aabc7541d6f0": "b98294c076a9fbbd58e0939d2a11ba6a",
".git/objects/c0/f3630362c1cb8001bec4843ab631526dc4ca3c": "620c2c8894be4df1db2829a23bbc6aaf",
".git/objects/c1/097812b67931d25b4109937747b5080d2a9b5e": "1427551270516a49ae668dbe0c3ef243",
".git/objects/c3/a3d3d3283e2313751080267db96ab2f65e7d0a": "473c5069b097732ecb8993aa4ae46815",
".git/objects/c7/630197d63fbb00970c989a65ccf297b16b8a58": "20b40288ad32013c89d4a0fcd8cc42ad",
".git/objects/cd/4454a59fc72b04dbc87271aad4658d74339caa": "69cba77b9a6f0cd28712df956e45776b",
".git/objects/d6/91d5a0127a21a39db841e415eda86b0f80e8b3": "e60efe0959f340a89affe88c2bdb4fc7",
".git/objects/e5/951dfb943474a56e611d9923405cd06c2dd28d": "c6fa51103d8db5478e1a43a661f6c68d",
".git/objects/e9/e575d0b36ebd696294496017834c26b62e1505": "8eca52e53d59927cc7c00a13888ea67b",
".git/objects/f1/b21a0a7b8d4a7e966a08e7b34e71c625f4316f": "c06ba42b171026e8d598ba55e3773052",
".git/objects/ff/4d903c52b408fe054959223d9c3a204de54e9f": "cf2dd89d76814b49d65e6afd547dec02",
".git/objects/pack/pack-6ed7fe1669a82e6ef74c2be1aea356e4989db243.idx": "39253cb1e9a7ee2ef2f5cf2e2d681437",
".git/objects/pack/pack-6ed7fe1669a82e6ef74c2be1aea356e4989db243.pack": "484914da9f791bd446a472d58c9c0685",
".git/refs/heads/master": "beaa723cf19f55bde92f055b203ad7e4",
".git/refs/heads/newhost": "ae9b8444450dcf599f97565eece71279",
".git/refs/remotes/origin/add-license-1": "99f4d0ba0ad2cf2985390ead7c01373c",
".git/refs/remotes/origin/master": "42d8b5b63964e61b0ff6e1470ab4d627",
".git/refs/remotes/origin/newhost": "ae9b8444450dcf599f97565eece71279",
".git/refs/remotes/origin/superhost": "42d8b5b63964e61b0ff6e1470ab4d627",
".git/refs/remotes/origin/superhost2": "a21adff8648ce3f4cd7dc4f0d0b63b87",
"assets/AssetManifest.json": "bb311f88698c06017836679885a457a0",
"assets/FontManifest.json": "7b2a36307916a9721811788013e65289",
"assets/fonts/MaterialIcons-Regular.otf": "7e7a6cccddf6d7b20012a548461d5d81",
"assets/images/Envelope.png": "88551fa85d0a4eb4394c792b5b987b0c",
"assets/images/GitHub%2520(1).png": "1afea3ca6d51c2925382c7ecc3280552",
"assets/images/Instagram%2520(1).png": "a812ddd592c1f1f8a7e324014d664c9a",
"assets/images/LinkedIn%25202.png": "c225ff5cdd7889d349b1e2782b6a82bd",
"assets/images/opencemslogo.png": "9726f4657d9e9cfe041a7a720f6157f2",
"assets/images/test.jpg": "6aaf5746d9c42d9fc2c1f1d99fde349a",
"assets/loading.gif": "6636bf18e02a2039c006803dd02401b3",
"assets/NOTICES": "b80290114c9bc858039257e5f636e03e",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "6d342eb68f170c97609e9da345464e5e",
"canvaskit/canvaskit.js": "3725a0811e16affbef87d783520e61d4",
"canvaskit/canvaskit.wasm": "4b83d89d9fecbea8ca46f2f760c5a9ba",
"canvaskit/profiling/canvaskit.js": "491df729e7b715d86fc167feabea031a",
"canvaskit/profiling/canvaskit.wasm": "95e736ab31147d1b2c7b25f11d4c32cd",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"index.html": "6c18a0e2b78844f7546fbc22ecd60de2",
"/": "6c18a0e2b78844f7546fbc22ecd60de2",
"main.dart.js": "bf25246e64cb83294f80dfce1bf1583f",
"manifest.json": "e4272f053ad3b525316aeeb50429bd51",
"version.json": "6657dfced0f6b0546539baf43d9a4dbe"
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
