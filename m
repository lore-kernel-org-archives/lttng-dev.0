From: Amit Margalit <AMITM@il.ibm.com>
Subject: Babeltrace API question - how can I determine event IDs
 that exist in a trace I opened?
Date: Sun, 6 Apr 2014 14:53:06 +0300
Message-ID: <OF6AA99225.C2D7812B-ONC2257CB2.00411006-C2257CB2.00414E93__7366.91847346282$1396785256$gmane$org@il.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1934229380=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from e06smtp13.uk.ibm.com ([195.75.94.109])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <amitm@il.ibm.com>) id 1WWlde-0007lx-TD
 for lttng-dev@lists.lttng.org; Sun, 06 Apr 2014 07:53:28 -0400
Received: from /spool/local
 by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <lttng-dev@lists.lttng.org> from <amitm@il.ibm.com>;
 Sun, 6 Apr 2014 12:53:20 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com
 (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
 by d06dlp03.portsmouth.uk.ibm.com (Postfix) with ESMTP id 929C51B0804B
 for <lttng-dev@lists.lttng.org>; Sun,  6 Apr 2014 12:53:15 +0100 (BST)
Received: from d06av04.portsmouth.uk.ibm.com (d06av04.portsmouth.uk.ibm.com
 [9.149.37.216])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s36Br5JI47841464
 for <lttng-dev@lists.lttng.org>; Sun, 6 Apr 2014 11:53:05 GMT
Received: from d06av04.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av04.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s36BrHVV006686
 for <lttng-dev@lists.lttng.org>; Sun, 6 Apr 2014 05:53:17 -0600
Received: from d06ml311.portsmouth.uk.ibm.com (d06ml311.portsmouth.uk.ibm.com
 [9.149.104.181])
 by d06av04.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id
 s36BrG1M006681
 for <lttng-dev@lists.lttng.org>; Sun, 6 Apr 2014 05:53:16 -0600
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

This is a multipart message in MIME format.
--===============1934229380==
Content-Type: multipart/alternative; boundary="=_alternative 00414E4EC2257CB2_="

This is a multipart message in MIME format.
--=_alternative 00414E4EC2257CB2_=
Content-Type: text/plain; charset="US-ASCII"

Hi,

Once I have created a context, and successfully added a trace, is there a 
way to determine which event IDs are present in the trace I just opened?

Specifically, I would like to create a table linking event ID to its name, 
without iterating the entire trace to find out...

Is this possible?

Thanks,

Amit Margalit
IBM XIV - Storage Reinvented
XIV-NAS Development Team
Tel. 03-689-7774
Fax. 03-689-7230
--=_alternative 00414E4EC2257CB2_=
Content-Type: text/html; charset="US-ASCII"

<font size=2 face="sans-serif">Hi,</font>
<br>
<br><font size=2 face="sans-serif">Once I have created a context, and successfully
added a trace, is there a way to determine which event IDs are present
in the trace I just opened?</font>
<br>
<br><font size=2 face="sans-serif">Specifically, I would like to create
a table linking event ID to its name, <u>without</u> iterating the entire
trace to find out...</font>
<br>
<br><font size=2 face="sans-serif">Is this possible?</font>
<br>
<br><font size=2 face="sans-serif">Thanks,</font>
<br>
<br><font size=2 color=#000080 face="sans-serif">Amit Margalit</font>
<br><font size=2 color=#808000 face="sans-serif">IBM XIV </font><font size=2 face="sans-serif">-
<i>Storage Reinvented</i></font>
<br><font size=2 face="sans-serif">XIV-NAS Development Team</font>
<br><font size=2 face="sans-serif">Tel. 03</font><font size=2 face="Arial">-689-7774</font>
<br><font size=2 face="Arial">Fax. 03-689-7230</font>
--=_alternative 00414E4EC2257CB2_=--



--===============1934229380==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1934229380==--
