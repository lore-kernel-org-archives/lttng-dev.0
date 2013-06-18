From: Amit Margalit <AMITM@il.ibm.com>
Subject: Re: [RFC PATCH lttng-tools] Allow environment variable
 LTTNG_HOME to override HOME - for lttng-tools - UPDATED PATCH
Date: Tue, 18 Jun 2013 10:02:08 +0300
Message-ID: <OF22F6CF87.62E29056-ONC2257B8E.00267925-C2257B8E.002691A2__22504.8569999219$1371538992$gmane$org@il.ibm.com>
References: <OF6896CCA9.D04FC8AB-ONC2257B87.00424736-C2257B87.00427FF3@il.ibm.com>	<51B889B6.6020200@efficios.com>
	<OFDDF6769F.EB68519B-ONC2257B89.0034BB76-C2257B89.0034F473@il.ibm.com>
	<OF0D9D1EAD.C7331410-ONC2257B89.00430C64-C2257B89.00434492@il.ibm.com>
	<51BF670B.50603@efficios.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=_mixed 00269168C2257B8E_="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from e06smtp16.uk.ibm.com ([195.75.94.112])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <amitm@il.ibm.com>) id 1Uopvy-0000vg-AH
	for lttng-dev@lists.lttng.org; Tue, 18 Jun 2013 03:02:30 -0400
Received: from /spool/local
	by e06smtp16.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <lttng-dev@lists.lttng.org> from <amitm@il.ibm.com>;
	Tue, 18 Jun 2013 07:57:22 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com
	(d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
	by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id D81D817D806A
	for <lttng-dev@lists.lttng.org>; Tue, 18 Jun 2013 08:03:44 +0100 (BST)
Received: from d06av08.portsmouth.uk.ibm.com (d06av08.portsmouth.uk.ibm.com
	[9.149.37.249])
	by b06cxnps3075.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with
	ESMTP id r5I729mE53936336
	for <lttng-dev@lists.lttng.org>; Tue, 18 Jun 2013 07:02:09 GMT
Received: from d06av08.portsmouth.uk.ibm.com (localhost [127.0.0.1])
	by d06av08.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with
	ESMTP id r5I72KBt023169
	for <lttng-dev@lists.lttng.org>; Tue, 18 Jun 2013 01:02:20 -0600
Received: from d06ml311.portsmouth.uk.ibm.com (d06ml311.portsmouth.uk.ibm.com
	[9.149.104.181])
	by d06av08.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with
	ESMTP id r5I72KWK023153
	for <lttng-dev@lists.lttng.org>; Tue, 18 Jun 2013 01:02:20 -0600
In-Reply-To: <51BF670B.50603@efficios.com>
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

--=_mixed 00269168C2257B8E_=
Content-Type: multipart/alternative; boundary="=_alternative 00269168C2257B8E_="


--=_alternative 00269168C2257B8E_=
Content-Type: text/plain; charset="US-ASCII"

As requested the patch file is attached.


It is based on top of 3a68137cb2a86e7e8b13239fee52cae4542605af .

Amit Margalit
IBM XIV - Storage Reinvented
XIV-NAS Development Team
Tel. 03-689-7774
Fax. 03-689-7230



From:   David Goulet <dgoulet@efficios.com>
To:     Amit Margalit/Israel/IBM@IBMIL
Cc:     lttng-dev@lists.lttng.org
Date:   06/17/2013 10:44 PM
Subject:        Re: [lttng-dev] [RFC PATCH lttng-tools] Allow environment 
variable LTTNG_HOME to override HOME - for lttng-tools - UPDATED PATCH



Hi Amit,

There seems to be a problem with this patch, I can't merge it due to some
malformed part of it...

Did you use "git send-email" ? If you don't have that, either attach the 
"git
format-patch" to the email, the "git log -1" or the diff in a separate 
file.

Thanks!
David

Amit Margalit:
> Hi,
> 
> I've added a paragraph to the man page. Here is the new patch:
> From a72bd9dd6a58ac727280f2f9a85ee80607f1aba9 Mon Sep 17 00:00:00 2001
> From: Amit Margalit <amitm@il.ibm.com>
> Date: Thu, 13 Jun 2013 12:35:13 +0300
> Subject: [PATCH] Using LTTNG_HOME environment variable if exists, with
> fallback to HOME
> 
> ---
> doc/man/lttng.1                 |  4 ++++
> src/bin/lttng-relayd/utils.c    | 10 +---------
> src/bin/lttng-sessiond/main.c   |  2 +-
> src/bin/lttng-sessiond/utils.c  | 10 ----------
> src/bin/lttng/commands/create.c |  2 +-
> src/bin/lttng/conf.c            | 13 +++----------
> src/bin/lttng/conf.h            |  1 -
> src/bin/lttng/utils.c           |  3 ++-
> src/common/defaults.h           |  2 ++
> src/common/utils.c              | 15 +++++++++++++++
> src/common/utils.h              |  1 +
> src/lib/lttng-ctl/lttng-ctl.c   |  5 +++--
> 12 files changed, 33 insertions(+), 35 deletions(-)
> 
> diff --git a/doc/man/lttng.1 b/doc/man/lttng.1
> index f472d38..26fd44a 100644
> --- a/doc/man/lttng.1
> +++ b/doc/man/lttng.1
> @@ -214,6 +214,10 @@ automatically created having this form: 
'auto-yyyymmdd-hhmmss'.
> 
> If no \fB\-o, \-\-output\fP is specified, the traces will be written in
> $HOME/lttng-traces.
> +
> +The $HOME environment variable can be overridden by defining the 
environment
> +variable LTTNG_HOME. This is useful when the user running the commands 
has
> +a non-writeable home directory.
> .fi
> 
> .B OPTIONS:
> diff --git a/src/bin/lttng-relayd/utils.c b/src/bin/lttng-relayd/utils.c
> index ad13d32..392fab6 100644
> --- a/src/bin/lttng-relayd/utils.c
> +++ b/src/bin/lttng-relayd/utils.c
> @@ -29,14 +29,6 @@
> #include "lttng-relayd.h"
> #include "utils.h"
> 
> -/*
> - * Returns the HOME directory path. Caller MUST NOT free(3) the return 
pointer.
> - */
> -static char *get_default_path(void)
> -{
> -        return getenv("HOME");
> -}
> -
> static char *create_output_path_auto(char *path_name)
> {
>         int ret;
> @@ -44,7 +36,7 @@ static char *create_output_path_auto(char *path_name)
>          char *alloc_path = NULL;
>         char *default_path;
> 
> -        default_path = get_default_path();
> +        default_path = utils_get_home_dir();
>         if (default_path == NULL) {
>                 ERR("Home path not found.\n \
>                                 Please specify an output path using -o, 
--output
> PATH");
> diff --git a/src/bin/lttng-sessiond/main.c 
b/src/bin/lttng-sessiond/main.c
> index 4470afc..256ffba 100644
> --- a/src/bin/lttng-sessiond/main.c
> +++ b/src/bin/lttng-sessiond/main.c
> @@ -4136,7 +4136,7 @@ int main(int argc, char **argv)
>                 DBG2("Kernel consumer cmd path: %s",
>                                 kconsumer_data.cmd_unix_sock_path);
>         } else {
> -                home_path = get_home_dir();
> +                home_path = utils_get_home_dir();
>                 if (home_path == NULL) {
>                         /* TODO: Add --socket PATH option */
>                         ERR("Can't get HOME directory for sockets 
creation.");
> diff --git a/src/bin/lttng-sessiond/utils.c 
b/src/bin/lttng-sessiond/utils.c
> index 5ea3374..af42ad0 100644
> --- a/src/bin/lttng-sessiond/utils.c
> +++ b/src/bin/lttng-sessiond/utils.c
> @@ -45,13 +45,3 @@ int notify_thread_pipe(int wpipe)
> 
>         return ret;
> }
> -
> -/*
> - * Return pointer to home directory path using the env variable HOME.
> - *
> - * No home, NULL is returned.
> - */
> -const char *get_home_dir(void)
> -{
> -        return ((const char *) getenv("HOME"));
> -}
> diff --git a/src/bin/lttng/commands/create.c 
b/src/bin/lttng/commands/create.c
> index 805cdb1..ddd2983 100644
> --- a/src/bin/lttng/commands/create.c
> +++ b/src/bin/lttng/commands/create.c
> @@ -250,7 +250,7 @@ static int create_session(void)
>                 print_str_url = url;
>         } else {
>                 /* Auto output path */
> -                alloc_path = config_get_default_path();
> +                alloc_path = utils_get_home_dir();
>                 if (alloc_path == NULL) {
>                         ERR("HOME path not found.\n \
>                                         Please specify an output path 
using -o,
> --output PATH");
> diff --git a/src/bin/lttng/conf.c b/src/bin/lttng/conf.c
> index b6632fc..5a0da9d 100644
> --- a/src/bin/lttng/conf.c
> +++ b/src/bin/lttng/conf.c
> @@ -25,6 +25,7 @@
> #include <unistd.h>
> 
> #include <common/error.h>
> +#include <common/utils.h>
> 
> #include "conf.h"
> 
> @@ -123,14 +124,6 @@ end:
> }
> 
> /*
> - * Returns the HOME directory path. Caller MUST NOT free(3) the return 
pointer.
> - */
> -char *config_get_default_path(void)
> -{
> -        return getenv("HOME");
> -}
> -
> -/*
>  * Destroys directory config and file config.
>  */
> void config_destroy(char *path)
> @@ -161,7 +154,7 @@ end:
>  */
> void config_destroy_default(void)
> {
> -        char *path = config_get_default_path();
> +        char *path = utils_get_home_dir();
>         if (path == NULL) {
>                 return;
>         }
> @@ -277,7 +270,7 @@ int config_init(char *session_name)
>         int ret;
>         char *path;
> 
> -        path = config_get_default_path();
> +        path = utils_get_home_dir();
>         if (path == NULL) {
>                 ret = -1;
>                 goto error;
> diff --git a/src/bin/lttng/conf.h b/src/bin/lttng/conf.h
> index 2cb04b0..3bed59c 100644
> --- a/src/bin/lttng/conf.h
> +++ b/src/bin/lttng/conf.h
> @@ -25,7 +25,6 @@ void config_destroy_default(void);
> int config_exists(const char *path);
> int config_init(char *path);
> int config_add_session_name(char *path, char *name);
> -char *config_get_default_path(void);
> 
> /* Must free() the return pointer */
> char *config_read_session_name(char *path);
> diff --git a/src/bin/lttng/utils.c b/src/bin/lttng/utils.c
> index 94c4527..6041655 100644
> --- a/src/bin/lttng/utils.c
> +++ b/src/bin/lttng/utils.c
> @@ -21,6 +21,7 @@
> #include <limits.h>
> 
> #include <common/error.h>
> +#include <common/utils.h>
> 
> #include "conf.h"
> #include "utils.h"
> @@ -36,7 +37,7 @@ char *get_session_name(void)
>         char *path, *session_name = NULL;
> 
>         /* Get path to config file */
> -        path = config_get_default_path();
> +        path = utils_get_home_dir();
>         if (path == NULL) {
>                 goto error;
>         }
> diff --git a/src/common/defaults.h b/src/common/defaults.h
> index 66bb972..c040634 100644
> --- a/src/common/defaults.h
> +++ b/src/common/defaults.h
> @@ -77,6 +77,8 @@
> #define DEFAULT_USTCONSUMERD32_ERR_SOCK_PATH DEFAULT_USTCONSUMERD32_PATH 
"/error"
> 
> /* Default lttng run directory */
> +#define DEFAULT_LTTNG_HOME_ENV_VAR              "LTTNG_HOME"
> +#define DEFAULT_LTTNG_FALLBACK_HOME_ENV_VAR        "HOME"
> #define DEFAULT_LTTNG_RUNDIR                    "/var/run/lttng"
> #define DEFAULT_LTTNG_HOME_RUNDIR               "%s/.lttng"
> #define DEFAULT_LTTNG_SESSIOND_PIDFILE          "lttng-sessiond.pid"
> diff --git a/src/common/utils.c b/src/common/utils.c
> index 38f78a7..436febe 100644
> --- a/src/common/utils.c
> +++ b/src/common/utils.c
> @@ -32,6 +32,7 @@
> #include <common/runas.h>
> 
> #include "utils.h"
> +#include "defaults.h"
> 
> /*
>  * Return the realpath(3) of the path even if the last directory token 
does not
> @@ -584,3 +585,17 @@ int utils_get_count_order_u32(uint32_t x)
> 
>         return fls_u32(x - 1);
> }
> +
> +/**
> + * Obtain the value of LTTNG_HOME environment variable, if exists.
> + * Otherwise returns the value of HOME.
> + */
> +char *utils_get_home_dir(void)
> +{
> +        char *val = NULL;
> +        val = getenv(DEFAULT_LTTNG_HOME_ENV_VAR);
> +        if (val != NULL) {
> +                return val;
> +        }
> +        return getenv(DEFAULT_LTTNG_FALLBACK_HOME_ENV_VAR);
> +}
> diff --git a/src/common/utils.h b/src/common/utils.h
> index 083acef..9e6fb37 100644
> --- a/src/common/utils.h
> +++ b/src/common/utils.h
> @@ -40,5 +40,6 @@ int utils_rotate_stream_file(char *path_name, char 
*file_name,
> uint64_t size,
>                 uint64_t count, int uid, int gid, int out_fd, uint64_t 
*new_count);
> int utils_parse_size_suffix(char *str, uint64_t *size);
>  int utils_get_count_order_u32(uint32_t x);
> +char *utils_get_home_dir(void);
> 
> #endif /* _COMMON_UTILS_H */
> diff --git a/src/lib/lttng-ctl/lttng-ctl.c 
b/src/lib/lttng-ctl/lttng-ctl.c
> index a7328eb..9d76f79 100644
> --- a/src/lib/lttng-ctl/lttng-ctl.c
> +++ b/src/lib/lttng-ctl/lttng-ctl.c
> @@ -32,6 +32,7 @@
> #include <common/defaults.h>
> #include <common/sessiond-comm/sessiond-comm.h>
> #include <common/uri.h>
> +#include <common/utils.h>
> #include <lttng/lttng.h>
> 
> #include "filter/filter-ast.h"
> @@ -485,7 +486,7 @@ static int set_session_daemon_path(void)
>                  * With GNU C >= 2.1, snprintf returns the required size
> (excluding closing null)
>                  */
>                 ret = snprintf(sessiond_sock_path, 
sizeof(sessiond_sock_path),
> -                                DEFAULT_HOME_CLIENT_UNIX_SOCK, 
getenv("HOME"));
> +                                DEFAULT_HOME_CLIENT_UNIX_SOCK,
> utils_get_home_dir());
>                 if ((ret < 0) || (ret >= sizeof(sessiond_sock_path))) {
>                         goto error;
>                 }
> @@ -1543,7 +1544,7 @@ static int set_health_socket_path(void)
>                  * With GNU C <  2.1, snprintf returns -1 if the target 
buffer
> is too small;
>                   * With GNU C >= 2.1, snprintf returns the required 
size
> (excluding closing null)
>                  */
> -                home = getenv("HOME");
> +                home = utils_get_home_dir();
>                 if (home == NULL) {
>                         /* Fallback in /tmp .. */
>                         home = "/tmp";
> -- 
> 1.7.11.7
> 
> 
> Amit Margalit
> IBM XIV - /Storage Reinvented/
> XIV-NAS Development Team
> Tel. 03-689-7774
> Fax. 03-689-7230
> 
> 
> 
> From:        Amit Margalit/Israel/IBM@IBMIL
> To:        David Goulet <dgoulet@efficios.com>
> Cc:        lttng-dev@lists.lttng.org
> Date:        06/13/2013 12:39 PM
> Subject:        Re: [lttng-dev] [RFC PATCH lttng-tools] Allow 
environment
> variable LTTNG_HOME to override HOME - for lttng-tools
> 
--------------------------------------------------------------------------------
> 
> 
> 
> I think I've done all that you suggested, for lttng-tools only, though, 
based on
> cfa9a5a2b4a96e0d6a9eeddd2622a6d7c173b7ac which is the latest master as 
of right now.
> 
> Here is the patch:
> From 5881718a60608d640ac1124c9c1f439a2a084707 Mon Sep 17 00:00:00 2001
> From: Amit Margalit <amitm@il.ibm.com>
> Date: Thu, 13 Jun 2013 12:35:13 +0300
> Subject: [PATCH] Using LTTNG_HOME environment variable if exists, with
> fallback to HOME
> 
> ---
> [Old patch deleted]
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> 



--=_alternative 00269168C2257B8E_=
Content-Type: text/html; charset="US-ASCII"

<font size=2 face="sans-serif">As requested the patch file is attached.</font>
<br>
<br>
<br><font size=2 face="sans-serif">It is based on top of 3a68137cb2a86e7e8b13239fee52cae4542605af
.</font>
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
&nbsp;</font><font size=1 face="sans-serif">06/17/2013 10:44 PM</font>
<br><font size=1 color=#5f5f5f face="sans-serif">Subject: &nbsp; &nbsp;
&nbsp; &nbsp;</font><font size=1 face="sans-serif">Re: [lttng-dev]
[RFC PATCH lttng-tools] Allow environment variable LTTNG_HOME to override
HOME - for lttng-tools - UPDATED PATCH</font>
<br>
<hr noshade>
<br>
<br>
<br><tt><font size=2>Hi Amit,<br>
<br>
There seems to be a problem with this patch, I can't merge it due to some<br>
malformed part of it...<br>
<br>
Did you use &quot;git send-email&quot; ? If you don't have that, either
attach the &quot;git<br>
format-patch&quot; to the email, the &quot;git log -1&quot; or the diff
in a separate file.<br>
<br>
Thanks!<br>
David<br>
<br>
Amit Margalit:<br>
&gt; Hi,<br>
&gt; <br>
&gt; I've added a paragraph to the man page. Here is the new patch:<br>
&gt; From a72bd9dd6a58ac727280f2f9a85ee80607f1aba9 Mon Sep 17 00:00:00
2001<br>
&gt; From: Amit Margalit &lt;amitm@il.ibm.com&gt;<br>
&gt; Date: Thu, 13 Jun 2013 12:35:13 +0300<br>
&gt; Subject: [PATCH] Using LTTNG_HOME environment variable if exists,
with<br>
&gt; fallback to HOME<br>
&gt; <br>
&gt; ---<br>
&gt; doc/man/lttng.1 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
| &nbsp;4 ++++<br>
&gt; src/bin/lttng-relayd/utils.c &nbsp; &nbsp;| 10 +---------<br>
&gt; src/bin/lttng-sessiond/main.c &nbsp; | &nbsp;2 +-<br>
&gt; src/bin/lttng-sessiond/utils.c &nbsp;| 10 ----------<br>
&gt; src/bin/lttng/commands/create.c | &nbsp;2 +-<br>
&gt; src/bin/lttng/conf.c &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;| 13
+++----------<br>
&gt; src/bin/lttng/conf.h &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;| &nbsp;1
-<br>
&gt; src/bin/lttng/utils.c &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; | &nbsp;3
++-<br>
&gt; src/common/defaults.h &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; | &nbsp;2
++<br>
&gt; src/common/utils.c &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;|
15 +++++++++++++++<br>
&gt; src/common/utils.h &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;|
&nbsp;1 +<br>
&gt; src/lib/lttng-ctl/lttng-ctl.c &nbsp; | &nbsp;5 +++--<br>
&gt; 12 files changed, 33 insertions(+), 35 deletions(-)<br>
&gt; <br>
&gt; diff --git a/doc/man/lttng.1 b/doc/man/lttng.1<br>
&gt; index f472d38..26fd44a 100644<br>
&gt; --- a/doc/man/lttng.1<br>
&gt; +++ b/doc/man/lttng.1<br>
&gt; @@ -214,6 +214,10 @@ automatically created having this form: 'auto-yyyymmdd-hhmmss'.<br>
&gt; <br>
&gt; If no \fB\-o, \-\-output\fP is specified, the traces will be written
in<br>
&gt; $HOME/lttng-traces.<br>
&gt; +<br>
&gt; +The $HOME environment variable can be overridden by defining the
environment<br>
&gt; +variable LTTNG_HOME. This is useful when the user running the commands
has<br>
&gt; +a non-writeable home directory.<br>
&gt; .fi<br>
&gt; <br>
&gt; .B OPTIONS:<br>
&gt; diff --git a/src/bin/lttng-relayd/utils.c b/src/bin/lttng-relayd/utils.c<br>
&gt; index ad13d32..392fab6 100644<br>
&gt; --- a/src/bin/lttng-relayd/utils.c<br>
&gt; +++ b/src/bin/lttng-relayd/utils.c<br>
&gt; @@ -29,14 +29,6 @@<br>
&gt; #include &quot;lttng-relayd.h&quot;<br>
&gt; #include &quot;utils.h&quot;<br>
&gt; <br>
&gt; -/*<br>
&gt; - * Returns the HOME directory path. Caller MUST NOT free(3) the return
pointer.<br>
&gt; - */<br>
&gt; -static char *get_default_path(void)<br>
&gt; -{<br>
&gt; - &nbsp; &nbsp; &nbsp; &nbsp;return getenv(&quot;HOME&quot;);<br>
&gt; -}<br>
&gt; -<br>
&gt; static char *create_output_path_auto(char *path_name)<br>
&gt; {<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; int ret;<br>
&gt; @@ -44,7 +36,7 @@ static char *create_output_path_auto(char *path_name)<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;char *alloc_path = NULL;<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; char *default_path;<br>
&gt; <br>
&gt; - &nbsp; &nbsp; &nbsp; &nbsp;default_path = get_default_path();<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp;default_path = utils_get_home_dir();<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; if (default_path == NULL) {<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ERR(&quot;Home
path not found.\n \<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Please specify an output path
using -o, --output<br>
&gt; PATH&quot;);<br>
&gt; diff --git a/src/bin/lttng-sessiond/main.c b/src/bin/lttng-sessiond/main.c<br>
&gt; index 4470afc..256ffba 100644<br>
&gt; --- a/src/bin/lttng-sessiond/main.c<br>
&gt; +++ b/src/bin/lttng-sessiond/main.c<br>
&gt; @@ -4136,7 +4136,7 @@ int main(int argc, char **argv)<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; DBG2(&quot;Kernel
consumer cmd path: %s&quot;,<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; kconsumer_data.cmd_unix_sock_path);<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; } else {<br>
&gt; - &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;home_path
= get_home_dir();<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;home_path
= utils_get_home_dir();<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; if (home_path
== NULL) {<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; /* TODO: Add --socket PATH option */<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; ERR(&quot;Can't get HOME directory for sockets creation.&quot;);<br>
&gt; diff --git a/src/bin/lttng-sessiond/utils.c b/src/bin/lttng-sessiond/utils.c<br>
&gt; index 5ea3374..af42ad0 100644<br>
&gt; --- a/src/bin/lttng-sessiond/utils.c<br>
&gt; +++ b/src/bin/lttng-sessiond/utils.c<br>
&gt; @@ -45,13 +45,3 @@ int notify_thread_pipe(int wpipe)<br>
&gt; <br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; return ret;<br>
&gt; }<br>
&gt; -<br>
&gt; -/*<br>
&gt; - * Return pointer to home directory path using the env variable HOME.<br>
&gt; - *<br>
&gt; - * No home, NULL is returned.<br>
&gt; - */<br>
&gt; -const char *get_home_dir(void)<br>
&gt; -{<br>
&gt; - &nbsp; &nbsp; &nbsp; &nbsp;return ((const char *) getenv(&quot;HOME&quot;));<br>
&gt; -}<br>
&gt; diff --git a/src/bin/lttng/commands/create.c b/src/bin/lttng/commands/create.c<br>
&gt; index 805cdb1..ddd2983 100644<br>
&gt; --- a/src/bin/lttng/commands/create.c<br>
&gt; +++ b/src/bin/lttng/commands/create.c<br>
&gt; @@ -250,7 +250,7 @@ static int create_session(void)<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; print_str_url
= url;<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; } else {<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; /* Auto output
path */<br>
&gt; - &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;alloc_path
= config_get_default_path();<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;alloc_path
= utils_get_home_dir();<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; if (alloc_path
== NULL) {<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; ERR(&quot;HOME path not found.\n \<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Please
specify an output path using -o,<br>
&gt; --output PATH&quot;);<br>
&gt; diff --git a/src/bin/lttng/conf.c b/src/bin/lttng/conf.c<br>
&gt; index b6632fc..5a0da9d 100644<br>
&gt; --- a/src/bin/lttng/conf.c<br>
&gt; +++ b/src/bin/lttng/conf.c<br>
&gt; @@ -25,6 +25,7 @@<br>
&gt; #include &lt;unistd.h&gt;<br>
&gt; <br>
&gt; #include &lt;common/error.h&gt;<br>
&gt; +#include &lt;common/utils.h&gt;<br>
&gt; <br>
&gt; #include &quot;conf.h&quot;<br>
&gt; <br>
&gt; @@ -123,14 +124,6 @@ end:<br>
&gt; }<br>
&gt; <br>
&gt; /*<br>
&gt; - * Returns the HOME directory path. Caller MUST NOT free(3) the return
pointer.<br>
&gt; - */<br>
&gt; -char *config_get_default_path(void)<br>
&gt; -{<br>
&gt; - &nbsp; &nbsp; &nbsp; &nbsp;return getenv(&quot;HOME&quot;);<br>
&gt; -}<br>
&gt; -<br>
&gt; -/*<br>
&gt; &nbsp;* Destroys directory config and file config.<br>
&gt; &nbsp;*/<br>
&gt; void config_destroy(char *path)<br>
&gt; @@ -161,7 +154,7 @@ end:<br>
&gt; &nbsp;*/<br>
&gt; void config_destroy_default(void)<br>
&gt; {<br>
&gt; - &nbsp; &nbsp; &nbsp; &nbsp;char *path = config_get_default_path();<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp;char *path = utils_get_home_dir();<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; if (path == NULL) {<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; return;<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; }<br>
&gt; @@ -277,7 +270,7 @@ int config_init(char *session_name)<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; int ret;<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; char *path;<br>
&gt; <br>
&gt; - &nbsp; &nbsp; &nbsp; &nbsp;path = config_get_default_path();<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp;path = utils_get_home_dir();<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; if (path == NULL) {<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ret = -1;<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; goto error;<br>
&gt; diff --git a/src/bin/lttng/conf.h b/src/bin/lttng/conf.h<br>
&gt; index 2cb04b0..3bed59c 100644<br>
&gt; --- a/src/bin/lttng/conf.h<br>
&gt; +++ b/src/bin/lttng/conf.h<br>
&gt; @@ -25,7 +25,6 @@ void config_destroy_default(void);<br>
&gt; int config_exists(const char *path);<br>
&gt; int config_init(char *path);<br>
&gt; int config_add_session_name(char *path, char *name);<br>
&gt; -char *config_get_default_path(void);<br>
&gt; <br>
&gt; /* Must free() the return pointer */<br>
&gt; char *config_read_session_name(char *path);<br>
&gt; diff --git a/src/bin/lttng/utils.c b/src/bin/lttng/utils.c<br>
&gt; index 94c4527..6041655 100644<br>
&gt; --- a/src/bin/lttng/utils.c<br>
&gt; +++ b/src/bin/lttng/utils.c<br>
&gt; @@ -21,6 +21,7 @@<br>
&gt; #include &lt;limits.h&gt;<br>
&gt; <br>
&gt; #include &lt;common/error.h&gt;<br>
&gt; +#include &lt;common/utils.h&gt;<br>
&gt; <br>
&gt; #include &quot;conf.h&quot;<br>
&gt; #include &quot;utils.h&quot;<br>
&gt; @@ -36,7 +37,7 @@ char *get_session_name(void)<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; char *path, *session_name = NULL;<br>
&gt; <br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; /* Get path to config file */<br>
&gt; - &nbsp; &nbsp; &nbsp; &nbsp;path = config_get_default_path();<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp;path = utils_get_home_dir();<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; if (path == NULL) {<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; goto error;<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; }<br>
&gt; diff --git a/src/common/defaults.h b/src/common/defaults.h<br>
&gt; index 66bb972..c040634 100644<br>
&gt; --- a/src/common/defaults.h<br>
&gt; +++ b/src/common/defaults.h<br>
&gt; @@ -77,6 +77,8 @@<br>
&gt; #define DEFAULT_USTCONSUMERD32_ERR_SOCK_PATH &nbsp; &nbsp;DEFAULT_USTCONSUMERD32_PATH
&quot;/error&quot;<br>
&gt; <br>
&gt; /* Default lttng run directory */<br>
&gt; +#define DEFAULT_LTTNG_HOME_ENV_VAR &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp;&quot;LTTNG_HOME&quot;<br>
&gt; +#define DEFAULT_LTTNG_FALLBACK_HOME_ENV_VAR &nbsp; &nbsp; &nbsp;
&nbsp;&quot;HOME&quot;<br>
&gt; #define DEFAULT_LTTNG_RUNDIR &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp;&quot;/var/run/lttng&quot;<br>
&gt; #define DEFAULT_LTTNG_HOME_RUNDIR &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &quot;%s/.lttng&quot;<br>
&gt; #define DEFAULT_LTTNG_SESSIOND_PIDFILE &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp;&quot;lttng-sessiond.pid&quot;<br>
&gt; diff --git a/src/common/utils.c b/src/common/utils.c<br>
&gt; index 38f78a7..436febe 100644<br>
&gt; --- a/src/common/utils.c<br>
&gt; +++ b/src/common/utils.c<br>
&gt; @@ -32,6 +32,7 @@<br>
&gt; #include &lt;common/runas.h&gt;<br>
&gt; <br>
&gt; #include &quot;utils.h&quot;<br>
&gt; +#include &quot;defaults.h&quot;<br>
&gt; <br>
&gt; /*<br>
&gt; &nbsp;* Return the realpath(3) of the path even if the last directory
token does not<br>
&gt; @@ -584,3 +585,17 @@ int utils_get_count_order_u32(uint32_t x)<br>
&gt; <br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; return fls_u32(x - 1);<br>
&gt; }<br>
&gt; +<br>
&gt; +/**<br>
&gt; + * Obtain the value of LTTNG_HOME environment variable, if exists.<br>
&gt; + * Otherwise returns the value of HOME.<br>
&gt; + */<br>
&gt; +char *utils_get_home_dir(void)<br>
&gt; +{<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp;char *val = NULL;<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp;val = getenv(DEFAULT_LTTNG_HOME_ENV_VAR);<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp;if (val != NULL) {<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;return val;<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp;}<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp;return getenv(DEFAULT_LTTNG_FALLBACK_HOME_ENV_VAR);<br>
&gt; +}<br>
&gt; diff --git a/src/common/utils.h b/src/common/utils.h<br>
&gt; index 083acef..9e6fb37 100644<br>
&gt; --- a/src/common/utils.h<br>
&gt; +++ b/src/common/utils.h<br>
&gt; @@ -40,5 +40,6 @@ int utils_rotate_stream_file(char *path_name, char
*file_name,<br>
&gt; uint64_t size,<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; uint64_t count,
int uid, int gid, int out_fd, uint64_t *new_count);<br>
&gt; int utils_parse_size_suffix(char *str, uint64_t *size);<br>
&gt; &nbsp;int utils_get_count_order_u32(uint32_t x);<br>
&gt; +char *utils_get_home_dir(void);<br>
&gt; <br>
&gt; #endif /* _COMMON_UTILS_H */<br>
&gt; diff --git a/src/lib/lttng-ctl/lttng-ctl.c b/src/lib/lttng-ctl/lttng-ctl.c<br>
&gt; index a7328eb..9d76f79 100644<br>
&gt; --- a/src/lib/lttng-ctl/lttng-ctl.c<br>
&gt; +++ b/src/lib/lttng-ctl/lttng-ctl.c<br>
&gt; @@ -32,6 +32,7 @@<br>
&gt; #include &lt;common/defaults.h&gt;<br>
&gt; #include &lt;common/sessiond-comm/sessiond-comm.h&gt;<br>
&gt; #include &lt;common/uri.h&gt;<br>
&gt; +#include &lt;common/utils.h&gt;<br>
&gt; #include &lt;lttng/lttng.h&gt;<br>
&gt; <br>
&gt; #include &quot;filter/filter-ast.h&quot;<br>
&gt; @@ -485,7 +486,7 @@ static int set_session_daemon_path(void)<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;* With
GNU C &gt;= 2.1, snprintf returns the required size<br>
&gt; (excluding closing null)<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;*/<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ret = snprintf(sessiond_sock_path,
sizeof(sessiond_sock_path),<br>
&gt; - &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;DEFAULT_HOME_CLIENT_UNIX_SOCK,
getenv(&quot;HOME&quot;));<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;DEFAULT_HOME_CLIENT_UNIX_SOCK,<br>
&gt; utils_get_home_dir());<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; if ((ret &lt;
0) || (ret &gt;= sizeof(sessiond_sock_path))) {<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; goto error;<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; }<br>
&gt; @@ -1543,7 +1544,7 @@ static int set_health_socket_path(void)<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;* With
GNU C &lt; &nbsp;2.1, snprintf returns -1 if the target buffer<br>
&gt; is too small;<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; * With
GNU C &gt;= 2.1, snprintf returns the required size<br>
&gt; (excluding closing null)<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;*/<br>
&gt; - &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;home = getenv(&quot;HOME&quot;);<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;home = utils_get_home_dir();<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; if (home ==
NULL) {<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; /* Fallback in /tmp .. */<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; home = &quot;/tmp&quot;;<br>
&gt; -- <br>
&gt; 1.7.11.7<br>
&gt; <br>
&gt; <br>
&gt; Amit Margalit<br>
&gt; IBM XIV - /Storage Reinvented/<br>
&gt; XIV-NAS Development Team<br>
&gt; Tel. 03-689-7774<br>
&gt; Fax. 03-689-7230<br>
&gt; <br>
&gt; <br>
&gt; <br>
&gt; From: &nbsp; &nbsp; &nbsp; &nbsp;Amit Margalit/Israel/IBM@IBMIL<br>
&gt; To: &nbsp; &nbsp; &nbsp; &nbsp;David Goulet &lt;dgoulet@efficios.com&gt;<br>
&gt; Cc: &nbsp; &nbsp; &nbsp; &nbsp;lttng-dev@lists.lttng.org<br>
&gt; Date: &nbsp; &nbsp; &nbsp; &nbsp;06/13/2013 12:39 PM<br>
&gt; Subject: &nbsp; &nbsp; &nbsp; &nbsp;Re: [lttng-dev] [RFC PATCH lttng-tools]
Allow environment<br>
&gt; variable LTTNG_HOME to override HOME - for lttng-tools<br>
&gt; --------------------------------------------------------------------------------<br>
&gt; <br>
&gt; <br>
&gt; <br>
&gt; I think I've done all that you suggested, for lttng-tools only, though,
based on<br>
&gt; cfa9a5a2b4a96e0d6a9eeddd2622a6d7c173b7ac which is the latest master
as of right now.<br>
&gt; <br>
&gt; Here is the patch:<br>
&gt; From 5881718a60608d640ac1124c9c1f439a2a084707 Mon Sep 17 00:00:00
2001<br>
&gt; From: Amit Margalit &lt;amitm@il.ibm.com&gt;<br>
&gt; Date: Thu, 13 Jun 2013 12:35:13 +0300<br>
&gt; Subject: [PATCH] Using LTTNG_HOME environment variable if exists,
with<br>
&gt; fallback to HOME<br>
&gt; <br>
&gt; ---<br>
&gt; [Old patch deleted]<br>
&gt; _______________________________________________<br>
&gt; lttng-dev mailing list<br>
&gt; lttng-dev@lists.lttng.org<br>
&gt; </font></tt><a href="http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev"><tt><font size=2>http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev</font></tt></a><tt><font size=2><br>
&gt; <br>
<br>
</font></tt>
<br>
--=_alternative 00269168C2257B8E_=--

--=_mixed 00269168C2257B8E_=
Content-Type: application/octet-stream; name="0001-Using-LTTNG_HOME-environment-variable-if-exists-with.patch"
Content-Disposition: attachment; filename="0001-Using-LTTNG_HOME-environment-variable-if-exists-with.patch"
Content-Transfer-Encoding: base64

RnJvbSAwMDNkZDIyMDU0YzVhNDlkZmVhYzIzNGJlOTYwMGI4ZmQzNTMyMmQzIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbWl0IE1hcmdhbGl0IDxhbWl0bUBpbC5pYm0uY29tPgpEYXRl
OiBUaHUsIDEzIEp1biAyMDEzIDEyOjM1OjEzICswMzAwClN1YmplY3Q6IFtQQVRDSF0gVXNpbmcg
TFRUTkdfSE9NRSBlbnZpcm9ubWVudCB2YXJpYWJsZSBpZiBleGlzdHMsIHdpdGgKIGZhbGxiYWNr
IHRvIEhPTUUKCi0tLQogZG9jL21hbi9sdHRuZy4xICAgICAgICAgICAgICAgICB8ICA0ICsrKysK
IHNyYy9iaW4vbHR0bmctcmVsYXlkL3V0aWxzLmMgICAgfCAxMCArLS0tLS0tLS0tCiBzcmMvYmlu
L2x0dG5nLXNlc3Npb25kL21haW4uYyAgIHwgIDIgKy0KIHNyYy9iaW4vbHR0bmctc2Vzc2lvbmQv
dXRpbHMuYyAgfCAxMCAtLS0tLS0tLS0tCiBzcmMvYmluL2x0dG5nL2NvbW1hbmRzL2NyZWF0ZS5j
IHwgIDIgKy0KIHNyYy9iaW4vbHR0bmcvY29uZi5jICAgICAgICAgICAgfCAxMyArKystLS0tLS0t
LS0tCiBzcmMvYmluL2x0dG5nL2NvbmYuaCAgICAgICAgICAgIHwgIDEgLQogc3JjL2Jpbi9sdHRu
Zy91dGlscy5jICAgICAgICAgICB8ICAzICsrLQogc3JjL2NvbW1vbi9kZWZhdWx0cy5oICAgICAg
ICAgICB8ICAyICsrCiBzcmMvY29tbW9uL3V0aWxzLmMgICAgICAgICAgICAgIHwgMTUgKysrKysr
KysrKysrKysrCiBzcmMvY29tbW9uL3V0aWxzLmggICAgICAgICAgICAgIHwgIDEgKwogc3JjL2xp
Yi9sdHRuZy1jdGwvbHR0bmctY3RsLmMgICB8ICA1ICsrKy0tCiAxMiBmaWxlcyBjaGFuZ2VkLCAz
MyBpbnNlcnRpb25zKCspLCAzNSBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kb2MvbWFuL2x0
dG5nLjEgYi9kb2MvbWFuL2x0dG5nLjEKaW5kZXggZjQ3MmQzOC4uMjZmZDQ0YSAxMDA2NDQKLS0t
IGEvZG9jL21hbi9sdHRuZy4xCisrKyBiL2RvYy9tYW4vbHR0bmcuMQpAQCAtMjE0LDYgKzIxNCwx
MCBAQCBhdXRvbWF0aWNhbGx5IGNyZWF0ZWQgaGF2aW5nIHRoaXMgZm9ybTogJ2F1dG8teXl5eW1t
ZGQtaGhtbXNzJy4KIAogSWYgbm8gXGZCXC1vLCBcLVwtb3V0cHV0XGZQIGlzIHNwZWNpZmllZCwg
dGhlIHRyYWNlcyB3aWxsIGJlIHdyaXR0ZW4gaW4KICRIT01FL2x0dG5nLXRyYWNlcy4KKworVGhl
ICRIT01FIGVudmlyb25tZW50IHZhcmlhYmxlIGNhbiBiZSBvdmVycmlkZGVuIGJ5IGRlZmluaW5n
IHRoZSBlbnZpcm9ubWVudAordmFyaWFibGUgTFRUTkdfSE9NRS4gVGhpcyBpcyB1c2VmdWwgd2hl
biB0aGUgdXNlciBydW5uaW5nIHRoZSBjb21tYW5kcyBoYXMKK2Egbm9uLXdyaXRlYWJsZSBob21l
IGRpcmVjdG9yeS4KIC5maQogCiAuQiBPUFRJT05TOgpkaWZmIC0tZ2l0IGEvc3JjL2Jpbi9sdHRu
Zy1yZWxheWQvdXRpbHMuYyBiL3NyYy9iaW4vbHR0bmctcmVsYXlkL3V0aWxzLmMKaW5kZXggYWQx
M2QzMi4uMzkyZmFiNiAxMDA2NDQKLS0tIGEvc3JjL2Jpbi9sdHRuZy1yZWxheWQvdXRpbHMuYwor
KysgYi9zcmMvYmluL2x0dG5nLXJlbGF5ZC91dGlscy5jCkBAIC0yOSwxNCArMjksNiBAQAogI2lu
Y2x1ZGUgImx0dG5nLXJlbGF5ZC5oIgogI2luY2x1ZGUgInV0aWxzLmgiCiAKLS8qCi0gKiBSZXR1
cm5zIHRoZSBIT01FIGRpcmVjdG9yeSBwYXRoLiBDYWxsZXIgTVVTVCBOT1QgZnJlZSgzKSB0aGUg
cmV0dXJuIHBvaW50ZXIuCi0gKi8KLXN0YXRpYyBjaGFyICpnZXRfZGVmYXVsdF9wYXRoKHZvaWQp
Ci17Ci0JcmV0dXJuIGdldGVudigiSE9NRSIpOwotfQotCiBzdGF0aWMgY2hhciAqY3JlYXRlX291
dHB1dF9wYXRoX2F1dG8oY2hhciAqcGF0aF9uYW1lKQogewogCWludCByZXQ7CkBAIC00NCw3ICsz
Niw3IEBAIHN0YXRpYyBjaGFyICpjcmVhdGVfb3V0cHV0X3BhdGhfYXV0byhjaGFyICpwYXRoX25h
bWUpCiAJY2hhciAqYWxsb2NfcGF0aCA9IE5VTEw7CiAJY2hhciAqZGVmYXVsdF9wYXRoOwogCi0J
ZGVmYXVsdF9wYXRoID0gZ2V0X2RlZmF1bHRfcGF0aCgpOworCWRlZmF1bHRfcGF0aCA9IHV0aWxz
X2dldF9ob21lX2RpcigpOwogCWlmIChkZWZhdWx0X3BhdGggPT0gTlVMTCkgewogCQlFUlIoIkhv
bWUgcGF0aCBub3QgZm91bmQuXG4gXAogCQkJCVBsZWFzZSBzcGVjaWZ5IGFuIG91dHB1dCBwYXRo
IHVzaW5nIC1vLCAtLW91dHB1dCBQQVRIIik7CmRpZmYgLS1naXQgYS9zcmMvYmluL2x0dG5nLXNl
c3Npb25kL21haW4uYyBiL3NyYy9iaW4vbHR0bmctc2Vzc2lvbmQvbWFpbi5jCmluZGV4IDc0NmYy
MWUuLmY4MGY0MWEgMTAwNjQ0Ci0tLSBhL3NyYy9iaW4vbHR0bmctc2Vzc2lvbmQvbWFpbi5jCisr
KyBiL3NyYy9iaW4vbHR0bmctc2Vzc2lvbmQvbWFpbi5jCkBAIC00MjYxLDcgKzQyNjEsNyBAQCBp
bnQgbWFpbihpbnQgYXJnYywgY2hhciAqKmFyZ3YpCiAJCURCRzIoIktlcm5lbCBjb25zdW1lciBj
bWQgcGF0aDogJXMiLAogCQkJCWtjb25zdW1lcl9kYXRhLmNtZF91bml4X3NvY2tfcGF0aCk7CiAJ
fSBlbHNlIHsKLQkJaG9tZV9wYXRoID0gZ2V0X2hvbWVfZGlyKCk7CisJCWhvbWVfcGF0aCA9IHV0
aWxzX2dldF9ob21lX2RpcigpOwogCQlpZiAoaG9tZV9wYXRoID09IE5VTEwpIHsKIAkJCS8qIFRP
RE86IEFkZCAtLXNvY2tldCBQQVRIIG9wdGlvbiAqLwogCQkJRVJSKCJDYW4ndCBnZXQgSE9NRSBk
aXJlY3RvcnkgZm9yIHNvY2tldHMgY3JlYXRpb24uIik7CmRpZmYgLS1naXQgYS9zcmMvYmluL2x0
dG5nLXNlc3Npb25kL3V0aWxzLmMgYi9zcmMvYmluL2x0dG5nLXNlc3Npb25kL3V0aWxzLmMKaW5k
ZXggMzU4ZTQwNy4uODVhMWYwMiAxMDA2NDQKLS0tIGEvc3JjL2Jpbi9sdHRuZy1zZXNzaW9uZC91
dGlscy5jCisrKyBiL3NyYy9iaW4vbHR0bmctc2Vzc2lvbmQvdXRpbHMuYwpAQCAtNDksMTYgKzQ5
LDYgQEAgaW50IG5vdGlmeV90aHJlYWRfcGlwZShpbnQgd3BpcGUpCiAJcmV0dXJuIHJldDsKIH0K
IAotLyoKLSAqIFJldHVybiBwb2ludGVyIHRvIGhvbWUgZGlyZWN0b3J5IHBhdGggdXNpbmcgdGhl
IGVudiB2YXJpYWJsZSBIT01FLgotICoKLSAqIE5vIGhvbWUsIE5VTEwgaXMgcmV0dXJuZWQuCi0g
Ki8KLWNvbnN0IGNoYXIgKmdldF9ob21lX2Rpcih2b2lkKQotewotCXJldHVybiAoKGNvbnN0IGNo
YXIgKikgZ2V0ZW52KCJIT01FIikpOwotfQotCiB2b2lkIGh0X2NsZWFudXBfcHVzaChzdHJ1Y3Qg
bHR0bmdfaHQgKmh0KQogewogCWludCByZXQ7CmRpZmYgLS1naXQgYS9zcmMvYmluL2x0dG5nL2Nv
bW1hbmRzL2NyZWF0ZS5jIGIvc3JjL2Jpbi9sdHRuZy9jb21tYW5kcy9jcmVhdGUuYwppbmRleCA4
MDVjZGIxLi5kZGQyOTgzIDEwMDY0NAotLS0gYS9zcmMvYmluL2x0dG5nL2NvbW1hbmRzL2NyZWF0
ZS5jCisrKyBiL3NyYy9iaW4vbHR0bmcvY29tbWFuZHMvY3JlYXRlLmMKQEAgLTI1MCw3ICsyNTAs
NyBAQCBzdGF0aWMgaW50IGNyZWF0ZV9zZXNzaW9uKHZvaWQpCiAJCXByaW50X3N0cl91cmwgPSB1
cmw7CiAJfSBlbHNlIHsKIAkJLyogQXV0byBvdXRwdXQgcGF0aCAqLwotCQlhbGxvY19wYXRoID0g
Y29uZmlnX2dldF9kZWZhdWx0X3BhdGgoKTsKKwkJYWxsb2NfcGF0aCA9IHV0aWxzX2dldF9ob21l
X2RpcigpOwogCQlpZiAoYWxsb2NfcGF0aCA9PSBOVUxMKSB7CiAJCQlFUlIoIkhPTUUgcGF0aCBu
b3QgZm91bmQuXG4gXAogCQkJCQlQbGVhc2Ugc3BlY2lmeSBhbiBvdXRwdXQgcGF0aCB1c2luZyAt
bywgLS1vdXRwdXQgUEFUSCIpOwpkaWZmIC0tZ2l0IGEvc3JjL2Jpbi9sdHRuZy9jb25mLmMgYi9z
cmMvYmluL2x0dG5nL2NvbmYuYwppbmRleCBiNjYzMmZjLi41YTBkYTlkIDEwMDY0NAotLS0gYS9z
cmMvYmluL2x0dG5nL2NvbmYuYworKysgYi9zcmMvYmluL2x0dG5nL2NvbmYuYwpAQCAtMjUsNiAr
MjUsNyBAQAogI2luY2x1ZGUgPHVuaXN0ZC5oPgogCiAjaW5jbHVkZSA8Y29tbW9uL2Vycm9yLmg+
CisjaW5jbHVkZSA8Y29tbW9uL3V0aWxzLmg+CiAKICNpbmNsdWRlICJjb25mLmgiCiAKQEAgLTEy
MywxNCArMTI0LDYgQEAgZW5kOgogfQogCiAvKgotICogUmV0dXJucyB0aGUgSE9NRSBkaXJlY3Rv
cnkgcGF0aC4gQ2FsbGVyIE1VU1QgTk9UIGZyZWUoMykgdGhlIHJldHVybiBwb2ludGVyLgotICov
Ci1jaGFyICpjb25maWdfZ2V0X2RlZmF1bHRfcGF0aCh2b2lkKQotewotCXJldHVybiBnZXRlbnYo
IkhPTUUiKTsKLX0KLQotLyoKICAqIERlc3Ryb3lzIGRpcmVjdG9yeSBjb25maWcgYW5kIGZpbGUg
Y29uZmlnLgogICovCiB2b2lkIGNvbmZpZ19kZXN0cm95KGNoYXIgKnBhdGgpCkBAIC0xNjEsNyAr
MTU0LDcgQEAgZW5kOgogICovCiB2b2lkIGNvbmZpZ19kZXN0cm95X2RlZmF1bHQodm9pZCkKIHsK
LQljaGFyICpwYXRoID0gY29uZmlnX2dldF9kZWZhdWx0X3BhdGgoKTsKKwljaGFyICpwYXRoID0g
dXRpbHNfZ2V0X2hvbWVfZGlyKCk7CiAJaWYgKHBhdGggPT0gTlVMTCkgewogCQlyZXR1cm47CiAJ
fQpAQCAtMjc3LDcgKzI3MCw3IEBAIGludCBjb25maWdfaW5pdChjaGFyICpzZXNzaW9uX25hbWUp
CiAJaW50IHJldDsKIAljaGFyICpwYXRoOwogCi0JcGF0aCA9IGNvbmZpZ19nZXRfZGVmYXVsdF9w
YXRoKCk7CisJcGF0aCA9IHV0aWxzX2dldF9ob21lX2RpcigpOwogCWlmIChwYXRoID09IE5VTEwp
IHsKIAkJcmV0ID0gLTE7CiAJCWdvdG8gZXJyb3I7CmRpZmYgLS1naXQgYS9zcmMvYmluL2x0dG5n
L2NvbmYuaCBiL3NyYy9iaW4vbHR0bmcvY29uZi5oCmluZGV4IDJjYjA0YjAuLjNiZWQ1OWMgMTAw
NjQ0Ci0tLSBhL3NyYy9iaW4vbHR0bmcvY29uZi5oCisrKyBiL3NyYy9iaW4vbHR0bmcvY29uZi5o
CkBAIC0yNSw3ICsyNSw2IEBAIHZvaWQgY29uZmlnX2Rlc3Ryb3lfZGVmYXVsdCh2b2lkKTsKIGlu
dCBjb25maWdfZXhpc3RzKGNvbnN0IGNoYXIgKnBhdGgpOwogaW50IGNvbmZpZ19pbml0KGNoYXIg
KnBhdGgpOwogaW50IGNvbmZpZ19hZGRfc2Vzc2lvbl9uYW1lKGNoYXIgKnBhdGgsIGNoYXIgKm5h
bWUpOwotY2hhciAqY29uZmlnX2dldF9kZWZhdWx0X3BhdGgodm9pZCk7CiAKIC8qIE11c3QgZnJl
ZSgpIHRoZSByZXR1cm4gcG9pbnRlciAqLwogY2hhciAqY29uZmlnX3JlYWRfc2Vzc2lvbl9uYW1l
KGNoYXIgKnBhdGgpOwpkaWZmIC0tZ2l0IGEvc3JjL2Jpbi9sdHRuZy91dGlscy5jIGIvc3JjL2Jp
bi9sdHRuZy91dGlscy5jCmluZGV4IDk0YzQ1MjcuLjYwNDE2NTUgMTAwNjQ0Ci0tLSBhL3NyYy9i
aW4vbHR0bmcvdXRpbHMuYworKysgYi9zcmMvYmluL2x0dG5nL3V0aWxzLmMKQEAgLTIxLDYgKzIx
LDcgQEAKICNpbmNsdWRlIDxsaW1pdHMuaD4KIAogI2luY2x1ZGUgPGNvbW1vbi9lcnJvci5oPgor
I2luY2x1ZGUgPGNvbW1vbi91dGlscy5oPgogCiAjaW5jbHVkZSAiY29uZi5oIgogI2luY2x1ZGUg
InV0aWxzLmgiCkBAIC0zNiw3ICszNyw3IEBAIGNoYXIgKmdldF9zZXNzaW9uX25hbWUodm9pZCkK
IAljaGFyICpwYXRoLCAqc2Vzc2lvbl9uYW1lID0gTlVMTDsKIAogCS8qIEdldCBwYXRoIHRvIGNv
bmZpZyBmaWxlICovCi0JcGF0aCA9IGNvbmZpZ19nZXRfZGVmYXVsdF9wYXRoKCk7CisJcGF0aCA9
IHV0aWxzX2dldF9ob21lX2RpcigpOwogCWlmIChwYXRoID09IE5VTEwpIHsKIAkJZ290byBlcnJv
cjsKIAl9CmRpZmYgLS1naXQgYS9zcmMvY29tbW9uL2RlZmF1bHRzLmggYi9zcmMvY29tbW9uL2Rl
ZmF1bHRzLmgKaW5kZXggNjZiYjk3Mi4uYzA0MDYzNCAxMDA2NDQKLS0tIGEvc3JjL2NvbW1vbi9k
ZWZhdWx0cy5oCisrKyBiL3NyYy9jb21tb24vZGVmYXVsdHMuaApAQCAtNzcsNiArNzcsOCBAQAog
I2RlZmluZSBERUZBVUxUX1VTVENPTlNVTUVSRDMyX0VSUl9TT0NLX1BBVEggICAgREVGQVVMVF9V
U1RDT05TVU1FUkQzMl9QQVRIICIvZXJyb3IiCiAKIC8qIERlZmF1bHQgbHR0bmcgcnVuIGRpcmVj
dG9yeSAqLworI2RlZmluZSBERUZBVUxUX0xUVE5HX0hPTUVfRU5WX1ZBUiAgICAgICAgICAgICAg
IkxUVE5HX0hPTUUiCisjZGVmaW5lIERFRkFVTFRfTFRUTkdfRkFMTEJBQ0tfSE9NRV9FTlZfVkFS
CSJIT01FIgogI2RlZmluZSBERUZBVUxUX0xUVE5HX1JVTkRJUiAgICAgICAgICAgICAgICAgICAg
Ii92YXIvcnVuL2x0dG5nIgogI2RlZmluZSBERUZBVUxUX0xUVE5HX0hPTUVfUlVORElSICAgICAg
ICAgICAgICAgIiVzLy5sdHRuZyIKICNkZWZpbmUgREVGQVVMVF9MVFROR19TRVNTSU9ORF9QSURG
SUxFICAgICAgICAgICJsdHRuZy1zZXNzaW9uZC5waWQiCmRpZmYgLS1naXQgYS9zcmMvY29tbW9u
L3V0aWxzLmMgYi9zcmMvY29tbW9uL3V0aWxzLmMKaW5kZXggMzhmNzhhNy4uNDM2ZmViZSAxMDA2
NDQKLS0tIGEvc3JjL2NvbW1vbi91dGlscy5jCisrKyBiL3NyYy9jb21tb24vdXRpbHMuYwpAQCAt
MzIsNiArMzIsNyBAQAogI2luY2x1ZGUgPGNvbW1vbi9ydW5hcy5oPgogCiAjaW5jbHVkZSAidXRp
bHMuaCIKKyNpbmNsdWRlICJkZWZhdWx0cy5oIgogCiAvKgogICogUmV0dXJuIHRoZSByZWFscGF0
aCgzKSBvZiB0aGUgcGF0aCBldmVuIGlmIHRoZSBsYXN0IGRpcmVjdG9yeSB0b2tlbiBkb2VzIG5v
dApAQCAtNTg0LDMgKzU4NSwxNyBAQCBpbnQgdXRpbHNfZ2V0X2NvdW50X29yZGVyX3UzMih1aW50
MzJfdCB4KQogCiAJcmV0dXJuIGZsc191MzIoeCAtIDEpOwogfQorCisvKioKKyAqIE9idGFpbiB0
aGUgdmFsdWUgb2YgTFRUTkdfSE9NRSBlbnZpcm9ubWVudCB2YXJpYWJsZSwgaWYgZXhpc3RzLgor
ICogT3RoZXJ3aXNlIHJldHVybnMgdGhlIHZhbHVlIG9mIEhPTUUuCisgKi8KK2NoYXIgKnV0aWxz
X2dldF9ob21lX2Rpcih2b2lkKQoreworCWNoYXIgKnZhbCA9IE5VTEw7CisJdmFsID0gZ2V0ZW52
KERFRkFVTFRfTFRUTkdfSE9NRV9FTlZfVkFSKTsKKwlpZiAodmFsICE9IE5VTEwpIHsKKwkJcmV0
dXJuIHZhbDsKKwl9CisJcmV0dXJuIGdldGVudihERUZBVUxUX0xUVE5HX0ZBTExCQUNLX0hPTUVf
RU5WX1ZBUik7Cit9CmRpZmYgLS1naXQgYS9zcmMvY29tbW9uL3V0aWxzLmggYi9zcmMvY29tbW9u
L3V0aWxzLmgKaW5kZXggMDgzYWNlZi4uOWU2ZmIzNyAxMDA2NDQKLS0tIGEvc3JjL2NvbW1vbi91
dGlscy5oCisrKyBiL3NyYy9jb21tb24vdXRpbHMuaApAQCAtNDAsNSArNDAsNiBAQCBpbnQgdXRp
bHNfcm90YXRlX3N0cmVhbV9maWxlKGNoYXIgKnBhdGhfbmFtZSwgY2hhciAqZmlsZV9uYW1lLCB1
aW50NjRfdCBzaXplLAogCQl1aW50NjRfdCBjb3VudCwgaW50IHVpZCwgaW50IGdpZCwgaW50IG91
dF9mZCwgdWludDY0X3QgKm5ld19jb3VudCk7CiBpbnQgdXRpbHNfcGFyc2Vfc2l6ZV9zdWZmaXgo
Y2hhciAqc3RyLCB1aW50NjRfdCAqc2l6ZSk7CiBpbnQgdXRpbHNfZ2V0X2NvdW50X29yZGVyX3Uz
Mih1aW50MzJfdCB4KTsKK2NoYXIgKnV0aWxzX2dldF9ob21lX2Rpcih2b2lkKTsKIAogI2VuZGlm
IC8qIF9DT01NT05fVVRJTFNfSCAqLwpkaWZmIC0tZ2l0IGEvc3JjL2xpYi9sdHRuZy1jdGwvbHR0
bmctY3RsLmMgYi9zcmMvbGliL2x0dG5nLWN0bC9sdHRuZy1jdGwuYwppbmRleCBhNzMyOGViLi45
ZDc2Zjc5IDEwMDY0NAotLS0gYS9zcmMvbGliL2x0dG5nLWN0bC9sdHRuZy1jdGwuYworKysgYi9z
cmMvbGliL2x0dG5nLWN0bC9sdHRuZy1jdGwuYwpAQCAtMzIsNiArMzIsNyBAQAogI2luY2x1ZGUg
PGNvbW1vbi9kZWZhdWx0cy5oPgogI2luY2x1ZGUgPGNvbW1vbi9zZXNzaW9uZC1jb21tL3Nlc3Np
b25kLWNvbW0uaD4KICNpbmNsdWRlIDxjb21tb24vdXJpLmg+CisjaW5jbHVkZSA8Y29tbW9uL3V0
aWxzLmg+CiAjaW5jbHVkZSA8bHR0bmcvbHR0bmcuaD4KIAogI2luY2x1ZGUgImZpbHRlci9maWx0
ZXItYXN0LmgiCkBAIC00ODUsNyArNDg2LDcgQEAgc3RhdGljIGludCBzZXRfc2Vzc2lvbl9kYWVt
b25fcGF0aCh2b2lkKQogCQkgKiBXaXRoIEdOVSBDID49IDIuMSwgc25wcmludGYgcmV0dXJucyB0
aGUgcmVxdWlyZWQgc2l6ZSAoZXhjbHVkaW5nIGNsb3NpbmcgbnVsbCkKIAkJICovCiAJCXJldCA9
IHNucHJpbnRmKHNlc3Npb25kX3NvY2tfcGF0aCwgc2l6ZW9mKHNlc3Npb25kX3NvY2tfcGF0aCks
Ci0JCQkJREVGQVVMVF9IT01FX0NMSUVOVF9VTklYX1NPQ0ssIGdldGVudigiSE9NRSIpKTsKKwkJ
CQlERUZBVUxUX0hPTUVfQ0xJRU5UX1VOSVhfU09DSywgdXRpbHNfZ2V0X2hvbWVfZGlyKCkpOwog
CQlpZiAoKHJldCA8IDApIHx8IChyZXQgPj0gc2l6ZW9mKHNlc3Npb25kX3NvY2tfcGF0aCkpKSB7
CiAJCQlnb3RvIGVycm9yOwogCQl9CkBAIC0xNTQzLDcgKzE1NDQsNyBAQCBzdGF0aWMgaW50IHNl
dF9oZWFsdGhfc29ja2V0X3BhdGgodm9pZCkKIAkJICogV2l0aCBHTlUgQyA8ICAyLjEsIHNucHJp
bnRmIHJldHVybnMgLTEgaWYgdGhlIHRhcmdldCBidWZmZXIgaXMgdG9vIHNtYWxsOwogCQkgKiBX
aXRoIEdOVSBDID49IDIuMSwgc25wcmludGYgcmV0dXJucyB0aGUgcmVxdWlyZWQgc2l6ZSAoZXhj
bHVkaW5nIGNsb3NpbmcgbnVsbCkKIAkJICovCi0JCWhvbWUgPSBnZXRlbnYoIkhPTUUiKTsKKwkJ
aG9tZSA9IHV0aWxzX2dldF9ob21lX2RpcigpOwogCQlpZiAoaG9tZSA9PSBOVUxMKSB7CiAJCQkv
KiBGYWxsYmFjayBpbiAvdG1wIC4uICovCiAJCQlob21lID0gIi90bXAiOwotLSAKMS43LjExLjcK
Cg==

--=_mixed 00269168C2257B8E_=
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--=_mixed 00269168C2257B8E_=--
