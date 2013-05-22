From: "Ikaheimonen, JP" <jp_ikaheimonen@mentor.com>
Subject: [Babeltrace PATCH 11/23] Add MinGW implementation of
	nftw
Date: Wed, 22 May 2013 08:06:45 +0000
Message-ID: <009B25148989C6458484484699278506E5382F62__28771.2001394995$1369210047$gmane$org@EU-MBX-01.mgc.mentorg.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jp_ikaheimonen@mentor.com>) id 1Uf44U-0006Vc-MH
	for lttng-dev@lists.lttng.org; Wed, 22 May 2013 04:06:54 -0400
Content-Language: en-US
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "Mathieu Desnoyers (mathieu.desnoyers@efficios.com)" <mathieu.desnoyers@efficios.com>, =?iso-8859-1?Q?J=E9r=E9mie_Galarneau_=28jeremie=2Egalarneau=40efficios=2E?= =?iso-8859-1?Q?com=29?= <jeremie.galarneau@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Add MinGW implementation of nftw.
This implementation works only with plain directories containing
plain files.
---
 converter/babeltrace.c          |  2 +-
 include/babeltrace/compat/ftw.h | 73 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 74 insertions(+), 1 deletion(-)
 create mode 100644 include/babeltrace/compat/ftw.h

diff --git a/converter/babeltrace.c b/converter/babeltrace.c
index d5a7040..b356c43 100644
--- a/converter/babeltrace.c
+++ b/converter/babeltrace.c
@@ -48,7 +48,7 @@
 #include <fcntl.h>
 #include <unistd.h>
 #include <inttypes.h>
-#include <ftw.h>
+#include <babeltrace/compat/ftw.h>
 #include <string.h>
 
 #include <babeltrace/ctf-ir/metadata.h>	/* for clocks */
diff --git a/include/babeltrace/compat/ftw.h b/include/babeltrace/compat/ftw.h
new file mode 100644
index 0000000..f1e7bfd
--- /dev/null
+++ b/include/babeltrace/compat/ftw.h
@@ -0,0 +1,73 @@
+#ifndef _BABELTRACE_INCLUDE_COMPAT_FTW_H
+#define _BABELTRACE_INCLUDE_COMPAT_FTW_H
+
+#ifndef __MINGW32__
+#include <ftw.h>
+#else
+
+#include <windows.h>
+
+struct FTW {
+	int base;
+	int level;
+};
+
+
+#define FTW_F 0
+#define FTW_D 1
+#define FTW_DNR 2
+#define FTW_NS 3
+#define FTW_SL 4
+
+static inline
+int nftw(const char *dirpath,
+	int (*fn) (const char *fpath, const struct stat *sb,
+		int typeflag, struct FTW *ftwbuf),
+	int nopenfd, int flags)
+{
+	CHAR szSearch[MAX_PATH]         = {0};
+	CHAR szDirectory[MAX_PATH]      = {0};
+	HANDLE hFind                    = NULL;
+	WIN32_FIND_DATAA FindFileData;
+
+	sprintf(szSearch, "%s%s", dirpath, "\\*");
+	hFind = FindFirstFileA(szSearch, &FindFileData);
+	if(hFind == INVALID_HANDLE_VALUE)
+	{
+		/* print error */
+		return -1;
+	}
+	do {
+
+		if((FindFileData.dwFileAttributes & FILE_ATTRIBUTE_DIRECTORY) == FILE_ATTRIBUTE_DIRECTORY)
+		{
+			/* this is a directory */
+			/* skip '..' */
+			if (strcmp(FindFileData.cFileName, "..") == 0)
+				continue;
+
+			/* return '.' but do not recurse into it */
+			if (strcmp(FindFileData.cFileName, ".") == 0)
+			{
+				(*fn)(dirpath, 0, FTW_D, 0);
+				continue;
+			}
+
+			/* for others, recurse into them */
+			sprintf(szDirectory, "%s/%s", dirpath, FindFileData.cFileName);
+			nftw(szDirectory, fn, nopenfd, flags);
+
+		}
+		else
+		{
+			/* for files, report but do not recurse */
+			sprintf(szDirectory, "%s/%s", dirpath, FindFileData.cFileName);
+			(*fn)(szDirectory, 0, FTW_F, 0);
+		}
+	} while(FindNextFileA(hFind, &FindFileData));
+
+	FindClose(hFind);
+	return 0;
+}
+#endif
+#endif
-- 
1.8.1.msysgit.1
