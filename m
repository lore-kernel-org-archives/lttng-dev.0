From: Amit Margalit <AMITM@il.ibm.com>
Subject: Is there a way to make LTTng use the same subbuffers
	for multiple processes?
Date: Sun, 28 Apr 2013 16:51:35 +0300
Message-ID: <OFDF63FF91.58AE5030-ONC2257B5B.004BA0B5-C2257B5B.004C083C__40666.7051640854$1367157144$gmane$org@il.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1069493462=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from e06smtp14.uk.ibm.com ([195.75.94.110])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <amitm@il.ibm.com>) id 1UWS1E-0000H3-EW
	for lttng-dev@lists.lttng.org; Sun, 28 Apr 2013 09:51:56 -0400
Received: from /spool/local
	by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <lttng-dev@lists.lttng.org> from <amitm@il.ibm.com>;
	Sun, 28 Apr 2013 14:46:28 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com
	(d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
	by d06dlp03.portsmouth.uk.ibm.com (Postfix) with ESMTP id 7A3771B0805D
	for <lttng-dev@lists.lttng.org>; Sun, 28 Apr 2013 14:51:47 +0100 (BST)
Received: from d06av04.portsmouth.uk.ibm.com (d06av04.portsmouth.uk.ibm.com
	[9.149.37.216])
	by b06cxnps3075.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with
	ESMTP id r3SDpbJR50987056
	for <lttng-dev@lists.lttng.org>; Sun, 28 Apr 2013 13:51:37 GMT
Received: from d06av04.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av04.portsmouth.uk.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with
	ESMTP id r3SDpl6K029042
	for <lttng-dev@lists.lttng.org>; Sun, 28 Apr 2013 07:51:47 -0600
Received: from d06ml311.portsmouth.uk.ibm.com (d06ml311.portsmouth.uk.ibm.com
	[9.149.104.181])
	by d06av04.portsmouth.uk.ibm.com (8.14.4/8.13.1/NCO v10.0 AVin) with
	ESMTP id r3SDplrr029039
	for <lttng-dev@lists.lttng.org>; Sun, 28 Apr 2013 07:51:47 -0600
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
--===============1069493462==
Content-Type: multipart/alternative; boundary="=_alternative 004C07C2C2257B5B_="

This is a multipart message in MIME format.
--=_alternative 004C07C2C2257B5B_=
Content-Type: text/plain; charset="US-ASCII"

Hi,

We're considering using LTTng as a logging / tracing solution for a 
multi-process application, which spawns many sub-processes.

Our system is a 12-core x86 (6-core + HT). If I take 4 subbuffers of 1MB, 
this means 4MB per process. As the number of processes rises, this becomes 
prohibitive.

For example, we may need to support > 500 sub-processes ==> 500 * 4MB = 
2GB - which is a bit too much.

Is there a way to tell LTTng to share the sub-buffers with forked 
processes?

If not - how difficult would it be to add such support?

Thanks,

Amit Margalit
IBM XIV - Storage Reinvented
XIV-NAS Development Team
Tel. 03-689-7774
Fax. 03-689-7230
--=_alternative 004C07C2C2257B5B_=
Content-Type: text/html; charset="US-ASCII"

<font size=2 face="sans-serif">Hi,</font>
<br>
<br><font size=2 face="sans-serif">We're considering using LTTng as a logging
/ tracing solution for a multi-process application, which spawns many sub-processes.</font>
<br>
<br><font size=2 face="sans-serif">Our system is a 12-core x86 (6-core
+ HT). If I take 4 subbuffers of 1MB, this means 4MB per process. As the
number of processes rises, this becomes prohibitive.</font>
<br>
<br><font size=2 face="sans-serif">For example, we may need to support
&gt; 500 sub-processes ==&gt; 500 * 4MB = 2GB - which is a bit too much.</font>
<br>
<br><font size=2 face="sans-serif">Is there a way to tell LTTng to share
the sub-buffers with forked processes?</font>
<br>
<br><font size=2 face="sans-serif">If not - how difficult would it be to
add such support?</font>
<br>
<br><font size=2 face="sans-serif">Thanks,</font>
<br>
<br><font size=2 color=#000080 face="sans-serif">Amit Margalit</font>
<br><font size=2 color=#808000 face="sans-serif">IBM XIV </font><font size=2 face="sans-serif">-
<i>Storage Reinvented</i></font>
<br><font size=2 face="sans-serif">XIV-NAS Development Team</font>
<br><font size=2 face="sans-serif">Tel. 03</font><font size=2 face="Arial">-689-7774</font>
<br><font size=2 face="Arial">Fax. 03-689-7230</font>
--=_alternative 004C07C2C2257B5B_=--



--===============1069493462==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1069493462==--
