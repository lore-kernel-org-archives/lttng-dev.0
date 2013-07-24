From: Xiaona Han <xiaonahappy13@163.com>
Subject: [PATCH babeltrace] Use a unique name to get a field's
	value
Date: Wed, 24 Jul 2013 17:57:47 +0800
Message-ID: <1374659868-6264-2-git-send-email-xiaonahappy13__18286.9355463938$1374631145$gmane$org@163.com>
References: <1374659868-6264-1-git-send-email-xiaonahappy13@163.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from [124.16.141.1] (helo=host.localdomain)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <root@host.localdomain>) id 1V1oLB-00023D-AD
	for lttng-dev@lists.lttng.org; Tue, 23 Jul 2013 21:58:15 -0400
In-Reply-To: <1374659868-6264-1-git-send-email-xiaonahappy13@163.com>
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

Signed-off-by: Xiaona Han <xiaonahappy13@163.com>
---
 bindings/python/babeltrace.i.in |   19 +++++++++++++++++++
 1 files changed, 19 insertions(+), 0 deletions(-)

diff --git a/bindings/python/babeltrace.i.in b/bindings/python/babeltrace.i.in
index 880b23e..806cc73 100755
--- a/bindings/python/babeltrace.i.in
+++ b/bindings/python/babeltrace.i.in
@@ -986,6 +986,25 @@ class ctf:
 			"""
 			return _bt_ctf_get_string(self._d)
 
+		def get_value(self):
+			"""
+			Return the value associated with the field according to its type.
+			If the field does not exist, the value returned is undefined.
+			To check if an error occured, use the ctf.field_error() function
+			after accessing a field.
+			"""
+			id = self.field_type()
+			if id == ctf.type_id.STRING:
+				return self.get_str()
+			if type_id == ctf.type_id.ARRAY:
+				return self.get_char_array()
+			if type_id == ctf.type_id.INTEGER:
+				if self.get_int_signedness == 0:
+					return self.get_uint64()
+				else:
+					return self.get_int64()
+			return None
+
 		def get_scope(self):
 			"""Return the scope of a field or None on error."""
 			return self._s
-- 
1.7.1
