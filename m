From: Partha Pratim Mukherjee <ppm.floss@gmail.com>
Subject: Re: [PATCH lttng-tools] Fix: destroy session removes
	the default config file
Date: Thu, 28 May 2015 18:05:17 +0000
Message-ID: <87zj4owpb6.fsf__26552.3666785613$1432836551$gmane$org@hahabo.in>
References: <87h9r7yt1m.fsf@hahabo.in>
 <CA+jJMxsMHrN7D7XhAte8jSn9=yd2+aSvJM9e5jNexTYaexXcLg@mail.gmail.com>
 <87r3q3yl5g.fsf@hahabo.in>
 <CA+jJMxtQ-=CXzXpA_eaY8ogwDjYp8hGxH=HRns+UixF15PLWmg@mail.gmail.com>
 <87k2vtyl6u.fsf@hahabo.in>
 <CA+jJMxsJNzy294Stve-ajKJzk_8eFFRvW_ObNs-t2kpCcz0jnQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-pd0-f175.google.com ([209.85.192.175])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <ppm.floss@gmail.com>) id 1Yy2DT-0004E5-Lj
 for lttng-dev@lists.lttng.org; Thu, 28 May 2015 14:07:49 -0400
Received: by pdbqa5 with SMTP id qa5so47128148pdb.0
 for <lttng-dev@lists.lttng.org>; Thu, 28 May 2015 11:07:34 -0700 (PDT)
