From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RELEASE] LTTng-UST 2.6.7 and LTTng modules 2.6.6
 (Linux user-space and kernel tracers)
Date: Fri, 20 May 2016 22:07:04 +0000 (UTC)
Message-ID: <1337690017.15198.1463782024832.JavaMail.zimbra__26899.9108965092$1463782060$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [78.47.125.74])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id 92CC5A34F1
 for <lttng-dev@lists.lttng.org>; Fri, 20 May 2016 22:07:10 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 626FF340427
 for <lttng-dev@lists.lttng.org>; Fri, 20 May 2016 22:07:10 +0000 (UTC)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (evm-mail-1.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id j-rJ5KJIz8_e for <lttng-dev@lists.lttng.org>;
 Fri, 20 May 2016 22:07:05 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 3F07434042A
 for <lttng-dev@lists.lttng.org>; Fri, 20 May 2016 22:07:05 +0000 (UTC)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (evm-mail-1.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id 7oVUqeBZ1azp for <lttng-dev@lists.lttng.org>;
 Fri, 20 May 2016 22:07:05 +0000 (UTC)
Received: from evm-mail-1.efficios.com (evm-mail-1.efficios.com [78.47.125.74])
 by mail.efficios.com (Postfix) with ESMTP id 18D9D340427
 for <lttng-dev@lists.lttng.org>; Fri, 20 May 2016 22:07:05 +0000 (UTC)
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

SGksCgpIZXJlIGlzIGEgcmVsZWFzZSBhbm5vdW5jZW1lbnQgb2YgbGFzdCBidWdmaXggcmVsZWFz
ZXMgZm9yIHRoZSAyLjYueApzZXJpZXMgb2YgbHR0bmcgdXN0IGFuZCBsdHRuZyBtb2R1bGVzLiBX
aXRoIHRoZSByZWxlYXNlIG9mIDIuOC4wIGRvbmUKdG9kYXksIHRoaXMgbWFya3MgdGhlIGVuZCBv
ZiBsaWZlIG9mIHRoZSAyLjYueCBzZXJpZXMuCgpMVFRuZy1VU1QsIHRoZSBMaW51eCBUcmFjZSBU
b29sa2l0IE5leHQgR2VuZXJhdGlvbiBVc2Vyc3BhY2UgVHJhY2VyLAppcyBhIGxvdy1vdmVyaGVh
ZCBhcHBsaWNhdGlvbiB0cmFjZXIuIFRoZSBsaWJyYXJ5ICJsaWJsdHRuZy11c3QiIGVuYWJsZXMK
dHJhY2luZyBvZiBhcHBsaWNhdGlvbnMgYW5kIGxpYnJhcmllcy4KClRoZSBMVFRuZyBtb2R1bGVz
IHByb3ZpZGUgTGludXgga2VybmVsIHRyYWNpbmcgY2FwYWJpbGl0eSB0byB0aGUgTFRUbmcKMi54
IHRyYWNlciB0b29sc2V0LgoKUHJvamVjdCB3ZWJzaXRlOiBodHRwOi8vbHR0bmcub3JnCkRvY3Vt
ZW50YXRpb246IGh0dHA6Ly9sdHRuZy5vcmcvZG9jcwpEb3dubG9hZCBsaW5rOiBodHRwOi8vbHR0
bmcub3JnL2Rvd25sb2FkCgpDaGFuZ2Vsb2cgTFRUbmctVVNUOgoKMjAxNi0wNS0yMCAoQmlrZS10
by1Xb3JrIERheSkgbHR0bmctdXN0IDIuNi43CiAgICAgICAgKiBQcmludCBEQkcoKSBtZXNzYWdl
IGFib3V0IGNvbXBpbGVyIHdlYWsgaGlkZGVuIHN5bWJvbCBiZWhhdmlvcgogICAgICAgICogRG9j
dW1lbnRhdGlvbjogcmluZyBidWZmZXI6IFNXSVRDSF9GTFVTSCBjYW4gYmUgdXNlZCB3aGVuIGFj
dGl2ZQogICAgICAgICogRml4OiB1bmNoZWNrZWQgcmV0dXJuIHZhbHVlIGluIHRyYWNlX2Nsb2Nr
X3JlYWQ2NF9tb25vdG9uaWMKICAgICAgICAqIEZpeDogSmF2YSBhZ2VudCBzaG91bGQgdXNlIExU
VE5HX0hPTUUKICAgICAgICAqIEZpeDogZXhhbXBsZXMgbWFrZSBkaXN0Y2hlY2sgZmFpbHVyZQog
ICAgICAgICogRml4OiBlbmRpYW5uZXNzIG9mIGludGVnZXJzIHJlY2VpdmVkIGJ5IGZpbHRlcgoK
Q2hhbmdlbG9nIExUVG5nIG1vZHVsZXM6CgoyMDE2LTA1LTIwIExUVG5nIG1vZHVsZXMgMi42LjYK
ICAgICAgICAqIEZpeDogcmluZyBidWZmZXI6IGhvbm9yIHN3aXRjaCBwYXJhbWV0ZXIgdHlwZSBp
biByZW1vdGUgc3dpdGNoCiAgICAgICAgKiBGaXg6IG9ubHkgZmx1c2ggbm9uLW1ldGFkYXRhIGNo
YW5uZWxzCiAgICAgICAgKiBGaXg6IGRvbid0IHBlcmZvcm0gZXh0cmEgZmx1c2ggb24gbWV0YWRh
dGEgY2hhbm5lbAogICAgICAgICogRml4OiBmbHVzaCBlbXB0eSBwYWNrZXRzIG9uIHNuYXBzaG90
IGNoYW5uZWwKICAgICAgICAqIEZpeDogZG8gbm90IGdlbmVyYXRlIHBhY2tldCBhdCBkZXN0cm95
IGFmdGVyIHN0b3AKICAgICAgICAqIEZpeDogY29tcGF0IGlvY3RsIGZvciBmbHVzaC9nZXQgbWV0
YWRhdGEgdmVyc2lvbgogICAgICAgICogRml4OiBfX3N0cmluZygpIGFuZCB0cF9zdHJjcHkoKSBz
aG91bGQgaGFuZGxlIE5VTEwgcG9pbnRlcnMKICAgICAgICAqIEZpeDogYWRkIG1vZHVsZXMgdGFy
Z2V0IHRvIGJhc2UgTWFrZWZpbGUKICAgICAgICAqIEZpeDogbWFrZSBjbGVhbiBkb2VzIG5vdCBp
bmNsdWRlIGRvdC1jb25maWcKICAgICAgICAqIEZpeDogdHJpZ2dlciBidWlsZCBlcnJvciBpZiBD
T05GSUdfVFJBQ0VQT0lOVFMgaXMgbm90IHNldAogICAgICAgICogRml4OiB4ODYga3ZtIG1tdXRy
YWNlIGluc3RydW1lbnRhdGlvbiBmb3Iga2VybmVsIDwgMy42CiAgICAgICAgKiBGaXg6IFVidW50
dSBrZXJuZWwgcmFuZ2UgZm9yIG1tX3BhZ2VfYWxsb2NfZXh0ZnJhZwogICAgICAgICogRml4OiB1
cGRhdGUgc2NoZWQgaW5zdHJ1bWVudGF0aW9uIGZvciBrZXJuZWwgNC40LjAKICAgICAgICAqIEZp
eDogbWlzc2luZyBUcmFjZXBvaW50IHByb3RvdHlwZSBjaGVja2luZyBkdWUgdG8gYm9ndXMgbWVy
Z2UKCi0tIApNYXRoaWV1IERlc25veWVycwpFZmZpY2lPUyBJbmMuCmh0dHA6Ly93d3cuZWZmaWNp
b3MuY29tCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmx0
dG5nLWRldiBtYWlsaW5nIGxpc3QKbHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZwpodHRwczovL2xp
c3RzLmx0dG5nLm9yZy9jZ2ktYmluL21haWxtYW4vbGlzdGluZm8vbHR0bmctZGV2Cg==
