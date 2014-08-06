From: Jonathan Rajotte Julien <jonathan.r.julien@gmail.com>
Subject: [PATCH lttng-tool] Mi & save/load: add option to indent
	or not on config writer creation
Date: Wed, 6 Aug 2014 10:13:48 -0400
Message-ID: <1407334428-7601-1-git-send-email-jonathan.r.julien__15903.4477932893$1407334503$gmane$org@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from usevmg21.ericsson.net ([198.24.6.65])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jonathan.rajotte-julien@ericsson.com>)
 id 1XF1ye-0000t9-Me
 for lttng-dev@lists.lttng.org; Wed, 06 Aug 2014 10:14:07 -0400
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

The presence of tabulation and newline in mi is irrelevant and
can impact client performance. The parsing & processing of a lot of data from mi
with many /t and /n impact performance. This aim to fix the problem at the
source. Style is useless for machine.

Signed-off-by: Jonathan Rajotte Julien <jonathan.r.julien@gmail.com>
---
 src/bin/lttng-sessiond/save.c | 2 +-
 src/common/config/config.c    | 8 ++++----
 src/common/config/config.h    | 5 ++++-
 src/common/mi-lttng.c         | 2 +-
 4 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/src/bin/lttng-sessiond/save.c b/src/bin/lttng-sessiond/save.c
index 90b3a3b..28844e3 100644
--- a/src/bin/lttng-sessiond/save.c
+++ b/src/bin/lttng-sessiond/save.c
@@ -1514,7 +1514,7 @@ int save_session(struct ltt_session *session,
 	}
 	file_opened = 1;
 
-	writer = config_writer_create(fd);
+	writer = config_writer_create(fd, 1);
 	if (!writer) {
 		ret = LTTNG_ERR_NOMEM;
 		goto end;
diff --git a/src/common/config/config.c b/src/common/config/config.c
index bfb2576..1dccd26 100644
--- a/src/common/config/config.c
+++ b/src/common/config/config.c
@@ -353,7 +353,7 @@ end:
 }
 
 LTTNG_HIDDEN
-struct config_writer *config_writer_create(int fd_output)
+struct config_writer *config_writer_create(int fd_output, int indent)
 {
 	int ret;
 	struct config_writer *writer;
@@ -379,12 +379,12 @@ struct config_writer *config_writer_create(int fd_output)
 
 	ret = xmlTextWriterSetIndentString(writer->writer,
 		BAD_CAST config_xml_indent_string);
-	if (ret)  {
+	if (ret) {
 		goto error_destroy;
 	}
 
-	ret = xmlTextWriterSetIndent(writer->writer, 1);
-	if (ret)  {
+	ret = xmlTextWriterSetIndent(writer->writer, indent);
+	if (ret) {
 		goto error_destroy;
 	}
 
diff --git a/src/common/config/config.h b/src/common/config/config.h
index 9a5671a..2fed612 100644
--- a/src/common/config/config.h
+++ b/src/common/config/config.h
@@ -81,11 +81,14 @@ int config_parse_value(const char *value);
  * fd_output File to which the XML content must be written. The file will be
  * closed once the config_writer has been destroyed.
  *
+ * indent If other than 0 the XML will be pretty printed
+ * with indentation and newline.
+ *
  * Returns an instance of a configuration writer on success, NULL on
  * error.
  */
 LTTNG_HIDDEN
-struct config_writer *config_writer_create(int fd_output);
+struct config_writer *config_writer_create(int fd_output, int indent);
 
 /*
  * Destroy an instance of a configuration writer.
diff --git a/src/common/mi-lttng.c b/src/common/mi-lttng.c
index a636c71..31fa610 100644
--- a/src/common/mi-lttng.c
+++ b/src/common/mi-lttng.c
@@ -352,7 +352,7 @@ struct mi_writer *mi_lttng_writer_create(int fd_output, int mi_output_type)
 		goto end;
 	}
 	if (mi_output_type == LTTNG_MI_XML) {
-		mi_writer->writer = config_writer_create(fd_output);
+		mi_writer->writer = config_writer_create(fd_output, 0);
 		if (!mi_writer->writer) {
 			goto err_destroy;
 		}
-- 
2.0.0
