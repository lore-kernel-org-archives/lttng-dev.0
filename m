From: Yannick Lamarre <ylamarre@efficios.com>
Subject: [PATCH lttng-tools v2] Fix: Properly sanitize input
 parameter
Date: Tue, 26 Mar 2019 15:53:06 -0400
Message-ID: <20190326195306.8278-1-ylamarre__29828.2107849204$1553630012$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 44TMHs3mNJz180G
 for <lttng-dev@lists.lttng.org>; Tue, 26 Mar 2019 15:53:13 -0400 (EDT)
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

The lttng client uses the sizeof the containing buffer, defined as
LTTNG_SYMBOL_NAME_LEN, for input string sanitation instead of libc defined
macro NAME_MAX. lttng-enable_channel improperly verified user input
and wrongly discarded valid input in case NAME_MAX was less than the
sizeof the containing buffer for the channel's name.
This patch also fixes potential buffer overflow caused by an improperly
bounded strcpy in the case where NAME_MAX would have been greater than
LTTNG_SYMBOL_NAME_LEN.

Signed-off-by: Yannick Lamarre <ylamarre@efficios.com>
---
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
