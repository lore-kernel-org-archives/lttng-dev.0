From: Michael Jeanson <mjeanson@efficios.com>
Subject: [PATCH lttng-tools stable-2.6 3/3] Tests: use
	configured processor count in tracefile count test
Date: Tue, 15 Mar 2016 16:13:26 -0400
Message-ID: <1458072806-19932-3-git-send-email-mjeanson__37795.0229020373$1458072848$gmane$org@efficios.com>
References: <1458072806-19932-1-git-send-email-mjeanson@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [78.47.125.74])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id EF5EBA084E
 for <lttng-dev@lists.lttng.org>; Tue, 15 Mar 2016 20:13:46 +0000 (UTC)
In-Reply-To: <1458072806-19932-1-git-send-email-mjeanson@efficios.com>
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
LQogdGVzdHMvcmVncmVzc2lvbi90b29scy90cmFjZWZpbGUtbGltaXRzL3Rlc3RfdHJhY2VmaWxl
X2NvdW50IHwgNCArKy0tCiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0
aW9ucygtKQoKZGlmZiAtLWdpdCBhL3Rlc3RzL3JlZ3Jlc3Npb24vdG9vbHMvdHJhY2VmaWxlLWxp
bWl0cy90ZXN0X3RyYWNlZmlsZV9jb3VudCBiL3Rlc3RzL3JlZ3Jlc3Npb24vdG9vbHMvdHJhY2Vm
aWxlLWxpbWl0cy90ZXN0X3RyYWNlZmlsZV9jb3VudAppbmRleCBkZjFjZGNlLi45MDAxNTBjIDEw
MDc1NQotLS0gYS90ZXN0cy9yZWdyZXNzaW9uL3Rvb2xzL3RyYWNlZmlsZS1saW1pdHMvdGVzdF90
cmFjZWZpbGVfY291bnQKKysrIGIvdGVzdHMvcmVncmVzc2lvbi90b29scy90cmFjZWZpbGUtbGlt
aXRzL3Rlc3RfdHJhY2VmaWxlX2NvdW50CkBAIC0yNywxMCArMjcsMTAgQEAgVEVTVEFQUF9CSU49
IiRURVNUQVBQX1BBVEgvJFRFU1RBUFBfTkFNRS8kVEVTVEFQUF9OQU1FIgogU1RBVFNfQklOPSIk
VEVTVERJUi91dGlscy9iYWJlbHN0YXRzLnBsIgogTlVNX1RFU1RTPTc0CiAKLU5VTV9DUFVTPWBu
cHJvY2AKLQogc291cmNlICRURVNURElSL3V0aWxzL3V0aWxzLnNoCiAKK05VTV9DUFVTPSQoY29u
Zl9wcm9jX2NvdW50KQorCiBpZiBbICEgLXggIiRURVNUQVBQX0JJTiIgXTsgdGhlbgogCUJBSUxf
T1VUICJObyBVU1QgZXZlbnRzIGJpbmFyeSBkZXRlY3RlZC4iCiBmaQotLSAKMi43LjAKCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmx0dG5nLWRldiBtYWls
aW5nIGxpc3QKbHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZwpodHRwczovL2xpc3RzLmx0dG5nLm9y
Zy9jZ2ktYmluL21haWxtYW4vbGlzdGluZm8vbHR0bmctZGV2Cg==
