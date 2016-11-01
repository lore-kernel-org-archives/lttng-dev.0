From: Philippe Proulx <pproulx@efficios.com>
Subject: Create virtual LTTng environments with vlttng (blog
	post)
Date: Tue, 1 Nov 2016 05:55:02 +0000 (UTC)
Message-ID: <85561876.11751.1477979702408.JavaMail.zimbra__36857.2052372203$1477980247$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.141])
 by lists.lttng.org (Postfix) with ESMTPS id 3EC49158FF
 for <lttng-dev@lists.lttng.org>; Tue,  1 Nov 2016 06:04:01 +0000 (UTC)
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: lttng-dev <lttng-dev@lists.lttng.org>, tracecompass-dev <tracecompass-dev@eclipse.org>
List-Id: lttng-dev@lists.lttng.org

SGVsbG8gZXZlcnlvbmUhCgpJIGp1c3Qgd3JvdGUgYSBibG9nIHBvc3QgYWJvdXQgYSB0b29sIEkg
Y3JlYXRlZCBzb21ld2hhdCByZWNlbnRseSwgYW5kCndoaWNoIEkgd2FudCB0byB5b3UgdG8ga25v
dyBpdCBleGlzdHM6Cgo8aHR0cDovL2x0dG5nLm9yZy9ibG9nLzIwMTYvMTAvMzEvdmx0dG5nLz4K
ClRoZSB0b29sIGlzIGNhbGxlZCB2bHR0bmcgYW5kIGl0IGNhbiBjcmVhdGUgdmlydHVhbCwgaXNv
bGF0ZWQgTFRUbmcKZW52aXJvbm1lbnRzLCBqdXN0IGxpa2UgdmlydHVhbGVudiBkb2VzIGluIHRo
ZSBQeXRob24gd29ybGQuCgp2bHR0bmcgImtub3dzIiB0aGUgZm9sbG93aW5nIHByb2plY3RzOgoK
KiBiYWJlbHRyYWNlCiogZWxmdXRpbHMKKiBnbGliCiogbGlieG1sMgoqIGx0dG5nLWFuYWx5c2Vz
CiogbHR0bmctbW9kdWxlcwoqIGx0dG5nLXRvb2xzCiogbHR0bmctdXN0CiogcG9wdAoqIHRyYWNl
Y29tcGFzcwoqIHVyY3UKCkFzIEkgd3JvdGUgaXQgaW4gdGhlIGJsb2cgcG9zdCwgeW91IHNob3Vs
ZCBiZSBpbnRlcmVzdGVkIGluIHZsdHRuZyBpZjoKCiogWW91IHdhbnQgdG8gY29udHJpYnV0ZSB0
byBvbmUgb2YgdGhlIExUVG5nIG9yIEJhYmVsdHJhY2UgcHJvamVjdHMuCiogWW91IHdhbnQgdG8g
dGVzdCBhIHNwZWNpZmljIGNvbmZpZ3VyYXRpb24gb2YgdGhlIHRvb2xzIHdpdGhvdXQKICB0YWlu
dGluZyB0aGUgc3lzdGVtLgoqIFlvdSB3YW50IHRvIHVzZSBMVFRuZyBvbiBhIGRpc3RyaWJ1dGlv
biB3aXRoIG5vIExUVG5nIHBhY2thZ2VzLgoqIFlvdSB3YW50IHRvIGNyb3NzLWNvbXBpbGUgdGhl
IHRvb2xzLgoKSSBndWVzcyBpdCdzIGFsc28gdXNlZnVsIGlmIHlvdSB3YW50IHRvIHRyeSB0aGUg
YmxlZWRpbmcgZWRnZSB2ZXJzaW9ucwpvZiB0aGUgTFRUbmcsIEJhYmVsdHJhY2UsIGFuZCBUcmFj
ZSBDb21wYXNzIHByb2plY3RzIHdpdGhvdXQgaGF2aW5nIHRvCnJlYWQgYW55IGRvYyBhYm91dCBo
b3cgdG8gYnVpbGQgYW5kIGluc3RhbGwgdGhlbS4KCkhhdmUgZnVuLAoKUGhpbGlwcGUgUHJvdWx4
CkVmZmljaU9TIEluYy4KaHR0cDovL3d3dy5lZmZpY2lvcy5jb20vCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmx0dG5nLWRldiBtYWlsaW5nIGxpc3QKbHR0
bmctZGV2QGxpc3RzLmx0dG5nLm9yZwpodHRwczovL2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmluL21h
aWxtYW4vbGlzdGluZm8vbHR0bmctZGV2Cg==
