From: Xiaona Han <xiaonahappy13@163.com>
Subject: [PATCH babeltrace] Add bt_unregister_format function
	support
Date: Tue,  9 Jul 2013 14:50:22 +0800
Message-ID: <1373352622-11876-1-git-send-email-xiaonahappy13__9561.05713635243$1373323872$gmane$org@163.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from [124.16.141.1] (helo=host.localdomain)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <root@host.localdomain>) id 1UwKGX-0001KF-3o
	for lttng-dev@lists.lttng.org; Mon, 08 Jul 2013 18:50:41 -0400
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

---
 bindings/python/babeltrace.i.in |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/bindings/python/babeltrace.i.in b/bindings/python/babeltrace.i.in
index 06b8d40..dd2dacc 100644
--- a/bindings/python/babeltrace.i.in
+++ b/bindings/python/babeltrace.i.in
@@ -188,10 +188,12 @@ class Context:
 %rename("lookup_format") bt_lookup_format(bt_intern_str qname);
 %rename("_bt_print_format_list") bt_fprintf_format_list(FILE *fp);
 %rename("register_format") bt_register_format(struct format *format);
+%rename("unregister_format") bt_unregister_format(struct bt_format *format);
 
 extern struct format *bt_lookup_format(bt_intern_str qname);
 extern void bt_fprintf_format_list(FILE *fp);
 extern int bt_register_format(struct bt_format *format);
+extern void bt_unregister_format(struct bt_format *format);
 
 %pythoncode %{
 
-- 
1.7.1
