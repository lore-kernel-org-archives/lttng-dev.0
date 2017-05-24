From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-modules] Fix: update sched
 instrumentation for kernel 4.12
Date: Wed, 24 May 2017 16:11:48 +0000 (UTC)
Message-ID: <417919179.24120.1495642308675.JavaMail.zimbra__31338.6293281384$1495642699$gmane$org@efficios.com>
References: <1495568718-29003-1-git-send-email-mjeanson@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.141])
 by lists.lttng.org (Postfix) with ESMTPS id 3wXy881GDmz113l
 for <lttng-dev@lists.lttng.org>; Wed, 24 May 2017 16:11:52 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 81F54340378
 for <lttng-dev@lists.lttng.org>; Wed, 24 May 2017 16:11:51 +0000 (UTC)
In-Reply-To: <1495568718-29003-1-git-send-email-mjeanson@efficios.com>
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

TWVyZ2VkIGludG8gbWFzdGVyLCAyLjEwLCAyLjksIDIuOC4KClRoYW5rcywKCk1hdGhpZXUKCi0t
LS0tIE9uIE1heSAyMywgMjAxNywgYXQgOTo0NSBQTSwgTWljaGFlbCBKZWFuc29uIG1qZWFuc29u
QGVmZmljaW9zLmNvbSB3cm90ZToKCj4gU2VlIHVwc3RyZWFtIGNvbW1pdCBiOTE0NzNmZjZlOTc5
YzAwMjhmMDJmOTBlNDBjODQ0OTU5YzczNmQ4Cj4gCj4gU2lnbmVkLW9mZi1ieTogTWljaGFlbCBK
ZWFuc29uIDxtamVhbnNvbkBlZmZpY2lvcy5jb20+Cj4gLS0tCj4gaW5zdHJ1bWVudGF0aW9uL2V2
ZW50cy9sdHRuZy1tb2R1bGUvc2NoZWQuaCB8IDIwICsrKysrKysrKysrKysrKysrKystCj4gMSBm
aWxlIGNoYW5nZWQsIDE5IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKPiAKPiBkaWZmIC0t
Z2l0IGEvaW5zdHJ1bWVudGF0aW9uL2V2ZW50cy9sdHRuZy1tb2R1bGUvc2NoZWQuaAo+IGIvaW5z
dHJ1bWVudGF0aW9uL2V2ZW50cy9sdHRuZy1tb2R1bGUvc2NoZWQuaAo+IGluZGV4IGU1MDY2YWYu
LmM2OGRkMjcgMTAwNjQ0Cj4gLS0tIGEvaW5zdHJ1bWVudGF0aW9uL2V2ZW50cy9sdHRuZy1tb2R1
bGUvc2NoZWQuaAo+ICsrKyBiL2luc3RydW1lbnRhdGlvbi9ldmVudHMvbHR0bmctbW9kdWxlL3Nj
aGVkLmgKPiBAQCAtNTQwLDcgKzU0MCwyNSBAQCBMVFROR19UUkFDRVBPSU5UX0VWRU5UKHNjaGVk
X3N0YXRfcnVudGltZSwKPiApCj4gI2VuZGlmCj4gCj4gLSNpZiAoTElOVVhfVkVSU0lPTl9DT0RF
ID49IEtFUk5FTF9WRVJTSU9OKDIsNiwzNykpCj4gKyNpZiAoTElOVVhfVkVSU0lPTl9DT0RFID49
IEtFUk5FTF9WRVJTSU9OKDQsMTIsMCkpCj4gKy8qCj4gKyAqIFRyYWNlcG9pbnQgZm9yIHNob3dp
bmcgcHJpb3JpdHkgaW5oZXJpdGFuY2UgbW9kaWZ5aW5nIGEgdGFza3MKPiArICogcHJpb3JpdHku
Cj4gKyAqLwo+ICtMVFROR19UUkFDRVBPSU5UX0VWRU5UKHNjaGVkX3BpX3NldHByaW8sCj4gKwo+
ICsJVFBfUFJPVE8oc3RydWN0IHRhc2tfc3RydWN0ICp0c2ssIHN0cnVjdCB0YXNrX3N0cnVjdCAq
cGlfdGFzayksCj4gKwo+ICsJVFBfQVJHUyh0c2ssIHBpX3Rhc2spLAo+ICsKPiArCVRQX0ZJRUxE
UygKPiArCQljdGZfYXJyYXlfdGV4dChjaGFyLCBjb21tLCB0c2stPmNvbW0sIFRBU0tfQ09NTV9M
RU4pCj4gKwkJY3RmX2ludGVnZXIocGlkX3QsIHRpZCwgdHNrLT5waWQpCj4gKwkJY3RmX2ludGVn
ZXIoaW50LCBvbGRwcmlvLCB0c2stPnByaW8gLSBNQVhfUlRfUFJJTykKPiArCQljdGZfaW50ZWdl
cihpbnQsIG5ld3ByaW8sIHBpX3Rhc2sgPyBwaV90YXNrLT5wcmlvIC0gTUFYX1JUX1BSSU8gOiB0
c2stPnByaW8gLQo+IE1BWF9SVF9QUklPKQo+ICsJKQo+ICspCj4gKyNlbGlmIChMSU5VWF9WRVJT
SU9OX0NPREUgPj0gS0VSTkVMX1ZFUlNJT04oMiw2LDM3KSkKPiAvKgo+ICAqIFRyYWNlcG9pbnQg
Zm9yIHNob3dpbmcgcHJpb3JpdHkgaW5oZXJpdGFuY2UgbW9kaWZ5aW5nIGEgdGFza3MKPiAgKiBw
cmlvcml0eS4KPiAtLQo+IDIuNy40CgotLSAKTWF0aGlldSBEZXNub3llcnMKRWZmaWNpT1MgSW5j
LgpodHRwOi8vd3d3LmVmZmljaW9zLmNvbQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwpsdHRuZy1kZXYgbWFpbGluZyBsaXN0Cmx0dG5nLWRldkBsaXN0cy5s
dHRuZy5vcmcKaHR0cHM6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZv
L2x0dG5nLWRldgo=
