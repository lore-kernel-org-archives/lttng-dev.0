From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH lttng-tools] Fix: warning 'fd' may be used
 uninitialized
Date: Tue, 22 Jan 2019 14:34:15 -0500
Message-ID: <CA+jJMxsWvTXunjWAFBFhfcB4N+cFBponYLLqfvTz7RRVaRuCQQ__31573.876906053$1548185708$gmane$org@mail.gmail.com>
References: <20181129214951.1960-1-mjeanson@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 43kdsn54fDznWR
 for <lttng-dev@lists.lttng.org>; Tue, 22 Jan 2019 14:34:53 -0500 (EST)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id 5B098B5E77
 for <lttng-dev@lists.lttng.org>; Tue, 22 Jan 2019 14:34:53 -0500 (EST)
Received: from mail.efficios.com ([IPv6:::1])
 by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
 with ESMTP id VAH9vEQfmca4 for <lttng-dev@lists.lttng.org>;
 Tue, 22 Jan 2019 14:34:53 -0500 (EST)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id 0EF14B5E6F
 for <lttng-dev@lists.lttng.org>; Tue, 22 Jan 2019 14:34:53 -0500 (EST)
Received: from mail.efficios.com ([IPv6:::1])
 by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
 with ESMTP id oRb7CIP1WXkO for <lttng-dev@lists.lttng.org>;
 Tue, 22 Jan 2019 14:34:52 -0500 (EST)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com
 [209.85.167.48])
 by mail.efficios.com (Postfix) with ESMTPSA id A8DC3B5E66
 for <lttng-dev@lists.lttng.org>; Tue, 22 Jan 2019 14:34:52 -0500 (EST)
Received: by mail-lf1-f48.google.com with SMTP id a8so18985298lfk.5
 for <lttng-dev@lists.lttng.org>; Tue, 22 Jan 2019 11:34:52 -0800 (PST)
In-Reply-To: <20181129214951.1960-1-mjeanson@efficios.com>
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
Cc: lttng-dev <lttng-dev@lists.lttng.org>, Jeremie Galarneau <jgalar@efficios.com>
List-Id: lttng-dev@lists.lttng.org

