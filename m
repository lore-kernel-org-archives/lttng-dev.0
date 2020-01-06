From: Benjamin Poirier <benjamin.poirier@gmail.com>
Subject: [PATCH] doc: Fix bind address example for lttng-relayd
Date: Mon,  6 Jan 2020 14:19:54 +0900
Message-ID: <20200106051954.138370-1-benjamin.poirier__47900.9766875365$1578288039$gmane$org@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com
 [IPv6:2607:f8b0:4864:20::1043])
 by lists.lttng.org (Postfix) with ESMTPS id 47rkNl6Gyhz1Tx8
 for <lttng-dev@lists.lttng.org>; Mon,  6 Jan 2020 00:20:23 -0500 (EST)
Received: by mail-pj1-x1043.google.com with SMTP id j11so7088968pjs.1
 for <lttng-dev@lists.lttng.org>; Sun, 05 Jan 2020 21:20:23 -0800 (PST)
Received: from f3.synalogic.ca (ag061063.dynamic.ppp.asahi-net.or.jp.
 [157.107.61.63])
 by smtp.gmail.com with ESMTPSA id r1sm70645421pgp.15.2020.01.05.21.20.19
 for <lttng-dev@lists.lttng.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Jan 2020 21:20:20 -0800 (PST)
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

INADDR_ANY is 0.0.0.0

Fixes: c93eadade277 ("doc/man: use propagated default values in man pages")
Signed-off-by: Benjamin Poirier <benjamin.poirier@gmail.com>
---
 doc/man/lttng-relayd.8.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/man/lttng-relayd.8.txt b/doc/man/lttng-relayd.8.txt
index be59675d..bf88a535 100644
--- a/doc/man/lttng-relayd.8.txt
+++ b/doc/man/lttng-relayd.8.txt
@@ -40,7 +40,7 @@ it can write to the output directory and listen on the configured ports.
 If a user is within a secured network and/or has proper firewall
 settings, `lttng-relayd` can listen to LTTng live connections from _all_
 network interfaces by specifying
-+--live-port=tcp://{default_network_viewer_bind_address}:{default_network_viewer_port}+.
++--live-port=tcp://0.0.0.0:{default_network_viewer_port}+.
 
 Once a trace has been streamed completely, the trace can be processed by
 any tool that can process an LTTng trace located on the local
-- 
2.25.0.rc0
