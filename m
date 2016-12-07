From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-modules 2/2] Fix: SCSI instrumentation
 for SLES12 SP2
Date: Wed, 7 Dec 2016 01:38:29 +0000 (UTC)
Message-ID: <1720977830.29171.1481074709502.JavaMail.zimbra__25300.8733889603$1481074617$gmane$org@efficios.com>
References: <1481065533-25966-1-git-send-email-mjeanson@efficios.com>
 <1481065533-25966-2-git-send-email-mjeanson@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.141])
 by lists.lttng.org (Postfix) with ESMTPS id 3tYLk836NdzdbG
 for <lttng-dev@lists.lttng.org>; Wed,  7 Dec 2016 01:38:40 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 0A12C3401FA
 for <lttng-dev@lists.lttng.org>; Wed,  7 Dec 2016 01:38:30 +0000 (UTC)
In-Reply-To: <1481065533-25966-2-git-send-email-mjeanson@efficios.com>
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
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

LS0tLS0gT24gRGVjIDYsIDIwMTYsIGF0IDY6MDUgUE0sIE1pY2hhZWwgSmVhbnNvbiBtamVhbnNv
bkBlZmZpY2lvcy5jb20gd3JvdGU6Cgo+IFNpZ25lZC1vZmYtYnk6IE1pY2hhZWwgSmVhbnNvbiA8
bWplYW5zb25AZWZmaWNpb3MuY29tPgo+IC0tLQo+IGluc3RydW1lbnRhdGlvbi9ldmVudHMvbHR0
bmctbW9kdWxlL3Njc2kuaCB8IDMgKystCj4gMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygr
KSwgMSBkZWxldGlvbigtKQo+IAo+IGRpZmYgLS1naXQgYS9pbnN0cnVtZW50YXRpb24vZXZlbnRz
L2x0dG5nLW1vZHVsZS9zY3NpLmgKPiBiL2luc3RydW1lbnRhdGlvbi9ldmVudHMvbHR0bmctbW9k
dWxlL3Njc2kuaAo+IGluZGV4IDAyZTMzNTMuLjdjNmVjZjEgMTAwNjQ0Cj4gLS0tIGEvaW5zdHJ1
bWVudGF0aW9uL2V2ZW50cy9sdHRuZy1tb2R1bGUvc2NzaS5oCj4gKysrIGIvaW5zdHJ1bWVudGF0
aW9uL2V2ZW50cy9sdHRuZy1tb2R1bGUvc2NzaS5oCj4gQEAgLTE1LDcgKzE1LDggQEAKPiAKPiAj
ZGVmaW5lIHNjc2lfb3Bjb2RlX25hbWUob3Bjb2RlKQl7IG9wY29kZSwgI29wY29kZSB9Cj4gCj4g
LSNpZiAoTElOVVhfVkVSU0lPTl9DT0RFID49IEtFUk5FTF9WRVJTSU9OKDQsNywwKSkKPiArI2lm
IChMSU5VWF9WRVJTSU9OX0NPREUgPj0gS0VSTkVMX1ZFUlNJT04oNCw3LDApIFwKPiArCXx8IExU
VE5HX1NMRV9LRVJORUxfUkFOR0UoNCw0LDksMzYsMCwwICw0LDUsMCwwLDAsMCkpCgpJIHR5cGlj
YWxseSBkbzoKCkxUVE5HX1NMRV9LRVJORUxfUkFOR0UoNCw0LDksMzYsMCwwLCA0LDUsMCwwLDAs
MCkKCihzcGFjaW5nIGFuZCBjb21tYSBsYXlvdXQpCgpUaGFua3MsCgpNYXRoaWV1Cgo+IAo+ICNk
ZWZpbmUgc2hvd19vcGNvZGVfbmFtZSh2YWwpCQkJCQlcCj4gCV9fcHJpbnRfc3ltYm9saWModmFs
LAkJCQkJXAo+IC0tCj4gMi43LjQKCi0tIApNYXRoaWV1IERlc25veWVycwpFZmZpY2lPUyBJbmMu
Cmh0dHA6Ly93d3cuZWZmaWNpb3MuY29tCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCmx0dG5nLWRldiBtYWlsaW5nIGxpc3QKbHR0bmctZGV2QGxpc3RzLmx0
dG5nLm9yZwpodHRwczovL2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmluL21haWxtYW4vbGlzdGluZm8v
bHR0bmctZGV2Cg==
