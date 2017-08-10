From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH] Fix test: ctf writer has too large offset_s
Date: Thu, 10 Aug 2017 15:21:23 -0400
Message-ID: <CA+jJMxswywOGpkaP71oGRP+L+pw5fFFMhxxCvvArnwdu1G295g__41078.4065294594$1502392896$gmane$org@mail.gmail.com>
References: <1502219928-17184-1-git-send-email-mjeanson@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-yw0-x243.google.com (mail-yw0-x243.google.com
 [IPv6:2607:f8b0:4002:c05::243])
 by lists.lttng.org (Postfix) with ESMTPS id 3xSyft0Rx3ztLS
 for <lttng-dev@lists.lttng.org>; Thu, 10 Aug 2017 19:21:25 +0000 (UTC)
Received: by mail-yw0-x243.google.com with SMTP id u207so1028613ywc.0
 for <lttng-dev@lists.lttng.org>; Thu, 10 Aug 2017 12:21:25 -0700 (PDT)
In-Reply-To: <1502219928-17184-1-git-send-email-mjeanson@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Michael Jeanson <mjeanson@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>, Jeremie Galarneau <jgalar@efficios.com>
List-Id: lttng-dev@lists.lttng.org

VGhpcyB3YXMgZml4ZWQgYXMgcGFydCBvZiBhIHB1bGwgcmVxdWVzdCBbMV0gd2hpY2ggd2FzIG1l
cmdlZCB5ZXN0ZXJkYXkuCgpUaGFua3MhCkrDqXLDqW1pZQoKWzFdIGh0dHBzOi8vZ2l0aHViLmNv
bS9lZmZpY2lvcy9iYWJlbHRyYWNlL3B1bGwvNzUKCk9uIDggQXVndXN0IDIwMTcgYXQgMTU6MTgs
IE1pY2hhZWwgSmVhbnNvbiA8bWplYW5zb25AZWZmaWNpb3MuY29tPiB3cm90ZToKPiBUaGUgb2Zm
c2V0X3MgdmFsdWVzIG11bHRpcGxpZWQgYnkgMTAwMDAwMDAwMCBvdmVyZmxvd3MgNjQtYml0Lgo+
Cj4gU2lnbmVkLW9mZi1ieTogTWljaGFlbCBKZWFuc29uIDxtamVhbnNvbkBlZmZpY2lvcy5jb20+
Cj4gLS0tCj4gIHRlc3RzL2xpYi90ZXN0X2N0Zl93cml0ZXIuYyB8IDIgKy0KPiAgMSBmaWxlIGNo
YW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCj4KPiBkaWZmIC0tZ2l0IGEvdGVz
dHMvbGliL3Rlc3RfY3RmX3dyaXRlci5jIGIvdGVzdHMvbGliL3Rlc3RfY3RmX3dyaXRlci5jCj4g
aW5kZXggZDNjN2E5Ni4uY2NkOGEyNCAxMDA2NDQKPiAtLS0gYS90ZXN0cy9saWIvdGVzdF9jdGZf
d3JpdGVyLmMKPiArKysgYi90ZXN0cy9saWIvdGVzdF9jdGZfd3JpdGVyLmMKPiBAQCAtMjgzMCw3
ICsyODMwLDcgQEAgaW50IG1haW4oaW50IGFyZ2MsIGNoYXIgKiphcmd2KQo+ICAgICAgICAgY29u
c3QgY2hhciAqcmV0dXJuZWRfY2xvY2tfbmFtZTsKPiAgICAgICAgIGNvbnN0IGNoYXIgKnJldHVy
bmVkX2Nsb2NrX2Rlc2NyaXB0aW9uOwo+ICAgICAgICAgY29uc3QgdWludDY0X3QgZnJlcXVlbmN5
ID0gMTEyMzQ1Njc4OTsKPiAtICAgICAgIGNvbnN0IGludDY0X3Qgb2Zmc2V0X3MgPSAxMzUxNTMw
OTI5OTQ1ODI0MzIzOwo+ICsgICAgICAgY29uc3QgaW50NjRfdCBvZmZzZXRfcyA9IDEzNTE1MzA5
Owo+ICAgICAgICAgY29uc3QgaW50NjRfdCBvZmZzZXQgPSAxMjM0NTY3Owo+ICAgICAgICAgaW50
NjRfdCBnZXRfb2Zmc2V0X3MsCj4gICAgICAgICAgICAgICAgIGdldF9vZmZzZXQ7Cj4gLS0KPiAy
LjcuNAo+CgoKCi0tIApKw6lyw6ltaWUgR2FsYXJuZWF1CkVmZmljaU9TIEluYy4KaHR0cDovL3d3
dy5lZmZpY2lvcy5jb20KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KbHR0bmctZGV2IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0
dHBzOi8vbGlzdHMubHR0bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK
