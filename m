From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: [RELEASE] LTTng-Tools 2.8.3 - Isseki Nicho
Date: Thu, 1 Dec 2016 18:54:48 -0500
Message-ID: <CA+jJMxt0RrykpRejgfPOxhftZs1p2n2UvSzyuAOAC_MM30VfDw__12036.9132877842$1480636497$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-vk0-x233.google.com (mail-vk0-x233.google.com
 [IPv6:2607:f8b0:400c:c05::233])
 by lists.lttng.org (Postfix) with ESMTPS id 3tVDhb4j8fztPc
 for <lttng-dev@lists.lttng.org>; Thu,  1 Dec 2016 23:56:31 +0000 (UTC)
Received: by mail-vk0-x233.google.com with SMTP id p9so137639951vkd.3
 for <lttng-dev@lists.lttng.org>; Thu, 01 Dec 2016 15:54:49 -0800 (PST)
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

SGkgYWxsLAoKVG9kYXkgd2UgYXJlIHJlbGVhc2luZyB0aGUgdGhpcmQgYnVnLWZpeCByZWxlYXNl
IG9mIExUVG5nLVRvb2xzIDIuOC4KVGhpcyByZWxlYXNlIGFkZHJlc3NlcyBhIG51bWJlciBvZiBt
aW5vciBpc3N1ZXMgbGlzdGVkIGJlbG93LgoKMjAxNi0xMi0wMSBsdHRuZy10b29scyAyLjguMyAo
TmF0aW9uYWwgUGllIERheSkKICAgICAgICAqIEZpeDogdHJ1bmNhdGUgdGhlIG1ldGFkYXRhIGZp
bGUgaW4gc2htLXBhdGgKICAgICAgICAqIEZpeDogYWRkIG1pc3NpbmcgcmVmY291bnQgb2YgbG9h
ZGVkIG1vZHVsZXMKICAgICAgICAqIEZpeDogb25seSB1bmxvYWQgc3VjY2Vzc2Z1bGx5IGxvYWRl
ZCBrZXJuZWwgbW9kdWxlcwogICAgICAgICogRml4OiB0ZXN0IGNhc2VzIG5vdyByZWx5IG9uIGV4
cGxpY2l0IHdvcmtsb2FkcwogICAgICAgICogbTQvcHByaW50Lm00OiB1cGRhdGUgd2l0aCBjb3Jy
ZWN0IHF1b3RpbmcKICAgICAgICAqIGNvbmZpZ3VyZS5hYzogbW92ZSB3YXJuaW5nIHRvIGVuZCBv
ZiBvdXRwdXQgZm9yIHRoZSBlbmQgdXNlcgogICAgICAgICogZG9jL21hbjogb25seSByZXF1aXJl
IGFzY2lpZG9jLWF0dHJzLmNvbmYgd2hlbiBidWlsZGluZyB0aGUgbWFuIHBhZ2VzCiAgICAgICAg
KiBBZGQgdmVyc2lvbiBpbmZvIHRvIGx0dG5nLXJlbGF5ZCBoZWxwCiAgICAgICAgKiBGaXg6IHN0
b3Agc2Vzc2lvbmQgdGhyZWFkcyBvbiBoZWFsdGggdGhyZWFkIGVycm9yCiAgICAgICAgKiBGaXg6
IHN0b3AgbHR0bmctcmVsYXlkIHRocmVhZHMgb24gaGVhbHRoIHRocmVhZCBlcnJvcgogICAgICAg
ICogRml4OiByZXBvcnQgYW4gZXJyb3IgaWYgdW5peCBzb2NrZXQgYWRkcmVzcyBpcyB0b28gbG9u
ZwogICAgICAgICogRml4OiBzYXZlOiBsZWFrIG9mIGNvbmZpZ3VyYXRpb24gZmlsZSBmZAoKQXMg
YWx3YXlzLCBwbGVhc2UgcmVwb3J0IGFueSBpc3N1ZSB5b3UgbWF5IGVuY291bnRlciB0byBidWdz
Lmx0dG5nLm9yZwpvciBvbiB0aGlzIG1haWxpbmcgbGlzdC4KClByb2plY3Qgd2Vic2l0ZTogaHR0
cHM6Ly9sdHRuZy5vcmcKCkRvd25sb2FkIGxpbms6Cmh0dHBzOi8vbHR0bmcub3JnL2ZpbGVzL2x0
dG5nLXRvb2xzL2x0dG5nLXRvb2xzLTIuOC4zLnRhci5iejIKCkdQRyBzaWc6IGh0dHBzOi8vbHR0
bmcub3JnL2ZpbGVzL2x0dG5nLXRvb2xzL2x0dG5nLXRvb2xzLTIuOC4zLnRhci5iejIuYXNjCgpK
w6lyw6ltaWUKCi0tIApKw6lyw6ltaWUgR2FsYXJuZWF1CkVmZmljaU9TIEluYy4KaHR0cDovL3d3
dy5lZmZpY2lvcy5jb20KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KbHR0bmctZGV2IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0
dHBzOi8vbGlzdHMubHR0bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK
