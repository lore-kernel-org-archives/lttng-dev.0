From: Philippe Proulx <eeppeliteloop@gmail.com>
Subject: [lttng-tools 1/2] Fix: sessiond: revents may be 0 when
	using poll()
Date: Wed, 26 Nov 2014 16:29:18 -0500
Message-ID: <1417037359-20877-2-git-send-email-eeppeliteloop__30898.0997688652$1417037383$gmane$org@gmail.com>
References: <1417037359-20877-1-git-send-email-eeppeliteloop@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qa0-f44.google.com ([209.85.216.44])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <eeppeliteloop@gmail.com>) id 1Xtk8r-0003Kh-T5
 for lttng-dev@lists.lttng.org; Wed, 26 Nov 2014 16:28:54 -0500
Received: by mail-qa0-f44.google.com with SMTP id i13so2490267qae.17
 for <lttng-dev@lists.lttng.org>; Wed, 26 Nov 2014 13:28:48 -0800 (PST)
Received: from archeepp.internal.efficios.com ([173.246.22.116])
 by mx.google.com with ESMTPSA id b17sm4927018qah.35.2014.11.26.13.28.47
 for <lttng-dev@lists.lttng.org>
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Wed, 26 Nov 2014 13:28:47 -0800 (PST)
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

Fixes: #747

Signed-off-by: Philippe Proulx <eeppeliteloop@gmail.com>
---
 src/bin/lttng-sessiond/ht-cleanup.c |  5 +++++
 src/bin/lttng-sessiond/main.c       | 10 ++++++++++
 src/bin/lttng-sessiond/ust-thread.c |  5 +++++
 3 files changed, 20 insertions(+)

diff --git a/src/bin/lttng-sessiond/ht-cleanup.c b/src/bin/lttng-sessiond/ht-cleanup.c
index 0469f92..8f841ed 100644
--- a/src/bin/lttng-sessiond/ht-cleanup.c
+++ b/src/bin/lttng-sessiond/ht-cleanup.c
@@ -90,6 +90,11 @@ restart:
 			revents = LTTNG_POLL_GETEV(&events, i);
 			pollfd = LTTNG_POLL_GETFD(&events, i);
 
+			/* Do not waste time if no returned events for this fd */
+			if (!revents) {
+				continue;
+			}
+
 			/* Thread quit pipe has been closed. Killing thread. */
 			ret = sessiond_check_thread_quit_pipe(pollfd, revents);
 			if (ret) {
diff --git a/src/bin/lttng-sessiond/main.c b/src/bin/lttng-sessiond/main.c
index 81b5e94..e97f560 100644
--- a/src/bin/lttng-sessiond/main.c
+++ b/src/bin/lttng-sessiond/main.c
@@ -1034,6 +1034,11 @@ static void *thread_manage_kernel(void *data)
 
 			health_code_update();
 
+			/* Do not waste time if no returned events for this fd */
+			if (!revents) {
+				continue;
+			}
+
 			/* Thread quit pipe has been closed. Killing thread. */
 			ret = sessiond_check_thread_quit_pipe(pollfd, revents);
 			if (ret) {
@@ -1482,6 +1487,11 @@ static void *thread_manage_apps(void *data)
 
 			health_code_update();
 
+			/* Do not waste time if no returned events for this fd */
+			if (!revents) {
+				continue;
+			}
+
 			/* Thread quit pipe has been closed. Killing thread. */
 			ret = sessiond_check_thread_quit_pipe(pollfd, revents);
 			if (ret) {
diff --git a/src/bin/lttng-sessiond/ust-thread.c b/src/bin/lttng-sessiond/ust-thread.c
index d92c1f9..2a87444 100644
--- a/src/bin/lttng-sessiond/ust-thread.c
+++ b/src/bin/lttng-sessiond/ust-thread.c
@@ -92,6 +92,11 @@ restart:
 			revents = LTTNG_POLL_GETEV(&events, i);
 			pollfd = LTTNG_POLL_GETFD(&events, i);
 
+			/* Do not waste time if no returned events for this fd */
+			if (!revents) {
+				continue;
+			}
+
 			/* Thread quit pipe has been closed. Killing thread. */
 			ret = sessiond_check_thread_quit_pipe(pollfd, revents);
 			if (ret) {
-- 
2.1.3
