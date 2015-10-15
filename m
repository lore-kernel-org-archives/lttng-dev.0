From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH babeltrace] Fix: memstream compat layer
	requires use of babeltrace_close_memstream
Date: Thu, 15 Oct 2015 14:39:20 -0400
Message-ID: <CA+jJMxtcZ+ZJRW72qNjfHX6XkJqvh3G+wi01ceVHx0F8q++42g__26489.7658410066$1444934439$gmane$org@mail.gmail.com>
References: <1444925328-16174-1-git-send-email-mjeanson@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-yk0-f177.google.com ([209.85.160.177])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jeremie.galarneau@gmail.com>) id 1ZmnR0-0005Jf-35
 for lttng-dev@lists.lttng.org; Thu, 15 Oct 2015 14:39:27 -0400
Received: by yknn9 with SMTP id n9so12654775ykn.0
 for <lttng-dev@lists.lttng.org>; Thu, 15 Oct 2015 11:39:20 -0700 (PDT)
In-Reply-To: <1444925328-16174-1-git-send-email-mjeanson@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Michael Jeanson <mjeanson@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>, Jeremie Galarneau <jgalar@efficios.com>
List-Id: lttng-dev@lists.lttng.org

TWVyZ2VkLCB0aGFua3MhCgpKw6lyw6ltaWUKCk9uIFRodSwgT2N0IDE1LCAyMDE1IGF0IDEyOjA4
IFBNLCBNaWNoYWVsIEplYW5zb24gPG1qZWFuc29uQGVmZmljaW9zLmNvbT4gd3JvdGU6Cj4gRnJv
bTogTWF0aGlldSBEZXNub3llcnMgPG1hdGhpZXUuZGVzbm95ZXJzQGVmZmljaW9zLmNvbT4KPgo+
IEluIGNvbXBhdGliaWxpdHkgbW9kZSwgdGhlIGJhYmVsdHJhY2UgY29tcGF0IGxheWVyIGFyb3Vu
ZCBtZW1zdHJlYW0KPiBjb3BpZXMgdGhlIGZpbGUgY29udGVudCBpbnRvIHRoZSBidWZmZXIgb25s
eSBhdCBjbG9zZS4KPgo+IFNpZ25lZC1vZmYtYnk6IE1hdGhpZXUgRGVzbm95ZXJzIDxtYXRoaWV1
LmRlc25veWVyc0BlZmZpY2lvcy5jb20+Cj4gLS0tCj4gIGZvcm1hdHMvbHR0bmctbGl2ZS9sdHRu
Zy1saXZlLWNvbW0uYyB8IDUgKysrLS0KPiAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygr
KSwgMiBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1naXQgYS9mb3JtYXRzL2x0dG5nLWxpdmUvbHR0
bmctbGl2ZS1jb21tLmMgYi9mb3JtYXRzL2x0dG5nLWxpdmUvbHR0bmctbGl2ZS1jb21tLmMKPiBp
bmRleCA5MWUzNDRjLi42NDIyZTY1IDEwMDY0NAo+IC0tLSBhL2Zvcm1hdHMvbHR0bmctbGl2ZS9s
dHRuZy1saXZlLWNvbW0uYwo+ICsrKyBiL2Zvcm1hdHMvbHR0bmctbGl2ZS9sdHRuZy1saXZlLWNv
bW0uYwo+IEBAIC05MzIsOCArOTMyLDkgQEAgaW50IGdldF9uZXdfbWV0YWRhdGEoc3RydWN0IGx0
dG5nX2xpdmVfY3R4ICpjdHgsCj4gICAgICAgICAgICAgICAgIH0KPiAgICAgICAgIH0gd2hpbGUg
KHJldCA+IDAgfHwgIWxlbl9yZWFkKTsKPgo+IC0gICAgICAgaWYgKGZjbG9zZShtZXRhZGF0YV9z
dHJlYW0tPm1ldGFkYXRhX2ZwX3dyaXRlKSkKPiAtICAgICAgICAgICAgICAgcGVycm9yKCJmY2xv
c2UiKTsKPiArICAgICAgIGlmIChiYWJlbHRyYWNlX2Nsb3NlX21lbXN0cmVhbShtZXRhZGF0YV9i
dWYsICZzaXplLAo+ICsgICAgICAgICAgICAgICAgICAgICAgIG1ldGFkYXRhX3N0cmVhbS0+bWV0
YWRhdGFfZnBfd3JpdGUpKQo+ICsgICAgICAgICAgICAgICBwZXJyb3IoImJhYmVsdHJhY2VfY2xv
c2VfbWVtc3RyZWFtIik7Cj4gICAgICAgICBtZXRhZGF0YV9zdHJlYW0tPm1ldGFkYXRhX2ZwX3dy
aXRlID0gTlVMTDsKPgo+ICBlcnJvcjoKPiAtLQo+IDEuOS4xCj4KCgoKLS0gCkrDqXLDqW1pZSBH
YWxhcm5lYXUKRWZmaWNpT1MgSW5jLgpodHRwOi8vd3d3LmVmZmljaW9zLmNvbQoKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2IG1haWxpbmcg
bGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHA6Ly9saXN0cy5sdHRuZy5vcmcvY2dp
LWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRldgo=
