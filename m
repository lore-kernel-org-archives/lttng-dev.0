From: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
Subject: [PATCH lttng-tools 2/2] Fix: lttng-crash: remove tmp
	working directory
Date: Thu,  3 Sep 2015 17:52:07 -0400
Message-ID: <1441317127-10878-2-git-send-email-jonathan.rajotte-julien__46416.2417957143$1441317333$gmane$org@efficios.com>
References: <1441317127-10878-1-git-send-email-jonathan.rajotte-julien@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jonathan.rajotte-julien@efficios.com>)
 id 1ZXcQv-0006MS-3i
 for lttng-dev@lists.lttng.org; Thu, 03 Sep 2015 17:52:41 -0400
In-Reply-To: <1441317127-10878-1-git-send-email-jonathan.rajotte-julien@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
Cc: jgalar@efficios.com
List-Id: lttng-dev@lists.lttng.org

Signed-off-by: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
---
 src/bin/lttng-crash/lttng-crash.c | 65 +++++++++++++++++++++++++++++----------
 1 file changed, 48 insertions(+), 17 deletions(-)

diff --git a/src/bin/lttng-crash/lttng-crash.c b/src/bin/lttng-crash/lttng-crash.c
index 8e57034..00a97df 100644
--- a/src/bin/lttng-crash/lttng-crash.c
+++ b/src/bin/lttng-crash/lttng-crash.c
@@ -1053,35 +1053,62 @@ end:
 }
 
 static
-int delete_trace(const char *trace_path)
+int delete_recursive_dir(const char *path)
 {
-	DIR *trace_dir;
-	int trace_dir_fd, ret = 0, closeret;
+	DIR *dir;
+	int dir_fd, ret = 0, closeret;
 	struct dirent *entry;
 
 	/* Open trace directory */
-	trace_dir = opendir(trace_path);
-	if (!trace_dir) {
-		PERROR("Cannot open '%s' path", trace_path);
+	dir = opendir(path);
+	if (!dir) {
+		PERROR("Cannot open '%s' path", path);
 		return -1;
 	}
-	trace_dir_fd = dirfd(trace_dir);
-	if (trace_dir_fd < 0) {
+	dir_fd = dirfd(dir);
+	if (dir_fd < 0) {
 		PERROR("dirfd");
 		return -1;
 	}
 
-	while ((entry = readdir(trace_dir))) {
+	while ((entry = readdir(dir))) {
 		if (!strcmp(entry->d_name, ".")
 				|| !strcmp(entry->d_name, "..")) {
 			continue;
 		}
 		switch (entry->d_type) {
 		case DT_DIR:
-			unlinkat(trace_dir_fd, entry->d_name, AT_REMOVEDIR);
+		{
+			char subpath[PATH_MAX];
+
+			strncpy(subpath, path,
+				sizeof(subpath));
+			subpath[sizeof(subpath) - 1] = '\0';
+			strncat(subpath, "/",
+				sizeof(subpath) - strlen(subpath) - 1);
+			strncat(subpath, entry->d_name,
+				sizeof(subpath) - strlen(subpath) - 1);
+
+			ret = delete_recursive_dir(subpath);
+			if (ret) {
+				goto end;
+			}
+
+			ret = unlinkat(dir_fd, entry->d_name, AT_REMOVEDIR);
+			if (ret) {
+				PERROR("Unlinking '%s'", entry->d_name);
+				goto end;
+			}
+
 			break;
+		}
 		case DT_REG:
-			unlinkat(trace_dir_fd, entry->d_name, 0);
+			ret = unlinkat(dir_fd, entry->d_name, 0);
+			if (ret) {
+				PERROR("Unlinking '%s'", entry->d_name);
+				goto end;
+			}
+
 			break;
 		default:
 			ret = -EINVAL;
@@ -1089,13 +1116,10 @@ int delete_trace(const char *trace_path)
 		}
 	}
 end:
-	closeret = closedir(trace_dir);
+	closeret = closedir(dir);
 	if (closeret) {
 		PERROR("closedir");
 	}
-	if (!ret) {
-		ret = rmdir(trace_path);
-	}
 	return ret;
 }
 
@@ -1178,9 +1202,16 @@ int main(int argc, char *argv[])
 			has_warning = 1;
 
 		/* unlink temporary trace */
-		ret = delete_trace(output_path);
-		if (ret)
+		ret = delete_recursive_dir(output_path);
+		if (ret){
 			has_warning = 1;
+		}else{
+			ret = rmdir(output_path);
+			if (ret) {
+				PERROR("Deleting '%s'", output_path);
+				has_warning = 1;
+			}
+		}
 	}
 	if (has_warning)
 		exit(EXIT_FAILURE);
-- 
2.1.4
