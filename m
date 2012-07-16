From: Christian Babeux <christian.babeux@efficios.com>
Subject: [PATCH lttng-tools] relayd fix missing option --help
Date: Mon, 16 Jul 2012 16:20:05 -0400
Message-ID: <CAGDH53ktFTHBeFDHQ+6uQSNsLeFVF+7QYD-RPjzdDVMjQUUkJA__36800.3822667108$1342470044$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-lb0-f176.google.com ([209.85.217.176])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <christian.babeux@0x80.ca>) id 1Sqrm7-0007zN-Nu
	for lttng-dev@lists.lttng.org; Mon, 16 Jul 2012 16:20:11 -0400
Received: by lboj14 with SMTP id j14so9339704lbo.35
	for <lttng-dev@lists.lttng.org>; Mon, 16 Jul 2012 13:20:05 -0700 (PDT)
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

Fix missing getopt_long option for --help in relayd.

diff --git a/src/bin/lttng-relayd/main.c b/src/bin/lttng-relayd/main.c
index 338341d..acc6ca8 100644
--- a/src/bin/lttng-relayd/main.c
+++ b/src/bin/lttng-relayd/main.c
@@ -120,6 +120,7 @@ int parse_args(int argc, char **argv)
                { "data-port", 1, 0, 'D' },
                { "daemonize", 0, 0, 'd' },
                { "output", 1, 0, 'o' },
+              { "help", 0, 0, 'h' },
                { "verbose", 0, 0, 'v' },
                { NULL, 0, 0, 0 }
        };
