From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: [RELEASE] Babeltrace 1.5.0
Date: Tue, 29 Nov 2016 18:11:37 -0500
Message-ID: <CA+jJMxsqQoEKuBczimpDkXWnvMKcfq9-QcRMS4zU5YKtM4jW5Q__25086.525156121$1480461109$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ua0-x243.google.com (mail-ua0-x243.google.com
 [IPv6:2607:f8b0:400c:c08::243])
 by lists.lttng.org (Postfix) with ESMTPS id 3tSzqd1Qmjzp0d
 for <lttng-dev@lists.lttng.org>; Tue, 29 Nov 2016 23:13:15 +0000 (UTC)
Received: by mail-ua0-x243.google.com with SMTP id 20so15665634uak.0
 for <lttng-dev@lists.lttng.org>; Tue, 29 Nov 2016 15:11:39 -0800 (PST)
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
Cc: "diamon-discuss@lists.linuxfoundation.org" <diamon-discuss@lists.linuxfoundation.org>
List-Id: lttng-dev@lists.lttng.org

SGkgYWxsLAoKVG9kYXkgd2UgYXJlIHJlbGVhc2luZyB0aGUgZmluYWwgcmVsZWFzZSBvZiBCYWJl
bHRyYWNlIDEuNS4KClRoZSBCYWJlbHRyYWNlIHByb2plY3QgcHJvdmlkZXMgdHJhY2UgcmVhZCBh
bmQgd3JpdGUgbGlicmFyaWVzLCBhcyB3ZWxsCmFzIGEgdHJhY2UgY29udmVydGVyLiBQbHVnaW5z
IGNhbiBiZSBjcmVhdGVkIGZvciBhbnkgdHJhY2UgZm9ybWF0IHRvCmFsbG93IGl0cyBjb252ZXJz
aW9uIHRvL2Zyb20gYW5vdGhlciB0cmFjZSBmb3JtYXQuCgpUaGUgbWFpbiBmb3JtYXQgZXhwZWN0
ZWQgdG8gYmUgY29udmVydGVkIHRvL2Zyb20gaXMgdGhlIENvbW1vbiBUcmFjZQpGb3JtYXQgKENU
RikuIFRoZSBkZWZhdWx0IGlucHV0IGZvcm1hdCBvZiB0aGUgImJhYmVsdHJhY2UiIGNvbW1hbmQg
aXMKQ1RGLCBhbmQgaXRzIGRlZmF1bHQgb3V0cHV0IGZvcm1hdCBpcyBhIGh1bWFuLXJlYWRhYmxl
IHRleHQgbG9nLiBUaGUKImJhYmVsdHJhY2UtbG9nIiBjb21tYW5kIGNvbnZlcnRzIGZyb20gYSB0
ZXh0IGxvZyB0byBhIENURiB0cmFjZS4KClRoaXMgcmVsZWFzZSBhZGRzIHR3byBmZWF0dXJlcyB0
byB0aGUgQ1RGIFdyaXRlciBsaWJyYXJ5OgogICAgKiBBbGxvdyB0aGUgZGVmaW5pdGlvbiBvZiBj
dXN0b20gc3RyZWFtIHBhY2tldCBoZWFkZXJzCiAgICAqIFZhbGlkYXRpb24gdXRpbGl0eSB0byBj
aGVjayBmb3IgcmVzZXJ2ZWQgQ1RGIGlkZW50aWZpZXJzCgpDaGFuZ2UgbG9nOgoyMDE2LTExLTI5
IGJhYmVsdHJhY2UgMS41LjAgKE5hdGlvbmFsIFNxdWFyZSBEYW5jZSBEYXkpCiAgICAgICAgKiBG
aXg6IHJlbW92ZSBCVF9ISURERU4gZnJvbSBidF92YWx1ZV9udWxsIHNpbmdsZXRvbiBkZWNsYXJh
dGlvbgogICAgICAgICogRml4IG1peGluZyBvZiBidF9jdGZfc2NvcGUgYW5kIGJ0X2N0Zl9pcl9z
Y29wZSBlbnVtcwogICAgICAgICogUmV2ZXJ0IEFCSS1icmVha2luZyBlbnVtIGJ0X2N0Zl9zdHJp
bmdfZW5jb2RpbmcgY2hhbmdlCiAgICAgICAgKiBGaXg6IHdhcm5pbmdzIGVtaXR0ZWQgYmVjYXVz
ZSBvZiBlbnVtIGN0Zl9zdHJpbmdfZW5jb2RpbmcgbWl4aW5nCgpQcm9qZWN0IHdlYnNpdGU6IGh0
dHA6Ly9kaWFtb24ub3JnL2JhYmVsdHJhY2UvCkRvd25sb2FkIGxpbms6IGh0dHA6Ly93d3cuZWZm
aWNpb3MuY29tL2ZpbGVzL2JhYmVsdHJhY2UvYmFiZWx0cmFjZS0xLjUuMC50YXIuYnoyCkNURiBz
cGVjaWZpY2F0aW9uOiBodHRwOi8vZGlhbW9uLm9yZy9jdGYvCgpKw6lyw6ltaWUKCi0tIApKw6ly
w6ltaWUgR2FsYXJuZWF1CkVmZmljaU9TIEluYy4KaHR0cDovL3d3dy5lZmZpY2lvcy5jb20KX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2IG1h
aWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0bmcu
b3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK
