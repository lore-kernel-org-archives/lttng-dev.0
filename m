From: Philippe Proulx <eeppeliteloop@gmail.com>
Subject: [lttng-tools 2/2] Fix: relayd: revents may be 0 when
	using poll()
Date: Wed, 26 Nov 2014 16:29:19 -0500
Message-ID: <1417037359-20877-3-git-send-email-eeppeliteloop__12684.7397689291$1417037405$gmane$org@gmail.com>
References: <1417037359-20877-1-git-send-email-eeppeliteloop@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qc0-f175.google.com ([209.85.216.175])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <eeppeliteloop@gmail.com>) id 1Xtk8t-0003Ki-F5
 for lttng-dev@lists.lttng.org; Wed, 26 Nov 2014 16:28:57 -0500
Received: by mail-qc0-f175.google.com with SMTP id b13so3036474qcw.6
 for <lttng-dev@lists.lttng.org>; Wed, 26 Nov 2014 13:28:50 -0800 (PST)
Received: from archeepp.internal.efficios.com ([173.246.22.116])
 by mx.google.com with ESMTPSA id b17sm4927018qah.35.2014.11.26.13.28.48
 for <lttng-dev@lists.lttng.org>
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Wed, 26 Nov 2014 13:28:49 -0800 (PST)
In-Reply-To: <1417037359-20877-1-git-send-email-eeppeliteloop@gmail.com>
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

Refs: #747

Signed-off-by: Philippe Proulx <eeppeliteloop@gmail.com>
---
 src/bin/lttng-relayd/main.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/src/bin/lttng-relayd/main.c b/src/bin/lttng-relayd/main.c
index 00b8735..07cb8f5 100644
--- a/src/bin/lttng-relayd/main.c
+++ b/src/bin/lttng-relayd/main.c
@@ -2499,6 +2499,11 @@ restart:
 
 			health_code_update();
 
+			/* Do not waste time if no returned events for this fd */
+			if (!revents) {
+				continue;
+			}
+
 			/* Thread quit pipe has been closed. Killing thread. */
 			ret = check_thread_quit_pipe(pollfd, revents);
 			if (ret) {
-- 
2.1.3
