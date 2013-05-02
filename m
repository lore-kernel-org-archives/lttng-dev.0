From: "Ikaheimonen, JP" <jp_ikaheimonen@mentor.com>
Subject: [Babeltrace RFC PATCH 08/28] Add MinGW implementation
 of mmap and munmap
Date: Thu, 2 May 2013 11:49:25 +0000
Message-ID: <009B25148989C6458484484699278506E537E8A5__23486.1902813011$1367495406$gmane$org@EU-MBX-01.mgc.mentorg.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jp_ikaheimonen@mentor.com>) id 1UXs0z-0001vN-0u
	for lttng-dev@lists.lttng.org; Thu, 02 May 2013 07:49:33 -0400
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

Implementations of mmap and munmap using Windows API.
The header file sys/mman.h is now indirectly included by
include/babeltrace/compat/mman.h .
For MinGW, PAGE_SIZE is defined as a constant instead of
using a sysconf() setting.
---
 compat/Makefile.am                  |   4 +-
 compat/compat_mman.c                | 128 ++++++++++++++++++++++++++++++++++++
 converter/babeltrace-log.c          |   2 +-
 formats/bt-dummy/bt-dummy.c         |   2 +-
 formats/ctf-metadata/ctf-metadata.c |   2 +-
 formats/ctf-text/ctf-text.c         |   2 +-
 formats/ctf/ctf.c                   |   2 +-
 include/babeltrace/align.h          |   5 ++
 include/babeltrace/compat/mman.h    |  24 +++++++
 include/babeltrace/ctf-text/types.h |   2 +-
 include/babeltrace/mmap-align.h     |   2 +-
 11 files changed, 166 insertions(+), 9 deletions(-)
 create mode 100644 compat/compat_mman.c
 create mode 100644 include/babeltrace/compat/mman.h

diff --git a/compat/Makefile.am b/compat/Makefile.am
index e624a79..e573854 100644
--- a/compat/Makefile.am
+++ b/compat/Makefile.am
@@ -9,5 +9,5 @@ libcompat_la_LDFLAGS = \
 	-Wl,--no-as-needed
 
 if BABELTRACE_BUILD_WITH_MINGW