TWVyZ2VkIGluIG1hc3Rlciwgc3RhYmxlLTIuMTEsIHN0YWJsZS0yLjEwLCBhbmQgc3RhYmxlLTIu
OS4KClRoYW5rcyEKSsOpcsOpbWllCgpPbiBUaHUsIDI5IE5vdiAyMDE4IGF0IDE2OjQ5LCBNaWNo
YWVsIEplYW5zb24gPG1qZWFuc29uQGVmZmljaW9zLmNvbT4gd3JvdGU6Cj4KPiBJbml0aWFsaXpl
IGZkIHRvIGludmFsaWQgJy0xJyBhbmQgcmVtb3ZlIHVubmVjZXNzYXJ5IGZpbGVfb3BlbmVkLgo+
Cj4gU2lnbmVkLW9mZi1ieTogTWljaGFlbCBKZWFuc29uIDxtamVhbnNvbkBlZmZpY2lvcy5jb20+
Cj4gLS0tCj4gIHNyYy9iaW4vbHR0bmctc2Vzc2lvbmQvc2F2ZS5jIHwgOCArKystLS0tLQo+ICAx
IGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQo+Cj4gZGlmZiAt
LWdpdCBhL3NyYy9iaW4vbHR0bmctc2Vzc2lvbmQvc2F2ZS5jIGIvc3JjL2Jpbi9sdHRuZy1zZXNz
aW9uZC9zYXZlLmMKPiBpbmRleCA4ZGFmODcwYy4uNmNlOTkyYjIgMTAwNjQ0Cj4gLS0tIGEvc3Jj
L2Jpbi9sdHRuZy1zZXNzaW9uZC9zYXZlLmMKPiArKysgYi9zcmMvYmluL2x0dG5nLXNlc3Npb25k
L3NhdmUuYwo+IEBAIC0yMjg0LDggKzIyODQsNyBAQCBzdGF0aWMKPiAgaW50IHNhdmVfc2Vzc2lv
bihzdHJ1Y3QgbHR0X3Nlc3Npb24gKnNlc3Npb24sCj4gICAgICAgICBzdHJ1Y3QgbHR0bmdfc2F2
ZV9zZXNzaW9uX2F0dHIgKmF0dHIsIGx0dG5nX3NvY2tfY3JlZCAqY3JlZHMpCj4gIHsKPiAtICAg
ICAgIGludCByZXQsIGZkOwo+IC0gICAgICAgdW5zaWduZWQgaW50IGZpbGVfb3BlbmVkID0gMDsg
ICAvKiBJbmRpY2F0ZSBpZiB0aGUgZmlsZSBoYXMgYmVlbiBvcGVuZWQgKi8KPiArICAgICAgIGlu
dCByZXQsIGZkID0gLTE7Cj4gICAgICAgICBjaGFyIGNvbmZpZ19maWxlX3BhdGhbUEFUSF9NQVhd
Owo+ICAgICAgICAgc2l6ZV90IGxlbjsKPiAgICAgICAgIHN0cnVjdCBjb25maWdfd3JpdGVyICp3
cml0ZXIgPSBOVUxMOwo+IEBAIC0yMzc4LDcgKzIzNzcsNiBAQCBpbnQgc2F2ZV9zZXNzaW9uKHN0
cnVjdCBsdHRfc2Vzc2lvbiAqc2Vzc2lvbiwKPiAgICAgICAgICAgICAgICAgcmV0ID0gTFRUTkdf
RVJSX1NBVkVfSU9fRkFJTDsKPiAgICAgICAgICAgICAgICAgZ290byBlbmQ7Cj4gICAgICAgICB9
Cj4gLSAgICAgICBmaWxlX29wZW5lZCA9IDE7Cj4KPiAgICAgICAgIHdyaXRlciA9IGNvbmZpZ193
cml0ZXJfY3JlYXRlKGZkLCAxKTsKPiAgICAgICAgIGlmICghd3JpdGVyKSB7Cj4gQEAgLTI0OTIs
MTIgKzI0OTAsMTIgQEAgZW5kOgo+ICAgICAgICAgfQo+ICAgICAgICAgaWYgKHJldCkgewo+ICAg
ICAgICAgICAgICAgICAvKiBEZWxldGUgZmlsZSBpbiBjYXNlIG9mIGVycm9yICovCj4gLSAgICAg
ICAgICAgICAgIGlmIChmaWxlX29wZW5lZCAmJiB1bmxpbmsoY29uZmlnX2ZpbGVfcGF0aCkpIHsK
PiArICAgICAgICAgICAgICAgaWYgKChmZCA+PSAwKSAmJiB1bmxpbmsoY29uZmlnX2ZpbGVfcGF0
aCkpIHsKPiAgICAgICAgICAgICAgICAgICAgICAgICBQRVJST1IoIlVubGlua2luZyBYTUwgc2Vz
c2lvbiBjb25maWd1cmF0aW9uLiIpOwo+ICAgICAgICAgICAgICAgICB9Cj4gICAgICAgICB9Cj4K
PiAtICAgICAgIGlmIChmaWxlX29wZW5lZCkgewo+ICsgICAgICAgaWYgKGZkID49IDApIHsKPiAg
ICAgICAgICAgICAgICAgcmV0ID0gY2xvc2UoZmQpOwo+ICAgICAgICAgICAgICAgICBpZiAocmV0
KSB7Cj4gICAgICAgICAgICAgICAgICAgICAgICAgUEVSUk9SKCJDbG9zaW5nIFhNTCBzZXNzaW9u
IGNvbmZpZ3VyYXRpb24iKTsKPiAtLQo+IDIuMTcuMQo+CgoKLS0gCkrDqXLDqW1pZSBHYWxhcm5l
YXUKRWZmaWNpT1MgSW5jLgpodHRwOi8vd3d3LmVmZmljaW9zLmNvbQpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsdHRuZy1kZXYgbWFpbGluZyBsaXN0Cmx0
dG5nLWRldkBsaXN0cy5sdHRuZy5vcmcKaHR0cHM6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9t
YWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRldgo=
