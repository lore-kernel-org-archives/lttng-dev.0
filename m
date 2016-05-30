From: Michael Jeanson <mjeanson@efficios.com>
Subject: [PATCH babeltrace 2/2] Fix: strerror_r behavior is
	glibc specific
Date: Mon, 30 May 2016 16:39:02 -0400
Message-ID: <1464640742-24658-2-git-send-email-mjeanson__32795.5505498268$1464640782$gmane$org@efficios.com>
References: <1464640742-24658-1-git-send-email-mjeanson@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [78.47.125.74])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id CE770A372B
 for <lttng-dev@lists.lttng.org>; Mon, 30 May 2016 20:39:13 +0000 (UTC)
In-Reply-To: <1464640742-24658-1-git-send-email-mjeanson@efficios.com>
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
LQogaW5jbHVkZS9iYWJlbHRyYWNlL2NvbXBhdC9zdHJpbmcuaCB8IDIgKy0KIDEgZmlsZSBjaGFu
Z2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2luY2x1ZGUv
YmFiZWx0cmFjZS9jb21wYXQvc3RyaW5nLmggYi9pbmNsdWRlL2JhYmVsdHJhY2UvY29tcGF0L3N0
cmluZy5oCmluZGV4IDdhNTc0ZTYuLjYwOTI2MTYgMTAwNjQ0Ci0tLSBhL2luY2x1ZGUvYmFiZWx0
cmFjZS9jb21wYXQvc3RyaW5nLmgKKysrIGIvaW5jbHVkZS9iYWJlbHRyYWNlL2NvbXBhdC9zdHJp
bmcuaApAQCAtMjYsNyArMjYsNyBAQAogI2luY2x1ZGUgPHN0cmluZy5oPgogI2luY2x1ZGUgPHN0
ZGxpYi5oPgogCi0jaWYgIWRlZmluZWQoX19saW51eF9fKSB8fCAoKF9QT1NJWF9DX1NPVVJDRSA+
PSAyMDAxMTJMIHx8IF9YT1BFTl9TT1VSQ0UgPj0gNjAwKSAmJiAhZGVmaW5lZChfR05VX1NPVVJD
RSkpCisjaWYgIWRlZmluZWQoX19HTElCQ19fKSB8fCAoKF9QT1NJWF9DX1NPVVJDRSA+PSAyMDAx
MTJMIHx8IF9YT1BFTl9TT1VSQ0UgPj0gNjAwKSAmJiAhZGVmaW5lZChfR05VX1NPVVJDRSkpCiAK
IC8qIFhTSS1jb21wbGlhbnQgc3RyZXJyb3JfciAqLwogc3RhdGljIGlubGluZQotLSAKMi43LjQK
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmx0dG5nLWRl
diBtYWlsaW5nIGxpc3QKbHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZwpodHRwczovL2xpc3RzLmx0
dG5nLm9yZy9jZ2ktYmluL21haWxtYW4vbGlzdGluZm8vbHR0bmctZGV2Cg==
