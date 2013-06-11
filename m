From: Amit Margalit <AMITM@il.ibm.com>
Subject: [RFC PATCH lttng-ust] Allow environment variable
 LTTNG_HOME to override HOME
Date: Tue, 11 Jun 2013 15:04:05 +0300
Message-ID: <OFA5A3277B.87DDB05C-ONC2257B87.0041920C-C2257B87.0042359F__36603.3512320884$1370952303$gmane$org@il.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1758847860=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from e06smtp14.uk.ibm.com ([195.75.94.110])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <amitm@il.ibm.com>) id 1UmNJK-0004Sp-5L
	for lttng-dev@lists.lttng.org; Tue, 11 Jun 2013 08:04:26 -0400
Received: from /spool/local
	by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <lttng-dev@lists.lttng.org> from <amitm@il.ibm.com>;
	Tue, 11 Jun 2013 12:57:24 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com
	(d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
	by d06dlp03.portsmouth.uk.ibm.com (Postfix) with ESMTP id 8FCBE1B08061
	for <lttng-dev@lists.lttng.org>; Tue, 11 Jun 2013 13:04:17 +0100 (BST)
Received: from d06av06.portsmouth.uk.ibm.com (d06av06.portsmouth.uk.ibm.com
	[9.149.37.217])
	by b06cxnps3074.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with
	ESMTP id r5BC46hb26280096
	for <lttng-dev@lists.lttng.org>; Tue, 11 Jun 2013 12:04:06 GMT
Received: from d06av06.portsmouth.uk.ibm.com (localhost [127.0.0.1])
	by d06av06.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with
	ESMTP id r5BC4G2N016953
	for <lttng-dev@lists.lttng.org>; Tue, 11 Jun 2013 06:04:16 -0600
Received: from d06ml311.portsmouth.uk.ibm.com (d06ml311.portsmouth.uk.ibm.com
	[9.149.104.181])
	by d06av06.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with
	ESMTP id r5BC4GHZ016944
	for <lttng-dev@lists.lttng.org>; Tue, 11 Jun 2013 06:04:16 -0600
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
--===============1758847860==
Content-Type: multipart/alternative; boundary="=_alternative 0042356DC2257B87_="

This is a multipart message in MIME format.
--=_alternative 0042356DC2257B87_=
Content-Type: text/plain; charset="US-ASCII"

Hello all,

I tried to find some guide for contribution, but http://lttng.org/contrib 
insists that page is not found, so please forgive me (and teach) where I 
do things in a non-standard way.

Patch functionality - If LTTNG_HOME environment variable exists, it is 
used instead of HOME.
Reason for patch - We are trying to deploy LTTng on a system where $HOME 
is on a filesystem mounted read-only, but cannot afford to run lttng as a 
different user and cannot move the home directories of users to writeable 
locations.
Patch baseline: 2.2.0 rc2 

This patch handles only UST. The next email will be a patch against 
lttng-tools.

diff -ur lttng-ust-2.2.0-rc2-orig/liblttng-ust/lttng-ust-comm.c 
lttng-ust-2.2.0-rc2/liblttng-ust/lttng-ust-comm.c
--- lttng-ust-2.2.0-rc2-orig/liblttng-ust/lttng-ust-comm.c      2013-05-08 
22:58:40.000000000 +0300
+++ lttng-ust-2.2.0-rc2/liblttng-ust/lttng-ust-comm.c   2013-06-11 
14:12:55.921673678 +0300
@@ -189,6 +189,20 @@
 extern void lttng_ring_buffer_metadata_client_exit(void);
 
 /*
+ * Returns the HOME directory path. Caller MUST NOT free(3) the return 
pointer.
+ */
+static
+char *get_lttng_home_dir(void)
+{
+       char *val = NULL;
+       val = getenv("LTTNG_HOME");
+       if (val != NULL) {
+               return val;
+       }
+       return getenv("HOME");
+}
+
+/*
  * Force a read (imply TLS fixup for dlopen) of TLS variables.
  */
 static
@@ -230,7 +244,7 @@
                assert(local_apps.allowed == 0);
                return 0;
        }
