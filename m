From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: [RELEASE] Babeltrace 1.2.6
Date: Mon, 6 Jun 2016 16:28:21 -0400
Message-ID: <CA+jJMxuDipVz2sdSigrcvTDLmGM4owBDzbzTXB-_fHzizzb=nA__9955.97347287021$1465244921$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qg0-f46.google.com (mail-qg0-f46.google.com
 [209.85.192.46])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id 9B6EFA37E6
 for <lttng-dev@lists.lttng.org>; Mon,  6 Jun 2016 20:28:22 +0000 (UTC)
Received: by mail-qg0-f46.google.com with SMTP id 93so48465149qgx.2
 for <lttng-dev@lists.lttng.org>; Mon, 06 Jun 2016 13:28:22 -0700 (PDT)
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

SGkgYWxsLAoKV2UgYXJlIHJlbGVhc2luZyBCYWJlbHRyYWNlIDEuMi42LCB3aGljaCBpcyBhIGJ1
Z2ZpeCByZWxlYXNlLgpXaXRoIHRvZGF5J3MgcmVsZWFzZSBvZiBCYWJlbHRyYWNlIDEuNC4wLCB0
aGlzIHJlbGVhc2UgbWFya3MKdGhlIGVuZCBvZiBsaWZlIG9mIHRoZSAxLjIueCBzZXJpZXMgb2Yg
cmVsZWFzZXMuCgpCYWJlbHRyYWNlIGlzIGFuIG9wZW4gc291cmNlIHRyYWNlIGZvcm1hdCBjb252
ZXJ0ZXIuCgpUaGUgQmFiZWx0cmFjZSBwcm9qZWN0IHByb3ZpZGVzIGEgbGlicmFyeSwgUHl0aG9u
IGJpbmRpbmdzIGZvciB0aGlzCmxpYnJhcnksIGFzIHdlbGwgYXMgYSBoYW5keSBsaXR0bGUgY29t
bWFuZC1saW5lIHRvb2zigJRhcHRseSBuYW1lZApiYWJlbHRyYWNl4oCUd2hpY2ggbWFrZXMgaXQg
dmVyeSBlYXN5IHRvIHZpZXcgYW5kIGNvbnZlcnQgdHJhY2VzLgoKQmFiZWx0cmFjZSBpcyBhbHNv
IHRoZSByZWZlcmVuY2UgcGFyc2VyIGltcGxlbWVudGF0aW9uIG9mIHRoZSBDb21tb24KVHJhY2Ug
Rm9ybWF0IChDVEYpLCBhIHZlcnkgdmVyc2F0aWxlIHRyYWNlIGZvcm1hdC4KCjIwMTYtMDYtMDYg
YmFiZWx0cmFjZSAxLjIuNiAoTmF0aW9uYWwgWW8tWW8gRGF5KQogICAgICAgICogRG9jczogY2hh
bmdlIC0tY2xvY2stcmF3IHRvIC0tY2xvY2stY3ljbGVzCiAgICAgICAgKiBGaXg6IG91dC1vZi10
cmVlIGRpc3QgZmFpbHMgdG8gZmluZCB0ZXN0IHRyYWNlcwogICAgICAgICogRml4IHJ1bm5pbmcg
dGVzdHMgb3V0IG9mIHRyZWUKClByb2plY3Qgd2Vic2l0ZTogaHR0cDovL2RpYW1vbi5vcmcvYmFi
ZWx0cmFjZS8KRG93bmxvYWQgbGluazogaHR0cDovL3d3dy5lZmZpY2lvcy5jb20vZmlsZXMvYmFi
ZWx0cmFjZS9iYWJlbHRyYWNlLTEuMi42LnRhci5iejIKQ1RGIHNwZWNpZmljYXRpb246IGh0dHA6
Ly9kaWFtb24ub3JnL2N0Zi8KCi0tIApKw6lyw6ltaWUgR2FsYXJuZWF1CkVmZmljaU9TIEluYy4K
aHR0cDovL3d3dy5lZmZpY2lvcy5jb20KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KbHR0bmctZGV2IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0
bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9s
dHRuZy1kZXYK
