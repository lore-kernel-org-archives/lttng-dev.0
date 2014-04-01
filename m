From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-ust] Fix: Override AM_PATH_PYTHON's
 default action-if-not-found
Date: Tue, 1 Apr 2014 17:47:06 +0000 (UTC)
Message-ID: <1755268860.3617.1396374426194.JavaMail.zimbra__40866.0573339604$1396374507$gmane$org@efficios.com>
References: <OFEFA91F70.CE626678-ONC2257CAD.004B5DA5-C2257CAD.004C1B49@il.ibm.com>
 <1396367398-31434-1-git-send-email-jeremie.galarneau@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1WV2mI-0001Mv-Pm
 for lttng-dev@lists.lttng.org; Tue, 01 Apr 2014 13:47:23 -0400
In-Reply-To: <1396367398-31434-1-git-send-email-jeremie.galarneau@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: =?utf-8?B?SsOpcsOpbWll?= Galarneau <jeremie.galarneau@efficios.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

TWVyZ2VkLCB0aGFua3MhCgpNYXRoaWV1CgotLS0tLSBPcmlnaW5hbCBNZXNzYWdlIC0tLS0tCj4g
RnJvbTogIkrDqXLDqW1pZSBHYWxhcm5lYXUiIDxqZXJlbWllLmdhbGFybmVhdUBlZmZpY2lvcy5j
b20+Cj4gVG86IGx0dG5nLWRldkBsaXN0cy5sdHRuZy5vcmcKPiBDYzogIm1hdGhpZXUgZGVzbm95
ZXJzIiA8bWF0aGlldS5kZXNub3llcnNAZWZmaWNpb3MuY29tPiwgIkrDqXLDqW1pZSBHYWxhcm5l
YXUiIDxqZXJlbWllLmdhbGFybmVhdUBlZmZpY2lvcy5jb20+Cj4gU2VudDogVHVlc2RheSwgQXBy
aWwgMSwgMjAxNCAxMTo0OTo1OCBBTQo+IFN1YmplY3Q6IFtQQVRDSCBsdHRuZy11c3RdIEZpeDog
T3ZlcnJpZGUgQU1fUEFUSF9QWVRIT04ncyBkZWZhdWx0IGFjdGlvbi1pZi1ub3QtZm91bmQKPiAK
PiBBTV9QQVRIX1BZVEhPTidzIGRlZmF1bHQgYWN0aW9uIGFib3J0cyBjb25maWd1cmUuIFRoaXMg
Zml4IGVuc3VyZXMgdGhhdAo+IGNvbmZpZ3VyZSBmb2xsb3dzIHRocm91Z2ggd2l0aCBhIG5vb3Au
Cj4gCj4gU2lnbmVkLW9mZi1ieTogSsOpcsOpbWllIEdhbGFybmVhdSA8amVyZW1pZS5nYWxhcm5l
YXVAZWZmaWNpb3MuY29tPgo+IC0tLQo+ICBjb25maWd1cmUuYWMgfCAyICstCj4gIDEgZmlsZSBj
aGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQo+IAo+IGRpZmYgLS1naXQgYS9j
b25maWd1cmUuYWMgYi9jb25maWd1cmUuYWMKPiBpbmRleCBkNDkyNmU0Li5iMDRkNGUzIDEwMDY0
NAo+IC0tLSBhL2NvbmZpZ3VyZS5hYwo+ICsrKyBiL2NvbmZpZ3VyZS5hYwo+IEBAIC0yODgsNyAr
Mjg4LDcgQEAgQUNfREVGSU5FX1VOUVVPVEVEKFtMVFROR19TWVNURU1fUlVORElSXSwKPiBbIiRs
dHRuZ19zeXN0ZW1fcnVuZGlyIl0sCj4gIGx0dG5nbGliamF2YWRpcj0iJHtsaWJkaXJ9L2x0dG5n
L2phdmEiCj4gIEFDX1NVQlNUKGx0dG5nbGliamF2YWRpcikKPiAgCj4gLUFNX1BBVEhfUFlUSE9O
KFsyLjddLEJVSUxEX0dFTl9UUF9FWEFNUExFUz0xKQo+ICtBTV9QQVRIX1BZVEhPTihbMi43XSxC
VUlMRF9HRU5fVFBfRVhBTVBMRVM9MSxbOl0pCj4gIEFNX0NPTkRJVElPTkFMKFtCVUlMRF9HRU5f
VFBfRVhBTVBMRVNdLCBbdGVzdCAkQlVJTERfR0VOX1RQX0VYQU1QTEVTXSwKPiAgW0J1aWxkIGV4
YW1wbGVzIHJlcXVpcmluZyBsdHRuZy1nZW4tdHBdKQo+ICAKPiAgQUNfQ09ORklHX0ZJTEVTKFsK
PiAtLQo+IDEuOS4xCj4gCj4gCgotLSAKTWF0aGlldSBEZXNub3llcnMKRWZmaWNpT1MgSW5jLgpo
dHRwOi8vd3d3LmVmZmljaW9zLmNvbQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KbHR0bmctZGV2IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0
bmcub3JnCmh0dHA6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0
dG5nLWRldgo=
