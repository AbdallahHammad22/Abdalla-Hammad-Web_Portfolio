'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {".git/COMMIT_EDITMSG": "55ac7d6ef150cb25bc6ddfaa6830e0ae",
".git/config": "9324c8604c37d4bbd15b93dba70257f0",
".git/description": "a0a7c3fff21f2aea3cfa1d0316dd816c",
".git/HEAD": "cf7dd3ce51958c5f13fece957cc417fb",
".git/hooks/applypatch-msg.sample": "ce562e08d8098926a3862fc6e7905199",
".git/hooks/commit-msg.sample": "579a3c1e12a1e74a98169175fb913012",
".git/hooks/fsmonitor-watchman.sample": "a0b2633a2c8e97501610bd3f73da66fc",
".git/hooks/post-update.sample": "2b7ea5cee3c49ff53d41e00785eb974c",
".git/hooks/pre-applypatch.sample": "054f9ffb8bfe04a599751cc757226dda",
".git/hooks/pre-commit.sample": "5029bfab85b1c39281aa9697379ea444",
".git/hooks/pre-merge-commit.sample": "39cb268e2a85d436b9eb6f47614c3cbc",
".git/hooks/pre-push.sample": "2c642152299a94e05ea26eae11993b13",
".git/hooks/pre-rebase.sample": "56e45f2bcbc8226d2b4200f7c46371bf",
".git/hooks/pre-receive.sample": "2ad18ec82c20af7b5926ed9cea6aeedd",
".git/hooks/prepare-commit-msg.sample": "2b5c047bdb474555e1787db32b2d2fc5",
".git/hooks/push-to-checkout.sample": "c7ab00c7784efeadad3ae9b228d4b4db",
".git/hooks/sendemail-validate.sample": "4d67df3a8d5c98cb8565c07e42be0b04",
".git/hooks/update.sample": "647ae13c682f7827c22f5fc08a03674e",
".git/index": "d25794705095da60fb515a6121172569",
".git/info/exclude": "036208b4a1ab4a235d75c181e685e5a3",
".git/logs/HEAD": "38987bf8bf69a3b2743d9ff089d7648b",
".git/logs/refs/heads/main": "cdac9b8bafa7fc74583e5161d4e60d68",
".git/logs/refs/remotes/origin/main": "209cecbafc62ba0675540d9a868d3e06",
".git/objects/07/7edd8a1936fac6a0bf67a7528e4a69c63cfc46": "ef68d2abbef833d65aee407fba2248bb",
".git/objects/08/32d0db2def1613c1c45aa4fe9156a1c6b7d589": "e05df183e5eeaddf39672a2516f9c41d",
".git/objects/0c/37594409355f44e27de8152dd5be76567012e6": "be6abe3ed5650c087848c03a14b2e9df",
".git/objects/10/9e09162ca13a58688826bdba02799a2807377e": "1cbece680724604d8d9a5827bdb62a2d",
".git/objects/14/97ce8bbec338a619137a601d9ca9c594d22cff": "7c9f3531efb40cebcde9bced8953e505",
".git/objects/1b/ec0cd6e11ac1d26fd2cceecdf92d96d4b0a7f3": "77002361a9c1283b3ae0ffb74b119281",
".git/objects/1f/45b5bcaac804825befd9117111e700e8fcb782": "7a9d811fd6ce7c7455466153561fb479",
".git/objects/21/4558b5de28a9f31ccb7ccb907886dcf1f3cde2": "21ec4498f6ca8ea15ef188dc80055e5d",
".git/objects/22/5744bd6947df637fa2f5dbcc5e7c0dea0a6aa1": "9a92957b4a8b60d7f510b1a0baaae628",
".git/objects/26/bd90e221efa2257801656e4a497f6bc3b24ccd": "300eeb919449fc90bbbe85363841d61f",
".git/objects/2f/a005ec0052eb214258b0735fdf3b2657ab2bbd": "fb78a0cead56c29107df248610e1bbea",
".git/objects/32/aa3cae58a7432051fc105cc91fca4d95d1d011": "4f8558ca16d04c4f28116d3292ae263d",
".git/objects/3a/7525f2996a1138fe67d2a0904bf5d214bfd22c": "ab6f2f6356cba61e57d5c10c2e18739d",
".git/objects/3b/eb7890b45ca2875195243c4d7b8090b4f2549e": "7ad1148a6be26d6dc597bf1d110c6ccb",
".git/objects/40/0d5b186c9951e294699e64671b9dde52c6f6a0": "f6bd3c7f9b239e8898bace6f9a7446b9",
".git/objects/41/0908b6ca9e1b0f65f70dcf453c7a33c8c1b475": "bf9e0fcf69014007e7bfbdae7fa41eae",
".git/objects/44/a8b8e41b111fcf913a963e318b98e7f6976886": "5014fdb68f6b941b7c134a717a3a2bc6",
".git/objects/45/45b8eaf094b432e53b551486b4dbcd4586844d": "ae8553488dfce048a2bf9bf1333cda81",
".git/objects/46/4ab5882a2234c39b1a4dbad5feba0954478155": "2e52a767dc04391de7b4d0beb32e7fc4",
".git/objects/4f/7fe97022e3090f88e294e7d84db98a50ec0ceb": "060b1c608d63d47be24f1d0949051fcc",
".git/objects/51/e7b04eace0bb986e1f8dee6a4e3148f77bfe17": "d82d400a226bff06047a9ebba5a34060",
".git/objects/54/9567bc5d49f3666309c0a72874063c225a12c6": "f10a9f750fb0d0363d1fc3c083162619",
".git/objects/5c/6a2651e97d3bb6413bf031b882e5bb43579c26": "58f060773c909f1f057c1648838eddc3",
".git/objects/5c/a017893b2927c9a549a678278c883a97ef2a0d": "ae6097befff3fad1d76396cd065264d6",
".git/objects/5d/20189fb9fee244eb41036fd9f78f0a31400278": "eff3bef2d0eef8663321eefdc49c35f6",
".git/objects/62/1e24c0ca3347917ca1650b696c0490f63770cf": "ef08c985b9a1c860a3a4261480bb641e",
".git/objects/69/7612b856b42c7df2f6b11a751697ce3fb59ba5": "eb2c167bd5d2090211aac5d103a33a2d",
".git/objects/6b/4fe76cba540db20f6ff1a0eaa79f93e313f940": "c9f53c7b8e485568d0eb632158ed784e",
".git/objects/6b/e909fbf40b23748412f0ea89bf0fae827ed976": "5f118419157d9534688915220cc803f7",
".git/objects/70/6b89226856a184964d4ef26acca4690f34feb3": "b47861a6de6336cfde49244ec049778b",
".git/objects/72/ada6baac9193047a04d1ef7fc6c08c19a0aad4": "515cf0496f523efb00e1cdbca48aebe4",
".git/objects/72/d2ac11e3a7e709db33c98612eb36324b65a1c5": "c79df3f24627348b03a122af4e1edf89",
".git/objects/75/42c6b0e9cdcf9c8e3f7da12ab5edf7415f9fad": "f31e0e5a82c78b71792ba19b15f96867",
".git/objects/84/0516208d35dcb4298847ab835e2ef84ada92fa": "36a4a870d8d9c1c623d8e1be329049da",
".git/objects/85/6a39233232244ba2497a38bdd13b2f0db12c82": "eef4643a9711cce94f555ae60fecd388",
".git/objects/88/cfd48dff1169879ba46840804b412fe02fefd6": "e42aaae6a4cbfbc9f6326f1fa9e3380c",
".git/objects/8a/aa46ac1ae21512746f852a42ba87e4165dfdd1": "1d8820d345e38b30de033aa4b5a23e7b",
".git/objects/8b/90278644d1bf235a84c2d815236d42eb3a068d": "fa10ed352fc403000ea78b8f6bdeafc2",
".git/objects/90/bcfcf0a77ab618a826db0fd8b0942963b653af": "fc109675cdf1233dd6599a4c3c0a7a69",
".git/objects/95/695ea66875753d6d6a865a396c4898d8f5017e": "77b31849e029cc2cf30553f1d1e24be1",
".git/objects/96/9124f69edb595b03958ad47d8e4f13619e1bac": "b200b3cd909a1d3183f4ebe84349ca05",
".git/objects/98/57c9b3b0448c92818efc5fda0f206b21914168": "ecbde07c564dabbec0f249821051b8af",
".git/objects/a1/7b9f52268d856f0dc531cb7a6857653f4436cc": "9de85c04e3c4b2a9760790b3d2875f64",
".git/objects/a3/f80b9dd059fe88030d229b0cdeddb06081cc5c": "c48b002581132c3d64b06761602928e2",
".git/objects/a9/0581d49e22d1b024685f2db6c7d20e64bc74f3": "f6085149e841c1f191616ce32d97b299",
".git/objects/a9/7d0c6fd270b109af7e8a4e06b8efbe47ee504d": "42dbb00e47ab6bdec4e0752c63cf8337",
".git/objects/aa/46c04c756faf26d2ee144c157b845727fe3ce8": "bd4e67b65849a5649714e94aaebc6e7d",
".git/objects/b1/5ad935a6a00c2433c7fadad53602c1d0324365": "8f96f41fe1f2721c9e97d75caa004410",
".git/objects/b1/7cc174c188bee1bc21eaf04c45b359f72af607": "28d6185ba83aa5f9b6bba795a9223357",
".git/objects/b3/9c3a60c5543ac2149a7458b6f33bafc8afdcdd": "1a1b6e39a7ba15f3c4b16815546803b6",
".git/objects/b4/cf6071aec553895730574a19ade8c73f6cc8c1": "a1de0a30e649e822cbeae3a84d324e8a",
".git/objects/b7/49bfef07473333cf1dd31e9eed89862a5d52aa": "36b4020dca303986cad10924774fb5dc",
".git/objects/b9/2a0d854da9a8f73216c4a0ef07a0f0a44e4373": "f62d1eb7f51165e2a6d2ef1921f976f3",
".git/objects/ba/5317db6066f0f7cfe94eec93dc654820ce848c": "9b7629bf1180798cf66df4142eb19a4e",
".git/objects/be/dd4deef0ee5021443673c3979b4e41b69a7464": "d31dcde48c7e653791f2c106477f012f",
".git/objects/c1/b22ef102aa1bde715267edff5c17846f94d3fb": "1ee14692ae12e9a49789a1b1a9bdb635",
".git/objects/c3/944b8a86e8e765015d9f823da8321bc425b40f": "00f2a42df0979a2759e789cb2c87b344",
".git/objects/c7/008b132e5af518b8d693472b0607fe54f92ad1": "502575312945e5493a40f6246f5e3f4b",
".git/objects/cf/abec5332e39477740def2827441fcd74d97898": "ec4eb901b8cb0a6ed80e66b88fdccfdd",
".git/objects/cf/f8b0732f31e154c6dfd25fd75f15a0cec5b0b9": "f4440bdcdcf93fa2fb152258e153b376",
".git/objects/d0/23371979cf1e985205df19078051c10de0a82d": "700b71074bad7afee32068791dec7442",
".git/objects/d4/3532a2348cc9c26053ddb5802f0e5d4b8abc05": "3dad9b209346b1723bb2cc68e7e42a44",
".git/objects/d4/e6ec7c64cb8f6c21fd214102e670d6d9824e5e": "5b9d899a4829b52d928626548659a95e",
".git/objects/d5/bb50b3c3bc534b51ba035a5e8495ba7af5025b": "81d30e6f235d2cd1960b1a0d917b3043",
".git/objects/d6/9c56691fbdb0b7efa65097c7cc1edac12a6d3e": "868ce37a3a78b0606713733248a2f579",
".git/objects/da/fd65422747502c19b5c74b4230282644d2169c": "d8a62caf99a372ff6c7692e143787ce3",
".git/objects/df/33a0e7bdb1d42460634bd8b837f42c802c4bd7": "ad68eb02065e3f9611fe704ec6669475",
".git/objects/e3/893d874f83726c7faee6b44a20e3f501a947cf": "018c2070207c5adf1a0677acd0bd09fc",
".git/objects/e9/c0e11e4639bfb29e8999754dc6e5cd3d42948e": "d12d1e02beb7c32f59239f54f79dc211",
".git/objects/eb/9b4d76e525556d5d89141648c724331630325d": "37c0954235cbe27c4d93e74fe9a578ef",
".git/objects/ef/d711c62994e569152200fcc5f611e13b53e5ea": "bb19824f3b6f685ac6817ab194535b97",
".git/objects/f2/04823a42f2d890f945f70d88b8e2d921c6ae26": "6b47f314ffc35cf6a1ced3208ecc857d",
".git/objects/f6/92c7e4cbd25c45a36f5091a35c6b4f3c3d1c54": "c6fe3c5c05f814fded295d354bb40347",
".git/objects/ff/4203d9ea3ac0f4c30bdfd5280aa11906a936f6": "42818c8c9c9d4bbe5b4d9c4ec52615ff",
".git/refs/heads/main": "abb8813823d7e05a1dcf51a606dc5398",
".git/refs/remotes/origin/main": "abb8813823d7e05a1dcf51a606dc5398",
"assets/AssetManifest.bin": "626fc19c836e97119c304716bc3c3c00",
"assets/AssetManifest.bin.json": "c5073030ccc7eed00315eca921655e25",
"assets/AssetManifest.json": "88abefbf0f5368671066d01f78038bf6",
"assets/assets/icon/facebook.png": "ba803196d3b7644ffb2576efd1500b6b",
"assets/assets/icon/github.png": "a29dc3691124638b000809a7696281d5",
"assets/assets/icon/linkedin.png": "d492efc706db983e74258dbd348f2208",
"assets/assets/icon/whatsapp.png": "bfc018faae614d1c20a7a56b26d45960",
"assets/assets/images/admin_panel.png": "8ef74bd51387d7a1e7ca56d77492b686",
"assets/assets/images/Aldawa_1.png": "ee2ed775947e8a99676c11867709755a",
"assets/assets/images/Arab_ICON.jpg": "e1d80005af7c912dff8bb12086b43cf1",
"assets/assets/images/articl_1.png": "a3d921e81e8e1cf108308e7ebb628b99",
"assets/assets/images/articl_2.png": "5a0efcda643e6cae550fb533fda3dd55",
"assets/assets/images/articl_3.png": "8d1555469c7d0a88f127e01c5d68f6fd",
"assets/assets/images/DIEAYA_1.png": "afb2823a946dca9e6e01a316b13334fa",
"assets/assets/images/DIEAYA_ICON.png": "abccefad0f44a218d2381ceae0430da7",
"assets/assets/images/ELKHAYAL_1.png": "c09ef44cd808cdfe03f5437582eb34e6",
"assets/assets/images/hero.jpg": "4e1c06d17edd9602ed28c63c3cc1febd",
"assets/assets/images/Osool_1.png": "a066df78db870af03c3c27f9519b2cbe",
"assets/assets/images/profile-pic.png": "caaa2eb67141be0968ca38fbca29d18c",
"assets/assets/images/TOBTEN_ICON.png": "62a977ae5061b6301d402d2a54a48d60",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/fonts/MaterialIcons-Regular.otf": "e7069dfd19b331be16bed984668fe080",
"assets/NOTICES": "d48811c7e93d33e3158a60eb8a84231d",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "b93248a553f9e8bc17f1065929d5934b",
"assets/packages/flutter_inappwebview/assets/t_rex_runner/t-rex.css": "5a8d0222407e388155d7d1395a75d5b9",
"assets/packages/flutter_inappwebview/assets/t_rex_runner/t-rex.html": "16911fcc170c8af1c5457940bd0bf055",
"assets/packages/flutter_inappwebview_web/assets/web/web_support.js": "509ae636cfdd93e49b5a6eaf0f06d79f",
"assets/packages/youtube_player_flutter/assets/speedometer.webp": "50448630e948b5b3998ae5a5d112622b",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"canvaskit/canvaskit.js": "66177750aff65a66cb07bb44b8c6422b",
"canvaskit/canvaskit.js.symbols": "48c83a2ce573d9692e8d970e288d75f7",
"canvaskit/canvaskit.wasm": "1f237a213d7370cf95f443d896176460",
"canvaskit/chromium/canvaskit.js": "671c6b4f8fcc199dcc551c7bb125f239",
"canvaskit/chromium/canvaskit.js.symbols": "a012ed99ccba193cf96bb2643003f6fc",
"canvaskit/chromium/canvaskit.wasm": "b1ac05b29c127d86df4bcfbf50dd902a",
"canvaskit/skwasm.js": "694fda5704053957c2594de355805228",
"canvaskit/skwasm.js.symbols": "262f4827a1317abb59d71d6c587a93e2",
"canvaskit/skwasm.wasm": "9f0c0c02b82a910d12ce0543ec130e60",
"canvaskit/skwasm.worker.js": "89990e8c92bcb123999aa81f7e203b1c",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"flutter.js": "f393d3c16b631f36852323de8e583132",
"flutter_bootstrap.js": "b42470c018af3a70687a3181785a3cb7",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"index.html": "26cfce6518d4932acf51cbef6f773c28",
"/": "26cfce6518d4932acf51cbef6f773c28",
"main.dart.js": "8e191ff40e8a195bb5d5abd6be5c1dee",
"manifest.json": "1f669504dbbe32938cdf975a493d24dc",
"version.json": "a1f3fb16d9290b637dc368abe87ef2e4"};
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
