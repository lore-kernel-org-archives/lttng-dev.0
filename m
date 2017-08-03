From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: [RELEASE] LTTng-Tools 2.8.8 - Isseki Nicho (End of Life)
Date: Thu, 3 Aug 2017 16:42:12 -0400
Message-ID: <CA+jJMxvU3-eW60SV5YJea746VdXZQfHCRt0ZLBkHuCsVyYPmjA__27325.4791660749$1501793055$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-yw0-x22a.google.com (mail-yw0-x22a.google.com
 [IPv6:2607:f8b0:4002:c05::22a])
 by lists.lttng.org (Postfix) with ESMTPS id 3xNhnK6R8XzCjS
 for <lttng-dev@lists.lttng.org>; Thu,  3 Aug 2017 20:42:13 +0000 (UTC)
Received: by mail-yw0-x22a.google.com with SMTP id u207so15737814ywc.3
 for <lttng-dev@lists.lttng.org>; Thu, 03 Aug 2017 13:42:13 -0700 (PDT)
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

SGkgYWxsLAoKVG9kYXkgd2UgYXJlIHJlbGVhc2luZyB0aGUgZWlnaHRoIGFuZCBmaW5hbCBidWct
Zml4IHJlbGVhc2Ugb2YKTFRUbmctVG9vbHMgMi44IC0gSXNzZWtpIE5pY2hvIGFzIGl0IGhhcyBu
b3cgcmVhY2hlZCBlbmQgb2YgbGlmZS4KVGhpcyByZWxlYXNlIGFkZHJlc3NlcyBhIG51bWJlciBv
ZiBpc3N1ZXMgbGlzdGVkIGJlbG93LgoKMjAxNy0wOC0wMyBsdHRuZy10b29scyAyLjguOCAoV2F0
ZXJtZWxvbiBEYXkpCiAgICAgICAgKiBGaXg6IHVuaW5pdGlhbGl6ZWQgcmV0dXJuIHZhbHVlIG9u
IGVycm9yIHBhdGgKICAgICAgICAqIEZpeDogZW5zdXJlIGtlcm5lbCBjb250ZXh0IGlzIGluIGEg
bGlzdCBiZWZvcmUgdHJ5aW5nIHRvIGRlbGV0ZSBpdAogICAgICAgICogRml4OiBhbWJpZ3VvdXMg
b3duZXJzaGlwIG9mIGtlcm5lbCBjb250ZXh0IGJ5IG11bHRpcGxlIGNoYW5uZWxzCiAgICAgICAg
KiBGaXg6IHJldCBpcyBuZXZlciB1c2VkIG9uIGVycm9yX29wZW4gY29kZSBwYXRoCiAgICAgICAg
KiBGaXg6IHVzZSBlcnJvciBjb2RlIHBhdGggaW5zdGVhZCBvZiBicmVhayB3aGVuIGVycm9ycyBo
YXBwZW4KYmVmb3JlIGV4ZWNsCiAgICAgICAgKiBGaXg6IHdyb25nIHZhcmlhYmxlIGFzc2lnbm1l
bnQgb24gZXJyb3IKICAgICAgICAqIEZpeDogbWlzc2luZyBlcnJvciBoYW5kbGluZyBpbiB1c2Ug
b2YgcHJpbnRfdGFicygpCiAgICAgICAgKiBGaXg6IHJldCBpcyB1c2VkIGluc3RlYWQgb3IgZXJy
IHRvIHNldCBhbiBlcnJvciBjb2RlCiAgICAgICAgKiBGaXg6IHJlcG9ydCBlcnJvciB1c2luZyBm
ZCBpbnN0ZWFkIG9mIHJldAogICAgICAgICogRml4OiBOVUxMIHBhc3NlZCB0byBtZW1jcHkgaW4g
ZXJyb3IgcGF0aAogICAgICAgICogRml4OiBsb3N0IHBhY2tldCBhY2NvdW50aW5nIGFsd2F5cyBs
b3N0IG9uIHNuYXBzaG90CiAgICAgICAgKiBGaXg6IHJlcG9ydCBlcnJvciBvbiBzZXNzaW9uIGxp
c3RpbmcKICAgICAgICAqIEZpeCBsaXZlLWNvbW06IG1lcmdlIFRDUCBzb2NrZXQgd3JpdGUtd3Jp
dGUgc2VxdWVuY2UgaW4gYSBzaW5nbGUgd3JpdGUKICAgICAgICAqIEZpeDogam9pbiBjb25zdW1l
ciB0aW1lciB0aHJlYWQKCkFzIGFsd2F5cywgcGxlYXNlIHJlcG9ydCBhbnkgaXNzdWUgeW91IG1h
eSBlbmNvdW50ZXIgdG8gYnVncy5sdHRuZy5vcmcKb3Igb24gdGhpcyBtYWlsaW5nIGxpc3QuCgpQ
cm9qZWN0IHdlYnNpdGU6IGh0dHBzOi8vbHR0bmcub3JnCgpEb3dubG9hZCBsaW5rOgpodHRwczov
L2x0dG5nLm9yZy9maWxlcy9sdHRuZy10b29scy9sdHRuZy10b29scy0yLjguOC50YXIuYnoyCgpH
UEcgc2lnOgpodHRwczovL2x0dG5nLm9yZy9maWxlcy9sdHRuZy10b29scy9sdHRuZy10b29scy0y
LjguOC50YXIuYnoyLmFzYwoKCi0tIApKw6lyw6ltaWUgR2FsYXJuZWF1CkVmZmljaU9TIEluYy4K
aHR0cDovL3d3dy5lZmZpY2lvcy5jb20KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KbHR0bmctZGV2IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0
bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9s
dHRuZy1kZXYK
