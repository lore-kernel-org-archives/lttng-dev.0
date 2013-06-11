From: Amit Margalit <AMITM@il.ibm.com>
Subject: [RFC PATCH lttng-tools] Allow environment variable
 LTTNG_HOME to override HOME - for lttng-tools
Date: Tue, 11 Jun 2013 15:07:16 +0300
Message-ID: <OF6896CCA9.D04FC8AB-ONC2257B87.00424736-C2257B87.00427FF3__26045.0999056504$1370952489$gmane$org@il.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1915015920=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from e06smtp13.uk.ibm.com ([195.75.94.109])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <amitm@il.ibm.com>) id 1UmNMN-0004VO-Ow
	for lttng-dev@lists.lttng.org; Tue, 11 Jun 2013 08:07:36 -0400
Received: from /spool/local
	by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <lttng-dev@lists.lttng.org> from <amitm@il.ibm.com>;
	Tue, 11 Jun 2013 13:03:39 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com
	(d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
	by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id 90BD92190066
	for <lttng-dev@lists.lttng.org>; Tue, 11 Jun 2013 13:10:47 +0100 (BST)
Received: from d06av02.portsmouth.uk.ibm.com (d06av02.portsmouth.uk.ibm.com
	[9.149.37.228])
	by b06cxnps3075.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with
	ESMTP id r5BC7Hlb52625616
	for <lttng-dev@lists.lttng.org>; Tue, 11 Jun 2013 12:07:17 GMT
Received: from d06av02.portsmouth.uk.ibm.com (localhost [127.0.0.1])
	by d06av02.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with
	ESMTP id r5BC7R5M008993
	for <lttng-dev@lists.lttng.org>; Tue, 11 Jun 2013 06:07:27 -0600
Received: from d06ml311.portsmouth.uk.ibm.com (d06ml311.portsmouth.uk.ibm.com
	[9.149.104.181])
	by d06av02.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with
	ESMTP id r5BC7QPu008967
	for <lttng-dev@lists.lttng.org>; Tue, 11 Jun 2013 06:07:27 -0600
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

This is a multipart message in MIME format.
--===============1915015920==
Content-Type: multipart/alternative; boundary="=_alternative 00427F8DC2257B87_="

This is a multipart message in MIME format.
--=_alternative 00427F8DC2257B87_=
Content-Type: text/plain; charset="US-ASCII"

Hello all, 

Patch functionality - If LTTNG_HOME environment variable exists, it is 
used instead of HOME. 
Reason for patch - We are trying to deploy LTTng on a system where $HOME 
is on a filesystem mounted read-only, but cannot afford to run lttng as a 
different user and cannot move the home directories of users to writeable 
locations. 
Patch baseline: 2.2.0 rc2 

This patch handles only lttng-tools.

I can provide the same patches against git, if asked.

diff -ur lttng-tools-2.2.0-rc2-orig/src/bin/lttng/conf.c 
lttng-tools-2.2.0-rc2/src/bin/lttng/conf.c
--- lttng-tools-2.2.0-rc2-orig/src/bin/lttng/conf.c     2013-05-06 
21:50:59.000000000 +0300
+++ lttng-tools-2.2.0-rc2/src/bin/lttng/conf.c  2013-06-11 
14:17:34.681673309 +0300
@@ -127,6 +127,11 @@
  */
 char *config_get_default_path(void)
 {
+       char *val = NULL;
+       val = getenv("LTTNG_HOME");
+       if (val != NULL) {
+               return val;
+       }
        return getenv("HOME");
 }
 
diff -ur lttng-tools-2.2.0-rc2-orig/src/bin/lttng-relayd/utils.c 
lttng-tools-2.2.0-rc2/src/bin/lttng-relayd/utils.c
--- lttng-tools-2.2.0-rc2-orig/src/bin/lttng-relayd/utils.c     2013-05-06 
21:50:59.000000000 +0300
+++ lttng-tools-2.2.0-rc2/src/bin/lttng-relayd/utils.c  2013-06-11 
14:15:52.553673444 +0300
@@ -34,7 +34,11 @@
  */
 static char *get_default_path(void)
 {
-       return getenv("HOME");
+       char *val = NULL;
+       val = getenv("LTTNG_HOME");
+       if (val != NULL) {
+               return val;
+       }
 }
 
 static char *create_output_path_auto(char *path_name)
diff -ur lttng-tools-2.2.0-rc2-orig/src/bin/lttng-sessiond/utils.c 
lttng-tools-2.2.0-rc2/src/bin/lttng-sessiond/utils.c
--- lttng-tools-2.2.0-rc2-orig/src/bin/lttng-sessiond/utils.c   2013-01-07 
22:05:16.000000000 +0200
+++ lttng-tools-2.2.0-rc2/src/bin/lttng-sessiond/utils.c        2013-06-11 
14:16:16.697673412 +0300
@@ -53,5 +53,10 @@
  */
 const char *get_home_dir(void)
 {
+       const char *val = NULL;
+       val = ((const char *) getenv("LTTNG_HOME"));
+       if (val != NULL) {
+               return val;
+       }
        return ((const char *) getenv("HOME"));
 }
diff -ur lttng-tools-2.2.0-rc2-orig/src/lib/lttng-ctl/lttng-ctl.c 
lttng-tools-2.2.0-rc2/src/lib/lttng-ctl/lttng-ctl.c
--- lttng-tools-2.2.0-rc2-orig/src/lib/lttng-ctl/lttng-ctl.c    2013-05-07 
22:42:07.000000000 +0300
+++ lttng-tools-2.2.0-rc2/src/lib/lttng-ctl/lttng-ctl.c 2013-06-11 
14:19:15.177673176 +0300
@@ -74,6 +74,22 @@
 int lttng_opt_verbose;
 
 /*
+ * Get the value of LTTNG_HOME if present, or HOME if not.
+ * Caller must not free the returned pointer.
+ * Used 
+ */
+static const char *get_lttng_home_dir(void)
+{
+       const char *val = NULL;
+       val = ((const char *) getenv("LTTNG_HOME"));
+       if (val != NULL) {
+               return val;
+       }
+       return ((const char *) getenv("HOME"));
+}
+
+
+/*
  * Compare two URL destination.
  *
  * Return 0 is equal else is not equal.
@@ -485,7 +501,7 @@
                 * With GNU C >= 2.1, snprintf returns the required size 
(excluding closing null)
                 */
                ret = snprintf(sessiond_sock_path, 
sizeof(sessiond_sock_path),
-                               DEFAULT_HOME_CLIENT_UNIX_SOCK, 
getenv("HOME"));
+                               DEFAULT_HOME_CLIENT_UNIX_SOCK, 
get_lttng_home_dir());
                if ((ret < 0) || (ret >= sizeof(sessiond_sock_path))) {
                        goto error;
                }
