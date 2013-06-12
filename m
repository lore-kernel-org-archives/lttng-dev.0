From: David Goulet <dgoulet@efficios.com>
Subject: Re: [RFC PATCH lttng-tools] Allow environment variable
 LTTNG_HOME to override HOME - for lttng-tools
Date: Wed, 12 Jun 2013 10:46:14 -0400
Message-ID: <51B889B6.6020200__8340.92132649875$1371048418$gmane$org@efficios.com>
References: <OF6896CCA9.D04FC8AB-ONC2257B87.00424736-C2257B87.00427FF3@il.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([5.9.158.244])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <dgoulet@efficios.com>) id 1UmmJb-0000rM-JT
	for lttng-dev@lists.lttng.org; Wed, 12 Jun 2013 10:46:23 -0400
In-Reply-To: <OF6896CCA9.D04FC8AB-ONC2257B87.00424736-C2257B87.00427FF3@il.ibm.com>
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

This looks good! It appears that there are multiple callsites doing the same
thing... We might want to just put it in src/common/utils.c with something like
utils_get_home_dir() and use it from there.

Also, adding "LTTNG_HOME" in defaults.h as a defined value for the env. variable
name. Finally, updating the man page would be also great. :)

Once you are ready to submit the patch, it would be good to use "git
format-patch" or send me a pull request based on git HEAD master.

Big thanks for this contribution!
David

Amit Margalit:
> Hello all,
> 
> Patch functionality - If LTTNG_HOME environment variable exists, it is used
> instead of HOME.
> Reason for patch - We are trying to deploy LTTng on a system where $HOME is on a
> filesystem mounted read-only, but cannot afford to run lttng as a different user
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
> --- lttng-tools-2.2.0-rc2-orig/src/bin/lttng-relayd/utils.c        2013-05-06
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
> --- lttng-tools-2.2.0-rc2-orig/src/bin/lttng-sessiond/utils.c        2013-01-07
> 22:05:16.000000000 +0200
> +++ lttng-tools-2.2.0-rc2/src/bin/lttng-sessiond/utils.c        2013-06-11
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
> --- lttng-tools-2.2.0-rc2-orig/src/lib/lttng-ctl/lttng-ctl.c        2013-05-07
> 22:42:07.000000000 +0300
> +++ lttng-tools-2.2.0-rc2/src/lib/lttng-ctl/lttng-ctl.c        2013-06-11
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
>                   * With GNU C >= 2.1, snprintf returns the required size
> (excluding closing null)
>                   */
>                  ret = snprintf(sessiond_sock_path, sizeof(sessiond_sock_path),
> -                                DEFAULT_HOME_CLIENT_UNIX_SOCK, getenv("HOME"));
> +                                DEFAULT_HOME_CLIENT_UNIX_SOCK,
> get_lttng_home_dir());
>                  if ((ret < 0) || (ret >= sizeof(sessiond_sock_path))) {
>                          goto error;
>                  }
> @@ -1543,7 +1559,7 @@
>                   * With GNU C <  2.1, snprintf returns -1 if the target buffer
> is too small;
>                   * With GNU C >= 2.1, snprintf returns the required size
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