-       home_dir = (const char *) getenv("HOME");
+       home_dir = (const char *) get_lttng_home_dir();
        if (!home_dir) {
                WARN("HOME environment variable not set. Disabling 
LTTng-UST per-user tracing.");
                assert(local_apps.allowed == 0);

Thanks,

Amit Margalit
IBM XIV - Storage Reinvented
XIV-NAS Development Team
Tel. 03-689-7774
Fax. 03-689-7230
--=_alternative 0042356DC2257B87_=
Content-Type: text/html; charset="US-ASCII"

<font size=2 face="sans-serif">Hello all,</font>
<br>
<br><font size=2 face="sans-serif">I tried to find some guide for contribution,
but </font><a href=http://lttng.org/contrib><font size=3 color=blue><u>http://lttng.org/contrib</u></font></a><font size=3>
</font><font size=2 face="sans-serif">insists that page is not found, so
please forgive me (and teach) where I do things in a non-standard way.</font>
<br>
<br><font size=2 face="sans-serif">Patch functionality - If LTTNG_HOME
environment variable exists, it is used instead of HOME.</font>
<br><font size=2 face="sans-serif">Reason for patch - We are trying to
deploy LTTng on a system where $HOME is on a filesystem mounted read-only,
but cannot afford to run lttng as a different user and cannot move the
home directories of users to writeable locations.</font>
<br><font size=2 face="sans-serif">Patch baseline: 2.2.0 rc2 </font>
<br>
<br><font size=2 face="sans-serif">This patch handles only UST. The next
email will be a patch against lttng-tools.</font>
<br>
<br><tt><font size=2>diff -ur lttng-ust-2.2.0-rc2-orig/liblttng-ust/lttng-ust-comm.c
lttng-ust-2.2.0-rc2/liblttng-ust/lttng-ust-comm.c</font></tt>
<br><tt><font size=2>--- lttng-ust-2.2.0-rc2-orig/liblttng-ust/lttng-ust-comm.c
&nbsp; &nbsp; &nbsp; &nbsp;2013-05-08 22:58:40.000000000 +0300</font></tt>
<br><tt><font size=2>+++ lttng-ust-2.2.0-rc2/liblttng-ust/lttng-ust-comm.c
&nbsp; &nbsp; &nbsp; &nbsp;2013-06-11 14:12:55.921673678 +0300</font></tt>
<br><tt><font size=2>@@ -189,6 +189,20 @@</font></tt>
<br><tt><font size=2>&nbsp;extern void lttng_ring_buffer_metadata_client_exit(void);</font></tt>
<br><tt><font size=2>&nbsp;</font></tt>
<br><tt><font size=2>&nbsp;/*</font></tt>
<br><tt><font size=2>+ * Returns the HOME directory path. Caller MUST NOT
free(3) the return pointer.</font></tt>
<br><tt><font size=2>+ */</font></tt>
<br><tt><font size=2>+static</font></tt>
<br><tt><font size=2>+char *get_lttng_home_dir(void)</font></tt>
<br><tt><font size=2>+{</font></tt>
<br><tt><font size=2>+ &nbsp; &nbsp; &nbsp; &nbsp;char *val = NULL;</font></tt>
<br><tt><font size=2>+ &nbsp; &nbsp; &nbsp; &nbsp;val = getenv(&quot;LTTNG_HOME&quot;);</font></tt>
<br><tt><font size=2>+ &nbsp; &nbsp; &nbsp; &nbsp;if (val != NULL)
{</font></tt>
<br><tt><font size=2>+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp;return val;</font></tt>
<br><tt><font size=2>+ &nbsp; &nbsp; &nbsp; &nbsp;}</font></tt>
<br><tt><font size=2>+ &nbsp; &nbsp; &nbsp; &nbsp;return getenv(&quot;HOME&quot;);</font></tt>
<br><tt><font size=2>+}</font></tt>
<br><tt><font size=2>+</font></tt>
<br><tt><font size=2>+/*</font></tt>
<br><tt><font size=2>&nbsp; * Force a read (imply TLS fixup for dlopen)
of TLS variables.</font></tt>
<br><tt><font size=2>&nbsp; */</font></tt>
<br><tt><font size=2>&nbsp;static</font></tt>
<br><tt><font size=2>@@ -230,7 +244,7 @@</font></tt>
<br><tt><font size=2>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp;assert(local_apps.allowed == 0);</font></tt>
<br><tt><font size=2>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp;return 0;</font></tt>
<br><tt><font size=2>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;}</font></tt>
<br><tt><font size=2>- &nbsp; &nbsp; &nbsp; &nbsp;home_dir = (const
char *) getenv(&quot;HOME&quot;);</font></tt>
<br><tt><font size=2>+ &nbsp; &nbsp; &nbsp; &nbsp;home_dir = (const
char *) get_lttng_home_dir();</font></tt>
<br><tt><font size=2>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;if (!home_dir)
{</font></tt>
<br><tt><font size=2>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp;WARN(&quot;HOME environment variable not set.
Disabling LTTng-UST per-user tracing.&quot;);</font></tt>
<br><tt><font size=2>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp;assert(local_apps.allowed == 0);</font></tt>
<br>
<br><font size=2 face="sans-serif">Thanks,</font>
<br>
<br><font size=2 color=#000080 face="sans-serif">Amit Margalit</font>
<br><font size=2 color=#808000 face="sans-serif">IBM XIV </font><font size=2 face="sans-serif">-
<i>Storage Reinvented</i></font>
<br><font size=2 face="sans-serif">XIV-NAS Development Team</font>
<br><font size=2 face="sans-serif">Tel. 03</font><font size=2 face="Arial">-689-7774</font>
<br><font size=2 face="Arial">Fax. 03-689-7230</font>
--=_alternative 0042356DC2257B87_=--



--===============1758847860==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1758847860==--
