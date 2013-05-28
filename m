From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: [PATCH 1/2] Do not call posix_fallocate() on uClibc
Date: Tue, 28 May 2013 15:27:06 +0200
Message-ID: <1369747627-21626-1-git-send-email-thomas.petazzoni__29321.5475198396$1369747672$gmane$org@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.free-electrons.com ([94.23.35.102])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <thomas.petazzoni@free-electrons.com>)
	id 1UhJvm-00015D-GD
	for lttng-dev@lists.lttng.org; Tue, 28 May 2013 09:27:14 -0400
Received: from localhost (col31-4-88-188-83-94.fbx.proxad.net [88.188.83.94])
	by mail.free-electrons.com (Postfix) with ESMTPSA id B7658D
	for <lttng-dev@lists.lttng.org>; Tue, 28 May 2013 15:27:06 +0200 (CEST)
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

uClibc does not implement posix_fallocate(), and posix_fallocate() is
mostly only an hint to the kernel that we will need such or such
amount of space inside a file. So we just don't call posix_fallocate()
when building against uClibc.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 formats/ctf/ctf.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/formats/ctf/ctf.c b/formats/ctf/ctf.c
index bb94e52..77aef28 100644
--- a/formats/ctf/ctf.c
+++ b/formats/ctf/ctf.c
@@ -43,6 +43,7 @@
 #include <sys/stat.h>
 #include <fcntl.h>
 #include <dirent.h>
+#include <features.h>
 #include <glib.h>
 #include <unistd.h>
 #include <stdlib.h>
@@ -723,9 +724,11 @@ void ctf_packet_seek(struct bt_stream_pos *stream_pos, size_t index, int whence)
 		}
 		pos->content_size = -1U;	/* Unknown at this point */
 		pos->packet_size = WRITE_PACKET_LEN;
+#ifndef __UCLIBC__
 		off = posix_fallocate(pos->fd, pos->mmap_offset,
 				      pos->packet_size / CHAR_BIT);
 		assert(off >= 0);
+#endif
 		pos->offset = 0;
 	} else {
 	read_next_packet:
-- 
1.7.9.5
