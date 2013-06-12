From: Amit Margalit <AMITM@il.ibm.com>
Subject: Re: [RFC PATCH lttng-tools] Allow environment variable
 LTTNG_HOME to override HOME - for lttng-tools
Date: Wed, 12 Jun 2013 22:11:26 +0300
Message-ID: <OF7B790C53.27565E2A-ONC2257B88.00695172-C2257B88.00695582__17873.8096532927$1371064355$gmane$org@il.ibm.com>
References: <OF6896CCA9.D04FC8AB-ONC2257B87.00424736-C2257B87.00427FF3@il.ibm.com>
	<51B889B6.6020200@efficios.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1237244065=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from e06smtp16.uk.ibm.com ([195.75.94.112])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <amitm@il.ibm.com>) id 1UmqSP-0002we-JT
	for lttng-dev@lists.lttng.org; Wed, 12 Jun 2013 15:11:45 -0400
Received: from /spool/local
	by e06smtp16.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <lttng-dev@lists.lttng.org> from <amitm@il.ibm.com>;
	Wed, 12 Jun 2013 20:06:45 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com
	(d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
	by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id F342D2190023
	for <lttng-dev@lists.lttng.org>; Wed, 12 Jun 2013 20:14:58 +0100 (BST)
Received: from d06av06.portsmouth.uk.ibm.com (d06av06.portsmouth.uk.ibm.com
	[9.149.37.217])
	by b06cxnps3075.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with
	ESMTP id r5CJBRMN52887744
	for <lttng-dev@lists.lttng.org>; Wed, 12 Jun 2013 19:11:27 GMT
Received: from d06av06.portsmouth.uk.ibm.com (localhost [127.0.0.1])
	by d06av06.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with
	ESMTP id r5CJBbgs024159
	for <lttng-dev@lists.lttng.org>; Wed, 12 Jun 2013 13:11:37 -0600
Received: from d06ml311.portsmouth.uk.ibm.com (d06ml311.portsmouth.uk.ibm.com
	[9.149.104.181])
	by d06av06.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with
	ESMTP id r5CJBbut024156
	for <lttng-dev@lists.lttng.org>; Wed, 12 Jun 2013 13:11:37 -0600
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
--===============1237244065==
Content-Type: multipart/alternative; boundary="=_alternative 00695537C2257B88_="

This is a multipart message in MIME format.
--=_alternative 00695537C2257B88_=
Content-Type: text/plain; charset="US-ASCII"

I'll try to do that. Thanks.

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



--=_alternative 00695537C2257B88_=
Content-Type: text/html; charset="US-ASCII"

<font size=2 face="sans-serif">I'll try to do that. Thanks.</font>
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
<br>
--=_alternative 00695537C2257B88_=--



--===============1237244065==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1237244065==--
