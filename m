From: Yannick Lamarre <ylamarre@efficios.com>
Subject: [PATCH lttng-tools] Fix: Properly sanitize input
 parameter
Date: Tue, 26 Mar 2019 14:21:23 -0400
Message-ID: <20190326182123.6889-1-ylamarre__38159.7751913191$1553624511$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 44TKG76y2Kz17s5
 for <lttng-dev@lists.lttng.org>; Tue, 26 Mar 2019 14:21:35 -0400 (EDT)
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
Cc: jgalar@efficios.com
List-Id: lttng-dev@lists.lttng.org

The lttng client uses the sizeof the containing buffer for input string
sanitation instead of libc defined macro.

Signed-off-by: Yannick Lamarre <ylamarre@efficios.com>
---
lttng-enable_channel was improperly verifying user input and wrongly rejected
valid input.

 src/bin/lttng/commands/enable_channels.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/bin/lttng/commands/enable_channels.c b/src/bin/lttng/commands/enable_channels.c
index b4e2942c..5e314d9b 100644
--- a/src/bin/lttng/commands/enable_channels.c
+++ b/src/bin/lttng/commands/enable_channels.c
@@ -244,7 +244,7 @@ static int enable_channel(char *session_name)
 		void *extended_ptr;
 
 		/* Validate channel name's length */
-		if (strlen(channel_name) >= NAME_MAX) {
+		if (strlen(channel_name) > sizeof(chan_opts.name) - 1) {
 			ERR("Channel name is too long (max. %zu characters)",
 					sizeof(chan_opts.name) - 1);
 			error = 1;
-- 
2.11.0
