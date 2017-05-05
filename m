From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: lttng-tools build failure with uClibc due to
 dlmopen()
Date: Fri, 5 May 2017 23:19:24 +0200
Message-ID: <20170505231924.60e6aa49__7597.97054711289$1494019193$gmane$org@free-electrons.com>
References: <20170301000945.38a285dc@free-electrons.com>
 <20170429154823.4cbd2d32@free-electrons.com>
 <CA+jJMxuXm+UEUiMXKrjBWvj7zTP81FzW9diFWiueu3CCaWypbg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.free-electrons.com (mail.free-electrons.com [62.4.15.54])
 by lists.lttng.org (Postfix) with ESMTP id 3wKPv14dt2zCNT
 for <lttng-dev@lists.lttng.org>; Fri,  5 May 2017 21:20:29 +0000 (UTC)
In-Reply-To: <CA+jJMxuXm+UEUiMXKrjBWvj7zTP81FzW9diFWiueu3CCaWypbg@mail.gmail.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: =?UTF-8?B?SsOpcsOpbWll?= Galarneau <jeremie.galarneau@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

SGVsbG8sCgpUaGFua3MgZm9yIHlvdXIgZmVlZGJhY2shCgpPbiBGcmksIDUgTWF5IDIwMTcgMTU6
NDI6NTIgLTA0MDAsIErDqXLDqW1pZSBHYWxhcm5lYXUgd3JvdGU6Cgo+IFRoaXMgcGF0Y2ggaXMg
YXZhaWxhYmxlOgo+IGh0dHBzOi8vZ2l0aHViLmNvbS9hbHBpbmVsaW51eC9hcG9ydHMvYmxvYi9t
YXN0ZXIvdGVzdGluZy9sdHRuZy10b29scy9tdXNsLWhhcy1uby1kbG1vcGVuLnBhdGNoCj4gCj4g
SG93ZXZlciwgSSB3b24ndCBtZXJnZSBpdCBhcy1pcyBzaW5jZSBpdCBkaXNhYmxlcyBhbGwgZGxt
b3BlbiB0ZXN0cwo+IG91dHJpZ2h0LiBJJ2QgcmF0aGVyIGRpc2FibGUgdGhlbSBvbmx5IHdoZW4g
aXQgaXMgbm90IGF2YWlsYWJsZS4KClNpbmNlIEFscGluZUxpbnV4IGlzIHVzaW5nIG11c2wgb25s
eSwgdGhleSBvZnRlbiB1c2Ugc29sdXRpb25zIHRoYXQKd29yayBmaW5lIGZvciBtdXNsLCBidXQg
YXJlIG5vdCBuZWNlc3NhcmlseSBhcHBsaWNhYmxlIGluIGEgbW9yZQpnZW5lcmFsIHdheS4KCkJ1
aWxkcm9vdCBwcm92aWRlcyBzdXBwb3J0IGZvciBnbGliYywgdWNsaWJjIGFuZCBtdXNsLCBzbyBB
bHBpbmVMaW51eCdzCnNvbHV0aW9uIGlzIG5vdCBzdWl0YWJsZSBhcy1pcy4KCkZvciBub3csIHdl
IGhhdmUgc2ltcGx5IGRpc2FibGVkIGx0dG5nLXRvb2xzIGZvciB1Y2xpYmMgYW5kIG11c2wKdG9v
bGNoYWlucyBpbiBCdWlsZHJvb3QuCgpCZXN0IHJlZ2FyZHMsCgpUaG9tYXMKLS0gClRob21hcyBQ
ZXRhenpvbmksIENUTywgRnJlZSBFbGVjdHJvbnMKRW1iZWRkZWQgTGludXggYW5kIEtlcm5lbCBl
bmdpbmVlcmluZwpodHRwOi8vZnJlZS1lbGVjdHJvbnMuY29tCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCmx0dG5nLWRldiBtYWlsaW5nIGxpc3QKbHR0bmct
ZGV2QGxpc3RzLmx0dG5nLm9yZwpodHRwczovL2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmluL21haWxt
YW4vbGlzdGluZm8vbHR0bmctZGV2Cg==
