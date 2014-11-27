From: Philippe Proulx <eeppeliteloop@gmail.com>
Subject: [PATCH lttng-tools] Fix: channel names are not validated
Date: Thu, 27 Nov 2014 17:35:32 -0500
Message-ID: <1417127732-24968-1-git-send-email-eeppeliteloop__36170.6623611555$1417127735$gmane$org@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qa0-f53.google.com ([209.85.216.53])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <eeppeliteloop@gmail.com>) id 1Xu7eO-0002sT-6u
 for lttng-dev@lists.lttng.org; Thu, 27 Nov 2014 17:35:01 -0500
Received: by mail-qa0-f53.google.com with SMTP id bm13so3777244qab.40
 for <lttng-dev@lists.lttng.org>; Thu, 27 Nov 2014 14:34:54 -0800 (PST)
Received: from archeepp.internal.efficios.com
 (cable-22.246.173-116.electronicbox.net. [173.246.22.116])
 by mx.google.com with ESMTPSA id p78sm7659184qgp.44.2014.11.27.14.34.53
 for <lttng-dev@lists.lttng.org>
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Thu, 27 Nov 2014 14:34:53 -0800 (PST)
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
 include/lttng/lttng-error.h              |  1 +
 src/bin/lttng-sessiond/cmd.c             |  6 ++++++
 src/bin/lttng/commands/enable_channels.c | 20 +++++++++++++++++---
 src/common/error.c                       |  1 +
 4 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/include/lttng/lttng-error.h b/include/lttng/lttng-error.h
index 1220e48..efdca65 100644
--- a/include/lttng/lttng-error.h
+++ b/include/lttng/lttng-error.h
@@ -133,6 +133,7 @@ enum lttng_error_code {
 	LTTNG_ERR_EXCLUSION_INVAL        = 110, /* Invalid event exclusion data */
 	LTTNG_ERR_EXCLUSION_NOMEM        = 111, /* Lack of memory while processing event exclusions */
 	LTTNG_ERR_INVALID_EVENT_NAME     = 112, /* Invalid event name */
+	LTTNG_ERR_INVALID_CHANNEL_NAME   = 113, /* Invalid channel name */
 
 	/* MUST be last element */
 	LTTNG_ERR_NR,                           /* Last element */
diff --git a/src/bin/lttng-sessiond/cmd.c b/src/bin/lttng-sessiond/cmd.c
index 33ab492..1ede96f 100644
--- a/src/bin/lttng-sessiond/cmd.c
+++ b/src/bin/lttng-sessiond/cmd.c
@@ -18,6 +18,7 @@
 #define _GNU_SOURCE
 #define _LGPL_SOURCE
 #include <assert.h>
+#include <string.h>
 #include <inttypes.h>
 #include <urcu/list.h>
 #include <urcu/uatomic.h>
@@ -944,6 +945,11 @@ int cmd_enable_channel(struct ltt_session *session,
 	assert(attr);
 	assert(domain);
 
+	/* Validate channel name */
+	if (attr->name[0] == '.' || strchr(attr->name, '/') != NULL) {
+		return LTTNG_ERR_INVALID_CHANNEL_NAME;
+	}
+
 	DBG("Enabling channel %s for session %s", attr->name, session->name);
 
 	rcu_read_lock();
diff --git a/src/bin/lttng/commands/enable_channels.c b/src/bin/lttng/commands/enable_channels.c
index f8272e9..b49c20d 100644
--- a/src/bin/lttng/commands/enable_channels.c
+++ b/src/bin/lttng/commands/enable_channels.c
@@ -275,9 +275,16 @@ static int enable_channel(char *session_name)
 	/* Strip channel list (format: chan1,chan2,...) */
 	channel_name = strtok(opt_channels, ",");
 	while (channel_name != NULL) {
-		/* Copy channel name and normalize it */
-		strncpy(chan.name, channel_name, NAME_MAX);
-		chan.name[NAME_MAX - 1] = '\0';
+		/* Validate channel name's length */
+		if (strlen(channel_name) >= NAME_MAX) {
+			ERR("Channel name is too long (max. %u characters)",
+			    NAME_MAX - 1);
+			error = 1;
+			goto skip_enable;
+		}
+
+		/* Copy channel name */
+		strcpy(chan.name, channel_name);
 
 		DBG("Enabling channel %s", channel_name);
 
@@ -292,6 +299,12 @@ static int enable_channel(char *session_name)
 						lttng_strerror(ret), session_name);
 				warn = 1;
 				break;
+			case LTTNG_ERR_INVALID_CHANNEL_NAME:
+				ERR("Invalid channel name: \"%s\". "
+				    "Channel names may not start with '.', and "
+				    "may not contain '/'.", channel_name);
+				error = 1;
+				break;
 			default:
 				ERR("Channel %s: %s (session %s)", channel_name,
 						lttng_strerror(ret), session_name);
@@ -304,6 +317,7 @@ static int enable_channel(char *session_name)
 			success = 1;
 		}
 
+skip_enable:
 		if (lttng_opt_mi) {
 			/* Mi print the channel element and leave it open */
 			ret = mi_lttng_channel(writer, &chan, 1);
diff --git a/src/common/error.c b/src/common/error.c
index 2cebbf9..d3e3b94 100644
--- a/src/common/error.c
+++ b/src/common/error.c
@@ -166,6 +166,7 @@ static const char *error_string_array[] = {
 	[ ERROR_INDEX(LTTNG_ERR_MI_IO_FAIL) ] = "IO error while writing MI output",
 	[ ERROR_INDEX(LTTNG_ERR_MI_NOT_IMPLEMENTED) ] = "Mi feature not implemented",
 	[ ERROR_INDEX(LTTNG_ERR_INVALID_EVENT_NAME) ] = "Invalid event name",
+	[ ERROR_INDEX(LTTNG_ERR_INVALID_CHANNEL_NAME) ] = "Invalid channel name",
 
 	/* Last element */
 	[ ERROR_INDEX(LTTNG_ERR_NR) ] = "Unknown error code"
-- 
2.1.3
