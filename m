From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: [RELEASE] Babeltrace 1.5.4
Date: Wed, 31 Jan 2018 22:23:13 -0500
Message-ID: <CA+jJMxtS=_B6LHOL=fyro+3fEnMwHxOAjvgAos+287SMEOYJWQ__18800.5113778219$1517455326$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-yw0-x236.google.com (mail-yw0-x236.google.com
 [IPv6:2607:f8b0:4002:c05::236])
 by lists.lttng.org (Postfix) with ESMTPS id 3zX56x5ZDRzCvV
 for <lttng-dev@lists.lttng.org>; Thu,  1 Feb 2018 03:23:37 +0000 (UTC)
Received: by mail-yw0-x236.google.com with SMTP id u17so9336257ywg.9
 for <lttng-dev@lists.lttng.org>; Wed, 31 Jan 2018 19:23:37 -0800 (PST)
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: lttng-dev@lists.lttng.org
Cc: diamon-discuss@lists.linuxfoundation.org
List-Id: lttng-dev@lists.lttng.org

SGkgYWxsLAoKVG9kYXkgd2UgYXJlIHJlbGVhc2luZyB0aGUgZm91cnRoIGJ1Zy1maXggcmVsZWFz
ZSBvZiBCYWJlbHRyYWNlIDEuNS40LgpUaGlzIHJlbGVhc2UgYWRkcmVzc2VzIGEgbnVtYmVyIG9m
IGlzc3VlcyBsaXN0ZWQgYmVsb3cuCgoyMDE4LTAxLTMxIGJhYmVsdHJhY2UgMS41LjQgKEdvcmls
bGEgU3VpdCBEYXkpCiAgICAgICAgKiBGaXg6IHVzZSBzaWduZWQgYWNjZXNzb3JzIGZvciBjbG9j
ayBvZmZzZXRzCiAgICAgICAgKiBGaXg6IHNpZ25lZG5lc3MgZXJyb3IgaW4gcHl0aG9uIGNvbXBs
ZW1lbnRzCiAgICAgICAgKiBGaXg6IGhhbmRsZSBwYWNrZXRfc2VlayBlcnJvcnMKICAgICAgICAq
IEZpeDogcHJldmVudCBjYWxsaW5nIGFkZGluZyB0aGUgc2FtZSB0cmFjZSByZWN1cnNpdmVseQog
ICAgICAgICogRml4OiBNYWtlIHN1cmUgd2UgaGF2ZSBhbGwgdGhlIG1ldGFkYXRhIHN0cmVhbXMg
YmVmb3JlCmFkZGluZyBuZXcgdHJhY2VzCiAgICAgICAgKiBBZGQgbWlzc2luZyBkZWJ1Z2dpbmcg
aW5mb3JtYXRpb24gaW4gdGhlIGxpdmUgcGx1Z2luCiAgICAgICAgKiBGaXg6IHNldCBzdHJlYW0g
aWQgaW4gSFVQIGNhc2UKICAgICAgICAqIEZpeDogVXNlIGxpc3QgcmF0aGVyIHRoYW4gcHRyIGFy
cmF5IGZvciB0cmFjZSBzdHJlYW1zCiAgICAgICAgKiBGaXg6IGxlYWsgb2Ygc3RyZWFtcwogICAg
ICAgICogRml4OiBoYW5kbGUgMCBzZXNzaW9uIGNhc2UgaW4gYXNrIG5ldyBzdHJlYW1zCiAgICAg
ICAgKiBGaXg6IGJyZWFrIGxvb3Agb24gZ2V0dGluZyBtZXRhZGF0YSBlcnJvcgogICAgICAgICog
Rml4OiByZXR1cm4gZXJyb3Igb24gYXNrX25ld19zdHJlYW0gd2hlbiBzaG91bGQgcXVpdAogICAg
ICAgICogRml4OiBkb24ndCBhY2Nlc3MgbWlzc2luZyBjdGYgdHJhY2Ugd2hlbiBnZXR0aW5nIG1l
dGFkYXRhCiAgICAgICAgKiBGaXg6IGx0dG5nLWxpdmUgZGlzY2FyZGVkIGV2ZW50IGNvdW50IGFm
dGVyIGluYWN0aXZpdHkKICAgICAgICAqIEZpeDogdGltZWdtIGNvbXBhdCBvbiBTb2xhcmlzCiAg
ICAgICAgKiBGaXg6IHB5dGhvbiBiaW5kaW5ncyB3aGVuIGJ1aWxkaW5nIHdpdGggUElFIGhhcmRl
bmluZwogICAgICAgICogbHR0bmctbGl2ZTogcHJpbnQgZGlzY2FyZGVkIGV2ZW50IGFuZCBwYWNr
ZXQgbG9zdCB3YXJuaW5ncyBvbiBzdGRlcnIKClByb2plY3Qgd2Vic2l0ZTogaHR0cDovL2RpYW1v
bi5vcmcvYmFiZWx0cmFjZS8KRG93bmxvYWQgbGluazogaHR0cDovL3d3dy5lZmZpY2lvcy5jb20v
ZmlsZXMvYmFiZWx0cmFjZS9iYWJlbHRyYWNlLTEuNS40LnRhci5iejIKQ1RGIHNwZWNpZmljYXRp
b246IGh0dHA6Ly9kaWFtb24ub3JnL2N0Zi8KCi0tIApKw6lyw6ltaWUgR2FsYXJuZWF1CkVmZmlj
aU9TIEluYy4KaHR0cDovL3d3dy5lZmZpY2lvcy5jb20KX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2IG1haWxpbmcgbGlzdApsdHRuZy1kZXZA
bGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9s
aXN0aW5mby9sdHRuZy1kZXYK
