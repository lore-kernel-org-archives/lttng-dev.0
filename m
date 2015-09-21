From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH babeltrace] Fix: glib >= 2.32 required for
 g_hash_table_contains() in lib/values.c
Date: Mon, 21 Sep 2015 21:42:28 +0000 (UTC)
Message-ID: <1764835261.12939.1442871748994.JavaMail.zimbra__2153.59573853693$1442871813$gmane$org@efficios.com>
References: <1442868519-22000-1-git-send-email-mjeanson@efficios.com>
 <CA+jJMxtE38xCqs_XZaMCErKsn4Li2MgNkceouBHXUn+aRSp__w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1Ze8rF-0003F3-0g
 for lttng-dev@lists.lttng.org; Mon, 21 Sep 2015 17:42:46 -0400
In-Reply-To: <CA+jJMxtE38xCqs_XZaMCErKsn4Li2MgNkceouBHXUn+aRSp__w@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Jeremie Galarneau <jeremie.galarneau@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>, Jeremie Galarneau <jgalar@efficios.com>
List-Id: lttng-dev@lists.lttng.org

LS0tLS0gT24gU2VwIDIxLCAyMDE1LCBhdCA1OjE1IFBNLCBKZXJlbWllIEdhbGFybmVhdSBqZXJl
bWllLmdhbGFybmVhdUBlZmZpY2lvcy5jb20gd3JvdGU6Cgo+IFdlIGNvdWxkIGNoYW5nZSB0aGUg
dXNlcyBvZiBnX2hhc2hfdGFibGVfY29udGFpbnMoKSB0byB1c2UKPiBnX2hhc2hfdGFibGVfZmlu
ZCgpICh3aGljaCB3YXMgcHJlc2VudCBpbiAyLjQpLgo+IAo+IEhvd2V2ZXIsIGF0IHRoaXMgcG9p
bnQgSSB3b3VsZG4ndCBmZWVsIHRvbyBiYWQgYnVtcGluZyB0aGUgZGVwZW5kZW5jeQo+IHRvIDIu
MzIgaW4gQlQgMi4wIGNvbnNpZGVyaW5nIGdsaWIgMi4zMiB3YXMgcmVsZWFzZWQgaW4gTWFyY2gg
MjAxMiBhbmQKPiB3YXMsIEFGQUlDVCwgc2hpcHBlZCBpbiBVYnVudHUgMTIuMDQuLi4gTm8gc3Ry
b25nIG9waW5pb24uCj4gCj4gTWF0aGlldSwgdGhvdWdodHM/CgpTTEVTIDExIHNwMyBzdGlsbCBo
YXMgZ2xpYiAyLjIyCgoKPiAKPiBKw6lyw6ltaWUKPiAKPiBPbiBNb24sIFNlcCAyMSwgMjAxNSBh
dCA0OjQ4IFBNLCBNaWNoYWVsIEplYW5zb24gPG1qZWFuc29uQGVmZmljaW9zLmNvbT4gd3JvdGU6
Cj4+IC0tLQo+PiAgY29uZmlndXJlLmFjIHwgMiArLQo+PiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5z
ZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCj4+Cj4+IGRpZmYgLS1naXQgYS9jb25maWd1cmUuYWMg
Yi9jb25maWd1cmUuYWMKPj4gaW5kZXggZGMyM2RhYS4uYTgxNTI3NCAxMDA2NDQKPj4gLS0tIGEv
Y29uZmlndXJlLmFjCj4+ICsrKyBiL2NvbmZpZ3VyZS5hYwo+PiBAQCAtNTQsNyArNTQsNyBAQCBp
ZiB0ZXN0ICEgLWYgIiRzcmNkaXIvZm9ybWF0cy9jdGYvbWV0YWRhdGEvY3RmLWxleGVyLmMiOyB0
aGVuCj4+ICBmaQo+Pgo+Pgo+PiAtQU1fUEFUSF9HTElCXzJfMCgyLjIyLjAsICxBQ19NU0dfRVJS
T1IoW2dsaWIgaXMgcmVxdWlyZWQgaW4gb3JkZXIgdG8gY29tcGlsZQo+PiBCYWJlbFRyYWNlIC0g
ZG93bmxvYWQgaXQgZnJvbSBmdHA6Ly9mdHAuZ3RrLm9yZy9wdWIvZ3RrXSkgLCBnbW9kdWxlKQo+
PiArQU1fUEFUSF9HTElCXzJfMCgyLjMyLjAsICxBQ19NU0dfRVJST1IoW2dsaWIgaXMgcmVxdWly
ZWQgaW4gb3JkZXIgdG8gY29tcGlsZQo+PiBCYWJlbFRyYWNlIC0gZG93bmxvYWQgaXQgZnJvbSBm
dHA6Ly9mdHAuZ3RrLm9yZy9wdWIvZ3RrXSkgLCBnbW9kdWxlKQo+Pgo+PiAgIyBDaGVja3MgZm9y
IHR5cGVkZWZzLCBzdHJ1Y3R1cmVzLCBhbmQgY29tcGlsZXIgY2hhcmFjdGVyaXN0aWNzLgo+PiAg
QUNfQ19JTkxJTkUKPj4gLS0KPj4gMS45LjEKPj4KPiAKPiAKPiAKPiAtLQo+IErDqXLDqW1pZSBH
YWxhcm5lYXUKPiBFZmZpY2lPUyBJbmMuCj4gaHR0cDovL3d3dy5lZmZpY2lvcy5jb20KCi0tIApN
YXRoaWV1IERlc25veWVycwpFZmZpY2lPUyBJbmMuCmh0dHA6Ly93d3cuZWZmaWNpb3MuY29tCgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsdHRuZy1kZXYg
bWFpbGluZyBsaXN0Cmx0dG5nLWRldkBsaXN0cy5sdHRuZy5vcmcKaHR0cDovL2xpc3RzLmx0dG5n
Lm9yZy9jZ2ktYmluL21haWxtYW4vbGlzdGluZm8vbHR0bmctZGV2Cg==
