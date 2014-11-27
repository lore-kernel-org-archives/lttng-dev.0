From: Philippe Proulx <eeppeliteloop@gmail.com>
Subject: [lttng-tools] Fix: channel name with '.' and '/' brings
	problems
Date: Wed, 26 Nov 2014 22:32:12 -0500
Message-ID: <1417059132-14298-1-git-send-email-eeppeliteloop__15362.1206329719$1417059143$gmane$org@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qg0-f47.google.com ([209.85.192.47])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <eeppeliteloop@gmail.com>) id 1Xtpnw-0005A4-Q7
 for lttng-dev@lists.lttng.org; Wed, 26 Nov 2014 22:31:43 -0500
Received: by mail-qg0-f47.google.com with SMTP id z60so3022603qgd.34
 for <lttng-dev@lists.lttng.org>; Wed, 26 Nov 2014 19:31:35 -0800 (PST)
Received: from archeepp.internal.efficios.com
 (cable-22.246.173-116.electronicbox.net. [173.246.22.116])
 by mx.google.com with ESMTPSA id f105sm5634578qge.1.2014.11.26.19.31.33
 for <lttng-dev@lists.lttng.org>
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Wed, 26 Nov 2014 19:31:34 -0800 (PST)
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

This patch ensures:

  1. A channel name does not contain any '/' character, since
     relative paths may be injected in the channel name
     otherwise (knowing that the channel name is eventually
     part of a file name)
  2. A channel name does not start with a '.' character, since
     trace readers (Babeltrace is one of them) could interpret
     files starting with a dot as hidden files and ignore
     them when opening the CTF trace

Fixes: #751

Signed-off-by: Philippe Proulx <eeppeliteloop@gmail.com>
---
 src/bin/lttng/commands/enable_channels.c | 38 +++++++++++++++++++++++++++-----
 1 file changed, 33 insertions(+), 5 deletions(-)

diff --git a/src/bin/lttng/commands/enable_channels.c b/src/bin/lttng/commands/enable_channels.c
index f8272e9..e6cce49 100644
--- a/src/bin/lttng/commands/enable_channels.c
+++ b/src/bin/lttng/commands/enable_channels.c
@@ -275,11 +275,39 @@ static int enable_channel(char *session_name)
 	/* Strip channel list (format: chan1,chan2,...) */
 	channel_name = strtok(opt_channels, ",");
 	while (channel_name != NULL) {
-		/* Copy channel name and normalize it */
+		/* Copy channel name, sanitize and normalize it */
 		strncpy(chan.name, channel_name, NAME_MAX);
 		chan.name[NAME_MAX - 1] = '\0';
 
-		DBG("Enabling channel %s", channel_name);
+		char *src, *dst;
+		int got_first = 0;
+
+		for (src = dst = chan.name; *src != '\0'; ++src) {
+			*dst = *src;
+
+			/*
+			 * Channel name could be used in file names, so remove
+			 * invalid '/'
+			 */
+			if (*dst != '/') {
+				/*
+				 * Remove starting dots since this could create
+				 * file names starting with dots, and trace
+				 * readers could interpret them as hidden files
+				 * and ignore them.
+				 */
+				if (*dst != '.') {
+					got_first = 1;
+					dst++;
+				} else if (got_first) {
+					dst++;
+				}
+			}
+		}
+
+		*dst = '\0';
+
+		DBG("Enabling channel %s", chan.name);
 
 		ret = lttng_enable_channel(handle, &chan);
 		if (ret < 0) {
@@ -288,19 +316,19 @@ static int enable_channel(char *session_name)
 			case LTTNG_ERR_KERN_CHAN_EXIST:
 			case LTTNG_ERR_UST_CHAN_EXIST:
 			case LTTNG_ERR_CHAN_EXIST:
-				WARN("Channel %s: %s (session %s)", channel_name,
+				WARN("Channel %s: %s (session %s)", chan.name,
 						lttng_strerror(ret), session_name);
 				warn = 1;
 				break;
 			default:
-				ERR("Channel %s: %s (session %s)", channel_name,
+				ERR("Channel %s: %s (session %s)", chan.name,
 						lttng_strerror(ret), session_name);
 				error = 1;
 				break;
 			}
 		} else {
 			MSG("%s channel %s enabled for session %s",
-					get_domain_str(dom.type), channel_name, session_name);
+					get_domain_str(dom.type), chan.name, session_name);
 			success = 1;
 		}
 
-- 
2.1.3
