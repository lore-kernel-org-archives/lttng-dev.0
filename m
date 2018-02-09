From: Francis Deslauriers <francis.deslauriers@efficios.com>
Subject: [PATCH lttng-ust v2 0/6] Support provider duplicates
	and unloading
Date: Fri,  9 Feb 2018 15:15:19 -0500
Message-ID: <1518207325-9641-1-git-send-email-francis.deslauriers__36546.231856528$1518207280$gmane$org@efficios.com>
References: <1517600891-23632-1-git-send-email-francis.deslauriers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.141])
 by lists.lttng.org (Postfix) with ESMTPS id 3zdRC22syqznnL
 for <lttng-dev@lists.lttng.org>; Fri,  9 Feb 2018 20:15:42 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 8BE8634020E
 for <lttng-dev@lists.lttng.org>; Fri,  9 Feb 2018 20:16:33 +0000 (UTC)
In-Reply-To: <1517600891-23632-1-git-send-email-francis.deslauriers@efficios.com>
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
List-Id: lttng-dev@lists.lttng.org

VGhpcyBwYXRjaCBzZXQgYWRkcyB0aGUgc3VwcG9ydCBmb3IgZHVwbGljYXRlZCBwcm9iZSBwcm92
aWRlcnMgYW5kCnN1cHBvcnQgZm9yIHVubG9hZGluZyBwcm9iZSBwcm92aWRlcnMgdXNpbmcgZGxj
bG9zZSgpLgoKSXQgYWxsb3dzIHRvIGFkdmFuY2Ugc2NlbmFyaW9zIHdoZXJlIHByb2JlIHByb3Zp
ZGVycyBjYW4gYmUgdXBncmFkZWQKZHVyaW5nIHRyYWNpbmcuCgpGb3IgZXhhbXBsZSwgZHVyaW5n
IHRyYWNpbmcgdGhlIHVzZXIgY291bGQgZGxvcGVuKCkgYSBuZXcgdmVyc2lvbiBvZiBhIHByb2Jl
CnByb3ZpZGVyIGFuZCBkbGNsb3NlKCkgdGhlIHByZXZpb3VzIG9uZS4gQWxsIHRoaXMgd2l0aG91
dCBzdG9wIHRyYWNpbmcuCgpBIHBhdGNoIHNldCBmb3IgbHR0bmctdG9vbHMgcHJvamVjdCBpcyBu
ZWNlc3NhcnkgdG8gdGFrZSBhZHZhbnRhZ2Ugb2YKdGhvc2UgY2hhbmdlcy4KClRoZSBsdHRuZy10
b29scyBjaGFuZ2VzIGNhbiBiZSBmb3VuZCBvbiB0aGlzIGJyYW5jaCBvZiBteSBHaXRodWIgZm9y
azoKaHR0cHM6Ly9naXRodWIuY29tL2ZyZGVzby9sdHRuZy10b29scy9jb21taXRzL211bHRpLWxp
Yi1zdXBwb3J0CgpGcmFuY2lzIERlc2xhdXJpZXJzICg1KToKICBDbGVhbnVwOiBNb3ZlIHZlcnNp
b24gbnVtYmVycyBpbiBzZXBhcmF0ZSB2YXJpYWJsZXMgaW4gY29uZmlndXJlCiAgICBzY3JpcHQK
ICBBZGQgcHJvYmUgcHJvdmlkZXIgdW5yZWdpc3RlciBmdW5jdGlvbgogIE1hbnVhbGx5IGRsb3Bl
bigpIGxpYmx0dG5nLXVzdC5zbyB0byBwcmV2ZW50IHVubG9hZGluZwogIFJlbmFtZSBsdHRuZ191
c3RfZW51bV9nZXQgdG8gbHR0bmdfdXN0X2VudW1fZ2V0X2Zyb21fZGVzYwogIFN1cHBvcnQgdW5s
b2FkaW5nIG9mIHByb2JlIHByb3ZpZGVycwoKTWF0aGlldSBEZXNub3llcnMgKDEpOgogIFJlbW92
ZSBkdXBsaWNhdGUgcHJvdmlkZXIgbmFtZSBjaGVja3MKCiBjb25maWd1cmUuYWMgICAgICAgICAg
ICAgICAgICAgICAgICAgfCAgIDcgKy0KIGluY2x1ZGUvbHR0bmcvdXN0LWV2ZW50cy5oICAgICAg
ICAgICB8ICAgNiArLQogaW5jbHVkZS9sdHRuZy91c3QtdHJhY2Vwb2ludC1ldmVudC5oIHwgICAy
ICstCiBsaWJsdHRuZy11c3QtY29tbS9sdHRuZy11c3QtY29tbS5jICAgfCAgIDMgKy0KIGxpYmx0
dG5nLXVzdC9NYWtlZmlsZS5hbSAgICAgICAgICAgICB8ICAgMiArCiBsaWJsdHRuZy11c3QvbHR0
bmctZXZlbnRzLmMgICAgICAgICAgfCAxMzUgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
LS0tLS0KIGxpYmx0dG5nLXVzdC9sdHRuZy1wcm9iZXMuYyAgICAgICAgICB8ICAyOCArKy0tLS0t
LQogbGlibHR0bmctdXN0L2x0dG5nLXVzdC1jb21tLmMgICAgICAgIHwgIDI1ICsrKysrKysKIGxp
Ymx0dG5nLXVzdC90cmFjZXBvaW50LmMgICAgICAgICAgICB8ICA0MyArKysrKysrKy0tLQogbGli
bHR0bmctdXN0L3VzdC1jb3JlLmMgICAgICAgICAgICAgIHwgIDExICsrLQogMTAgZmlsZXMgY2hh
bmdlZCwgMTk5IGluc2VydGlvbnMoKyksIDYzIGRlbGV0aW9ucygtKQoKLS0gCjIuNy40CgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsdHRuZy1kZXYgbWFp
bGluZyBsaXN0Cmx0dG5nLWRldkBsaXN0cy5sdHRuZy5vcmcKaHR0cHM6Ly9saXN0cy5sdHRuZy5v
cmcvY2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRldgo=
