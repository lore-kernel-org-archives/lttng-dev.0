From: Danny Serres <danny.serres@efficios.com>
Subject: [babeltrace PATCH] Fix: correct name of
	bt_ctf_field_get_error in comments and typo in man page
Date: Thu,  9 Aug 2012 11:45:00 -0400
Message-ID: <1344527100-10782-1-git-send-email-danny.serres__38322.5878853866$1344527148$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.polymtl.ca ([132.207.4.11])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <danny.serres@efficios.com>) id 1SzUv4-0003T1-QP
	for lttng-dev@lists.lttng.org; Thu, 09 Aug 2012 11:45:06 -0400
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
Cc: Danny Serres <danny.serres@efficios.com>
List-Id: lttng-dev@lists.lttng.org

Signed-off-by: Danny Serres <danny.serres@efficios.com>
---
 doc/babeltrace.1                |    2 +-
 formats/ctf/events.c            |    2 +-
 include/babeltrace/ctf/events.h |    4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/doc/babeltrace.1 b/doc/babeltrace.1
index db07caf..db462f4 100644
--- a/doc/babeltrace.1
+++ b/doc/babeltrace.1
@@ -97,7 +97,7 @@ babeltrace-log(1), lttng(1), lttng-ust(3), lttng-sessiond(8)
 .SH "BUGS"
 
 .PP
-No knows bugs at this point.
+No known bugs at this point.
 
 If you encounter any issues or usability problem, please report it on
 our mailing list <lttng-dev@lists.lttng.org> to help improve this
diff --git a/formats/ctf/events.c b/formats/ctf/events.c
index a8b08f6..5d92b08 100644
--- a/formats/ctf/events.c
+++ b/formats/ctf/events.c
@@ -34,7 +34,7 @@
 /*
  * thread local storage to store the last error that occured
  * while reading a field, this variable must be accessed by
- * bt_ctf_field_error only
+ * bt_ctf_field_get_error only
  */
 __thread int bt_ctf_last_field_error = 0;
 
diff --git a/include/babeltrace/ctf/events.h b/include/babeltrace/ctf/events.h
index 4232feb..2bf9c62 100644
--- a/include/babeltrace/ctf/events.h
+++ b/include/babeltrace/ctf/events.h
@@ -182,7 +182,7 @@ int bt_ctf_get_array_len(const struct definition *field);
  *
  * If the field does not exist or is not of the type requested, the value
  * returned is undefined. To check if an error occured, use the
- * bt_ctf_field_error() function after accessing a field.
+ * bt_ctf_field_get_error() function after accessing a field.
  */
 uint64_t bt_ctf_get_uint64(const struct definition *field);
 int64_t bt_ctf_get_int64(const struct definition *field);
@@ -190,7 +190,7 @@ char *bt_ctf_get_char_array(const struct definition *field);
 char *bt_ctf_get_string(const struct definition *field);
 
 /*
- * bt_ctf_field_error: returns the last error code encountered while
+ * bt_ctf_field_get_error: returns the last error code encountered while
  * accessing a field and reset the error flag.
  * Return 0 if no error, a negative value otherwise.
  */
-- 
1.7.9.5
