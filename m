From: Christian Babeux <christian.babeux@efficios.com>
Subject: [RFC PATCH lttng-tools] relayd pipes and error handling
Date: Tue, 17 Jul 2012 15:15:35 -0400
Message-ID: <CAGDH53nAXuZB20+LdogwiYZdiCrqEdZhSZZH9f4i28_wA8nJtg__27025.1107322567$1342552571$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-bk0-f48.google.com ([209.85.214.48])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <christian.babeux@0x80.ca>) id 1SrDFG-0001Zx-Cz
	for lttng-dev@lists.lttng.org; Tue, 17 Jul 2012 15:15:43 -0400
Received: by bkty5 with SMTP id y5so802720bkt.35
	for <lttng-dev@lists.lttng.org>; Tue, 17 Jul 2012 12:15:36 -0700 (PDT)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, David Goulet <dgoulet@efficios.com>, Julien Desfossez <jdesfossez@efficios.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Hi,

The current relayd employ two set of pipes for command relaying and
thread quit signalling.
The relay_cmd_pipe pipes are never closed. Also, the thread_quit_pipe
pipes are not closed in
some error cases (fail to parse args, fail to daemonize, etc.). Here
is a proposed way to cleanup
and handle error cases.

Thoughts?

Thanks,

Christian

Fix: relayd relay_cmd_pipe/thread_quit_pipe should be closed on exit/error.

diff --git a/src/bin/lttng-relayd/main.c b/src/bin/lttng-relayd/main.c
index acc6ca8..55452b3 100644
--- a/src/bin/lttng-relayd/main.c
+++ b/src/bin/lttng-relayd/main.c
@@ -231,14 +231,26 @@ void cleanup(void)

        DBG("Cleaning up");

+       /* Close thread quit pipes */
        for (i = 0; i < 2; i++) {
                if (thread_quit_pipe[i] >= 0) {
                        ret = close(thread_quit_pipe[i]);
                        if (ret) {
-                               PERROR("close");
+                               PERROR("close quit pipe");
                        }
                }
        }
+
+       /* Close relay cmd pipes */
+       for (i = 0; i < 2; i++) {
+               if (relay_cmd_pipe[i] >= 0) {
+                       ret = close(relay_cmd_pipe[i]);
+                       if (ret) {
+                               PERROR("close cmd pipe");
+                       }
+               }
+       }
+
 }

 /*
@@ -1479,7 +1491,7 @@ int main(int argc, char **argv)
        /* Parse arguments */
        progname = argv[0];
        if ((ret = parse_args(argc, argv) < 0)) {
-               goto error;
+               goto exit;
        }

        if ((ret = set_signal_handler()) < 0) {
@@ -1491,7 +1503,7 @@ int main(int argc, char **argv)
                ret = daemon(0, 0);
                if (ret < 0) {
                        PERROR("daemon");
-                       goto error;
+                       goto exit;
                }
        }

@@ -1502,7 +1514,7 @@ int main(int argc, char **argv)
                if (control_uri->port < 1024 || data_uri->port < 1024) {
                        ERR("Need to be root to use ports < 1024");
                        ret = -1;
-                       goto error;
+                       goto exit;
                }
        }

@@ -1567,6 +1579,7 @@ exit:
        if (!ret) {
                exit(EXIT_SUCCESS);
        }
+
 error:
        exit(EXIT_FAILURE);
 }