-libcompat_la_SOURCES += compat_uuid.c
-endif
\ No newline at end of file
+libcompat_la_SOURCES += compat_mman.c compat_uuid.c
+endif
diff --git a/compat/compat_mman.c b/compat/compat_mman.c
new file mode 100644
index 0000000..0e45260
--- /dev/null
+++ b/compat/compat_mman.c
@@ -0,0 +1,128 @@
+/* This file is only built under MINGW32 */
+
+#include <windows.h>
+#include <stdlib.h>
+#include <babeltrace/compat/mman.h>
+
+#define HAS_FLAG( BITSET, FLAG ) ( ( BITSET & FLAG ) == FLAG )
+
+typedef struct
+{
+    HANDLE hFile;
+    HANDLE hFileMappingObject;
+    unsigned char *start_addr;
+    long offset;
+} mmap_data;
+
+mmap_data *arr_mmap_data = NULL;
+size_t arr_mmap_data_size = 0;
+DWORD allocationGranularity = 0;
+
+void mmap_data_add( mmap_data data )
+{
+    arr_mmap_data = (mmap_data *) realloc( arr_mmap_data, ( arr_mmap_data_size + 1 ) * sizeof( mmap_data ) );
+    arr_mmap_data[ arr_mmap_data_size ] = data;
+    arr_mmap_data_size += 1;
+}
+
+mmap_data *mmap_data_find_addr( unsigned char *start_addr )
+{
+    size_t i;
+    for( i = 0; i < arr_mmap_data_size; ++i )
+	if( arr_mmap_data[i].start_addr + arr_mmap_data[i].offset == start_addr )
+	    return arr_mmap_data + i;
+
+    return NULL;
+}
+
+/* mmap for mingw32 */
+void *mmap( void *ptr, long size, long prot, long type, long handle, long arg )
+{
+    //__builtin_printf( "mmap: %p, %d, %d, %d, %d, %d\n", ptr, size, prot, type, handle, arg );
+    mmap_data data_entry;
+    long offset;
+
+    if (allocationGranularity == 0)
+    {
+        SYSTEM_INFO sysinfo;
+        GetSystemInfo(&sysinfo);
+        allocationGranularity = sysinfo.dwAllocationGranularity;
+    }
+
+    if( prot == PROT_NONE || HAS_FLAG( prot, PROT_EXEC ) )
+	return MAP_FAILED; /* not supported - fail safe */
+
+    data_entry.hFile = (HANDLE) _get_osfhandle( handle );
+    if( data_entry.hFile != INVALID_HANDLE_VALUE )
+    {
+
+	/* There is no 1:1 mapping, best effort strategy */
+	DWORD flProtect = PAGE_READONLY;
+	DWORD dwDesiredAccess = FILE_MAP_READ;
+
+	if( HAS_FLAG( prot, PROT_WRITE ) )
+	{
+	    flProtect = PAGE_READWRITE;
+	    if( HAS_FLAG( prot, PROT_READ ) )
+		dwDesiredAccess = FILE_MAP_ALL_ACCESS;
+	    else
+		dwDesiredAccess = FILE_MAP_WRITE;
+	}
+
+	if( HAS_FLAG( type, MAP_PRIVATE ) )
+	{
+	    flProtect = PAGE_WRITECOPY;
+	    dwDesiredAccess = FILE_MAP_COPY;
+	}
+
+	data_entry.hFileMappingObject = CreateFileMapping( data_entry.hFile, NULL, flProtect, 0, 0, NULL );
+	if( data_entry.hFileMappingObject != NULL )
+	{
+            DWORD filesizelow;
+            DWORD filesizehigh;
+	    filesizelow = GetFileSize(data_entry.hFile, &filesizehigh);
+	    offset = 0;
+            while (arg > allocationGranularity)
+            {
+                if (filesizelow < allocationGranularity)
+                {
+			filesizehigh--;
+		}
+		filesizelow -= allocationGranularity;
+
+                arg -= allocationGranularity;
+                offset += allocationGranularity;
+            }
+            data_entry.offset = arg;
+            size = size + arg;
+            if ((size > filesizelow) && (filesizehigh == 0))
+            {
+                size = filesizelow;
+            }
+	    data_entry.start_addr = MapViewOfFile( data_entry.hFileMappingObject, dwDesiredAccess, 0, offset, size);
+	    if( data_entry.start_addr != NULL )
+	    {
+		mmap_data_add( data_entry );
+		return (void *)(data_entry.start_addr + arg);
+	    }
+	}
+
+    }
+
+    return MAP_FAILED;
+}
+
+
+/* munmap for mingw32 */
+long munmap( void *ptr, long size )
+{
+    mmap_data *data_entry = mmap_data_find_addr( ptr );
+    if( data_entry != NULL  && UnmapViewOfFile( data_entry->start_addr ) != 0 )
+    {
+	CloseHandle( data_entry->hFileMappingObject );
+	data_entry->start_addr = NULL;
+	return 0;
+    }
+
+    return -1;
+}
diff --git a/converter/babeltrace-log.c b/converter/babeltrace-log.c
index 52a2fe1..b11eb99 100644
--- a/converter/babeltrace-log.c
+++ b/converter/babeltrace-log.c
@@ -33,7 +33,7 @@
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <fcntl.h>
-#include <sys/mman.h>
+#include <babeltrace/compat/mman.h>
 #include <dirent.h>
 #include <stdio.h>
 #include <stdlib.h>
diff --git a/formats/bt-dummy/bt-dummy.c b/formats/bt-dummy/bt-dummy.c
index 6192e88..4be9741 100644
--- a/formats/bt-dummy/bt-dummy.c
+++ b/formats/bt-dummy/bt-dummy.c
@@ -28,7 +28,7 @@
 #include <babeltrace/format.h>
 #include <babeltrace/babeltrace-internal.h>
 #include <inttypes.h>
-#include <sys/mman.h>
+#include <babeltrace/compat/mman.h>
 #include <errno.h>
 #include <sys/types.h>
 #include <sys/stat.h>
diff --git a/formats/ctf-metadata/ctf-metadata.c b/formats/ctf-metadata/ctf-metadata.c
index a5a74c3..7ac36e1 100644
--- a/formats/ctf-metadata/ctf-metadata.c
+++ b/formats/ctf-metadata/ctf-metadata.c
@@ -31,7 +31,7 @@
 #include <babeltrace/babeltrace-internal.h>
 #include <babeltrace/ctf/events-internal.h>
 #include <inttypes.h>