@@ -1543,7 +1559,7 @@
                 * With GNU C <  2.1, snprintf returns -1 if the target 
buffer is too small;
                 * With GNU C >= 2.1, snprintf returns the required size 
(excluding closing null)
                 */
-               home = getenv("HOME");
+               home = get_lttng_home_dir();
                if (home == NULL) {
                        /* Fallback in /tmp .. */
                        home = "/tmp";

Thanks,

Amit Margalit
IBM XIV - Storage Reinvented
XIV-NAS Development Team
Tel. 03-689-7774
Fax. 03-689-7230
--=_alternative 00427F8DC2257B87_=
Content-Type: text/html; charset="US-ASCII"

<font size=2 face="sans-serif">Hello all,</font><font size=3> </font>
<br>
<br><font size=2 face="sans-serif">Patch functionality - If LTTNG_HOME
environment variable exists, it is used instead of HOME.</font><font size=3>
</font><font size=2 face="sans-serif"><br>
Reason for patch - We are trying to deploy LTTng on a system where $HOME
is on a filesystem mounted read-only, but cannot afford to run lttng as
a different user and cannot move the home directories of users to writeable
locations.</font><font size=3> </font><font size=2 face="sans-serif"><br>
Patch baseline: 2.2.0 rc2 </font><font size=3><br>
</font><font size=2 face="sans-serif"><br>
This patch handles only lttng-tools.</font>
<br>
<br><font size=2 face="sans-serif">I can provide the same patches against
git, if asked.</font>
<br>
<br><tt><font size=2>diff -ur lttng-tools-2.2.0-rc2-orig/src/bin/lttng/conf.c
lttng-tools-2.2.0-rc2/src/bin/lttng/conf.c</font></tt>
<br><tt><font size=2>--- lttng-tools-2.2.0-rc2-orig/src/bin/lttng/conf.c
&nbsp; &nbsp; &nbsp; &nbsp;2013-05-06 21:50:59.000000000 +0300</font></tt>
<br><tt><font size=2>+++ lttng-tools-2.2.0-rc2/src/bin/lttng/conf.c &nbsp;
&nbsp; &nbsp; &nbsp;2013-06-11 14:17:34.681673309 +0300</font></tt>
<br><tt><font size=2>@@ -127,6 +127,11 @@</font></tt>
<br><tt><font size=2>&nbsp; */</font></tt>
<br><tt><font size=2>&nbsp;char *config_get_default_path(void)</font></tt>
<br><tt><font size=2>&nbsp;{</font></tt>
<br><tt><font size=2>+ &nbsp; &nbsp; &nbsp; &nbsp;char *val = NULL;</font></tt>
<br><tt><font size=2>+ &nbsp; &nbsp; &nbsp; &nbsp;val = getenv(&quot;LTTNG_HOME&quot;);</font></tt>
<br><tt><font size=2>+ &nbsp; &nbsp; &nbsp; &nbsp;if (val != NULL)
{</font></tt>
<br><tt><font size=2>+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp;return val;</font></tt>
<br><tt><font size=2>+ &nbsp; &nbsp; &nbsp; &nbsp;}</font></tt>
<br><tt><font size=2>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;return getenv(&quot;HOME&quot;);</font></tt>
<br><tt><font size=2>&nbsp;}</font></tt>
<br><tt><font size=2>&nbsp;</font></tt>
<br><tt><font size=2>diff -ur lttng-tools-2.2.0-rc2-orig/src/bin/lttng-relayd/utils.c
lttng-tools-2.2.0-rc2/src/bin/lttng-relayd/utils.c</font></tt>
<br><tt><font size=2>--- lttng-tools-2.2.0-rc2-orig/src/bin/lttng-relayd/utils.c
&nbsp; &nbsp; &nbsp; &nbsp;2013-05-06 21:50:59.000000000 +0300</font></tt>
<br><tt><font size=2>+++ lttng-tools-2.2.0-rc2/src/bin/lttng-relayd/utils.c
&nbsp; &nbsp; &nbsp; &nbsp;2013-06-11 14:15:52.553673444 +0300</font></tt>
<br><tt><font size=2>@@ -34,7 +34,11 @@</font></tt>
<br><tt><font size=2>&nbsp; */</font></tt>
<br><tt><font size=2>&nbsp;static char *get_default_path(void)</font></tt>
<br><tt><font size=2>&nbsp;{</font></tt>
<br><tt><font size=2>- &nbsp; &nbsp; &nbsp; &nbsp;return getenv(&quot;HOME&quot;);</font></tt>
<br><tt><font size=2>+ &nbsp; &nbsp; &nbsp; &nbsp;char *val = NULL;</font></tt>
<br><tt><font size=2>+ &nbsp; &nbsp; &nbsp; &nbsp;val = getenv(&quot;LTTNG_HOME&quot;);</font></tt>
<br><tt><font size=2>+ &nbsp; &nbsp; &nbsp; &nbsp;if (val != NULL)
{</font></tt>
<br><tt><font size=2>+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp;return val;</font></tt>
<br><tt><font size=2>+ &nbsp; &nbsp; &nbsp; &nbsp;}</font></tt>
<br><tt><font size=2>&nbsp;}</font></tt>
<br><tt><font size=2>&nbsp;</font></tt>
<br><tt><font size=2>&nbsp;static char *create_output_path_auto(char *path_name)</font></tt>
<br><tt><font size=2>diff -ur lttng-tools-2.2.0-rc2-orig/src/bin/lttng-sessiond/utils.c
lttng-tools-2.2.0-rc2/src/bin/lttng-sessiond/utils.c</font></tt>
<br><tt><font size=2>--- lttng-tools-2.2.0-rc2-orig/src/bin/lttng-sessiond/utils.c
&nbsp; &nbsp; &nbsp; &nbsp;2013-01-07 22:05:16.000000000 +0200</font></tt>
<br><tt><font size=2>+++ lttng-tools-2.2.0-rc2/src/bin/lttng-sessiond/utils.c
&nbsp; &nbsp; &nbsp; &nbsp;2013-06-11 14:16:16.697673412 +0300</font></tt>
<br><tt><font size=2>@@ -53,5 +53,10 @@</font></tt>
<br><tt><font size=2>&nbsp; */</font></tt>
<br><tt><font size=2>&nbsp;const char *get_home_dir(void)</font></tt>
<br><tt><font size=2>&nbsp;{</font></tt>
<br><tt><font size=2>+ &nbsp; &nbsp; &nbsp; &nbsp;const char *val
= NULL;</font></tt>
<br><tt><font size=2>+ &nbsp; &nbsp; &nbsp; &nbsp;val = ((const
char *) getenv(&quot;LTTNG_HOME&quot;));</font></tt>
<br><tt><font size=2>+ &nbsp; &nbsp; &nbsp; &nbsp;if (val != NULL)
{</font></tt>
<br><tt><font size=2>+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp;return val;</font></tt>
<br><tt><font size=2>+ &nbsp; &nbsp; &nbsp; &nbsp;}</font></tt>
<br><tt><font size=2>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;return ((const
char *) getenv(&quot;HOME&quot;));</font></tt>
<br><tt><font size=2>&nbsp;}</font></tt>
<br><tt><font size=2>diff -ur lttng-tools-2.2.0-rc2-orig/src/lib/lttng-ctl/lttng-ctl.c
lttng-tools-2.2.0-rc2/src/lib/lttng-ctl/lttng-ctl.c</font></tt>
<br><tt><font size=2>--- lttng-tools-2.2.0-rc2-orig/src/lib/lttng-ctl/lttng-ctl.c
&nbsp; &nbsp; &nbsp; &nbsp;2013-05-07 22:42:07.000000000 +0300</font></tt>
<br><tt><font size=2>+++ lttng-tools-2.2.0-rc2/src/lib/lttng-ctl/lttng-ctl.c
&nbsp; &nbsp; &nbsp; &nbsp;2013-06-11 14:19:15.177673176 +0300</font></tt>
<br><tt><font size=2>@@ -74,6 +74,22 @@</font></tt>
<br><tt><font size=2>&nbsp;int lttng_opt_verbose;</font></tt>
<br><tt><font size=2>&nbsp;</font></tt>
<br><tt><font size=2>&nbsp;/*</font></tt>
<br><tt><font size=2>+ * Get the value of LTTNG_HOME if present, or HOME
if not.</font></tt>
<br><tt><font size=2>+ * Caller must not free the returned pointer.</font></tt>
<br><tt><font size=2>+ * Used </font></tt>
<br><tt><font size=2>+ */</font></tt>
<br><tt><font size=2>+static const char *get_lttng_home_dir(void)</font></tt>
<br><tt><font size=2>+{</font></tt>
<br><tt><font size=2>+ &nbsp; &nbsp; &nbsp; &nbsp;const char *val
= NULL;</font></tt>
<br><tt><font size=2>+ &nbsp; &nbsp; &nbsp; &nbsp;val = ((const
char *) getenv(&quot;LTTNG_HOME&quot;));</font></tt>
<br><tt><font size=2>+ &nbsp; &nbsp; &nbsp; &nbsp;if (val != NULL)
{</font></tt>
<br><tt><font size=2>+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp;return val;</font></tt>
<br><tt><font size=2>+ &nbsp; &nbsp; &nbsp; &nbsp;}</font></tt>
<br><tt><font size=2>+ &nbsp; &nbsp; &nbsp; &nbsp;return ((const
char *) getenv(&quot;HOME&quot;));</font></tt>
<br><tt><font size=2>+}</font></tt>
<br><tt><font size=2>+</font></tt>
<br><tt><font size=2>+</font></tt>
<br><tt><font size=2>+/*</font></tt>
<br><tt><font size=2>&nbsp; * Compare two URL destination.</font></tt>
<br><tt><font size=2>&nbsp; *</font></tt>
<br><tt><font size=2>&nbsp; * Return 0 is equal else is not equal.</font></tt>
<br><tt><font size=2>@@ -485,7 +501,7 @@</font></tt>
<br><tt><font size=2>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; * With GNU C &gt;= 2.1, snprintf returns the
required size (excluding closing null)</font></tt>
<br><tt><font size=2>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; */</font></tt>
<br><tt><font size=2>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp;ret = snprintf(sessiond_sock_path, sizeof(sessiond_sock_path),</font></tt>
<br><tt><font size=2>- &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp;DEFAULT_HOME_CLIENT_UNIX_SOCK, getenv(&quot;HOME&quot;));</font></tt>
<br><tt><font size=2>+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp;DEFAULT_HOME_CLIENT_UNIX_SOCK, get_lttng_home_dir());</font></tt>
<br><tt><font size=2>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp;if ((ret &lt; 0) || (ret &gt;= sizeof(sessiond_sock_path)))
{</font></tt>
<br><tt><font size=2>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;goto error;</font></tt>
<br><tt><font size=2>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp;}</font></tt>
<br><tt><font size=2>@@ -1543,7 +1559,7 @@</font></tt>
<br><tt><font size=2>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; * With GNU C &lt; &nbsp;2.1, snprintf returns
-1 if the target buffer is too small;</font></tt>
<br><tt><font size=2>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; * With GNU C &gt;= 2.1, snprintf returns the
required size (excluding closing null)</font></tt>
<br><tt><font size=2>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; */</font></tt>
<br><tt><font size=2>- &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp;home = getenv(&quot;HOME&quot;);</font></tt>
<br><tt><font size=2>+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp;home = get_lttng_home_dir();</font></tt>
<br><tt><font size=2>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp;if (home == NULL) {</font></tt>
<br><tt><font size=2>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;/* Fallback
in /tmp .. */</font></tt>
<br><tt><font size=2>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;home =
&quot;/tmp&quot;;</font></tt>
<br>
<br><font size=2 face="sans-serif">Thanks,</font>
<br>
<br><font size=2 color=#000080 face="sans-serif">Amit Margalit</font>
<br><font size=2 color=#808000 face="sans-serif">IBM XIV </font><font size=2 face="sans-serif">-
<i>Storage Reinvented</i></font>
<br><font size=2 face="sans-serif">XIV-NAS Development Team</font>
<br><font size=2 face="sans-serif">Tel. 03</font><font size=2 face="Arial">-689-7774</font>
<br><font size=2 face="Arial">Fax. 03-689-7230</font>
--=_alternative 00427F8DC2257B87_=--



--===============1915015920==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1915015920==--
