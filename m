From: Amit Margalit <AMITM@il.ibm.com>
Subject: Re: [RFC PATCH lttng-tools] Allow environment variable
 LTTNG_HOME to override HOME - for lttng-tools
Date: Thu, 13 Jun 2013 12:39:19 +0300
Message-ID: <OFDDF6769F.EB68519B-ONC2257B89.0034BB76-C2257B89.0034F473__33485.5240457275$1371116429$gmane$org@il.ibm.com>
References: <OF6896CCA9.D04FC8AB-ONC2257B87.00424736-C2257B87.00427FF3@il.ibm.com>
	<51B889B6.6020200@efficios.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0183193147=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from e06smtp17.uk.ibm.com ([195.75.94.113])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <amitm@il.ibm.com>) id 1Un40O-0006vG-7c
	for lttng-dev@lists.lttng.org; Thu, 13 Jun 2013 05:39:44 -0400
Received: from /spool/local
	by e06smtp17.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <lttng-dev@lists.lttng.org> from <amitm@il.ibm.com>;
	Thu, 13 Jun 2013 10:35:57 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com
	(d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
	by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id B399C17D805D
	for <lttng-dev@lists.lttng.org>; Thu, 13 Jun 2013 10:40:51 +0100 (BST)
Received: from d06av12.portsmouth.uk.ibm.com (d06av12.portsmouth.uk.ibm.com
	[9.149.37.247])
	by b06cxnps4076.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with
	ESMTP id r5D9dJEr36896880
	for <lttng-dev@lists.lttng.org>; Thu, 13 Jun 2013 09:39:19 GMT
Received: from d06av12.portsmouth.uk.ibm.com (localhost [127.0.0.1])
	by d06av12.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with
	ESMTP id r5D9dTuv020601
	for <lttng-dev@lists.lttng.org>; Thu, 13 Jun 2013 03:39:29 -0600
Received: from d06ml311.portsmouth.uk.ibm.com (d06ml311.portsmouth.uk.ibm.com
	[9.149.104.181])
	by d06av12.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with
	ESMTP id r5D9dTGH020595
	for <lttng-dev@lists.lttng.org>; Thu, 13 Jun 2013 03:39:29 -0600
In-Reply-To: <51B889B6.6020200@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: David Goulet <dgoulet@efficios.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

This is a multipart message in MIME format.
--===============0183193147==
Content-Type: multipart/alternative; boundary="=_alternative 0034F40BC2257B89_="

This is a multipart message in MIME format.
--=_alternative 0034F40BC2257B89_=
Content-Type: text/plain; charset="US-ASCII"

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
 11 files changed, 29 insertions(+), 35 deletions(-)

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



From:   David Goulet <dgoulet@efficios.com>
To:     Amit Margalit/Israel/IBM@IBMIL
Cc:     lttng-dev@lists.lttng.org
Date:   06/12/2013 05:46 PM
Subject:        Re: [lttng-dev] [RFC PATCH lttng-tools] Allow environment 
variable LTTNG_HOME to override HOME - for lttng-tools



This looks good! It appears that there are multiple callsites doing the 
same
thing... We might want to just put it in src/common/utils.c with something 
like
utils_get_home_dir() and use it from there.

Also, adding "LTTNG_HOME" in defaults.h as a defined value for the env. 
variable
name. Finally, updating the man page would be also great. :)

Once you are ready to submit the patch, it would be good to use "git
format-patch" or send me a pull request based on git HEAD master.

Big thanks for this contribution!
David

