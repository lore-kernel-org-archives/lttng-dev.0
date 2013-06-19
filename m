From: Amit Margalit <AMITM@il.ibm.com>
Subject: Re: Weird assertion failure
 in	__lttng_events_init__provider ()
 at	/usr/include/lttng/ust-tracepoint-event.h:687
Date: Wed, 19 Jun 2013 10:11:30 +0300
Message-ID: <OFF799723A.58250DFD-ONC2257B8F.00276585-C2257B8F.00276BF8__42213.046612642$1371625949$gmane$org@il.ibm.com>
References: <OF02578AAF.2F483DCE-ONC2257B8E.003BBD95-C2257B8E.003C1290@il.ibm.com>
	<20130618134708.GA14004@Krystal>
	<CAFXXi0nAUYhGXPFgnwUDTkujj9wiTP-oKmd+TB4YwSf6FDSrZw@mail.gmail.com>
	<20130618141033.GD14004@Krystal>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2032316053=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from e06smtp10.uk.ibm.com ([195.75.94.106])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <amitm@il.ibm.com>) id 1UpCYW-00034z-OC
	for lttng-dev@lists.lttng.org; Wed, 19 Jun 2013 03:11:49 -0400
Received: from /spool/local
	by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <lttng-dev@lists.lttng.org> from <amitm@il.ibm.com>;
	Wed, 19 Jun 2013 08:09:20 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com
	(d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
	by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id E2FE72190063
	for <lttng-dev@lists.lttng.org>; Wed, 19 Jun 2013 08:15:06 +0100 (BST)
Received: from d06av08.portsmouth.uk.ibm.com (d06av08.portsmouth.uk.ibm.com
	[9.149.37.249])
	by b06cxnps3075.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with
	ESMTP id r5J7BR6X36110446
	for <lttng-dev@lists.lttng.org>; Wed, 19 Jun 2013 07:11:27 GMT
Received: from d06av08.portsmouth.uk.ibm.com (localhost [127.0.0.1])
	by d06av08.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with
	ESMTP id r5J7Bbv9009055
	for <lttng-dev@lists.lttng.org>; Wed, 19 Jun 2013 01:11:37 -0600
Received: from d06ml311.portsmouth.uk.ibm.com (d06ml311.portsmouth.uk.ibm.com
	[9.149.104.181])
	by d06av08.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with
	ESMTP id r5J7Bb0B009052
	for <lttng-dev@lists.lttng.org>; Wed, 19 Jun 2013 01:11:37 -0600
In-Reply-To: <20130618141033.GD14004@Krystal>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

This is a multipart message in MIME format.
--===============2032316053==
Content-Type: multipart/alternative; boundary="=_alternative 00276BB3C2257B8F_="

This is a multipart message in MIME format.
--=_alternative 00276BB3C2257B8F_=
Content-Type: text/plain; charset="US-ASCII"

Thanks! That has fixed it.

Amit Margalit
IBM XIV - Storage Reinvented
XIV-NAS Development Team
Tel. 03-689-7774
Fax. 03-689-7230



From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Simon Marchi <simon.marchi@polymtl.ca>
Cc:     Amit Margalit/Israel/IBM@IBMIL, "lttng-dev@lists.lttng.org" 
<lttng-dev@lists.lttng.org>
Date:   06/18/2013 05:10 PM
Subject:        Re: [lttng-dev] Weird assertion failure in 
__lttng_events_init__provider () at 
/usr/include/lttng/ust-tracepoint-event.h:687



Now fixed, see commit:

commit 7d381d6e31531cf4f7bc5f4df955dd819731ba44
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Date:   Tue Jun 18 10:02:00 2013 -0400

    Clarify probe registration documentation/errors
 
    Fixes #513
 
    Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

Thanks,

Mathieu

* Simon Marchi (simon.marchi@polymtl.ca) wrote:
> Glad to see I'm not the only one ;)
> 
> https://bugs.lttng.org/issues/513
> 
> On 18 June 2013 09:47, Mathieu Desnoyers 
<mathieu.desnoyers@efficios.com> wrote:
> > * Amit Margalit (AMITM@il.ibm.com) wrote:
> >> Hi,
> >>
> >> I'm getting an assertion failure as listed above. Any idea what this 
is?
> >>
> >> Program terminated with signal 6, Aborted.
> >> #0  0x00007fc304edb945 in raise () from /lib64/libc.so.6
> >> (gdb) bt
> >> #0  0x00007fc304edb945 in raise () from /lib64/libc.so.6
> >> #1  0x00007fc304edcf21 in abort () from /lib64/libc.so.6
> >> #2  0x00007fc304ed4810 in __assert_fail () from /lib64/libc.so.6
> >> #3  0x00007fc30a48d58a in __lttng_events_init__provider () at
> >> /usr/include/lttng/ust-tracepoint-event.h:687
> >>
> >> The change I made was to add 2 more tracepoints, in a separate file. 
The
> >> provider is the same.
> >
> > It looks like you have duplicated provider objects in your 
application.
> > E.g. twice the same provider name trying to register.
> >
> > Thanks,
> >
> > Mathieu
> >
> >>
> >> I am using --buffers-uid, btw. The code is stock 2.2.0rc2 + my 
LTTNG_HOME
> >> patch.
> >>
> >> Thanks,
> >>
> >>
> >> Amit Margalit
> >> IBM XIV - Storage Reinvented
> >> XIV-NAS Development Team
> >> Tel. 03-689-7774
> >> Fax. 03-689-7230
> >> _______________________________________________
> >> lttng-dev mailing list
> >> lttng-dev@lists.lttng.org
> >> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> >
> >
> > --
> > Mathieu Desnoyers
> > EfficiOS Inc.
> > http://www.efficios.com
> >
> > _______________________________________________
> > lttng-dev mailing list
> > lttng-dev@lists.lttng.org
> > http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com



--=_alternative 00276BB3C2257B8F_=
Content-Type: text/html; charset="US-ASCII"

<font size=2 face="sans-serif">Thanks! That has fixed it.</font>
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
&nbsp;</font><font size=1 face="sans-serif">Mathieu Desnoyers &lt;mathieu.desnoyers@efficios.com&gt;</font>
<br><font size=1 color=#5f5f5f face="sans-serif">To: &nbsp; &nbsp; &nbsp;
&nbsp;</font><font size=1 face="sans-serif">Simon Marchi &lt;simon.marchi@polymtl.ca&gt;</font>
<br><font size=1 color=#5f5f5f face="sans-serif">Cc: &nbsp; &nbsp; &nbsp;
&nbsp;</font><font size=1 face="sans-serif">Amit Margalit/Israel/IBM@IBMIL,
&quot;lttng-dev@lists.lttng.org&quot; &lt;lttng-dev@lists.lttng.org&gt;</font>
<br><font size=1 color=#5f5f5f face="sans-serif">Date: &nbsp; &nbsp; &nbsp;
&nbsp;</font><font size=1 face="sans-serif">06/18/2013 05:10 PM</font>
<br><font size=1 color=#5f5f5f face="sans-serif">Subject: &nbsp; &nbsp;
&nbsp; &nbsp;</font><font size=1 face="sans-serif">Re: [lttng-dev]
Weird assertion failure in &nbsp; &nbsp; &nbsp; &nbsp;__lttng_events_init__provider
() at &nbsp; &nbsp; &nbsp; &nbsp;/usr/include/lttng/ust-tracepoint-event.h:687</font>
<br>
<hr noshade>
<br>
<br>
<br><tt><font size=2>Now fixed, see commit:<br>
<br>
commit 7d381d6e31531cf4f7bc5f4df955dd819731ba44<br>
Author: Mathieu Desnoyers &lt;mathieu.desnoyers@efficios.com&gt;<br>
Date: &nbsp; Tue Jun 18 10:02:00 2013 -0400<br>
<br>
 &nbsp; &nbsp;Clarify probe registration documentation/errors<br>
 &nbsp; &nbsp;<br>
 &nbsp; &nbsp;Fixes #513<br>
 &nbsp; &nbsp;<br>
 &nbsp; &nbsp;Signed-off-by: Mathieu Desnoyers &lt;mathieu.desnoyers@efficios.com&gt;<br>
<br>
Thanks,<br>
<br>
Mathieu<br>
<br>
* Simon Marchi (simon.marchi@polymtl.ca) wrote:<br>
&gt; Glad to see I'm not the only one ;)<br>
&gt; <br>
&gt; </font></tt><a href=https://bugs.lttng.org/issues/513><tt><font size=2>https://bugs.lttng.org/issues/513</font></tt></a><tt><font size=2><br>
&gt; <br>
&gt; On 18 June 2013 09:47, Mathieu Desnoyers &lt;mathieu.desnoyers@efficios.com&gt;
wrote:<br>
&gt; &gt; * Amit Margalit (AMITM@il.ibm.com) wrote:<br>
&gt; &gt;&gt; Hi,<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; I'm getting an assertion failure as listed above. Any idea
what this is?<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; Program terminated with signal 6, Aborted.<br>
&gt; &gt;&gt; #0 &nbsp;0x00007fc304edb945 in raise () from /lib64/libc.so.6<br>
&gt; &gt;&gt; (gdb) bt<br>
&gt; &gt;&gt; #0 &nbsp;0x00007fc304edb945 in raise () from /lib64/libc.so.6<br>
&gt; &gt;&gt; #1 &nbsp;0x00007fc304edcf21 in abort () from /lib64/libc.so.6<br>
&gt; &gt;&gt; #2 &nbsp;0x00007fc304ed4810 in __assert_fail () from /lib64/libc.so.6<br>
&gt; &gt;&gt; #3 &nbsp;0x00007fc30a48d58a in __lttng_events_init__provider
() at<br>
&gt; &gt;&gt; /usr/include/lttng/ust-tracepoint-event.h:687<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; The change I made was to add 2 more tracepoints, in a separate
file. The<br>
&gt; &gt;&gt; provider is the same.<br>
&gt; &gt;<br>
&gt; &gt; It looks like you have duplicated provider objects in your application.<br>
&gt; &gt; E.g. twice the same provider name trying to register.<br>
&gt; &gt;<br>
&gt; &gt; Thanks,<br>
&gt; &gt;<br>
&gt; &gt; Mathieu<br>
&gt; &gt;<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; I am using --buffers-uid, btw. The code is stock 2.2.0rc2
+ my LTTNG_HOME<br>
&gt; &gt;&gt; patch.<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; Thanks,<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; Amit Margalit<br>
&gt; &gt;&gt; IBM XIV - Storage Reinvented<br>
&gt; &gt;&gt; XIV-NAS Development Team<br>
&gt; &gt;&gt; Tel. 03-689-7774<br>
&gt; &gt;&gt; Fax. 03-689-7230<br>
&gt; &gt;&gt; _______________________________________________<br>
&gt; &gt;&gt; lttng-dev mailing list<br>
&gt; &gt;&gt; lttng-dev@lists.lttng.org<br>
&gt; &gt;&gt; </font></tt><a href="http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev"><tt><font size=2>http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev</font></tt></a><tt><font size=2><br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; --<br>
&gt; &gt; Mathieu Desnoyers<br>
&gt; &gt; EfficiOS Inc.<br>
&gt; &gt; </font></tt><a href=http://www.efficios.com/><tt><font size=2>http://www.efficios.com</font></tt></a><tt><font size=2><br>
&gt; &gt;<br>
&gt; &gt; _______________________________________________<br>
&gt; &gt; lttng-dev mailing list<br>
&gt; &gt; lttng-dev@lists.lttng.org<br>
&gt; &gt; </font></tt><a href="http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev"><tt><font size=2>http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev</font></tt></a><tt><font size=2><br>
<br>
-- <br>
Mathieu Desnoyers<br>
EfficiOS Inc.<br>
</font></tt><a href=http://www.efficios.com/><tt><font size=2>http://www.efficios.com</font></tt></a><tt><font size=2><br>
<br>
</font></tt>
<br>
--=_alternative 00276BB3C2257B8F_=--



--===============2032316053==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============2032316053==--
