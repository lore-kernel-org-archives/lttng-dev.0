From: Julien Desfossez <jdesfossez@efficios.com>
Subject: [BABELTRACE PATCH 2/3] Handle packets containing only a
	header
Date: Wed, 27 Nov 2013 10:06:02 -0500
Message-ID: <1385564763-1374-2-git-send-email-jdesfossez__45472.7323180579$1385564942$gmane$org@efficios.com>
References: <1385564763-1374-1-git-send-email-jdesfossez@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([144.76.53.219])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jdesfossez@efficios.com>) id 1Vlggz-0007WJ-RD
	for lttng-dev@lists.lttng.org; Wed, 27 Nov 2013 10:06:23 -0500
In-Reply-To: <1385564763-1374-1-git-send-email-jdesfossez@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: mathieu.desnoyers@efficios.com
Cc: lttng-dev@lists.lttng.org, Julien Desfossez <jdesfossez@efficios.com>
List-Id: lttng-dev@lists.lttng.org

Signed-off-by: Julien Desfossez <jdesfossez@efficios.com>
---
 formats/ctf/ctf.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/formats/ctf/ctf.c b/formats/ctf/ctf.c
index 5f263cd..477392b 100644
--- a/formats/ctf/ctf.c
+++ b/formats/ctf/ctf.c
@@ -476,6 +476,10 @@ int ctf_read_event(struct bt_stream_pos *ppos, struct ctf_stream_definition *str
 		/* Stream is inactive for now (live reading). */
 		return EAGAIN;
 	}
+	/* Packet only contains headers */
+	if (pos->offset == pos->content_size)
+		return EOF;
+
 	assert(pos->offset < pos->content_size);
 
 	/* Read event header */
-- 
1.8.3.2