Amit Margalit:
> Hello all,
> 
> Patch functionality - If LTTNG_HOME environment variable exists, it is 
used
> instead of HOME.
> Reason for patch - We are trying to deploy LTTng on a system where $HOME 
is on a
> filesystem mounted read-only, but cannot afford to run lttng as a 
different user
> and cannot move the home directories of users to writeable locations.
> Patch baseline: 2.2.0 rc2
> 
> This patch handles only lttng-tools.
> 
> I can provide the same patches against git, if asked.
> 
> diff -ur lttng-tools-2.2.0-rc2-orig/src/bin/lttng/conf.c
> lttng-tools-2.2.0-rc2/src/bin/lttng/conf.c
> --- lttng-tools-2.2.0-rc2-orig/src/bin/lttng/conf.c        2013-05-06
> 21:50:59.000000000 +0300
> +++ lttng-tools-2.2.0-rc2/src/bin/lttng/conf.c        2013-06-11
> 14:17:34.681673309 +0300
> @@ -127,6 +127,11 @@
>   */
>  char *config_get_default_path(void)
>  {
> +        char *val = NULL;
> +        val = getenv("LTTNG_HOME");
> +        if (val != NULL) {
> +                return val;
> +        }
>          return getenv("HOME");
>  }
> 
> diff -ur lttng-tools-2.2.0-rc2-orig/src/bin/lttng-relayd/utils.c
> lttng-tools-2.2.0-rc2/src/bin/lttng-relayd/utils.c
> --- lttng-tools-2.2.0-rc2-orig/src/bin/lttng-relayd/utils.c 2013-05-06
> 21:50:59.000000000 +0300
> +++ lttng-tools-2.2.0-rc2/src/bin/lttng-relayd/utils.c        2013-06-11
> 14:15:52.553673444 +0300
> @@ -34,7 +34,11 @@
>   */
>  static char *get_default_path(void)
>  {
> -        return getenv("HOME");
> +        char *val = NULL;
> +        val = getenv("LTTNG_HOME");
> +        if (val != NULL) {
> +                return val;
> +        }
>  }
> 
>  static char *create_output_path_auto(char *path_name)
> diff -ur lttng-tools-2.2.0-rc2-orig/src/bin/lttng-sessiond/utils.c
> lttng-tools-2.2.0-rc2/src/bin/lttng-sessiond/utils.c
> --- lttng-tools-2.2.0-rc2-orig/src/bin/lttng-sessiond/utils.c 2013-01-07
> 22:05:16.000000000 +0200
> +++ lttng-tools-2.2.0-rc2/src/bin/lttng-sessiond/utils.c 2013-06-11
> 14:16:16.697673412 +0300
> @@ -53,5 +53,10 @@
>   */
>  const char *get_home_dir(void)
>  {
> +        const char *val = NULL;
> +        val = ((const char *) getenv("LTTNG_HOME"));
> +        if (val != NULL) {
> +                return val;
> +        }
>          return ((const char *) getenv("HOME"));
>  }
> diff -ur lttng-tools-2.2.0-rc2-orig/src/lib/lttng-ctl/lttng-ctl.c
> lttng-tools-2.2.0-rc2/src/lib/lttng-ctl/lttng-ctl.c
> --- lttng-tools-2.2.0-rc2-orig/src/lib/lttng-ctl/lttng-ctl.c 2013-05-07
> 22:42:07.000000000 +0300
> +++ lttng-tools-2.2.0-rc2/src/lib/lttng-ctl/lttng-ctl.c 2013-06-11
> 14:19:15.177673176 +0300
> @@ -74,6 +74,22 @@
>  int lttng_opt_verbose;
> 
>  /*
> + * Get the value of LTTNG_HOME if present, or HOME if not.
> + * Caller must not free the returned pointer.
> + * Used
> + */
> +static const char *get_lttng_home_dir(void)
> +{
> +        const char *val = NULL;
> +        val = ((const char *) getenv("LTTNG_HOME"));
> +        if (val != NULL) {
> +                return val;
> +        }
> +        return ((const char *) getenv("HOME"));
> +}
> +
> +
> +/*
>   * Compare two URL destination.
>   *
>   * Return 0 is equal else is not equal.
> @@ -485,7 +501,7 @@
>                   * With GNU C >= 2.1, snprintf returns the required 
size
> (excluding closing null)
>                   */
>                  ret = snprintf(sessiond_sock_path, 
sizeof(sessiond_sock_path),
> -                                DEFAULT_HOME_CLIENT_UNIX_SOCK, 
getenv("HOME"));
> +                                DEFAULT_HOME_CLIENT_UNIX_SOCK,
> get_lttng_home_dir());
>                  if ((ret < 0) || (ret >= sizeof(sessiond_sock_path))) {
>                          goto error;
>                  }
> @@ -1543,7 +1559,7 @@
>                   * With GNU C <  2.1, snprintf returns -1 if the target 
buffer
> is too small;
>                   * With GNU C >= 2.1, snprintf returns the required 
size
> (excluding closing null)
>                   */
> -                home = getenv("HOME");
> +                home = get_lttng_home_dir();
>                  if (home == NULL) {
>                          /* Fallback in /tmp .. */
>                          home = "/tmp";
> 
> Thanks,
> 
> Amit Margalit
> IBM XIV - /Storage Reinvented/
> XIV-NAS Development Team
> Tel. 03-689-7774
> Fax. 03-689-7230
> 
> 
> This body part will be downloaded on demand.



--=_alternative 0034F40BC2257B89_=
Content-Type: text/html; charset="US-ASCII"

<font size=2 face="sans-serif">I think I've done all that you suggested,
for lttng-tools only, though, based on cfa9a5a2b4a96e0d6a9eeddd2622a6d7c173b7ac
which is the latest master as of right now.</font>
<br>
<br><font size=2 face="sans-serif">Here is the patch:</font>
<br>
<div><tt><font size=2>From 5881718a60608d640ac1124c9c1f439a2a084707 Mon
Sep 17 00:00:00 2001<br>
From: Amit Margalit &lt;amitm@il.ibm.com&gt;<br>
Date: Thu, 13 Jun 2013 12:35:13 +0300<br>
Subject: [PATCH] Using LTTNG_HOME environment variable if exists, with<br>
 fallback to HOME</font></tt>
<br>
<br><tt><font size=2>---<br>
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
 11 files changed, 29 insertions(+), 35 deletions(-)</font></tt>
<br>
<br><tt><font size=2>diff --git a/src/bin/lttng-relayd/utils.c b/src/bin/lttng-relayd/utils.c<br>
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
@@ -44,7 +36,7 @@ static char *create_output_path_auto(char *path_name)<br>
 &nbsp; &nbsp; &nbsp; &nbsp; char *alloc_path = NULL;<br>
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
@@ -4136,7 +4136,7 @@ int main(int argc, char **argv)</font></tt>
<br><tt><font size=2>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp;DBG2(&quot;Kernel consumer cmd path: %s&quot;,<br>
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
-<br>
-/*<br>
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
Auto output path */</font></tt>
<br><tt><font size=2>- &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp;alloc_path = config_get_default_path();<br>
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
pointer.<br>
- */<br>
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
- &nbsp; &nbsp; &nbsp; &nbsp;path = config_get_default_path();</font></tt>
<br><tt><font size=2>+ &nbsp; &nbsp; &nbsp; &nbsp;path = utils_get_home_dir();<br>
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
diff --git a/src/bin/lttng/utils.c b/src/bin/lttng/utils.c<br>
index 94c4527..6041655 100644<br>
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
 &nbsp; &nbsp; &nbsp; &nbsp; }</font></tt>
<br><tt><font size=2>diff --git a/src/common/defaults.h b/src/common/defaults.h<br>
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
 #define DEFAULT_LTTNG_SESSIOND_PIDFILE &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&quot;lttng-sessiond.pid&quot;<br>
diff --git a/src/common/utils.c b/src/common/utils.c<br>
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
+ * Obtain the value of LTTNG_HOME environment variable, if exists.</font></tt>
<br><tt><font size=2>+ * Otherwise returns the value of HOME.<br>
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
 int utils_parse_size_suffix(char *str, uint64_t *size);<br>
 int utils_get_count_order_u32(uint32_t x);<br>
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
+#include &lt;common/utils.h&gt;</font></tt>
<br><tt><font size=2>&nbsp;#include &lt;lttng/lttng.h&gt;<br>
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
too small;<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;*
With GNU C &gt;= 2.1, snprintf returns the required size (excluding closing
null)<br>
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
&nbsp;</font><font size=1 face="sans-serif">David Goulet &lt;dgoulet@efficios.com&gt;</font>
<br><font size=1 color=#5f5f5f face="sans-serif">To: &nbsp; &nbsp; &nbsp;
&nbsp;</font><font size=1 face="sans-serif">Amit Margalit/Israel/IBM@IBMIL</font>
<br><font size=1 color=#5f5f5f face="sans-serif">Cc: &nbsp; &nbsp; &nbsp;
&nbsp;</font><font size=1 face="sans-serif">lttng-dev@lists.lttng.org</font>
<br><font size=1 color=#5f5f5f face="sans-serif">Date: &nbsp; &nbsp; &nbsp;
&nbsp;</font><font size=1 face="sans-serif">06/12/2013 05:46 PM</font>
<br><font size=1 color=#5f5f5f face="sans-serif">Subject: &nbsp; &nbsp;
&nbsp; &nbsp;</font><font size=1 face="sans-serif">Re: [lttng-dev]
[RFC PATCH lttng-tools] Allow environment variable LTTNG_HOME to override
HOME - for lttng-tools</font>
<br>
<hr noshade>
<br>
<br>
<br><tt><font size=2>This looks good! It appears that there are multiple
callsites doing the same<br>
thing... We might want to just put it in src/common/utils.c with something
like<br>
utils_get_home_dir() and use it from there.<br>
<br>
Also, adding &quot;LTTNG_HOME&quot; in defaults.h as a defined value for
the env. variable<br>
name. Finally, updating the man page would be also great. :)<br>
<br>
Once you are ready to submit the patch, it would be good to use &quot;git<br>
format-patch&quot; or send me a pull request based on git HEAD master.<br>
<br>
Big thanks for this contribution!<br>
David<br>
<br>
Amit Margalit:<br>
&gt; Hello all,<br>
&gt; <br>
&gt; Patch functionality - If LTTNG_HOME environment variable exists, it
is used<br>
&gt; instead of HOME.<br>
&gt; Reason for patch - We are trying to deploy LTTng on a system where
$HOME is on a<br>
&gt; filesystem mounted read-only, but cannot afford to run lttng as a
different user<br>
&gt; and cannot move the home directories of users to writeable locations.<br>
&gt; Patch baseline: 2.2.0 rc2<br>
&gt; <br>
&gt; This patch handles only lttng-tools.<br>
&gt; <br>
&gt; I can provide the same patches against git, if asked.<br>
&gt; <br>
&gt; diff -ur lttng-tools-2.2.0-rc2-orig/src/bin/lttng/conf.c<br>
&gt; lttng-tools-2.2.0-rc2/src/bin/lttng/conf.c<br>
&gt; --- lttng-tools-2.2.0-rc2-orig/src/bin/lttng/conf.c &nbsp; &nbsp;
&nbsp; &nbsp;2013-05-06<br>
&gt; 21:50:59.000000000 +0300<br>
&gt; +++ lttng-tools-2.2.0-rc2/src/bin/lttng/conf.c &nbsp; &nbsp; &nbsp;
&nbsp;2013-06-11<br>
&gt; 14:17:34.681673309 +0300<br>
&gt; @@ -127,6 +127,11 @@<br>
&gt; &nbsp; */<br>
&gt; &nbsp;char *config_get_default_path(void)<br>
&gt; &nbsp;{<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp;char *val = NULL;<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp;val = getenv(&quot;LTTNG_HOME&quot;);<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp;if (val != NULL) {<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;return val;<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp;}<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;return getenv(&quot;HOME&quot;);<br>
&gt; &nbsp;}<br>
&gt; &nbsp;<br>
&gt; diff -ur lttng-tools-2.2.0-rc2-orig/src/bin/lttng-relayd/utils.c<br>
&gt; lttng-tools-2.2.0-rc2/src/bin/lttng-relayd/utils.c<br>
&gt; --- lttng-tools-2.2.0-rc2-orig/src/bin/lttng-relayd/utils.c &nbsp;
&nbsp; &nbsp; &nbsp;2013-05-06<br>
&gt; 21:50:59.000000000 +0300<br>
&gt; +++ lttng-tools-2.2.0-rc2/src/bin/lttng-relayd/utils.c &nbsp; &nbsp;
&nbsp; &nbsp;2013-06-11<br>
&gt; 14:15:52.553673444 +0300<br>
&gt; @@ -34,7 +34,11 @@<br>
&gt; &nbsp; */<br>
&gt; &nbsp;static char *get_default_path(void)<br>
&gt; &nbsp;{<br>
&gt; - &nbsp; &nbsp; &nbsp; &nbsp;return getenv(&quot;HOME&quot;);<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp;char *val = NULL;<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp;val = getenv(&quot;LTTNG_HOME&quot;);<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp;if (val != NULL) {<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;return val;<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp;}<br>
&gt; &nbsp;}<br>
&gt; &nbsp;<br>
&gt; &nbsp;static char *create_output_path_auto(char *path_name)<br>
&gt; diff -ur lttng-tools-2.2.0-rc2-orig/src/bin/lttng-sessiond/utils.c<br>
&gt; lttng-tools-2.2.0-rc2/src/bin/lttng-sessiond/utils.c<br>
&gt; --- lttng-tools-2.2.0-rc2-orig/src/bin/lttng-sessiond/utils.c &nbsp;
&nbsp; &nbsp; &nbsp;2013-01-07<br>
&gt; 22:05:16.000000000 +0200<br>
&gt; +++ lttng-tools-2.2.0-rc2/src/bin/lttng-sessiond/utils.c &nbsp; &nbsp;
&nbsp; &nbsp;2013-06-11<br>
&gt; 14:16:16.697673412 +0300<br>
&gt; @@ -53,5 +53,10 @@<br>
&gt; &nbsp; */<br>
&gt; &nbsp;const char *get_home_dir(void)<br>
&gt; &nbsp;{<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp;const char *val = NULL;<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp;val = ((const char *) getenv(&quot;LTTNG_HOME&quot;));<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp;if (val != NULL) {<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;return val;<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp;}<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;return ((const char *) getenv(&quot;HOME&quot;));<br>
&gt; &nbsp;}<br>
&gt; diff -ur lttng-tools-2.2.0-rc2-orig/src/lib/lttng-ctl/lttng-ctl.c<br>
&gt; lttng-tools-2.2.0-rc2/src/lib/lttng-ctl/lttng-ctl.c<br>
&gt; --- lttng-tools-2.2.0-rc2-orig/src/lib/lttng-ctl/lttng-ctl.c &nbsp;
&nbsp; &nbsp; &nbsp;2013-05-07<br>
&gt; 22:42:07.000000000 +0300<br>
&gt; +++ lttng-tools-2.2.0-rc2/src/lib/lttng-ctl/lttng-ctl.c &nbsp; &nbsp;
&nbsp; &nbsp;2013-06-11<br>
&gt; 14:19:15.177673176 +0300<br>
&gt; @@ -74,6 +74,22 @@<br>
&gt; &nbsp;int lttng_opt_verbose;<br>
&gt; &nbsp;<br>
&gt; &nbsp;/*<br>
&gt; + * Get the value of LTTNG_HOME if present, or HOME if not.<br>
&gt; + * Caller must not free the returned pointer.<br>
&gt; + * Used<br>
&gt; + */<br>
&gt; +static const char *get_lttng_home_dir(void)<br>
&gt; +{<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp;const char *val = NULL;<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp;val = ((const char *) getenv(&quot;LTTNG_HOME&quot;));<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp;if (val != NULL) {<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;return val;<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp;}<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp;return ((const char *) getenv(&quot;HOME&quot;));<br>
&gt; +}<br>
&gt; +<br>
&gt; +<br>
&gt; +/*<br>
&gt; &nbsp; * Compare two URL destination.<br>
&gt; &nbsp; *<br>
&gt; &nbsp; * Return 0 is equal else is not equal.<br>
&gt; @@ -485,7 +501,7 @@<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; * With
GNU C &gt;= 2.1, snprintf returns the required size<br>
&gt; (excluding closing null)<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; */<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;ret
= snprintf(sessiond_sock_path, sizeof(sessiond_sock_path),<br>
&gt; - &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;DEFAULT_HOME_CLIENT_UNIX_SOCK,
getenv(&quot;HOME&quot;));<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;DEFAULT_HOME_CLIENT_UNIX_SOCK,<br>
&gt; get_lttng_home_dir());<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;if ((ret
&lt; 0) || (ret &gt;= sizeof(sessiond_sock_path))) {<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp;goto error;<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;}<br>
&gt; @@ -1543,7 +1559,7 @@<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; * With
GNU C &lt; &nbsp;2.1, snprintf returns -1 if the target buffer<br>
&gt; is too small;<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; * With
GNU C &gt;= 2.1, snprintf returns the required size<br>
&gt; (excluding closing null)<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; */<br>
&gt; - &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;home = getenv(&quot;HOME&quot;);<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;home = get_lttng_home_dir();<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;if (home
== NULL) {<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp;/* Fallback in /tmp .. */<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp;home = &quot;/tmp&quot;;<br>
&gt; <br>
&gt; Thanks,<br>
&gt; <br>
&gt; Amit Margalit<br>
&gt; IBM XIV - /Storage Reinvented/<br>
&gt; XIV-NAS Development Team<br>
&gt; Tel. 03-689-7774<br>
&gt; Fax. 03-689-7230<br>
&gt; <br>
&gt; <br>
&gt; This body part will be downloaded on demand.<br>
<br>
</font></tt>
<br></div>
--=_alternative 0034F40BC2257B89_=--



--===============0183193147==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0183193147==--
