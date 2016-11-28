From: Sebastien Boisvert <sboisvert@gydle.com>
Subject: Re: Can I track a single thread with "lttng track" ?
Date: Mon, 28 Nov 2016 18:02:11 +0100
Message-ID: <507598ed-a775-468a-232d-cbfff75d2d85__16611.4361644306$1480352499$gmane$org@gydle.com>
References: <33eb20f5-51f4-cdd5-bd9a-aa60be0304c6@gydle.com>
 <668701465.17837.1480350803804.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.gydle.com (mail.gydle.com [64.18.173.180])
 by lists.lttng.org (Postfix) with ESMTPS id 3tSCfv1cCrzmH2
 for <lttng-dev@lists.lttng.org>; Mon, 28 Nov 2016 17:03:02 +0000 (UTC)
In-Reply-To: <668701465.17837.1480350803804.JavaMail.zimbra@efficios.com>
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
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

SGkgTWF0aGlldSwKCkluIHRoZSBkb2MgWzFdLCB0aGlzIGNvbW1hbmQgaXMgZG9jdW1lbnRlZDoK
CiAgICBsdHRuZyBhZGQtY29udGV4dCAtLWtlcm5lbCAtLWNoYW5uZWw9bXktY2hhbm5lbCAtLXR5
cGU9dGlkCgoKCk9uIHRoZSB3aWtpIFsyXSwgdGhpcyBjb21tYW5kIGlzIGRvY3VtZW50ZWQ6Cgog
ICAgJCBsdHRuZyBhZGQtY29udGV4dCAtdSAtZSB1c3RfdGVzdHNfaGVsbG86dHB0ZXN0IC10IHBp
ZCAtdCBuaWNlIC10IHRpZAoKCQoKSG93ZXZlciwgaXQgc2VlbXMgdGhhdCBjb250ZXh0IGluZm9y
bWF0aW9uIGlzIG9ubHkgYXZhaWxhYmxlIGluIHRoZSBrZXJuZWwgdHJhY2VyOgoKcm9vdEBaMTov
aG9tZS9zYm9pc3ZlcnQvZ3lkbGUtc2NyaXB0cyMgbHR0bmcgYWRkLWNvbnRleHQgLWsgLXQgdGlk
Cktlcm5lbCBjb250ZXh0IHRpZCBhZGRlZCB0byBhbGwgY2hhbm5lbHMKCnJvb3RAWjE6L2hvbWUv
c2JvaXN2ZXJ0L2d5ZGxlLXNjcmlwdHMjIGx0dG5nIGFkZC1jb250ZXh0IC11IC10IHRpZApFcnJv
cjogdGlkOiBVU1QgaW52YWxpZCBjb250ZXh0Cldhcm5pbmc6IFNvbWUgY29tbWFuZChzKSB3ZW50
IHdyb25nCQkKCgpJcyB0aGVyZSBhIHdheSBhcm91bmQgdGhpcyB0byB1c2UgYWRkIHRpZCBpbiB0
aGUgY29udGV4dCBmb3IgbXkgVVNUIGV2ZW50cyA/CgoKLS0tLS0tLQpbMV0gaHR0cDovL2x0dG5n
Lm9yZy9kb2NzL3YyLjgvClsyXSBodHRwczovL2J1Z3MubHR0bmcub3JnL3Byb2plY3RzL2x0dG5n
LXRvb2xzL3dpa2kKCk9uIDI4LzExLzIwMTYgMTc6MzMsIE1hdGhpZXUgRGVzbm95ZXJzIHdyb3Rl
Ogo+IC0tLS0tIE9uIE5vdiAyOCwgMjAxNiwgYXQgMTE6MzAgQU0sIFNlYmFzdGllbiBCb2lzdmVy
dCBzYm9pc3ZlcnRAZ3lkbGUuY29tIHdyb3RlOgo+IAo+PiBIaSwKPj4KPj4gbHR0bmctdHJhY2sg
aGFzIG9ubHkgLS1waWQ9LiBDYW4gSSB0cmFjayBhIHNpbmdsZSB0aHJlYWQgd2l0aCAibHR0bmcg
dHJhY2siID8KPj4KPj4gSW4gcGVyZiwgdGhlcmUgaXMgdGhlIG9wdGlvbiAtLXBpZD0gYW5kIC0t
dGlkPS4KPiAKPiBObyBub3QgY3VycmVudGx5LAo+IAo+IFRoYW5rcywKPiAKPiBNYXRoaWV1Cj4g
Cj4+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj4+IGx0
dG5nLWRldiBtYWlsaW5nIGxpc3QKPj4gbHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZwo+PiBodHRw
czovL2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmluL21haWxtYW4vbGlzdGluZm8vbHR0bmctZGV2Cj4g
CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsdHRuZy1k
ZXYgbWFpbGluZyBsaXN0Cmx0dG5nLWRldkBsaXN0cy5sdHRuZy5vcmcKaHR0cHM6Ly9saXN0cy5s
dHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRldgo=
