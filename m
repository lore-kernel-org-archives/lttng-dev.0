From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: [RELEASE] Babeltrace 1.4.1
Date: Thu, 1 Dec 2016 18:40:43 -0500
Message-ID: <CA+jJMxtuZh2DAjgRzy499-nt+wrrBGGsqDj6DrMxZW+_REpcnQ__7265.76699312336$1480635662$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-vk0-x236.google.com (mail-vk0-x236.google.com
 [IPv6:2607:f8b0:400c:c05::236])
 by lists.lttng.org (Postfix) with ESMTPS id 3tVDNL4j0dztNK
 for <lttng-dev@lists.lttng.org>; Thu,  1 Dec 2016 23:42:26 +0000 (UTC)
Received: by mail-vk0-x236.google.com with SMTP id p9so137501132vkd.3
 for <lttng-dev@lists.lttng.org>; Thu, 01 Dec 2016 15:40:44 -0800 (PST)
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

SGkgYWxsLAoKV2UgYXJlIHJlbGVhc2luZyBCYWJlbHRyYWNlIDEuNC4xLCB3aGljaCBpcyBhIGJ1
Zy1maXggcmVsZWFzZS4KCkJhYmVsdHJhY2UgaXMgYW4gb3BlbiBzb3VyY2UgdHJhY2UgZm9ybWF0
IGNvbnZlcnRlci4KClRoZSBCYWJlbHRyYWNlIHByb2plY3QgcHJvdmlkZXMgYSBsaWJyYXJ5LCBQ
eXRob24gYmluZGluZ3MgZm9yIHRoaXMKbGlicmFyeSwgYXMgd2VsbCBhcyBhIGhhbmR5IGNvbW1h
bmQtbGluZSB0b29s4oCUYXB0bHkgbmFtZWQKYmFiZWx0cmFjZeKAlHdoaWNoIG1ha2VzIGl0IHZl
cnkgZWFzeSB0byB2aWV3IGFuZCBjb252ZXJ0IHRyYWNlcy4KCkJhYmVsdHJhY2UgaXMgYWxzbyB0
aGUgcmVmZXJlbmNlIHBhcnNlciBpbXBsZW1lbnRhdGlvbiBvZiB0aGUgQ29tbW9uClRyYWNlIEZv
cm1hdCAoQ1RGKSwgYSB2ZXJ5IHZlcnNhdGlsZSB0cmFjZSBmb3JtYXQuCgoyMDE2LTEyLTAxIGJh
YmVsdHJhY2UgMS40LjEgKE5hdGlvbmFsIFBpZSBEYXkpCiAgICAgICAgKiBkZWJ1ZyBpbmZvOiBD
YWxsIHJlZ2lzdGVyX2V2ZW50X2RlYnVnX2luZm9zIGZvciBhbGwgZXZlbnRzCiAgICAgICAgKiBU
eXBvOiBjb25maWd1cmUuYWMgaW1wbGVtZW5hdGlvbiAtPiBpbXBsZW1lbnRhdGlvbgogICAgICAg
ICogY29uZmlndXJlOiBmaXggdXVpZCBzdXBwb3J0IGRldGVjdGlvbiBvbiBzdGF0aWMgYnVpbGQK
ICAgICAgICAqIFRlc3RzOiBubyBzdWJzdGl0dXRpb24gbmVlZGVkIGZvciBtdWx0aS10cmFjZSBp
bnRlcnNlY3Rpb24gdGVzdAoKUHJvamVjdCB3ZWJzaXRlOiBodHRwOi8vZGlhbW9uLm9yZy9iYWJl
bHRyYWNlLwpEb3dubG9hZCBsaW5rOiBodHRwOi8vd3d3LmVmZmljaW9zLmNvbS9maWxlcy9iYWJl
bHRyYWNlL2JhYmVsdHJhY2UtMS40LjEudGFyLmJ6MgpDVEYgc3BlY2lmaWNhdGlvbjogaHR0cDov
L2RpYW1vbi5vcmcvY3RmLwoKSsOpcsOpbWllCgotLSAKSsOpcsOpbWllIEdhbGFybmVhdQpFZmZp
Y2lPUyBJbmMuCmh0dHA6Ly93d3cuZWZmaWNpb3MuY29tCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCmx0dG5nLWRldiBtYWlsaW5nIGxpc3QKbHR0bmctZGV2
QGxpc3RzLmx0dG5nLm9yZwpodHRwczovL2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmluL21haWxtYW4v
bGlzdGluZm8vbHR0bmctZGV2Cg==
