From: =?UTF-8?q?J=C3=A9r=C3=A9mie=20Galarneau?=
	<jeremie.galarneau@efficios.com>
Subject: [PATCH lttng-tools 2/4] Extras: Fix the undefined
	reference to md build error.
Date: Mon, 14 Jan 2013 16:45:47 +0000
Message-ID: <1358181949-23456-2-git-send-email-jeremie.galarneau__9909.69416820935$1358200072$gmane$org@efficios.com>
References: <1358181949-23456-1-git-send-email-jeremie.galarneau@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qc0-f178.google.com ([209.85.216.178])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jeremie.galarneau@gmail.com>) id 1TursA-0002Pd-Fr
	for lttng-dev@lists.lttng.org; Mon, 14 Jan 2013 16:47:14 -0500
Received: by mail-qc0-f178.google.com with SMTP id j34so2782083qco.23
	for <lttng-dev@lists.lttng.org>; Mon, 14 Jan 2013 13:47:09 -0800 (PST)
In-Reply-To: <1358181949-23456-1-git-send-email-jeremie.galarneau@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

UmVtb3ZlZCBzY3JpcHRlZCBtb2RpZmljYXRpb25zIHRvIGx0dG5nX3dyYXAuYyBkdXJpbmcgUHl0
aG9uIGJpbmRpbmcgZ2VuZXJhdGlvbi4KClNpZ25lZC1vZmYtYnk6IErDqXLDqW1pZSBHYWxhcm5l
YXUgPGplcmVtaWUuZ2FsYXJuZWF1QGVmZmljaW9zLmNvbT4KLS0tCiBleHRyYXMvYmluZGluZ3Mv
c3dpZy9weXRob24vTWFrZWZpbGUuYW0gfCA0IC0tLS0KIDEgZmlsZSBjaGFuZ2VkLCA0IGRlbGV0
aW9ucygtKQoKZGlmZiAtLWdpdCBhL2V4dHJhcy9iaW5kaW5ncy9zd2lnL3B5dGhvbi9NYWtlZmls
ZS5hbSBiL2V4dHJhcy9iaW5kaW5ncy9zd2lnL3B5dGhvbi9NYWtlZmlsZS5hbQppbmRleCBkNTky
ZGVkLi5jNmE2OTAxIDEwMDY0NAotLS0gYS9leHRyYXMvYmluZGluZ3Mvc3dpZy9weXRob24vTWFr
ZWZpbGUuYW0KKysrIGIvZXh0cmFzL2JpbmRpbmdzL3N3aWcvcHl0aG9uL01ha2VmaWxlLmFtCkBA
IC0xNywxMSArMTcsNyBAQCBfbHR0bmdfbGFfTERGTEFHUyA9IC1tb2R1bGUKIF9sdHRuZ19sYV9M
SUJBREQgPSAJJCh0b3Bfc3JjZGlyKS9zcmMvbGliL2x0dG5nLWN0bC9saWJsdHRuZy1jdGwubGEg
CQlcCiAJCQkkKHRvcF9zcmNkaXIpL3NyYy9jb21tb24vc2Vzc2lvbmQtY29tbS9saWJzZXNzaW9u
ZC1jb21tLmxhCiAKLSMgU1dJRyAnd2FybmluZyBtZCB2YXJpYWJsZSB1bnVzZWQnIGZpeGVkIGFm
dGVyIFNXSUcgYnVpbGQ6CiBsdHRuZ193cmFwLmM6IGx0dG5nLmkKIAkkKFNXSUcpIC1weXRob24g
LUkuIC1JJCh0b3Bfc3JjZGlyKS9zcmMvY29tbW9uL3Nlc3Npb25kLWNvbW0gbHR0bmcuaQotCXNl
ZCAtaSAicy9QeU9iamVjdCBcKm0sIFwqZCwgXCptZDsvUHlPYmplY3QgXCptLCBcKmQ7XG4jaWYg
ZGVmaW5lZChTV0lHUFlUSE9OX0JVSUxUSU4pXG5QeU9iamVjdCAqbWQ7XG4jZW5kaWYvZyIgbHR0
bmdfd3JhcC5jCi0Jc2VkIC1pICJzL21kID0gZC9kL2ciIGx0dG5nX3dyYXAuYwotCXNlZCAtaSAi
cy8odm9pZClwdWJsaWNfc3ltYm9sOy8odm9pZClwdWJsaWNfc3ltYm9sO1xuICBtZCA9IGQ7L2ci
IGx0dG5nX3dyYXAuYwogCiBDTEVBTkZJTEVTID0gbHR0bmcuaSBsdHRuZy5weSBsdHRuZ193cmFw
LmMgbHR0bmcucHljCi0tIAoxLjguMQoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCmx0dG5nLWRldiBtYWlsaW5nIGxpc3QKbHR0bmctZGV2QGxpc3RzLmx0
dG5nLm9yZwpodHRwOi8vbGlzdHMubHR0bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9s
dHRuZy1kZXYK
