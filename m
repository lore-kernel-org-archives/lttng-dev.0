From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH lttng-tools 01/10] Fix: bad file descriptors
 on close after rotation error
Date: Wed, 18 May 2016 22:57:48 -0400
Message-ID: <CA+jJMxutuOzZPxsBJTQOUpWQa32EhxiFukaoiwcL=T4MNCnYBQ__25846.9397588216$1463626691$gmane$org@mail.gmail.com>
References: <1463594659-10964-1-git-send-email-mathieu.desnoyers@efficios.com>
 <1463594659-10964-2-git-send-email-mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qk0-f196.google.com (mail-qk0-f196.google.com
 [209.85.220.196])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id 19C8BA35B4
 for <lttng-dev@lists.lttng.org>; Thu, 19 May 2016 02:57:49 +0000 (UTC)
Received: by mail-qk0-f196.google.com with SMTP id i7so6458122qkd.1
 for <lttng-dev@lists.lttng.org>; Wed, 18 May 2016 19:57:49 -0700 (PDT)
In-Reply-To: <1463594659-10964-2-git-send-email-mathieu.desnoyers@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>, Jeremie Galarneau <jgalar@efficios.com>
List-Id: lttng-dev@lists.lttng.org

TWVyZ2VkLCB0aGFua3MhCgpKw6lyw6ltaWUKCk9uIFdlZCwgTWF5IDE4LCAyMDE2IGF0IDI6MDQg
UE0sIE1hdGhpZXUgRGVzbm95ZXJzCjxtYXRoaWV1LmRlc25veWVyc0BlZmZpY2lvcy5jb20+IHdy
b3RlOgo+IEVuc3VyZSB3ZSBkb24ndCB0cnkgdG8gY2xvc2Ugb3V0cHV0IHN0cmVhbSBmaWxlIGRl
c2NyaXB0b3JzIHR3aWNlIHdoZW4gYQo+IHRyYWNlIGZpbGUgcm90YXRpb24gZXJyb3Igb2NjdXJz
IChvbmNlIGF0IHRyYWNlZmlsZSByb3RhdGlvbiwgb25jZSB3aGVuCj4gY2xvc2luZyB0aGUgc3Ry
ZWFtKS4gU2V0IHRoZSBmZCB2YWx1ZSB0byAtMSBhZnRlciB0aGUgZmlyc3QgY2xvc2UgdG8KPiBl
bnN1cmUgd2UgZG9uJ3QgdHJ5IHRvIGNsb3NlIGl0IGFnYWluLgo+Cj4gU2lnbmVkLW9mZi1ieTog
TWF0aGlldSBEZXNub3llcnMgPG1hdGhpZXUuZGVzbm95ZXJzQGVmZmljaW9zLmNvbT4KPiAtLS0K
PiAgc3JjL2NvbW1vbi91dGlscy5jIHwgMSArCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlv
bigrKQo+Cj4gZGlmZiAtLWdpdCBhL3NyYy9jb21tb24vdXRpbHMuYyBiL3NyYy9jb21tb24vdXRp
bHMuYwo+IGluZGV4IGRmNTVkYzkuLmZkZDg4MDIgMTAwNjQ0Cj4gLS0tIGEvc3JjL2NvbW1vbi91
dGlscy5jCj4gKysrIGIvc3JjL2NvbW1vbi91dGlscy5jCj4gQEAgLTg1MCw2ICs4NTAsNyBAQCBp
bnQgdXRpbHNfcm90YXRlX3N0cmVhbV9maWxlKGNoYXIgKnBhdGhfbmFtZSwgY2hhciAqZmlsZV9u
YW1lLCB1aW50NjRfdCBzaXplLAo+ICAgICAgICAgICAgICAgICBQRVJST1IoIkNsb3NpbmcgdHJh
Y2VmaWxlIik7Cj4gICAgICAgICAgICAgICAgIGdvdG8gZXJyb3I7Cj4gICAgICAgICB9Cj4gKyAg
ICAgICAqc3RyZWFtX2ZkID0gLTE7Cj4KPiAgICAgICAgIGlmIChjb3VudCA+IDApIHsKPiAgICAg
ICAgICAgICAgICAgLyoKPiAtLQo+IDIuMS40Cj4KCgoKLS0gCkrDqXLDqW1pZSBHYWxhcm5lYXUK
RWZmaWNpT1MgSW5jLgpodHRwOi8vd3d3LmVmZmljaW9zLmNvbQpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsdHRuZy1kZXYgbWFpbGluZyBsaXN0Cmx0dG5n
LWRldkBsaXN0cy5sdHRuZy5vcmcKaHR0cHM6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWls
bWFuL2xpc3RpbmZvL2x0dG5nLWRldgo=
