From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH babeltrace] Fix: glib >= 2.32 required for
 g_hash_table_contains() in lib/values.c
Date: Mon, 21 Sep 2015 17:15:59 -0400
Message-ID: <CA+jJMxtE38xCqs_XZaMCErKsn4Li2MgNkceouBHXUn+aRSp__w__40590.2386214167$1442870215$gmane$org@mail.gmail.com>
References: <1442868519-22000-1-git-send-email-mjeanson@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-yk0-f170.google.com ([209.85.160.170])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jeremie.galarneau@gmail.com>) id 1Ze8RQ-00034P-GZ
 for lttng-dev@lists.lttng.org; Mon, 21 Sep 2015 17:16:05 -0400
Received: by ykdt18 with SMTP id t18so115935193ykd.3
 for <lttng-dev@lists.lttng.org>; Mon, 21 Sep 2015 14:15:59 -0700 (PDT)
In-Reply-To: <1442868519-22000-1-git-send-email-mjeanson@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Michael Jeanson <mjeanson@efficios.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>, Jeremie Galarneau <jgalar@efficios.com>
List-Id: lttng-dev@lists.lttng.org

V2UgY291bGQgY2hhbmdlIHRoZSB1c2VzIG9mIGdfaGFzaF90YWJsZV9jb250YWlucygpIHRvIHVz
ZQpnX2hhc2hfdGFibGVfZmluZCgpICh3aGljaCB3YXMgcHJlc2VudCBpbiAyLjQpLgoKSG93ZXZl
ciwgYXQgdGhpcyBwb2ludCBJIHdvdWxkbid0IGZlZWwgdG9vIGJhZCBidW1waW5nIHRoZSBkZXBl
bmRlbmN5CnRvIDIuMzIgaW4gQlQgMi4wIGNvbnNpZGVyaW5nIGdsaWIgMi4zMiB3YXMgcmVsZWFz
ZWQgaW4gTWFyY2ggMjAxMiBhbmQKd2FzLCBBRkFJQ1QsIHNoaXBwZWQgaW4gVWJ1bnR1IDEyLjA0
Li4uIE5vIHN0cm9uZyBvcGluaW9uLgoKTWF0aGlldSwgdGhvdWdodHM/CgpKw6lyw6ltaWUKCk9u
IE1vbiwgU2VwIDIxLCAyMDE1IGF0IDQ6NDggUE0sIE1pY2hhZWwgSmVhbnNvbiA8bWplYW5zb25A
ZWZmaWNpb3MuY29tPiB3cm90ZToKPiAtLS0KPiAgY29uZmlndXJlLmFjIHwgMiArLQo+ICAxIGZp
bGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKPgo+IGRpZmYgLS1naXQg
YS9jb25maWd1cmUuYWMgYi9jb25maWd1cmUuYWMKPiBpbmRleCBkYzIzZGFhLi5hODE1Mjc0IDEw
MDY0NAo+IC0tLSBhL2NvbmZpZ3VyZS5hYwo+ICsrKyBiL2NvbmZpZ3VyZS5hYwo+IEBAIC01NCw3
ICs1NCw3IEBAIGlmIHRlc3QgISAtZiAiJHNyY2Rpci9mb3JtYXRzL2N0Zi9tZXRhZGF0YS9jdGYt
bGV4ZXIuYyI7IHRoZW4KPiAgZmkKPgo+Cj4gLUFNX1BBVEhfR0xJQl8yXzAoMi4yMi4wLCAsQUNf
TVNHX0VSUk9SKFtnbGliIGlzIHJlcXVpcmVkIGluIG9yZGVyIHRvIGNvbXBpbGUgQmFiZWxUcmFj
ZSAtIGRvd25sb2FkIGl0IGZyb20gZnRwOi8vZnRwLmd0ay5vcmcvcHViL2d0a10pICwgZ21vZHVs
ZSkKPiArQU1fUEFUSF9HTElCXzJfMCgyLjMyLjAsICxBQ19NU0dfRVJST1IoW2dsaWIgaXMgcmVx
dWlyZWQgaW4gb3JkZXIgdG8gY29tcGlsZSBCYWJlbFRyYWNlIC0gZG93bmxvYWQgaXQgZnJvbSBm
dHA6Ly9mdHAuZ3RrLm9yZy9wdWIvZ3RrXSkgLCBnbW9kdWxlKQo+Cj4gICMgQ2hlY2tzIGZvciB0
eXBlZGVmcywgc3RydWN0dXJlcywgYW5kIGNvbXBpbGVyIGNoYXJhY3RlcmlzdGljcy4KPiAgQUNf
Q19JTkxJTkUKPiAtLQo+IDEuOS4xCj4KCgoKLS0gCkrDqXLDqW1pZSBHYWxhcm5lYXUKRWZmaWNp
T1MgSW5jLgpodHRwOi8vd3d3LmVmZmljaW9zLmNvbQoKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2IG1haWxpbmcgbGlzdApsdHRuZy1kZXZA
bGlzdHMubHR0bmcub3JnCmh0dHA6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xp
c3RpbmZvL2x0dG5nLWRldgo=