In-Reply-To: <CA+jJMxsJNzy294Stve-ajKJzk_8eFFRvW_ObNs-t2kpCcz0jnQ@mail.gmail.com>
 (=?utf-8?B?IkrDqXLDqW1pZQ==?= Galarneau"'s message of "Wed, 27 May 2015
 14:53:41 -0400")
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: =?utf-8?B?SsOpcsOpbWll?= Galarneau <jeremie.galarneau@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

J=C3=A9r=C3=A9mie Galarneau <jeremie.galarneau@efficios.com> writes:

>
> Sounds good to me. Thanks!
>
> J=C3=A9r=C3=A9mie
> =C2=A0

Hi,

As discussed please find the patch which takes care of all your
suggestions. Please review.

Thanks once again.

Partha

--=-=-=
Content-Type: text/x-diff
Content-Disposition: inline;
 filename=0001-Fix-destroy-session-removes-the-default-config-file.patch

Destroy session command by default removes the default config file
without checking the current session. As a result when we call any
other command which expects a default session by calling
get_session_name() function, it fails.

This patch will fix this by checking that the default config file gets
removed only when destroy session is called with the current session.

This patch also moves error messages from get_session_name() to its
callers.

Fixes: #887

Signed-off-by: Partha Pratim Mukherjee <ppm.floss@gmail.com>
---
 src/bin/lttng/commands/destroy.c          |   15 ++++++++++++++-
 src/bin/lttng/commands/disable_channels.c |    5 +++++
 src/bin/lttng/commands/disable_events.c   |    6 +++++-
 src/bin/lttng/commands/enable_channels.c  |    4 ++++
 src/bin/lttng/commands/enable_events.c    |    5 +++++
 src/bin/lttng/commands/snapshot.c         |    4 ++++
 src/bin/lttng/commands/start.c            |    5 +++++
 src/bin/lttng/commands/stop.c             |    5 +++++
 src/bin/lttng/commands/track-untrack.c    |    5 +++++
 src/bin/lttng/commands/view.c             |    5 +++++
 src/bin/lttng/conf.c                      |    2 --
 11 files changed, 57 insertions(+), 4 deletions(-)

diff --git a/src/bin/lttng/commands/destroy.c b/src/bin/lttng/commands/destroy.c
index 95343c9..ad3475e 100644
--- a/src/bin/lttng/commands/destroy.c
+++ b/src/bin/lttng/commands/destroy.c
@@ -1,3 +1,4 @@
+
 /*
  * Copyright (C) 2011 - David Goulet <david.goulet@polymtl.ca>
  *
@@ -29,6 +30,7 @@
 
 #include <common/mi-lttng.h>
 #include <common/sessiond-comm/sessiond-comm.h>
+#include <common/utils.h>
 
 static char *opt_session_name;
 static int opt_destroy_all;
@@ -75,6 +77,7 @@ static void usage(FILE *ofp)
 static int destroy_session(struct lttng_session *session)
 {
 	int ret;
+	char *session_name = NULL;
 
 	ret = lttng_destroy_session(session->name);
 	if (ret < 0) {
@@ -90,7 +93,13 @@ static int destroy_session(struct lttng_session *session)
 	}
 
 	MSG("Session %s destroyed", session->name);
-	config_destroy_default();
+
+	session_name = get_session_name();
+	if (session_name && strncmp(session->name, session_name, NAME_MAX) == 0) {
+		config_destroy_default();
+	}
+	free(session_name);
+
 
 	if (lttng_opt_mi) {
 		ret = mi_lttng_session(writer, session, 0);
@@ -144,6 +153,7 @@ int cmd_destroy(int argc, const char **argv)
 	struct lttng_session *sessions;
 	int count;
 	int found;
+	char *path;
 
 	pc = poptGetContext(NULL, argc, argv, long_options, 0);
 	poptReadDefaultConfig(pc, 0);
@@ -217,6 +227,9 @@ int cmd_destroy(int argc, const char **argv)
 			/* No session name specified, lookup default */
 			session_name = get_session_name();
 			if (session_name == NULL) {
+				path = utils_get_home_dir();
+				ERR("Can't find valid lttng config %s/.lttngrc", path);
+				MSG("Did you create a session? (lttng create <my_session>)");
 				command_ret = CMD_ERROR;
 				success = 0;
 				goto mi_closing;
diff --git a/src/bin/lttng/commands/disable_channels.c b/src/bin/lttng/commands/disable_channels.c
index 96a9e5d..f68d2c5 100644
--- a/src/bin/lttng/commands/disable_channels.c
+++ b/src/bin/lttng/commands/disable_channels.c
@@ -27,6 +27,7 @@
 #include <assert.h>
 
 #include <common/mi-lttng.h>
+#include <common/utils.h>
 
 #include "../command.h"
 
@@ -239,6 +240,7 @@ int cmd_disable_channels(int argc, const char **argv)
 	int opt, ret = CMD_SUCCESS, command_ret = CMD_SUCCESS, success = 1;
 	static poptContext pc;
 	char *session_name = NULL;
+	char *path;
 
 	pc = poptGetContext(NULL, argc, argv, long_options, 0);
 	poptReadDefaultConfig(pc, 0);
@@ -272,6 +274,9 @@ int cmd_disable_channels(int argc, const char **argv)
 	if (!opt_session_name) {
 		session_name = get_session_name();
 		if (session_name == NULL) {
+			path = utils_get_home_dir();
+			ERR("Can't find valid lttng config %s/.lttngrc", path);
+			MSG("Did you create a session? (lttng create <my_session>)");
 			ret = CMD_ERROR;
 			goto end;
 		}
diff --git a/src/bin/lttng/commands/disable_events.c b/src/bin/lttng/commands/disable_events.c
index 45e91a8..ddce564 100644
--- a/src/bin/lttng/commands/disable_events.c
+++ b/src/bin/lttng/commands/disable_events.c
@@ -27,7 +27,7 @@
 #include <assert.h>
 
 #include <common/mi-lttng.h>
-
+#include <common/utils.h>
 #include "../command.h"
 
 static char *opt_event_list;
@@ -338,6 +338,7 @@ int cmd_disable_events(int argc, const char **argv)
 	static poptContext pc;
 	char *session_name = NULL;
 	int event_type = -1;
+	char *path;
 
 	pc = poptGetContext(NULL, argc, argv, long_options, 0);
 	poptReadDefaultConfig(pc, 0);
@@ -388,6 +389,9 @@ int cmd_disable_events(int argc, const char **argv)
 	if (!opt_session_name) {
 		session_name = get_session_name();
 		if (session_name == NULL) {
+			path = utils_get_home_dir();
+			ERR("Can't find valid lttng config %s/.lttngrc", path);
+			MSG("Did you create a session? (lttng create <my_session>)");
 			ret = CMD_ERROR;
 			goto end;
 		}
diff --git a/src/bin/lttng/commands/enable_channels.c b/src/bin/lttng/commands/enable_channels.c
index 101617f..fdc8cf7 100644
--- a/src/bin/lttng/commands/enable_channels.c
+++ b/src/bin/lttng/commands/enable_channels.c
@@ -393,6 +393,7 @@ int cmd_enable_channels(int argc, const char **argv)
 	static poptContext pc;
 	char *session_name = NULL;
 	char *opt_arg = NULL;
+	char *path;
 
 	init_channel_config();
 
@@ -607,6 +608,9 @@ int cmd_enable_channels(int argc, const char **argv)
 	if (!opt_session_name) {
 		session_name = get_session_name();
 		if (session_name == NULL) {
+			path = utils_get_home_dir();
+			ERR("Can't find valid lttng config %s/.lttngrc", path);
+			MSG("Did you create a session? (lttng create <my_session>)");
 			command_ret = CMD_ERROR;
 			success = 0;
 			goto mi_closing;
diff --git a/src/bin/lttng/commands/enable_events.c b/src/bin/lttng/commands/enable_events.c
index f1d0458..ae16edb 100644
--- a/src/bin/lttng/commands/enable_events.c
+++ b/src/bin/lttng/commands/enable_events.c
@@ -32,6 +32,7 @@
 
 /* Mi dependancy */
 #include <common/mi-lttng.h>
+#include <common/utils.h>
 
 #include "../command.h"
 
@@ -1345,6 +1346,7 @@ int cmd_enable_events(int argc, const char **argv)
 	static poptContext pc;
 	char *session_name = NULL;
 	int event_type = -1;
+	char *path;
 
 	pc = poptGetContext(NULL, argc, argv, long_options, 0);
 	poptReadDefaultConfig(pc, 0);
@@ -1441,6 +1443,9 @@ int cmd_enable_events(int argc, const char **argv)
 	if (!opt_session_name) {
 		session_name = get_session_name();
 		if (session_name == NULL) {
+			path = utils_get_home_dir();
+			ERR("Can't find valid lttng config %s/.lttngrc", path);
+			MSG("Did you create a session? (lttng create <my_session>)");
 			command_ret = CMD_ERROR;
 			success = 0;
 			goto mi_closing;
diff --git a/src/bin/lttng/commands/snapshot.c b/src/bin/lttng/commands/snapshot.c
index 846e9ba..586724a 100644
--- a/src/bin/lttng/commands/snapshot.c
+++ b/src/bin/lttng/commands/snapshot.c
@@ -684,6 +684,7 @@ int cmd_snapshot(int argc, const char **argv)
 	int opt, ret = CMD_SUCCESS, command_ret = CMD_SUCCESS, success = 1;
 	char *session_name = NULL;
 	static poptContext pc;
+	char *path;
 
 	pc = poptGetContext(NULL, argc, argv, snapshot_opts, 0);
 	poptReadDefaultConfig(pc, 0);
@@ -749,6 +750,9 @@ int cmd_snapshot(int argc, const char **argv)
 	if (!opt_session_name) {
 		session_name = get_session_name();
 		if (session_name == NULL) {
+			path = utils_get_home_dir();
+			ERR("Can't find valid lttng config %s/.lttngrc", path);
+			MSG("Did you create a session? (lttng create <my_session>)");
 			ret = CMD_ERROR;
 			goto end;
 		}
diff --git a/src/bin/lttng/commands/start.c b/src/bin/lttng/commands/start.c
index 8016434..8f2a86a 100644
--- a/src/bin/lttng/commands/start.c
+++ b/src/bin/lttng/commands/start.c
@@ -27,6 +27,7 @@
 
 #include <common/sessiond-comm/sessiond-comm.h>
 #include <common/mi-lttng.h>
+#include <common/utils.h>
 
 #include "../command.h"
 
@@ -101,10 +102,14 @@ static int start_tracing(void)
 {
 	int ret;
 	char *session_name;
+	char *path;
 
 	if (opt_session_name == NULL) {
 		session_name = get_session_name();
 		if (session_name == NULL) {
+			path = utils_get_home_dir();
+			ERR("Can't find valid lttng config %s/.lttngrc", path);
+			MSG("Did you create a session? (lttng create <my_session>)");
 			ret = CMD_ERROR;
 			goto error;
 		}
diff --git a/src/bin/lttng/commands/stop.c b/src/bin/lttng/commands/stop.c
index 5ac182b..40f71a1 100644
--- a/src/bin/lttng/commands/stop.c
+++ b/src/bin/lttng/commands/stop.c
@@ -28,6 +28,7 @@
 
 #include <common/sessiond-comm/sessiond-comm.h>
 #include <common/mi-lttng.h>
+#include <common/utils.h>
 
 #include "../command.h"
 
@@ -107,10 +108,14 @@ static int stop_tracing(void)
 {
 	int ret;
 	char *session_name;
+	char *path;
 
 	if (opt_session_name == NULL) {
 		session_name = get_session_name();
 		if (session_name == NULL) {
+			path = utils_get_home_dir();
+			ERR("Can't find valid lttng config %s/.lttngrc", path);
+			MSG("Did you create a session? (lttng create <my_session>)");
 			ret = CMD_ERROR;
 			goto error;
 		}
diff --git a/src/bin/lttng/commands/track-untrack.c b/src/bin/lttng/commands/track-untrack.c
index 52442cc..ede84e3 100644
--- a/src/bin/lttng/commands/track-untrack.c
+++ b/src/bin/lttng/commands/track-untrack.c
@@ -30,6 +30,7 @@
 #include <urcu/list.h>
 
 #include <common/mi-lttng.h>
+#include <common/utils.h>
 
 #include "../command.h"
 
@@ -305,6 +306,7 @@ int cmd_track_untrack(enum cmd_type cmd_type, const char *cmd_str,
 	static poptContext pc;
 	char *session_name = NULL;
 	struct mi_writer *writer = NULL;
+	char *path;
 
 	if (argc < 1) {
 		usage(stderr, cmd_str);
@@ -344,6 +346,9 @@ int cmd_track_untrack(enum cmd_type cmd_type, const char *cmd_str,
 	if (!opt_session_name) {
 		session_name = get_session_name();
 		if (session_name == NULL) {
+			path = utils_get_home_dir();
+			ERR("Can't find valid lttng config %s/.lttngrc", path);
+			MSG("Did you create a session? (lttng create <my_session>)");
 			ret = CMD_ERROR;
 			goto end;
 		}
diff --git a/src/bin/lttng/commands/view.c b/src/bin/lttng/commands/view.c
index dc37a09..4f29dbf 100644
--- a/src/bin/lttng/commands/view.c
+++ b/src/bin/lttng/commands/view.c
@@ -27,6 +27,7 @@
 
 #include "../command.h"
 #include <config.h>
+#include <common/utils.h>
 
 static char *opt_session_name;
 static char *opt_viewer;
@@ -328,6 +329,7 @@ static int view_trace(void)
 	int ret;
 	char *session_name, *trace_path = NULL;
 	struct lttng_session *sessions = NULL;
+	char *path;
 
 	/*
 	 * Safety net. If lttng is suid at some point for *any* useless reasons,
@@ -351,6 +353,9 @@ static int view_trace(void)
 	} else if(opt_session_name == NULL) {
 		session_name = get_session_name();
 		if (session_name == NULL) {
+			path = utils_get_home_dir();
+			ERR("Can't find valid lttng config %s/.lttngrc", path);
+			MSG("Did you create a session? (lttng create <my_session>)");
 			ret = CMD_ERROR;
 			goto error;
 		}
diff --git a/src/bin/lttng/conf.c b/src/bin/lttng/conf.c
index 7e6c833..6b8bf51 100644
--- a/src/bin/lttng/conf.c
+++ b/src/bin/lttng/conf.c
@@ -199,8 +199,6 @@ char *config_read_session_name(char *path)
 
 	fp = open_config(path, "r");
 	if (fp == NULL) {
-		ERR("Can't find valid lttng config %s/.lttngrc", path);
-		MSG("Did you create a session? (lttng create <my_session>)");
 		free(session_name);
 		goto error;
 	}
-- 
1.7.9.5


--=-=-=
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--=-=-=--
