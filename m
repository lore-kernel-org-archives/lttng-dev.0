From: "Ikaheimonen, JP" <jp_ikaheimonen@mentor.com>
Subject: [Babeltrace RFC PATCH 23/28] Add a MinGW substitute for
 openat() and related functions
Date: Thu, 2 May 2013 12:04:16 +0000
Message-ID: <009B25148989C6458484484699278506E537E9A6__40779.6486084864$1367496346$gmane$org@EU-MBX-01.mgc.mentorg.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jp_ikaheimonen@mentor.com>) id 1UXsFN-0002Fj-4d
	for lttng-dev@lists.lttng.org; Thu, 02 May 2013 08:04:25 -0400
Content-Language: en-US
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "Mathieu Desnoyers (mathieu.desnoyers@efficios.com)" <mathieu.desnoyers@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Check if the build system has openat() support.
If it does not, we have to open files based on the directory name
instead of the directory handle. Substitute openat() with
compat_openat() that also takes the directory path name as a
parameter.
If we don't have openat(), replace the function dirfd() with a dummy.
Also, if we don't have openat(), open() and close() will not
work for directories. Replace those with compat_opendirfd and
compat_closedirfd() with dummy equivalents, as the function
compat_openat() takes care of opening the file.
---
 configure.ac                       |  7 +++++
 converter/babeltrace-log.c         | 10 +++----
 converter/babeltrace.c             | 10 +++----
 formats/ctf/ctf.c                  |  8 +++---
 include/babeltrace/compat/dirent.h | 11 ++++++++
 include/babeltrace/compat/fcntl.h  | 58 ++++++++++++++++++++++++++++++++++++++
 6 files changed, 90 insertions(+), 14 deletions(-)

diff --git a/configure.ac b/configure.ac
index 5f9e38d..168fb91 100644
--- a/configure.ac
+++ b/configure.ac
@@ -84,6 +84,13 @@ AC_CHECK_LIB([c], [open_memstream],
 ]
 )
 
+# Check for openat
+AC_CHECK_LIB([c], [openat],
+[
+	AC_DEFINE_UNQUOTED([BABELTRACE_HAVE_OPENAT], 1, [Has openat support.])
+]
+)
+
 AC_CHECK_LIB([popt], [poptGetContext], [],
         [AC_MSG_ERROR([Cannot find popt.])]
 )
diff --git a/converter/babeltrace-log.c b/converter/babeltrace-log.c
index b11eb99..ac3bb3f 100644
--- a/converter/babeltrace-log.c
+++ b/converter/babeltrace-log.c
@@ -32,9 +32,9 @@
 #include <config.h>
 #include <sys/types.h>
 #include <sys/stat.h>
-#include <fcntl.h>
+#include <babeltrace/compat/fcntl.h>
 #include <babeltrace/compat/mman.h>
-#include <dirent.h>
+#include <babeltrace/compat/dirent.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <stdint.h>
@@ -343,20 +343,20 @@ int main(int argc, char **argv)
 		perror("opendir");
 		goto error_rmdir;
 	}
-	dir_fd = dirfd(dir);
+	dir_fd = compat_dirfd(dir);
 	if (dir_fd < 0) {
 		perror("dirfd");
 		goto error_closedir;
 	}
 
