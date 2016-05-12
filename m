From: Michael Jeanson <mjeanson@efficios.com>
Subject: [PATCH RFC lttng-tools] Drop installcheck target
Date: Thu, 12 May 2016 12:07:56 -0400
Message-ID: <1463069276-31747-1-git-send-email-mjeanson__44125.1255375848$1463069315$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [78.47.125.74])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id 16076A34AA
 for <lttng-dev@lists.lttng.org>; Thu, 12 May 2016 16:08:07 +0000 (UTC)
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
Cc: jgalar@efficios.com
List-Id: lttng-dev@lists.lttng.org

VGhlIGluc3RhbGxjaGVjayB0YXJnZXQgaXMgc3VwcG9zZWQgdG8gYmUgdXNlZCB0byBydW4gdGVz
dHMgb24gdGhlCmluc3RhbGxlZCBmaWxlcywgaG93ZXZlciBvdXIgY3VycmVudCBpbXBsZW1lbnRh
dGlvbiBydW5zIHRoZSBleGFjdCBzYW1lCnRlc3RzIGluIHRoZSBidWlsZCBkaXJlY3RvcnkgYXMg
dGhlIGNoZWNrIHRhcmdldCwgd2hpY2ggbWFrZXMgaXQgdXNlbGVzcy4KClNpZ25lZC1vZmYtYnk6
IE1pY2hhZWwgSmVhbnNvbiA8bWplYW5zb25AZWZmaWNpb3MuY29tPgotLS0KIHRlc3RzL01ha2Vm
aWxlLmFtIHwgMTYgLS0tLS0tLS0tLS0tLS0tLQogMSBmaWxlIGNoYW5nZWQsIDE2IGRlbGV0aW9u
cygtKQoKZGlmZiAtLWdpdCBhL3Rlc3RzL01ha2VmaWxlLmFtIGIvdGVzdHMvTWFrZWZpbGUuYW0K
aW5kZXggMDE3MTYzZi4uYzdkNGNkMCAxMDA2NDQKLS0tIGEvdGVzdHMvTWFrZWZpbGUuYW0KKysr
IGIvdGVzdHMvTWFrZWZpbGUuYW0KQEAgLTUsMjIgKzUsNiBAQCBpZiBCVUlMRF9URVNUUwogU1VC
RElSUyArPSB1dGlscyByZWdyZXNzaW9uIHVuaXQgc3RyZXNzIGRlc3RydWN0aXZlCiBlbmRpZgog
Ci1pbnN0YWxsY2hlY2stYW06Ci1pZiBCVUlMRF9URVNUUwotaWYgSEFTX1BHUkVQCi0JLi91dGls
cy93YXJuX2x0dG5nX3Byb2Nlc3Nlcy5zaCAkKFBHUkVQKQotZW5kaWYKLQkuL3J1bi5zaCB1bml0
X3Rlc3RzCi0JLi9ydW4uc2ggZmFzdF9yZWdyZXNzaW9uCi1pZiBQWVRIT05fQklORElORwotCS4v
cnVuLnNoIHdpdGhfYmluZGluZ3NfcmVncmVzc2lvbgotZW5kaWYKLWVsc2UKLQlAZWNobyAiPT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0iCi0JQGVjaG8gIldBUk5JTkc6
IFRlc3RzIHdlcmUgZGlzYWJsZWQgYXQgY29uZmlndXJlIgotCUBlY2hvICI9PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PSIKLWVuZGlmCi0KIGNoZWNrLWFtOgogaWYgQlVJ
TERfVEVTVFMKIGlmIEhBU19QR1JFUAotLSAKMS45LjEKCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCmx0dG5nLWRldiBtYWlsaW5nIGxpc3QKbHR0bmctZGV2
QGxpc3RzLmx0dG5nLm9yZwpodHRwczovL2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmluL21haWxtYW4v
bGlzdGluZm8vbHR0bmctZGV2Cg==
