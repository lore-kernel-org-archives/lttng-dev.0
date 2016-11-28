From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Can I track a single thread with "lttng track" ?
Date: Mon, 28 Nov 2016 17:06:02 +0000 (UTC)
Message-ID: <1889607545.17951.1480352762803.JavaMail.zimbra__35628.4770802178$1480352712$gmane$org@efficios.com>
References: <33eb20f5-51f4-cdd5-bd9a-aa60be0304c6@gydle.com>
 <668701465.17837.1480350803804.JavaMail.zimbra@efficios.com>
 <507598ed-a775-468a-232d-cbfff75d2d85@gydle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.141])
 by lists.lttng.org (Postfix) with ESMTPS id 3tSCkk69sPzmHX
 for <lttng-dev@lists.lttng.org>; Mon, 28 Nov 2016 17:06:22 +0000 (UTC)
In-Reply-To: <507598ed-a775-468a-232d-cbfff75d2d85@gydle.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Sebastien Boisvert <sboisvert@gydle.com>, Philippe Proulx <philippe.proulx@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Ci0tLS0tIE9uIE5vdiAyOCwgMjAxNiwgYXQgMTI6MDIgUE0sIFNlYmFzdGllbiBCb2lzdmVydCBz
Ym9pc3ZlcnRAZ3lkbGUuY29tIHdyb3RlOgoKPiBIaSBNYXRoaWV1LAo+IAo+IEluIHRoZSBkb2Mg
WzFdLCB0aGlzIGNvbW1hbmQgaXMgZG9jdW1lbnRlZDoKPiAKPiAgICBsdHRuZyBhZGQtY29udGV4
dCAtLWtlcm5lbCAtLWNoYW5uZWw9bXktY2hhbm5lbCAtLXR5cGU9dGlkCj4gCj4gCj4gCj4gT24g
dGhlIHdpa2kgWzJdLCB0aGlzIGNvbW1hbmQgaXMgZG9jdW1lbnRlZDoKPiAKPiAgICAkIGx0dG5n
IGFkZC1jb250ZXh0IC11IC1lIHVzdF90ZXN0c19oZWxsbzp0cHRlc3QgLXQgcGlkIC10IG5pY2Ug
LXQgdGlkCj4gCj4JCj4gCj4gSG93ZXZlciwgaXQgc2VlbXMgdGhhdCBjb250ZXh0IGluZm9ybWF0
aW9uIGlzIG9ubHkgYXZhaWxhYmxlIGluIHRoZSBrZXJuZWwKPiB0cmFjZXI6Cj4gCj4gcm9vdEBa
MTovaG9tZS9zYm9pc3ZlcnQvZ3lkbGUtc2NyaXB0cyMgbHR0bmcgYWRkLWNvbnRleHQgLWsgLXQg
dGlkCj4gS2VybmVsIGNvbnRleHQgdGlkIGFkZGVkIHRvIGFsbCBjaGFubmVscwo+IAo+IHJvb3RA
WjE6L2hvbWUvc2JvaXN2ZXJ0L2d5ZGxlLXNjcmlwdHMjIGx0dG5nIGFkZC1jb250ZXh0IC11IC10
IHRpZAo+IEVycm9yOiB0aWQ6IFVTVCBpbnZhbGlkIGNvbnRleHQKPiBXYXJuaW5nOiBTb21lIGNv
bW1hbmQocykgd2VudCB3cm9uZwo+IAo+IAo+IElzIHRoZXJlIGEgd2F5IGFyb3VuZCB0aGlzIHRv
IHVzZSBhZGQgdGlkIGluIHRoZSBjb250ZXh0IGZvciBteSBVU1QgZXZlbnRzID8KClVzZSB0aGUg
InZ0aWQiIGNvbnRleHQuCgpUaGUgd2lraSBpcyBvdXRkYXRlZC4gSSB3aWxsIGxldCBQaGlsaXBw
ZSBoYXZlIGEgbG9vayBhdCBbMl0gYW5kIGZpZ3VyZQpvdXQgaWYgd2UgbmVlZCB0byBkZXByZWNh
dGUgaXQuIFRoZSBuZXcgbHR0bmcgZG9jdW1lbnRhdGlvbiBoYXMgYWxsIHRoaXMKYW5kIG1vcmUu
Li4KClRoYW5rcywKCk1hdGhpZXUKCj4gCj4gCj4gLS0tLS0tLQo+IFsxXSBodHRwOi8vbHR0bmcu
b3JnL2RvY3MvdjIuOC8KPiBbMl0gaHR0cHM6Ly9idWdzLmx0dG5nLm9yZy9wcm9qZWN0cy9sdHRu
Zy10b29scy93aWtpCj4gCj4gT24gMjgvMTEvMjAxNiAxNzozMywgTWF0aGlldSBEZXNub3llcnMg
d3JvdGU6Cj4+IC0tLS0tIE9uIE5vdiAyOCwgMjAxNiwgYXQgMTE6MzAgQU0sIFNlYmFzdGllbiBC
b2lzdmVydCBzYm9pc3ZlcnRAZ3lkbGUuY29tCj4+IHdyb3RlOgo+PiAKPj4+IEhpLAo+Pj4KPj4+
IGx0dG5nLXRyYWNrIGhhcyBvbmx5IC0tcGlkPS4gQ2FuIEkgdHJhY2sgYSBzaW5nbGUgdGhyZWFk
IHdpdGggImx0dG5nIHRyYWNrIiA/Cj4+Pgo+Pj4gSW4gcGVyZiwgdGhlcmUgaXMgdGhlIG9wdGlv
biAtLXBpZD0gYW5kIC0tdGlkPS4KPj4gCj4+IE5vIG5vdCBjdXJyZW50bHksCj4+IAo+PiBUaGFu
a3MsCj4+IAo+PiBNYXRoaWV1Cj4+IAo+Pj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KPj4+IGx0dG5nLWRldiBtYWlsaW5nIGxpc3QKPj4+IGx0dG5nLWRl
dkBsaXN0cy5sdHRuZy5vcmcKPj4+IGh0dHBzOi8vbGlzdHMubHR0bmcub3JnL2NnaS1iaW4vbWFp
bG1hbi9saXN0aW5mby9sdHRuZy1kZXYKCi0tIApNYXRoaWV1IERlc25veWVycwpFZmZpY2lPUyBJ
bmMuCmh0dHA6Ly93d3cuZWZmaWNpb3MuY29tCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmx0dG5nLWRldiBtYWlsaW5nIGxpc3QKbHR0bmctZGV2QGxpc3Rz
Lmx0dG5nLm9yZwpodHRwczovL2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmluL21haWxtYW4vbGlzdGlu
Zm8vbHR0bmctZGV2Cg==
