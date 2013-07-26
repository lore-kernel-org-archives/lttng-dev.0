From: Xiaona Han <xiaonahappy13@163.com>
Subject: [PATCH babeltrace] Support getting the value of enums
Date: Fri, 26 Jul 2013 17:48:02 +0800
Message-ID: <1374832082-6663-1-git-send-email-xiaonahappy13__15317.2707804062$1374803352$gmane$org@163.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from [124.16.141.1] (helo=host.localdomain)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <root@host.localdomain>) id 1V2X8n-0000RM-P1
	for lttng-dev@lists.lttng.org; Thu, 25 Jul 2013 21:48:26 -0400
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

Use 'get_enmu_str' to get the string matching the current enumeration.

Signed-off-by: Xiaona Han <xiaonahappy13@163.com>
---
 bindings/python/babeltrace.i.in |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/bindings/python/babeltrace.i.in b/bindings/python/babeltrace.i.in
index c478dfc..d307fdb 100644
--- a/bindings/python/babeltrace.i.in
+++ b/bindings/python/babeltrace.i.in
@@ -560,6 +560,8 @@ struct bt_ctf_event *bt_ctf_iter_read_event(struct bt_ctf_iter *iter);
 %rename("_bt_ctf_get_int_byte_order") bt_ctf_get_int_byte_order(
 		const struct bt_declaration *field);
 %rename("_bt_ctf_get_int_len") bt_ctf_get_int_len(const struct bt_declaration *field);
+%rename("_bt_ctf_get_enum_int") bt_ctf_get_enum_int(const struct bt_definition *field);
+%rename("_bt_ctf_get_enum_str") bt_ctf_get_enum_str(const struct bt_definition *field);
 %rename("_bt_ctf_get_encoding") bt_ctf_get_encoding(const struct bt_declaration *field);
 %rename("_bt_ctf_get_array_len") bt_ctf_get_array_len(const struct bt_declaration *field);
 %rename("_bt_ctf_get_uint64") bt_ctf_get_uint64(const struct bt_definition *field);
@@ -591,6 +593,8 @@ int bt_ctf_get_int_signedness(const struct bt_declaration *field);
 int bt_ctf_get_int_base(const struct bt_declaration *field);
 int bt_ctf_get_int_byte_order(const struct bt_declaration *field);
 ssize_t bt_ctf_get_int_len(const struct bt_declaration *field);
+const struct bt_definition *bt_ctf_get_enum_int(const struct bt_definition *field);
+const char *bt_ctf_get_enum_str(const struct bt_definition *field);
 enum ctf_string_encoding bt_ctf_get_encoding(const struct bt_declaration *field);
 int bt_ctf_get_array_len(const struct bt_declaration *field);
 uint64_t bt_ctf_get_uint64(const struct bt_definition *field);
@@ -918,6 +922,13 @@ class ctf:
 			"""
 			return _bt_ctf_get_int_len(self._d)
 
+		def get_enum_str(self):
+			"""
+			Return the string matching the current enumeration.
+			Return None on error.
+			"""
+			return _bt_ctf_get_enum_str(self._d)
+
 		def get_encoding(self):
 			"""
 			Return the encoding of an int or a string.
-- 
1.7.1
