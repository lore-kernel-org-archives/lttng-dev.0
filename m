From: Amit Margalit <AMITM@il.ibm.com>
Subject: Re: [RFC PATCH lttng-tools] Allow environment variable
 LTTNG_HOME to override HOME - for lttng-tools - UPDATED PATCH
Date: Thu, 13 Jun 2013 15:15:39 +0300
Message-ID: <OF0D9D1EAD.C7331410-ONC2257B89.00430C64-C2257B89.00434492__4761.71399136565$1371125856$gmane$org@il.ibm.com>
References: <OF6896CCA9.D04FC8AB-ONC2257B87.00424736-C2257B87.00427FF3@il.ibm.com>	<51B889B6.6020200@efficios.com>
	<OFDDF6769F.EB68519B-ONC2257B89.0034BB76-C2257B89.0034F473@il.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2088667516=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from e06smtp17.uk.ibm.com ([195.75.94.113])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <amitm@il.ibm.com>) id 1Un6SU-0008P3-F2
	for lttng-dev@lists.lttng.org; Thu, 13 Jun 2013 08:16:54 -0400
Received: from /spool/local
	by e06smtp17.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <lttng-dev@lists.lttng.org> from <amitm@il.ibm.com>;
	Thu, 13 Jun 2013 13:13:07 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com
	(d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
	by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id 2BA7917D805D
	for <lttng-dev@lists.lttng.org>; Thu, 13 Jun 2013 13:18:08 +0100 (BST)
Received: from d06av08.portsmouth.uk.ibm.com (d06av08.portsmouth.uk.ibm.com
	[9.149.37.249])
	by b06cxnps4075.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with
	ESMTP id r5DCGZpm42926282
	for <lttng-dev@lists.lttng.org>; Thu, 13 Jun 2013 12:16:35 GMT
Received: from d06av08.portsmouth.uk.ibm.com (localhost [127.0.0.1])
	by d06av08.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with
	ESMTP id r5DCGUaw032143
	for <lttng-dev@lists.lttng.org>; Thu, 13 Jun 2013 06:16:45 -0600
Received: from d06ml311.portsmouth.uk.ibm.com (d06ml311.portsmouth.uk.ibm.com
	[9.149.104.181])
	by d06av08.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with
	ESMTP id r5DCFnfl029053
	for <lttng-dev@lists.lttng.org>; Thu, 13 Jun 2013 06:15:49 -0600
In-Reply-To: <OFDDF6769F.EB68519B-ONC2257B89.0034BB76-C2257B89.0034F473@il.ibm.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Amit Margalit <AMITM@il.ibm.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

This is a multipart message in MIME format.
--===============2088667516==
Content-Type: multipart/alternative; boundary="=_alternative 0043446DC2257B89_="

This is a multipart message in MIME format.
--=_alternative 0043446DC2257B89_=
Content-Type: text/plain; charset="US-ASCII"

Hi,

I've added a paragraph to the man page. Here is the new patch:

From a72bd9dd6a58ac727280f2f9a85ee80607f1aba9 Mon Sep 17 00:00:00 2001
From: Amit Margalit <amitm@il.ibm.com>
Date: Thu, 13 Jun 2013 12:35:13 +0300
Subject: [PATCH] Using LTTNG_HOME environment variable if exists, with
 fallback to HOME

---
 doc/man/lttng.1                 |  4 ++++
 src/bin/lttng-relayd/utils.c    | 10 +---------
 src/bin/lttng-sessiond/main.c   |  2 +-
 src/bin/lttng-sessiond/utils.c  | 10 ----------
 src/bin/lttng/commands/create.c |  2 +-
 src/bin/lttng/conf.c            | 13 +++----------
 src/bin/lttng/conf.h            |  1 -
 src/bin/lttng/utils.c           |  3 ++-
 src/common/defaults.h           |  2 ++
 src/common/utils.c              | 15 +++++++++++++++
 src/common/utils.h              |  1 +
 src/lib/lttng-ctl/lttng-ctl.c   |  5 +++--
 12 files changed, 33 insertions(+), 35 deletions(-)

diff --git a/doc/man/lttng.1 b/doc/man/lttng.1
index f472d38..26fd44a 100644
--- a/doc/man/lttng.1
+++ b/doc/man/lttng.1
@@ -214,6 +214,10 @@ automatically created having this form: 
'auto-yyyymmdd-hhmmss'.
 
 If no \fB\-o, \-\-output\fP is specified, the traces will be written in
 $HOME/lttng-traces.
+
+The $HOME environment variable can be overridden by defining the 
environment
+variable LTTNG_HOME. This is useful when the user running the commands 
has
+a non-writeable home directory.
 .fi
 
 .B OPTIONS:
diff --git a/src/bin/lttng-relayd/utils.c b/src/bin/lttng-relayd/utils.c
index ad13d32..392fab6 100644
--- a/src/bin/lttng-relayd/utils.c
+++ b/src/bin/lttng-relayd/utils.c
@@ -29,14 +29,6 @@
 #include "lttng-relayd.h"
 #include "utils.h"
 
-/*
- * Returns the HOME directory path. Caller MUST NOT free(3) the return 
pointer.
- */
-static char *get_default_path(void)
-{
-       return getenv("HOME");
-}
-
 static char *create_output_path_auto(char *path_name)
 {
        int ret;
@@ -44,7 +36,7 @@ static char *create_output_path_auto(char *path_name)
        char *alloc_path = NULL;
        char *default_path;
 
-       default_path = get_default_path();
+       default_path = utils_get_home_dir();
        if (default_path == NULL) {
                ERR("Home path not found.\n \
                                Please specify an output path using -o, 
--output PATH");
diff --git a/src/bin/lttng-sessiond/main.c b/src/bin/lttng-sessiond/main.c
index 4470afc..256ffba 100644
--- a/src/bin/lttng-sessiond/main.c
+++ b/src/bin/lttng-sessiond/main.c
@@ -4136,7 +4136,7 @@ int main(int argc, char **argv)
                DBG2("Kernel consumer cmd path: %s",
                                kconsumer_data.cmd_unix_sock_path);
        } else {
-               home_path = get_home_dir();
+               home_path = utils_get_home_dir();
                if (home_path == NULL) {
                        /* TODO: Add --socket PATH option */
                        ERR("Can't get HOME directory for sockets 
creation.");
diff --git a/src/bin/lttng-sessiond/utils.c 
b/src/bin/lttng-sessiond/utils.c
index 5ea3374..af42ad0 100644
--- a/src/bin/lttng-sessiond/utils.c
+++ b/src/bin/lttng-sessiond/utils.c
@@ -45,13 +45,3 @@ int notify_thread_pipe(int wpipe)
 
        return ret;
 }
-
-/*
- * Return pointer to home directory path using the env variable HOME.
- *
- * No home, NULL is returned.
- */
-const char *get_home_dir(void)
-{
-       return ((const char *) getenv("HOME"));
-}
diff --git a/src/bin/lttng/commands/create.c 
b/src/bin/lttng/commands/create.c
index 805cdb1..ddd2983 100644
--- a/src/bin/lttng/commands/create.c
+++ b/src/bin/lttng/commands/create.c
@@ -250,7 +250,7 @@ static int create_session(void)
                print_str_url = url;
        } else {
                /* Auto output path */
-               alloc_path = config_get_default_path();
+               alloc_path = utils_get_home_dir();
                if (alloc_path == NULL) {
                        ERR("HOME path not found.\n \
                                        Please specify an output path 
using -o, --output PATH");
diff --git a/src/bin/lttng/conf.c b/src/bin/lttng/conf.c
index b6632fc..5a0da9d 100644
--- a/src/bin/lttng/conf.c
+++ b/src/bin/lttng/conf.c
@@ -25,6 +25,7 @@
 #include <unistd.h>
 
 #include <common/error.h>
+#include <common/utils.h>
 
 #include "conf.h"
 
@@ -123,14 +124,6 @@ end:
 }
 
 /*
- * Returns the HOME directory path. Caller MUST NOT free(3) the return 
pointer.
- */
-char *config_get_default_path(void)
-{
-       return getenv("HOME");
-}
-
-/*
  * Destroys directory config and file config.
  */
 void config_destroy(char *path)
@@ -161,7 +154,7 @@ end:
  */
 void config_destroy_default(void)
 {
-       char *path = config_get_default_path();
+       char *path = utils_get_home_dir();
        if (path == NULL) {
                return;
        }
@@ -277,7 +270,7 @@ int config_init(char *session_name)
        int ret;
        char *path;
 
-       path = config_get_default_path();
+       path = utils_get_home_dir();
        if (path == NULL) {
                ret = -1;
                goto error;
diff --git a/src/bin/lttng/conf.h b/src/bin/lttng/conf.h
index 2cb04b0..3bed59c 100644
--- a/src/bin/lttng/conf.h
+++ b/src/bin/lttng/conf.h
@@ -25,7 +25,6 @@ void config_destroy_default(void);
 int config_exists(const char *path);
 int config_init(char *path);
 int config_add_session_name(char *path, char *name);
-char *config_get_default_path(void);
 
 /* Must free() the return pointer */
 char *config_read_session_name(char *path);
diff --git a/src/bin/lttng/utils.c b/src/bin/lttng/utils.c
index 94c4527..6041655 100644
--- a/src/bin/lttng/utils.c
+++ b/src/bin/lttng/utils.c
@@ -21,6 +21,7 @@
 #include <limits.h>
 
 #include <common/error.h>
+#include <common/utils.h>
 
 #include "conf.h"
 #include "utils.h"
@@ -36,7 +37,7 @@ char *get_session_name(void)
        char *path, *session_name = NULL;
 
        /* Get path to config file */
-       path = config_get_default_path();
+       path = utils_get_home_dir();
        if (path == NULL) {
                goto error;
        }
diff --git a/src/common/defaults.h b/src/common/defaults.h
index 66bb972..c040634 100644
--- a/src/common/defaults.h
+++ b/src/common/defaults.h
@@ -77,6 +77,8 @@
 #define DEFAULT_USTCONSUMERD32_ERR_SOCK_PATH DEFAULT_USTCONSUMERD32_PATH 
"/error"
 
 /* Default lttng run directory */
+#define DEFAULT_LTTNG_HOME_ENV_VAR              "LTTNG_HOME"
+#define DEFAULT_LTTNG_FALLBACK_HOME_ENV_VAR    "HOME"
 #define DEFAULT_LTTNG_RUNDIR                    "/var/run/lttng"
 #define DEFAULT_LTTNG_HOME_RUNDIR               "%s/.lttng"
 #define DEFAULT_LTTNG_SESSIOND_PIDFILE          "lttng-sessiond.pid"
diff --git a/src/common/utils.c b/src/common/utils.c
index 38f78a7..436febe 100644
--- a/src/common/utils.c
+++ b/src/common/utils.c
@@ -32,6 +32,7 @@
 #include <common/runas.h>
 
 #include "utils.h"
+#include "defaults.h"
 
 /*
  * Return the realpath(3) of the path even if the last directory token 
does not
@@ -584,3 +585,17 @@ int utils_get_count_order_u32(uint32_t x)
 
        return fls_u32(x - 1);
 }
+
+/**
+ * Obtain the value of LTTNG_HOME environment variable, if exists.
+ * Otherwise returns the value of HOME.
+ */
+char *utils_get_home_dir(void)
+{
+       char *val = NULL;
+       val = getenv(DEFAULT_LTTNG_HOME_ENV_VAR);
+       if (val != NULL) {
+               return val;
+       }
+       return getenv(DEFAULT_LTTNG_FALLBACK_HOME_ENV_VAR);
+}
diff --git a/src/common/utils.h b/src/common/utils.h
index 083acef..9e6fb37 100644
--- a/src/common/utils.h
+++ b/src/common/utils.h
@@ -40,5 +40,6 @@ int utils_rotate_stream_file(char *path_name, char 
*file_name, uint64_t size,
                uint64_t count, int uid, int gid, int out_fd, uint64_t 
*new_count);
 int utils_parse_size_suffix(char *str, uint64_t *size);
 int utils_get_count_order_u32(uint32_t x);
+char *utils_get_home_dir(void);
 
 #endif /* _COMMON_UTILS_H */
diff --git a/src/lib/lttng-ctl/lttng-ctl.c b/src/lib/lttng-ctl/lttng-ctl.c
index a7328eb..9d76f79 100644
--- a/src/lib/lttng-ctl/lttng-ctl.c
+++ b/src/lib/lttng-ctl/lttng-ctl.c
@@ -32,6 +32,7 @@
 #include <common/defaults.h>
 #include <common/sessiond-comm/sessiond-comm.h>
 #include <common/uri.h>
+#include <common/utils.h>
 #include <lttng/lttng.h>
 
 #include "filter/filter-ast.h"
@@ -485,7 +486,7 @@ static int set_session_daemon_path(void)
                 * With GNU C >= 2.1, snprintf returns the required size 
(excluding closing null)
                 */
                ret = snprintf(sessiond_sock_path, 
sizeof(sessiond_sock_path),
-                               DEFAULT_HOME_CLIENT_UNIX_SOCK, 
getenv("HOME"));
+                               DEFAULT_HOME_CLIENT_UNIX_SOCK, 
utils_get_home_dir());
                if ((ret < 0) || (ret >= sizeof(sessiond_sock_path))) {
                        goto error;
                }
@@ -1543,7 +1544,7 @@ static int set_health_socket_path(void)
                 * With GNU C <  2.1, snprintf returns -1 if the target 
buffer is too small;
                 * With GNU C >= 2.1, snprintf returns the required size 
(excluding closing null)
                 */
-               home = getenv("HOME");
+               home = utils_get_home_dir();
                if (home == NULL) {
                        /* Fallback in /tmp .. */
                        home = "/tmp";
-- 
1.7.11.7


Amit Margalit
IBM XIV - Storage Reinvented
XIV-NAS Development Team
Tel. 03-689-7774
Fax. 03-689-7230



From:   Amit Margalit/Israel/IBM@IBMIL
To:     David Goulet <dgoulet@efficios.com>
Cc:     lttng-dev@lists.lttng.org
Date:   06/13/2013 12:39 PM
Subject:        Re: [lttng-dev] [RFC PATCH lttng-tools] Allow environment 
variable LTTNG_HOME to override HOME - for lttng-tools



I think I've done all that you suggested, for lttng-tools only, though, 
based on cfa9a5a2b4a96e0d6a9eeddd2622a6d7c173b7ac which is the latest 
master as of right now. 

Here is the patch: 
From 5881718a60608d640ac1124c9c1f439a2a084707 Mon Sep 17 00:00:00 2001
From: Amit Margalit <amitm@il.ibm.com>
Date: Thu, 13 Jun 2013 12:35:13 +0300
Subject: [PATCH] Using LTTNG_HOME environment variable if exists, with
fallback to HOME 

---
[Old patch deleted]
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev


--=_alternative 0043446DC2257B89_=
Content-Type: text/html; charset="US-ASCII"

<font size=2 face="sans-serif">Hi,</font>
<br>
<br><font size=2 face="sans-serif">I've added a paragraph to the man page.
Here is the new patch:</font>
<br>
<div><tt><font size=2>From a72bd9dd6a58ac727280f2f9a85ee80607f1aba9 Mon
Sep 17 00:00:00 2001<br>
From: Amit Margalit &lt;amitm@il.ibm.com&gt;<br>
Date: Thu, 13 Jun 2013 12:35:13 +0300<br>
Subject: [PATCH] Using LTTNG_HOME environment variable if exists, with<br>
 fallback to HOME</font></tt>
<br>
<br><tt><font size=2>---<br>
 doc/man/lttng.1 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
| &nbsp;4 ++++<br>
 src/bin/lttng-relayd/utils.c &nbsp; &nbsp;| 10 +---------<br>
 src/bin/lttng-sessiond/main.c &nbsp; | &nbsp;2 +-<br>
 src/bin/lttng-sessiond/utils.c &nbsp;| 10 ----------<br>
 src/bin/lttng/commands/create.c | &nbsp;2 +-<br>
 src/bin/lttng/conf.c &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;| 13 +++----------<br>
 src/bin/lttng/conf.h &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;| &nbsp;1
-<br>
 src/bin/lttng/utils.c &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; | &nbsp;3 ++-<br>
 src/common/defaults.h &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; | &nbsp;2 ++<br>
 src/common/utils.c &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;| 15
+++++++++++++++<br>
 src/common/utils.h &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;| &nbsp;1
+<br>
 src/lib/lttng-ctl/lttng-ctl.c &nbsp; | &nbsp;5 +++--<br>
 12 files changed, 33 insertions(+), 35 deletions(-)</font></tt>
<br>
<br><tt><font size=2>diff --git a/doc/man/lttng.1 b/doc/man/lttng.1<br>
index f472d38..26fd44a 100644<br>
--- a/doc/man/lttng.1<br>
+++ b/doc/man/lttng.1<br>
@@ -214,6 +214,10 @@ automatically created having this form: 'auto-yyyymmdd-hhmmss'.<br>
 <br>
 If no \fB\-o, \-\-output\fP is specified, the traces will be written in<br>
 $HOME/lttng-traces.<br>
+<br>
+The $HOME environment variable can be overridden by defining the environment<br>
+variable LTTNG_HOME. This is useful when the user running the commands
has<br>
+a non-writeable home directory.<br>
 .fi<br>
 <br>
 .B OPTIONS:<br>
diff --git a/src/bin/lttng-relayd/utils.c b/src/bin/lttng-relayd/utils.c<br>
index ad13d32..392fab6 100644<br>
--- a/src/bin/lttng-relayd/utils.c<br>
+++ b/src/bin/lttng-relayd/utils.c<br>
@@ -29,14 +29,6 @@<br>
 #include &quot;lttng-relayd.h&quot;<br>
 #include &quot;utils.h&quot;<br>
 <br>
-/*<br>
- * Returns the HOME directory path. Caller MUST NOT free(3) the return
pointer.<br>
- */<br>
-static char *get_default_path(void)<br>
-{<br>
- &nbsp; &nbsp; &nbsp; &nbsp;return getenv(&quot;HOME&quot;);<br>
-}<br>
-<br>
 static char *create_output_path_auto(char *path_name)<br>
 {<br>
 &nbsp; &nbsp; &nbsp; &nbsp; int ret;<br>
@@ -44,7 +36,7 @@ static char *create_output_path_auto(char *path_name)</font></tt>
<br><tt><font size=2>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;char *alloc_path
= NULL;<br>
 &nbsp; &nbsp; &nbsp; &nbsp; char *default_path;<br>
 <br>
- &nbsp; &nbsp; &nbsp; &nbsp;default_path = get_default_path();<br>
+ &nbsp; &nbsp; &nbsp; &nbsp;default_path = utils_get_home_dir();<br>
 &nbsp; &nbsp; &nbsp; &nbsp; if (default_path == NULL) {<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ERR(&quot;Home
path not found.\n \<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Please
specify an output path using -o, --output PATH&quot;);<br>
diff --git a/src/bin/lttng-sessiond/main.c b/src/bin/lttng-sessiond/main.c<br>
index 4470afc..256ffba 100644<br>
--- a/src/bin/lttng-sessiond/main.c<br>
+++ b/src/bin/lttng-sessiond/main.c<br>
@@ -4136,7 +4136,7 @@ int main(int argc, char **argv)<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; DBG2(&quot;Kernel
consumer cmd path: %s&quot;,<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; kconsumer_data.cmd_unix_sock_path);<br>
 &nbsp; &nbsp; &nbsp; &nbsp; } else {<br>
- &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;home_path
= get_home_dir();<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;home_path
= utils_get_home_dir();<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; if
(home_path == NULL) {<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; /* TODO: Add --socket PATH option */<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; ERR(&quot;Can't get HOME directory for sockets
creation.&quot;);<br>
diff --git a/src/bin/lttng-sessiond/utils.c b/src/bin/lttng-sessiond/utils.c<br>
index 5ea3374..af42ad0 100644<br>
--- a/src/bin/lttng-sessiond/utils.c<br>
+++ b/src/bin/lttng-sessiond/utils.c<br>
@@ -45,13 +45,3 @@ int notify_thread_pipe(int wpipe)<br>
 <br>
 &nbsp; &nbsp; &nbsp; &nbsp; return ret;<br>
 }<br>
-</font></tt>
<br><tt><font size=2>-/*<br>
- * Return pointer to home directory path using the env variable HOME.<br>
- *<br>
- * No home, NULL is returned.<br>
- */<br>
-const char *get_home_dir(void)<br>
-{<br>
- &nbsp; &nbsp; &nbsp; &nbsp;return ((const char *) getenv(&quot;HOME&quot;));<br>
-}<br>
diff --git a/src/bin/lttng/commands/create.c b/src/bin/lttng/commands/create.c<br>
index 805cdb1..ddd2983 100644<br>
--- a/src/bin/lttng/commands/create.c<br>
+++ b/src/bin/lttng/commands/create.c<br>
@@ -250,7 +250,7 @@ static int create_session(void)<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; print_str_url
= url;<br>
 &nbsp; &nbsp; &nbsp; &nbsp; } else {<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; /*
Auto output path */<br>
- &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;alloc_path
= config_get_default_path();<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;alloc_path
= utils_get_home_dir();<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; if
(alloc_path == NULL) {<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; ERR(&quot;HOME path not found.\n \<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; Please specify an output path using -o, --output
PATH&quot;);<br>
diff --git a/src/bin/lttng/conf.c b/src/bin/lttng/conf.c<br>
index b6632fc..5a0da9d 100644<br>
--- a/src/bin/lttng/conf.c<br>
+++ b/src/bin/lttng/conf.c<br>
@@ -25,6 +25,7 @@<br>
 #include &lt;unistd.h&gt;<br>
 <br>
 #include &lt;common/error.h&gt;<br>
+#include &lt;common/utils.h&gt;<br>
 <br>
 #include &quot;conf.h&quot;<br>
 <br>
@@ -123,14 +124,6 @@ end:<br>
 }<br>
 <br>
 /*<br>
- * Returns the HOME directory path. Caller MUST NOT free(3) the return
pointer.</font></tt>
<br><tt><font size=2>- */<br>
-char *config_get_default_path(void)<br>
-{<br>
- &nbsp; &nbsp; &nbsp; &nbsp;return getenv(&quot;HOME&quot;);<br>
-}<br>
-<br>
-/*<br>
 &nbsp;* Destroys directory config and file config.<br>
 &nbsp;*/<br>
 void config_destroy(char *path)<br>
@@ -161,7 +154,7 @@ end:<br>
 &nbsp;*/<br>
 void config_destroy_default(void)<br>
 {<br>
- &nbsp; &nbsp; &nbsp; &nbsp;char *path = config_get_default_path();<br>
+ &nbsp; &nbsp; &nbsp; &nbsp;char *path = utils_get_home_dir();<br>
 &nbsp; &nbsp; &nbsp; &nbsp; if (path == NULL) {<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; return;<br>
 &nbsp; &nbsp; &nbsp; &nbsp; }<br>
@@ -277,7 +270,7 @@ int config_init(char *session_name)<br>
 &nbsp; &nbsp; &nbsp; &nbsp; int ret;<br>
 &nbsp; &nbsp; &nbsp; &nbsp; char *path;<br>
 <br>
- &nbsp; &nbsp; &nbsp; &nbsp;path = config_get_default_path();<br>
+ &nbsp; &nbsp; &nbsp; &nbsp;path = utils_get_home_dir();<br>
 &nbsp; &nbsp; &nbsp; &nbsp; if (path == NULL) {<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ret
= -1;<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; goto
error;<br>
diff --git a/src/bin/lttng/conf.h b/src/bin/lttng/conf.h<br>
index 2cb04b0..3bed59c 100644<br>
--- a/src/bin/lttng/conf.h<br>
+++ b/src/bin/lttng/conf.h<br>
@@ -25,7 +25,6 @@ void config_destroy_default(void);<br>
 int config_exists(const char *path);<br>
 int config_init(char *path);<br>
 int config_add_session_name(char *path, char *name);<br>
-char *config_get_default_path(void);<br>
 <br>
 /* Must free() the return pointer */<br>
 char *config_read_session_name(char *path);<br>
diff --git a/src/bin/lttng/utils.c b/src/bin/lttng/utils.c</font></tt>
<br><tt><font size=2>index 94c4527..6041655 100644<br>
--- a/src/bin/lttng/utils.c<br>
+++ b/src/bin/lttng/utils.c<br>
@@ -21,6 +21,7 @@<br>
 #include &lt;limits.h&gt;<br>
 <br>
 #include &lt;common/error.h&gt;<br>
+#include &lt;common/utils.h&gt;<br>
 <br>
 #include &quot;conf.h&quot;<br>
 #include &quot;utils.h&quot;<br>
@@ -36,7 +37,7 @@ char *get_session_name(void)<br>
 &nbsp; &nbsp; &nbsp; &nbsp; char *path, *session_name = NULL;<br>
 <br>
 &nbsp; &nbsp; &nbsp; &nbsp; /* Get path to config file */<br>
- &nbsp; &nbsp; &nbsp; &nbsp;path = config_get_default_path();<br>
+ &nbsp; &nbsp; &nbsp; &nbsp;path = utils_get_home_dir();<br>
 &nbsp; &nbsp; &nbsp; &nbsp; if (path == NULL) {<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; goto
error;<br>
 &nbsp; &nbsp; &nbsp; &nbsp; }<br>
diff --git a/src/common/defaults.h b/src/common/defaults.h<br>
index 66bb972..c040634 100644<br>
--- a/src/common/defaults.h<br>
+++ b/src/common/defaults.h<br>
@@ -77,6 +77,8 @@<br>
 #define DEFAULT_USTCONSUMERD32_ERR_SOCK_PATH &nbsp; &nbsp;DEFAULT_USTCONSUMERD32_PATH
&quot;/error&quot;<br>
 <br>
 /* Default lttng run directory */<br>
+#define DEFAULT_LTTNG_HOME_ENV_VAR &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp;&quot;LTTNG_HOME&quot;<br>
+#define DEFAULT_LTTNG_FALLBACK_HOME_ENV_VAR &nbsp; &nbsp; &nbsp; &nbsp;&quot;HOME&quot;<br>
 #define DEFAULT_LTTNG_RUNDIR &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp;&quot;/var/run/lttng&quot;<br>
 #define DEFAULT_LTTNG_HOME_RUNDIR &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &quot;%s/.lttng&quot;<br>
 #define DEFAULT_LTTNG_SESSIOND_PIDFILE &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&quot;lttng-sessiond.pid&quot;</font></tt>
<br><tt><font size=2>diff --git a/src/common/utils.c b/src/common/utils.c<br>
index 38f78a7..436febe 100644<br>
--- a/src/common/utils.c<br>
+++ b/src/common/utils.c<br>
@@ -32,6 +32,7 @@<br>
 #include &lt;common/runas.h&gt;<br>
 <br>
 #include &quot;utils.h&quot;<br>
+#include &quot;defaults.h&quot;<br>
 <br>
 /*<br>
 &nbsp;* Return the realpath(3) of the path even if the last directory
token does not<br>
@@ -584,3 +585,17 @@ int utils_get_count_order_u32(uint32_t x)<br>
 <br>
 &nbsp; &nbsp; &nbsp; &nbsp; return fls_u32(x - 1);<br>
 }<br>
+<br>
+/**<br>
+ * Obtain the value of LTTNG_HOME environment variable, if exists.<br>
+ * Otherwise returns the value of HOME.<br>
+ */<br>
+char *utils_get_home_dir(void)<br>
+{<br>
+ &nbsp; &nbsp; &nbsp; &nbsp;char *val = NULL;<br>
+ &nbsp; &nbsp; &nbsp; &nbsp;val = getenv(DEFAULT_LTTNG_HOME_ENV_VAR);<br>
+ &nbsp; &nbsp; &nbsp; &nbsp;if (val != NULL) {<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;return
val;<br>
+ &nbsp; &nbsp; &nbsp; &nbsp;}<br>
+ &nbsp; &nbsp; &nbsp; &nbsp;return getenv(DEFAULT_LTTNG_FALLBACK_HOME_ENV_VAR);<br>
+}<br>
diff --git a/src/common/utils.h b/src/common/utils.h<br>
index 083acef..9e6fb37 100644<br>
--- a/src/common/utils.h<br>
+++ b/src/common/utils.h<br>
@@ -40,5 +40,6 @@ int utils_rotate_stream_file(char *path_name, char *file_name,
uint64_t size,<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; uint64_t
count, int uid, int gid, int out_fd, uint64_t *new_count);<br>
 int utils_parse_size_suffix(char *str, uint64_t *size);</font></tt>
<br><tt><font size=2>&nbsp;int utils_get_count_order_u32(uint32_t x);<br>
+char *utils_get_home_dir(void);<br>
 <br>
 #endif /* _COMMON_UTILS_H */<br>
diff --git a/src/lib/lttng-ctl/lttng-ctl.c b/src/lib/lttng-ctl/lttng-ctl.c<br>
index a7328eb..9d76f79 100644<br>
--- a/src/lib/lttng-ctl/lttng-ctl.c<br>
+++ b/src/lib/lttng-ctl/lttng-ctl.c<br>
@@ -32,6 +32,7 @@<br>
 #include &lt;common/defaults.h&gt;<br>
 #include &lt;common/sessiond-comm/sessiond-comm.h&gt;<br>
 #include &lt;common/uri.h&gt;<br>
+#include &lt;common/utils.h&gt;<br>
 #include &lt;lttng/lttng.h&gt;<br>
 <br>
 #include &quot;filter/filter-ast.h&quot;<br>
@@ -485,7 +486,7 @@ static int set_session_daemon_path(void)<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;*
With GNU C &gt;= 2.1, snprintf returns the required size (excluding closing
null)<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;*/<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ret
= snprintf(sessiond_sock_path, sizeof(sessiond_sock_path),<br>
- &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;DEFAULT_HOME_CLIENT_UNIX_SOCK,
getenv(&quot;HOME&quot;));<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;DEFAULT_HOME_CLIENT_UNIX_SOCK,
utils_get_home_dir());<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; if
((ret &lt; 0) || (ret &gt;= sizeof(sessiond_sock_path))) {<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; goto error;<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; }<br>
@@ -1543,7 +1544,7 @@ static int set_health_socket_path(void)<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;*
With GNU C &lt; &nbsp;2.1, snprintf returns -1 if the target buffer is
too small;</font></tt>
<br><tt><font size=2>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; * With GNU C &gt;= 2.1, snprintf returns the
required size (excluding closing null)<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;*/<br>
- &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;home
= getenv(&quot;HOME&quot;);<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;home
= utils_get_home_dir();<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; if
(home == NULL) {<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; /* Fallback in /tmp .. */<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; home = &quot;/tmp&quot;;<br>
-- <br>
1.7.11.7</font></tt>
<br>
<br>
<br><font size=2 color=#000080 face="sans-serif">Amit Margalit</font>
<br><font size=2 color=#808000 face="sans-serif">IBM XIV </font><font size=2 face="sans-serif">-
<i>Storage Reinvented</i></font>
<br><font size=2 face="sans-serif">XIV-NAS Development Team</font>
<br><font size=2 face="sans-serif">Tel. 03</font><font size=2 face="Arial">-689-7774</font>
<br><font size=2 face="Arial">Fax. 03-689-7230</font>
<br>
<br>
<br>
<br><font size=1 color=#5f5f5f face="sans-serif">From: &nbsp; &nbsp; &nbsp;
&nbsp;</font><font size=1 face="sans-serif">Amit Margalit/Israel/IBM@IBMIL</font>
<br><font size=1 color=#5f5f5f face="sans-serif">To: &nbsp; &nbsp; &nbsp;
&nbsp;</font><font size=1 face="sans-serif">David Goulet &lt;dgoulet@efficios.com&gt;</font>
<br><font size=1 color=#5f5f5f face="sans-serif">Cc: &nbsp; &nbsp; &nbsp;
&nbsp;</font><font size=1 face="sans-serif">lttng-dev@lists.lttng.org</font>
<br><font size=1 color=#5f5f5f face="sans-serif">Date: &nbsp; &nbsp; &nbsp;
&nbsp;</font><font size=1 face="sans-serif">06/13/2013 12:39 PM</font>
<br><font size=1 color=#5f5f5f face="sans-serif">Subject: &nbsp; &nbsp;
&nbsp; &nbsp;</font><font size=1 face="sans-serif">Re: [lttng-dev]
[RFC PATCH lttng-tools] Allow environment variable LTTNG_HOME to override
HOME - for lttng-tools</font>
<br>
<hr noshade>
<br>
<br>
<br><font size=2 face="sans-serif">I think I've done all that you suggested,
for lttng-tools only, though, based on cfa9a5a2b4a96e0d6a9eeddd2622a6d7c173b7ac
which is the latest master as of right now.</font><font size=3> <br>
</font><font size=2 face="sans-serif"><br>
Here is the patch:</font><font size=3> </font>
<br><tt><font size=2>From 5881718a60608d640ac1124c9c1f439a2a084707 Mon
Sep 17 00:00:00 2001<br>
From: Amit Margalit &lt;amitm@il.ibm.com&gt;<br>
Date: Thu, 13 Jun 2013 12:35:13 +0300<br>
Subject: [PATCH] Using LTTNG_HOME environment variable if exists, with<br>
fallback to HOME</font></tt><font size=3> <br>
</font><tt><font size=2><br>
---<br>
</font></tt><font size=3>[Old patch deleted]<br>
</font><tt><font size=2>_______________________________________________<br>
lttng-dev mailing list<br>
lttng-dev@lists.lttng.org<br>
</font></tt><a href="http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev"><tt><font size=2>http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev</font></tt></a><tt><font size=2><br>
</font></tt>
<br></div>
--=_alternative 0043446DC2257B89_=--



--===============2088667516==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============2088667516==--
