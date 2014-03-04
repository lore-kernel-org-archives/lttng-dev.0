From: Zifei Tong <zifeitong@gmail.com>
Subject: [PATCH lttng-tools] Fix: clang
	'constant-out-of-range-compare' warning
Date: Tue,  4 Mar 2014 21:27:38 +0800
Message-ID: <1393939658-629-1-git-send-email-zifeitong__24973.7938437194$1393939732$gmane$org@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <zifeitong@gmail.com>) id 1WKpOK-0008CT-KP
	for lttng-dev@lists.lttng.org; Tue, 04 Mar 2014 08:28:17 -0500
Received: by mail-pa0-f43.google.com with SMTP id bj1so5160157pad.16
	for <lttng-dev@lists.lttng.org>; Tue, 04 Mar 2014 05:28:10 -0800 (PST)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: dgoulet@efficios.com
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

This patch fixes two 'autological-constant-out-of-range-compare'
clang warnings caused by comparing enum type variables with -1.

It's possible that compilers optimize these two comparisons away.

Signed-off-by: Zifei Tong <zifeitong@gmail.com>
---
 src/bin/lttng/commands/add_context.c     | 2 +-
 src/bin/lttng/commands/enable_channels.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/bin/lttng/commands/add_context.c b/src/bin/lttng/commands/add_context.c
index 3cd00f3..6483c98 100644
--- a/src/bin/lttng/commands/add_context.c
+++ b/src/bin/lttng/commands/add_context.c
@@ -474,7 +474,7 @@ int cmd_add_context(int argc, const char **argv)
 			}
 
 			type->opt = &ctx_opts[index];
-			if (type->opt->ctx_type == -1) {
+			if (type->opt->symbol == NULL) {
 				ERR("Unknown context type %s", opt_type);
 				free(type);
 				ret = CMD_ERROR;
diff --git a/src/bin/lttng/commands/enable_channels.c b/src/bin/lttng/commands/enable_channels.c
index c4bbc11..55fbae6 100644
--- a/src/bin/lttng/commands/enable_channels.c
+++ b/src/bin/lttng/commands/enable_channels.c
@@ -169,7 +169,7 @@ static void set_default_attr(struct lttng_domain *dom)
 	if (chan.attr.read_timer_interval == -1) {
 		chan.attr.read_timer_interval = default_attr.read_timer_interval;
 	}
-	if (chan.attr.output == -1) {
+	if ((int) chan.attr.output == -1) {
 		chan.attr.output = default_attr.output;
 	}
 	if (chan.attr.tracefile_count == -1) {
-- 
1.9.0
