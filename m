From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH babeltrace] Fix: use the configured swig
	executable
Date: Mon, 18 Sep 2017 17:52:04 -0400
Message-ID: <CA+jJMxvphVZgX1TXrNA1L7gWqFLSM8rg6JqZ4+Rs39J6j1xFdw__40087.3138606132$1505771533$gmane$org@mail.gmail.com>
References: <1505770093-23415-1-git-send-email-mjeanson@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qt0-x242.google.com (mail-qt0-x242.google.com
 [IPv6:2607:f8b0:400d:c0d::242])
 by lists.lttng.org (Postfix) with ESMTPS id 3xx08k3pnXzDRc
 for <lttng-dev@lists.lttng.org>; Mon, 18 Sep 2017 21:52:06 +0000 (UTC)
Received: by mail-qt0-x242.google.com with SMTP id t46so1225518qtj.3
 for <lttng-dev@lists.lttng.org>; Mon, 18 Sep 2017 14:52:06 -0700 (PDT)
In-Reply-To: <1505770093-23415-1-git-send-email-mjeanson@efficios.com>
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

TWVyZ2VkIGluIG1hc3RlciBhbmQgc3RhYmxlLTIuMC4KClRoYW5rcyEKSsOpcsOpbWllCgpPbiAx
OCBTZXB0ZW1iZXIgMjAxNyBhdCAxNzoyOCwgTWljaGFlbCBKZWFuc29uIDxtamVhbnNvbkBlZmZp
Y2lvcy5jb20+IHdyb3RlOgo+IFNpZ25lZC1vZmYtYnk6IE1pY2hhZWwgSmVhbnNvbiA8bWplYW5z
b25AZWZmaWNpb3MuY29tPgo+IC0tLQo+ICBiaW5kaW5ncy9weXRob24vYnQyL01ha2VmaWxlLmFt
IHwgMiArLQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkK
Pgo+IGRpZmYgLS1naXQgYS9iaW5kaW5ncy9weXRob24vYnQyL01ha2VmaWxlLmFtIGIvYmluZGlu
Z3MvcHl0aG9uL2J0Mi9NYWtlZmlsZS5hbQo+IGluZGV4IGZlMWM4M2IuLjk0NzRlYmIgMTAwNjQ0
Cj4gLS0tIGEvYmluZGluZ3MvcHl0aG9uL2J0Mi9NYWtlZmlsZS5hbQo+ICsrKyBiL2JpbmRpbmdz
L3B5dGhvbi9idDIvTWFrZWZpbGUuYW0KPiBAQCAtODAsNyArODAsNyBAQCBjb3B5LXN0YXRpYy1k
ZXBzLnN0YW1wOiAkKFNUQVRJQ19CSU5ESU5HU19ERVBTKQo+ICAgICAgICAgdG91Y2ggJEAKPgo+
ICBidWlsZC1weXRob24tYmluZGluZ3Muc3RhbXA6IGNvcHktc3RhdGljLWRlcHMuc3RhbXAgJChH
RU5FUkFURURfQklORElOR1NfREVQUykKPiAtICAgICAgICQoQlVJTERfRkxBR1MpICQoUFlUSE9O
KSAkKGJ1aWxkZGlyKS9zZXR1cC5weSBidWlsZF9leHQKPiArICAgICAgICQoQlVJTERfRkxBR1Mp
ICQoUFlUSE9OKSAkKGJ1aWxkZGlyKS9zZXR1cC5weSBidWlsZF9leHQgLS1zd2lnICIkKFNXSUcp
Igo+ICAgICAgICAgJChCVUlMRF9GTEFHUykgJChQWVRIT04pICQoYnVpbGRkaXIpL3NldHVwLnB5
IGJ1aWxkCj4gICAgICAgICB0b3VjaCAkQAo+Cj4gLS0KPiAyLjcuNAo+CgoKCi0tIApKw6lyw6lt
aWUgR2FsYXJuZWF1CkVmZmljaU9TIEluYy4KaHR0cDovL3d3dy5lZmZpY2lvcy5jb20KX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2IG1haWxp
bmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0bmcub3Jn
L2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK
