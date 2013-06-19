From: David Goulet <dgoulet@efficios.com>
Subject: Re: [RFC PATCH lttng-tools] Allow environment variable
 LTTNG_HOME to override HOME - for lttng-tools - UPDATED PATCH
Date: Wed, 19 Jun 2013 14:52:14 -0400
Message-ID: <51C1FDDE.8010005__29240.1747465648$1371667983$gmane$org@efficios.com>
References: <OF6896CCA9.D04FC8AB-ONC2257B87.00424736-C2257B87.00427FF3@il.ibm.com>	<51B889B6.6020200@efficios.com>
	<OFDDF6769F.EB68519B-ONC2257B89.0034BB76-C2257B89.0034F473@il.ibm.com>
	<OF0D9D1EAD.C7331410-ONC2257B89.00430C64-C2257B89.00434492@il.ibm.com>
	<51BF670B.50603@efficios.com>
	<OF22F6CF87.62E29056-ONC2257B8E.00267925-C2257B8E.002691A2@il.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([5.9.158.244])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <dgoulet@efficios.com>) id 1UpNUT-0000Rj-80
	for lttng-dev@lists.lttng.org; Wed, 19 Jun 2013 14:52:21 -0400
In-Reply-To: <OF22F6CF87.62E29056-ONC2257B8E.00267925-C2257B8E.002691A2@il.ibm.com>
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

Merged! Thanks!

David

Amit Margalit:
> As requested the patch file is attached.
> 
> 
> It is based on top of 3a68137cb2a86e7e8b13239fee52cae4542605af .
> 
> Amit Margalit
> IBM XIV - /Storage Reinvented/
> XIV-NAS Development Team
> Tel. 03-689-7774
> Fax. 03-689-7230
> 
> 
> 
> From:        David Goulet <dgoulet@efficios.com>
> To:        Amit Margalit/Israel/IBM@IBMIL
> Cc:        lttng-dev@lists.lttng.org
> Date:        06/17/2013 10:44 PM
> Subject:        Re: [lttng-dev] [RFC PATCH lttng-tools] Allow environment
> variable LTTNG_HOME to override HOME - for lttng-tools - UPDATED PATCH
> --------------------------------------------------------------------------------
> 
> 
> 
> Hi Amit,
> 
> There seems to be a problem with this patch, I can't merge it due to some
> malformed part of it...
> 
> Did you use "git send-email" ? If you don't have that, either attach the "git
> format-patch" to the email, the "git log -1" or the diff in a separate file.
> 
> Thanks!
> David
> 
> Amit Margalit:
>> Hi,
>>
>> I've added a paragraph to the man page. Here is the new patch:
>> From a72bd9dd6a58ac727280f2f9a85ee80607f1aba9 Mon Sep 17 00:00:00 2001
>> From: Amit Margalit <amitm@il.ibm.com>
>> Date: Thu, 13 Jun 2013 12:35:13 +0300
>> Subject: [PATCH] Using LTTNG_HOME environment variable if exists, with
>> fallback to HOME
>>
>> ---
>> doc/man/lttng.1                 |  4 ++++
>> src/bin/lttng-relayd/utils.c    | 10 +---------
>> src/bin/lttng-sessiond/main.c   |  2 +-
>> src/bin/lttng-sessiond/utils.c  | 10 ----------
>> src/bin/lttng/commands/create.c |  2 +-
>> src/bin/lttng/conf.c            | 13 +++----------
>> src/bin/lttng/conf.h            |  1 -
>> src/bin/lttng/utils.c           |  3 ++-
>> src/common/defaults.h           |  2 ++
>> src/common/utils.c              | 15 +++++++++++++++
>> src/common/utils.h              |  1 +
>> src/lib/lttng-ctl/lttng-ctl.c   |  5 +++--
>> 12 files changed, 33 insertions(+), 35 deletions(-)
>>
>> diff --git a/doc/man/lttng.1 b/doc/man/lttng.1
>> index f472d38..26fd44a 100644
>> --- a/doc/man/lttng.1
>> +++ b/doc/man/lttng.1
>> @@ -214,6 +214,10 @@ automatically created having this form:
> 'auto-yyyymmdd-hhmmss'.
>>
>> If no \fB\-o, \-\-output\fP is specified, the traces will be written in
>> $HOME/lttng-traces.
>> +
>> +The $HOME environment variable can be overridden by defining the environment
>> +variable LTTNG_HOME. This is useful when the user running the commands has
>> +a non-writeable home directory.
>> .fi
>>
>> .B OPTIONS:
>> diff --git a/src/bin/lttng-relayd/utils.c b/src/bin/lttng-relayd/utils.c
>> index ad13d32..392fab6 100644
>> --- a/src/bin/lttng-relayd/utils.c
>> +++ b/src/bin/lttng-relayd/utils.c
>> @@ -29,14 +29,6 @@
>> #include "lttng-relayd.h"
>> #include "utils.h"
>>
>> -/*
>> - * Returns the HOME directory path. Caller MUST NOT free(3) the return pointer.
>> - */
>> -static char *get_default_path(void)
>> -{
>> -        return getenv("HOME");
>> -}
>> -
>> static char *create_output_path_auto(char *path_name)
>> {
>>         int ret;
>> @@ -44,7 +36,7 @@ static char *create_output_path_auto(char *path_name)
>>          char *alloc_path = NULL;
>>         char *default_path;
>>
>> -        default_path = get_default_path();
>> +        default_path = utils_get_home_dir();
>>         if (default_path == NULL) {
>>                 ERR("Home path not found.\n \
>>                                 Please specify an output path using -o, --output
>> PATH");
>> diff --git a/src/bin/lttng-sessiond/main.c b/src/bin/lttng-sessiond/main.c
>> index 4470afc..256ffba 100644
>> --- a/src/bin/lttng-sessiond/main.c
>> +++ b/src/bin/lttng-sessiond/main.c
>> @@ -4136,7 +4136,7 @@ int main(int argc, char **argv)
>>                 DBG2("Kernel consumer cmd path: %s",
>>                                 kconsumer_data.cmd_unix_sock_path);
>>         } else {
>> -                home_path = get_home_dir();
>> +                home_path = utils_get_home_dir();
>>                 if (home_path == NULL) {
>>                         /* TODO: Add --socket PATH option */
>>                         ERR("Can't get HOME directory for sockets creation.");
>> diff --git a/src/bin/lttng-sessiond/utils.c b/src/bin/lttng-sessiond/utils.c
>> index 5ea3374..af42ad0 100644
>> --- a/src/bin/lttng-sessiond/utils.c
>> +++ b/src/bin/lttng-sessiond/utils.c
>> @@ -45,13 +45,3 @@ int notify_thread_pipe(int wpipe)
>>
>>         return ret;
>> }
>> -
>> -/*
>> - * Return pointer to home directory path using the env variable HOME.
>> - *
>> - * No home, NULL is returned.
>> - */
>> -const char *get_home_dir(void)
>> -{
>> -        return ((const char *) getenv("HOME"));
>> -}
>> diff --git a/src/bin/lttng/commands/create.c b/src/bin/lttng/commands/create.c
>> index 805cdb1..ddd2983 100644
>> --- a/src/bin/lttng/commands/create.c
>> +++ b/src/bin/lttng/commands/create.c
>> @@ -250,7 +250,7 @@ static int create_session(void)
>>                 print_str_url = url;
>>         } else {
>>                 /* Auto output path */
>> -                alloc_path = config_get_default_path();
>> +                alloc_path = utils_get_home_dir();
>>                 if (alloc_path == NULL) {
>>                         ERR("HOME path not found.\n \
>>                                         Please specify an output path using -o,
>> --output PATH");
>> diff --git a/src/bin/lttng/conf.c b/src/bin/lttng/conf.c
>> index b6632fc..5a0da9d 100644
>> --- a/src/bin/lttng/conf.c
>> +++ b/src/bin/lttng/conf.c
>> @@ -25,6 +25,7 @@
>> #include <unistd.h>
>>
>> #include <common/error.h>
>> +#include <common/utils.h>
>>
>> #include "conf.h"
>>
>> @@ -123,14 +124,6 @@ end:
>> }
>>
>> /*
>> - * Returns the HOME directory path. Caller MUST NOT free(3) the return pointer.
>> - */
>> -char *config_get_default_path(void)
>> -{
>> -        return getenv("HOME");
>> -}
>> -
>> -/*
>>  * Destroys directory config and file config.
>>  */
>> void config_destroy(char *path)
>> @@ -161,7 +154,7 @@ end:
>>  */
>> void config_destroy_default(void)
>> {
>> -        char *path = config_get_default_path();
>> +        char *path = utils_get_home_dir();
>>         if (path == NULL) {
>>                 return;
>>         }
>> @@ -277,7 +270,7 @@ int config_init(char *session_name)
>>         int ret;
>>         char *path;
>>
>> -        path = config_get_default_path();
>> +        path = utils_get_home_dir();
>>         if (path == NULL) {
>>                 ret = -1;
>>                 goto error;
>> diff --git a/src/bin/lttng/conf.h b/src/bin/lttng/conf.h
>> index 2cb04b0..3bed59c 100644
>> --- a/src/bin/lttng/conf.h
>> +++ b/src/bin/lttng/conf.h
>> @@ -25,7 +25,6 @@ void config_destroy_default(void);
>> int config_exists(const char *path);
>> int config_init(char *path);
>> int config_add_session_name(char *path, char *name);
>> -char *config_get_default_path(void);
>>
>> /* Must free() the return pointer */
>> char *config_read_session_name(char *path);
>> diff --git a/src/bin/lttng/utils.c b/src/bin/lttng/utils.c
>> index 94c4527..6041655 100644
>> --- a/src/bin/lttng/utils.c
>> +++ b/src/bin/lttng/utils.c
>> @@ -21,6 +21,7 @@
>> #include <limits.h>
>>
>> #include <common/error.h>
>> +#include <common/utils.h>
>>
>> #include "conf.h"
>> #include "utils.h"
>> @@ -36,7 +37,7 @@ char *get_session_name(void)
>>         char *path, *session_name = NULL;
>>
>>         /* Get path to config file */
>> -        path = config_get_default_path();
>> +        path = utils_get_home_dir();
>>         if (path == NULL) {
>>                 goto error;
>>         }
>> diff --git a/src/common/defaults.h b/src/common/defaults.h
>> index 66bb972..c040634 100644
>> --- a/src/common/defaults.h
>> +++ b/src/common/defaults.h
>> @@ -77,6 +77,8 @@
>> #define DEFAULT_USTCONSUMERD32_ERR_SOCK_PATH    DEFAULT_USTCONSUMERD32_PATH
> "/error"
>>
>> /* Default lttng run directory */
>> +#define DEFAULT_LTTNG_HOME_ENV_VAR              "LTTNG_HOME"
>> +#define DEFAULT_LTTNG_FALLBACK_HOME_ENV_VAR        "HOME"
>> #define DEFAULT_LTTNG_RUNDIR                    "/var/run/lttng"
>> #define DEFAULT_LTTNG_HOME_RUNDIR               "%s/.lttng"
>> #define DEFAULT_LTTNG_SESSIOND_PIDFILE          "lttng-sessiond.pid"
>> diff --git a/src/common/utils.c b/src/common/utils.c
>> index 38f78a7..436febe 100644
>> --- a/src/common/utils.c
>> +++ b/src/common/utils.c
>> @@ -32,6 +32,7 @@
>> #include <common/runas.h>
>>
>> #include "utils.h"
>> +#include "defaults.h"
>>
>> /*
>>  * Return the realpath(3) of the path even if the last directory token does not
>> @@ -584,3 +585,17 @@ int utils_get_count_order_u32(uint32_t x)
>>
>>         return fls_u32(x - 1);
>> }
>> +
>> +/**
>> + * Obtain the value of LTTNG_HOME environment variable, if exists.
>> + * Otherwise returns the value of HOME.
>> + */
>> +char *utils_get_home_dir(void)
>> +{
>> +        char *val = NULL;
>> +        val = getenv(DEFAULT_LTTNG_HOME_ENV_VAR);
>> +        if (val != NULL) {
>> +                return val;
>> +        }
>> +        return getenv(DEFAULT_LTTNG_FALLBACK_HOME_ENV_VAR);
>> +}
>> diff --git a/src/common/utils.h b/src/common/utils.h
>> index 083acef..9e6fb37 100644
>> --- a/src/common/utils.h
>> +++ b/src/common/utils.h
>> @@ -40,5 +40,6 @@ int utils_rotate_stream_file(char *path_name, char *file_name,
>> uint64_t size,
>>                 uint64_t count, int uid, int gid, int out_fd, uint64_t
> *new_count);
>> int utils_parse_size_suffix(char *str, uint64_t *size);
>>  int utils_get_count_order_u32(uint32_t x);
>> +char *utils_get_home_dir(void);
>>
>> #endif /* _COMMON_UTILS_H */
>> diff --git a/src/lib/lttng-ctl/lttng-ctl.c b/src/lib/lttng-ctl/lttng-ctl.c
>> index a7328eb..9d76f79 100644
>> --- a/src/lib/lttng-ctl/lttng-ctl.c
>> +++ b/src/lib/lttng-ctl/lttng-ctl.c
>> @@ -32,6 +32,7 @@
>> #include <common/defaults.h>
>> #include <common/sessiond-comm/sessiond-comm.h>
>> #include <common/uri.h>
>> +#include <common/utils.h>
>> #include <lttng/lttng.h>
>>
>> #include "filter/filter-ast.h"
>> @@ -485,7 +486,7 @@ static int set_session_daemon_path(void)
>>                  * With GNU C >= 2.1, snprintf returns the required size
>> (excluding closing null)
>>                  */
>>                 ret = snprintf(sessiond_sock_path, sizeof(sessiond_sock_path),
>> -                                DEFAULT_HOME_CLIENT_UNIX_SOCK, getenv("HOME"));
>> +                                DEFAULT_HOME_CLIENT_UNIX_SOCK,
>> utils_get_home_dir());
>>                 if ((ret < 0) || (ret >= sizeof(sessiond_sock_path))) {
>>                         goto error;
>>                 }
>> @@ -1543,7 +1544,7 @@ static int set_health_socket_path(void)
>>                  * With GNU C <  2.1, snprintf returns -1 if the target buffer
>> is too small;
>>                   * With GNU C >= 2.1, snprintf returns the required size
>> (excluding closing null)
>>                  */
>> -                home = getenv("HOME");
>> +                home = utils_get_home_dir();
>>                 if (home == NULL) {
>>                         /* Fallback in /tmp .. */
>>                         home = "/tmp";
>> --
>> 1.7.11.7
>>
>>
>> Amit Margalit
>> IBM XIV - /Storage Reinvented/
>> XIV-NAS Development Team
>> Tel. 03-689-7774
>> Fax. 03-689-7230
>>
>>
>>
>> From:        Amit Margalit/Israel/IBM@IBMIL
>> To:        David Goulet <dgoulet@efficios.com>
>> Cc:        lttng-dev@lists.lttng.org
>> Date:        06/13/2013 12:39 PM
>> Subject:        Re: [lttng-dev] [RFC PATCH lttng-tools] Allow environment
>> variable LTTNG_HOME to override HOME - for lttng-tools
>> --------------------------------------------------------------------------------
>>
>>
>>
>> I think I've done all that you suggested, for lttng-tools only, though, based on
>> cfa9a5a2b4a96e0d6a9eeddd2622a6d7c173b7ac which is the latest master as of
> right now.
>>
>> Here is the patch:
>> From 5881718a60608d640ac1124c9c1f439a2a084707 Mon Sep 17 00:00:00 2001
>> From: Amit Margalit <amitm@il.ibm.com>
>> Date: Thu, 13 Jun 2013 12:35:13 +0300
>> Subject: [PATCH] Using LTTNG_HOME environment variable if exists, with
>> fallback to HOME
>>
>> ---
>> [Old patch deleted]
>> _______________________________________________
>> lttng-dev mailing list
>> lttng-dev@lists.lttng.org
>> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>>
> 
> 