-#include <sys/mman.h>
+#include <babeltrace/compat/mman.h>
 #include <errno.h>
 #include <sys/types.h>
 #include <sys/stat.h>
diff --git a/formats/ctf-text/ctf-text.c b/formats/ctf-text/ctf-text.c
index 48ce31b..bc5c2a7 100644
--- a/formats/ctf-text/ctf-text.c
+++ b/formats/ctf-text/ctf-text.c
@@ -32,7 +32,7 @@
 #include <babeltrace/babeltrace-internal.h>
 #include <babeltrace/ctf/events-internal.h>
 #include <inttypes.h>
-#include <sys/mman.h>
+#include <babeltrace/compat/mman.h>
 #include <errno.h>
 #include <sys/types.h>
 #include <sys/stat.h>
diff --git a/formats/ctf/ctf.c b/formats/ctf/ctf.c
index d77c93a..0cfad44 100644
--- a/formats/ctf/ctf.c
+++ b/formats/ctf/ctf.c
@@ -37,7 +37,7 @@
 #include <babeltrace/endian.h>
 #include <inttypes.h>
 #include <stdio.h>
-#include <sys/mman.h>
+#include <babeltrace/compat/mman.h>
 #include <errno.h>
 #include <sys/types.h>
 #include <sys/stat.h>
diff --git a/include/babeltrace/align.h b/include/babeltrace/align.h
index f6a1966..e7d715e 100644
--- a/include/babeltrace/align.h
+++ b/include/babeltrace/align.h
@@ -30,8 +30,13 @@
 #include <limits.h>
 
 #ifndef PAGE_SIZE		/* Cygwin limits.h defines its own PAGE_SIZE */
+#ifdef __MINGW32__
+#define PAGE_SIZE		4096
+#else
 #define PAGE_SIZE		sysconf(_SC_PAGE_SIZE)
 #endif
+#endif
+
 
 #define ALIGN(x, a)		__ALIGN_MASK(x, (typeof(x))(a) - 1)
 #define __ALIGN_MASK(x, mask)	(((x) + (mask)) & ~(mask))
diff --git a/include/babeltrace/compat/mman.h b/include/babeltrace/compat/mman.h
new file mode 100644
index 0000000..a004b1e
--- /dev/null
+++ b/include/babeltrace/compat/mman.h
@@ -0,0 +1,24 @@
+#ifndef _BABELTRACE_INCLUDE_COMPAT_MMAN_H
+#define _BABELTRACE_INCLUDE_COMPAT_MMAN_H
+
+#ifdef __MINGW32__
+
+#define PROT_READ	0x1
+#define PROT_WRITE	0x2
+#define PROT_EXEC	0x4
+#define PROT_NONE	0x0
+
+#define MAP_SHARED	0x01
+#define MAP_PRIVATE	0x02
+#define MAP_FAILED	((void *) -1)
+
+/* mmap for mingw32 */
+void *mmap (void *ptr, long size, long prot, long type, long handle, long arg);
+/* munmap for mingw32 */
+long munmap (void *ptr, long size);
+
+#else
+#include <sys/mman.h>
+#endif
+
+#endif /* _BABELTRACE_INCLUDE_COMPAT_MMAN_H */
diff --git a/include/babeltrace/ctf-text/types.h b/include/babeltrace/ctf-text/types.h
index 7b4b717..c528355 100644
--- a/include/babeltrace/ctf-text/types.h
+++ b/include/babeltrace/ctf-text/types.h
@@ -27,7 +27,7 @@
  * SOFTWARE.
  */
 
-#include <sys/mman.h>
+#include <babeltrace/compat/mman.h>
 #include <errno.h>
 #include <stdint.h>
 #include <unistd.h>
diff --git a/include/babeltrace/mmap-align.h b/include/babeltrace/mmap-align.h
index f7c18fa..3d90c85 100644
--- a/include/babeltrace/mmap-align.h
+++ b/include/babeltrace/mmap-align.h
@@ -27,7 +27,7 @@
 
 #include <babeltrace/align.h>
 #include <stdlib.h>
-#include <sys/mman.h>
+#include <babeltrace/compat/mman.h>
 
 /*
  * This header implements a wrapper over mmap (mmap_align) that memory
-- 
1.8.1.msysgit.1