-	fd = openat(dir_fd, "datastream", O_RDWR|O_CREAT,
+	fd = compat_openat(s_outputname, dir_fd, "datastream", O_RDWR|O_CREAT,
 		    S_IRUSR|S_IWUSR|S_IRGRP|S_IWGRP);
 	if (fd < 0) {
 		perror("openat");
 		goto error_closedirfd;
 	}
 
-	metadata_fd = openat(dir_fd, "metadata", O_RDWR|O_CREAT,
+	metadata_fd = compat_openat(s_outputname, dir_fd, "metadata", O_RDWR|O_CREAT,
 			     S_IRUSR|S_IWUSR|S_IRGRP|S_IWGRP);
 	if (fd < 0) {
 		perror("openat");
diff --git a/converter/babeltrace.c b/converter/babeltrace.c
index f4a9217..d449ea7 100644
--- a/converter/babeltrace.c
+++ b/converter/babeltrace.c
@@ -45,7 +45,7 @@
 #include <ctype.h>
 #include <sys/stat.h>
 #include <sys/types.h>
-#include <fcntl.h>
+#include <babeltrace/compat/fcntl.h>
 #include <unistd.h>
 #include <inttypes.h>
 #include <babeltrace/compat/ftw.h>
@@ -409,15 +409,15 @@ static int traverse_trace_dir(const char *fpath, const struct stat *sb,
 	if (tflag != FTW_D)
 		return 0;
 
-	dirfd = open(fpath, 0);
+	dirfd = compat_opendirfd(fpath, 0);
 	if (dirfd < 0) {
 		fprintf(stderr, "[error] [Context] Unable to open trace "
 			"directory file descriptor.\n");
 		return 0;	/* partial error */
 	}
-	metafd = openat(dirfd, "metadata", O_RDONLY);
+	metafd = compat_openat(fpath, dirfd, "metadata", O_RDONLY);
 	if (metafd < 0) {
-		closeret = close(dirfd);
+		closeret = compat_closedirfd(dirfd);
 		if (closeret < 0) {
 			perror("close");
 			return -1;
@@ -430,7 +430,7 @@ static int traverse_trace_dir(const char *fpath, const struct stat *sb,
 			perror("close");
 			return -1;	/* failure */
 		}
-		closeret = close(dirfd);
+		closeret = compat_closedirfd(dirfd);
 		if (closeret < 0) {
 			perror("close");
 			return -1;	/* failure */
diff --git a/formats/ctf/ctf.c b/formats/ctf/ctf.c
index c6043bc..7878555 100644
--- a/formats/ctf/ctf.c
+++ b/formats/ctf/ctf.c
@@ -1078,7 +1078,7 @@ int ctf_open_trace_metadata_read(struct ctf_trace *td,
 		metadata_stream->pos.fd = -1;
 	} else {
 		td->metadata = &metadata_stream->parent;
-		metadata_stream->pos.fd = openat(td->dirfd, "metadata", O_RDONLY);
+		metadata_stream->pos.fd = compat_openat(td->parent.path, td->dirfd, "metadata", O_RDONLY);
 		if (metadata_stream->pos.fd < 0) {
 			fprintf(stderr, "Unable to open metadata.\n");
 			ret = -1;
@@ -1624,7 +1624,7 @@ int ctf_open_file_stream_read(struct ctf_trace *td, const char *path, int flags,
 	struct ctf_file_stream *file_stream;
 	struct stat statbuf;
 
-	fd = openat(td->dirfd, path, flags);
+	fd = compat_openat(td->parent.path, td->dirfd, path, flags);
 	if (fd < 0) {
 		perror("File stream openat()");
 		ret = fd;
@@ -1717,7 +1717,7 @@ int ctf_open_trace_read(struct ctf_trace *td,
 		goto error;
 	}
 
-	td->dirfd = open(path, 0);
+	td->dirfd = compat_opendirfd(path, 0);
 	if (td->dirfd < 0) {
 		fprintf(stderr, "[error] Unable to open trace directory file descriptor for path \"%s\".\n", path);
 		perror("Trace directory open");
@@ -1775,7 +1775,7 @@ int ctf_open_trace_read(struct ctf_trace *td,
 readdir_error:
 	free(dirent);
 error_metadata:
-	closeret = close(td->dirfd);
+	closeret = compat_closedirfd(td->dirfd);
 	if (closeret) {
 		perror("Error on fd close");
 	}
diff --git a/include/babeltrace/compat/dirent.h b/include/babeltrace/compat/dirent.h
index 281f40b..a7d6227 100644
--- a/include/babeltrace/compat/dirent.h
+++ b/include/babeltrace/compat/dirent.h
@@ -17,4 +17,15 @@ int readdir_r (DIR *dirp, struct dirent *entry, struct dirent **result)
 }
 #endif
 
+static inline
+int compat_dirfd(DIR * dirp)
+{
+#ifdef BABELTRACE_HAVE_OPENAT
+	return dirfd(dirp);
+#else
+	/* ignore dirfd - see compat_openat() */
+	return 0;
+#endif
+}
+
 #endif
diff --git a/include/babeltrace/compat/fcntl.h b/include/babeltrace/compat/fcntl.h
index 0707c28..f58a1bf 100644
--- a/include/babeltrace/compat/fcntl.h
+++ b/include/babeltrace/compat/fcntl.h
@@ -2,6 +2,10 @@
 #define _BABELTRACE_INCLUDE_COMPAT_FCNTL_H
 
 #include <fcntl.h>
+#include <stdlib.h>
+#include <stdarg.h>
+#include <stdio.h>
+
 #ifdef __MINGW32__
 static inline
 int posix_fallocate(int fd, off_t offset, off_t len)
@@ -10,4 +14,58 @@ int posix_fallocate(int fd, off_t offset, off_t len)
 }
 #endif
 
+/*
+   If we have BABELTRACE_HAVE_OPENAT, then
+   openat() and dirfd() work, and open() and close() can
+   work on directories.
+
+   If we don't have BABELTRACE_HAVE_OPENAT,
+   then we have to open files based on the directory name,
+   not the directory handle. The functions
+   compat_[opendirfd | closedirfd | dirfd] all are dummied
+   to return zero, and compat_openat() takes care of the
+   opening of the file.
+*/
+
+static inline
+int compat_openat(const char * dirname, int dirfd, const char *pathname, int flags, ...)
+{
+
+#ifdef BABELTRACE_HAVE_OPENAT
+	mode_t mode = 0;
+	va_list args;
+	va_start (args, flags);
+	mode = (mode_t)va_arg(args, int);
+	va_end(args);
+	return openat(dirfd, pathname, flags, mode);
+#else
+	char szSearch[MAX_PATH]         = {0};
+	sprintf(szSearch, "%s/%s", dirname, pathname);
+#ifdef __MINGW32__
+	flags = flags | O_BINARY;
+#endif
+	return open(szSearch, flags);
+#endif
+}
+
+static inline
+int compat_opendirfd(const char *fpath, int flags)
+{
+#ifdef BABELTRACE_HAVE_OPENAT
+	return open(fpath, flags);
+#else
+	return 0;
+#endif
+}
+
+static inline
+int compat_closedirfd(int dirfd)
+{
+#ifdef BABELTRACE_HAVE_OPENAT
+	return close(dirfd);
+#else
+	return 0;
+#endif
+}
+
 #endif
\ No newline at end of file
-- 
1.8.1.msysgit.1
