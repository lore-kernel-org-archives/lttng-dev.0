From: Michael Jeanson <mjeanson@efficios.com>
Subject: [PATCH babeltrace] Fix: add missing void param to
	bt_clock_class_priority_map_create
Date: Tue, 29 Aug 2017 12:16:39 -0400
Message-ID: <1504023399-15321-1-git-send-email-mjeanson__37374.563716776$1504023439$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.141])
 by lists.lttng.org (Postfix) with ESMTPS id 3xhYgF1JB6z14Qn
 for <lttng-dev@lists.lttng.org>; Tue, 29 Aug 2017 16:16:56 +0000 (UTC)
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

U2lnbmVkLW9mZi1ieTogTWljaGFlbCBKZWFuc29uIDxtamVhbnNvbkBlZmZpY2lvcy5jb20+Ci0t
LQogaW5jbHVkZS9iYWJlbHRyYWNlL2dyYXBoL2Nsb2NrLWNsYXNzLXByaW9yaXR5LW1hcC5oIHwg
MiArLQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZm
IC0tZ2l0IGEvaW5jbHVkZS9iYWJlbHRyYWNlL2dyYXBoL2Nsb2NrLWNsYXNzLXByaW9yaXR5LW1h
cC5oIGIvaW5jbHVkZS9iYWJlbHRyYWNlL2dyYXBoL2Nsb2NrLWNsYXNzLXByaW9yaXR5LW1hcC5o
CmluZGV4IGJkYTllYjMuLmQwM2IxZWEgMTAwNjQ0Ci0tLSBhL2luY2x1ZGUvYmFiZWx0cmFjZS9n
cmFwaC9jbG9jay1jbGFzcy1wcmlvcml0eS1tYXAuaAorKysgYi9pbmNsdWRlL2JhYmVsdHJhY2Uv
Z3JhcGgvY2xvY2stY2xhc3MtcHJpb3JpdHktbWFwLmgKQEAgLTkzLDcgKzkzLDcgQEAgc3RydWN0
IGJ0X2Nsb2NrX2NsYXNzX3ByaW9yaXR5X21hcDsKIAogQHBvc3RzdWNjZXNzcmVmY291bnRyZXQx
CiAqLwotZXh0ZXJuIHN0cnVjdCBidF9jbG9ja19jbGFzc19wcmlvcml0eV9tYXAgKmJ0X2Nsb2Nr
X2NsYXNzX3ByaW9yaXR5X21hcF9jcmVhdGUoKTsKK2V4dGVybiBzdHJ1Y3QgYnRfY2xvY2tfY2xh
c3NfcHJpb3JpdHlfbWFwICpidF9jbG9ja19jbGFzc19wcmlvcml0eV9tYXBfY3JlYXRlKHZvaWQp
OwogCiAvKioKIEBicmllZglSZXR1cm5zIHRoZSBudW1iZXIgb2YgQ1RGIElSIGNsb2NrIGNsYXNz
ZXMgY29udGFpbmVkIGluIHRoZQotLSAKMi43LjQKCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCmx0dG5nLWRldiBtYWlsaW5nIGxpc3QKbHR0bmctZGV2QGxp
c3RzLmx0dG5nLm9yZwpodHRwczovL2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmluL21haWxtYW4vbGlz
dGluZm8vbHR0bmctZGV2Cg==
