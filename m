From: Amit Margalit <AMITM@il.ibm.com>
Subject: Why is Python 2.7 required to build stock lttng-ust
	2.4.0 ?
Date: Tue, 1 Apr 2014 16:51:04 +0300
Message-ID: <OFEFA91F70.CE626678-ONC2257CAD.004B5DA5-C2257CAD.004C1B49__13945.7663907253$1396360363$gmane$org@il.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0272395450=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from e06smtp11.uk.ibm.com ([195.75.94.107])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <amitm@il.ibm.com>) id 1WUz65-0008Sb-J0
 for lttng-dev@lists.lttng.org; Tue, 01 Apr 2014 09:51:31 -0400
Received: from /spool/local
 by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <lttng-dev@lists.lttng.org> from <amitm@il.ibm.com>;
 Tue, 1 Apr 2014 14:51:19 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com
 (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
 by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id 593B42190041
 for <lttng-dev@lists.lttng.org>; Tue,  1 Apr 2014 14:51:11 +0100 (BST)
Received: from d06av06.portsmouth.uk.ibm.com (d06av06.portsmouth.uk.ibm.com
 [9.149.37.217])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s31Dp54s590288
 for <lttng-dev@lists.lttng.org>; Tue, 1 Apr 2014 13:51:05 GMT
Received: from d06av06.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av06.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s31EpHOY010454
 for <lttng-dev@lists.lttng.org>; Tue, 1 Apr 2014 08:51:17 -0600
Received: from d06ml311.portsmouth.uk.ibm.com (d06ml311.portsmouth.uk.ibm.com
 [9.149.104.181])
 by d06av06.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id
 s31EpHHh010450
 for <lttng-dev@lists.lttng.org>; Tue, 1 Apr 2014 08:51:17 -0600
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
--===============0272395450==
Content-Type: multipart/alternative; boundary="=_alternative 004C1AD1C2257CAD_="

This is a multipart message in MIME format.
--=_alternative 004C1AD1C2257CAD_=
Content-Type: text/plain; charset="US-ASCII"

Hello,

I've stumbled across this restriction, which seems quite arbitrary. I have 
an environment which is currently unable to update to Python 2.7, but I do 
want lttng-ust-2.4.0.

Looking into the code, it seems that if I don't cate about lttng-gen-tp, 
and the python bindings, then there is no reason to force this 
restriction.

I went into configure.ac, and modified the 2.7 requirement like this:

$ diff -r lttng-ust-2.4.0/configure.ac lttng-ust-2.4.0-py26/configure.ac
279c279
< AM_PATH_PYTHON([2.7],BUILD_GEN_TP_EXAMPLES=1)
---
> AM_PATH_PYTHON([2.6],BUILD_GEN_TP_EXAMPLES=0)

Now, lttng-ust-2.4.0 builds cleanly with Python 2.6.

I'm sure someone can come up with a patch that will simply say "if all you 
have is 2.6, then lets use it, but set BUILD_GEN_TP_EXAMPLES=0, and if you 
have 2.7, then BUILD_GEN_TP_EXAMPLES=1".

Now my experience with autoconf is limited, otherwise I would have done 
this and submitted a patch.

Do you want me to open a ticket for this?

Amit Margalit
IBM XIV - Storage Reinvented
XIV-NAS Development Team
Tel. 03-689-7774
Fax. 03-689-7230
--=_alternative 004C1AD1C2257CAD_=
Content-Type: text/html; charset="US-ASCII"

<font size=2 face="sans-serif">Hello,</font>
<br>
<br><font size=2 face="sans-serif">I've stumbled across this restriction,
which seems quite arbitrary. I have an environment which is currently unable
to update to Python 2.7, but I do want lttng-ust-2.4.0.</font>
<br>
<br><font size=2 face="sans-serif">Looking into the code, it seems that
if I don't cate about lttng-gen-tp, and the python bindings, then there
is no reason to force this restriction.</font>
<br>
<br><font size=2 face="sans-serif">I went into configure.ac, and modified
the 2.7 requirement like this:</font>
<br>
<br><font size=2 face="sans-serif">$ diff -r lttng-ust-2.4.0/configure.ac
lttng-ust-2.4.0-py26/configure.ac</font>
<br><font size=2 face="sans-serif">279c279</font>
<br><font size=2 face="sans-serif">&lt; AM_PATH_PYTHON([2.7],BUILD_GEN_TP_EXAMPLES=1)</font>
<br><font size=2 face="sans-serif">---</font>
<br><font size=2 face="sans-serif">&gt; AM_PATH_PYTHON([2.6],BUILD_GEN_TP_EXAMPLES=0)</font>
<br>
<br><font size=2 face="sans-serif">Now, lttng-ust-2.4.0 builds cleanly
with Python 2.6.</font>
<br>
<br><font size=2 face="sans-serif">I'm sure someone can come up with a
patch that will simply say &quot;if all you have is 2.6, then lets use
it, but set BUILD_GEN_TP_EXAMPLES=0, and if you have 2.7, then BUILD_GEN_TP_EXAMPLES=1&quot;.</font>
<br>
<br><font size=2 face="sans-serif">Now my experience with autoconf is limited,
otherwise I would have done this and submitted a patch.</font>
<br>
<br><font size=2 face="sans-serif">Do you want me to open a ticket for
this?</font>
<br>
<br><font size=2 color=#000080 face="sans-serif">Amit Margalit</font>
<br><font size=2 color=#808000 face="sans-serif">IBM XIV </font><font size=2 face="sans-serif">-
<i>Storage Reinvented</i></font>
<br><font size=2 face="sans-serif">XIV-NAS Development Team</font>
<br><font size=2 face="sans-serif">Tel. 03</font><font size=2 face="Arial">-689-7774</font>
<br><font size=2 face="Arial">Fax. 03-689-7230</font>
--=_alternative 004C1AD1C2257CAD_=--



--===============0272395450==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0272395450==--
