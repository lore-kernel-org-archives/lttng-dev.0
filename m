From: Amit Margalit <AMITM@il.ibm.com>
Subject: Re: How much shared memory is used by LTTng (UST) ?
Date: Wed, 10 Jul 2013 17:18:44 +0300
Message-ID: <OF915EC9C3.D105E64F-ONC2257BA4.004D98BF-C2257BA4.004E8DA6__17524.392650421$1373466001$gmane$org@il.ibm.com>
References: <OFCCB7B255.8E21590D-ONC2257BA4.004A6CD2-C2257BA4.004B3116@il.ibm.com>
	<20130710135939.GA2331@Krystal>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2069545889=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from e06smtp16.uk.ibm.com ([195.75.94.112])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <amitm@il.ibm.com>) id 1UwvEb-0003py-CK
	for lttng-dev@lists.lttng.org; Wed, 10 Jul 2013 10:19:09 -0400
Received: from /spool/local
	by e06smtp16.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <lttng-dev@lists.lttng.org> from <amitm@il.ibm.com>;
	Wed, 10 Jul 2013 15:13:26 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com
	(d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
	by d06dlp03.portsmouth.uk.ibm.com (Postfix) with ESMTP id 410F31B0806E
	for <lttng-dev@lists.lttng.org>; Wed, 10 Jul 2013 15:19:00 +0100 (BST)
Received: from d06av02.portsmouth.uk.ibm.com (d06av02.portsmouth.uk.ibm.com
	[9.149.37.228])
	by b06cxnps4074.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with
	ESMTP id r6AEImCu54460470
	for <lttng-dev@lists.lttng.org>; Wed, 10 Jul 2013 14:18:48 GMT
Received: from d06av02.portsmouth.uk.ibm.com (localhost [127.0.0.1])
	by d06av02.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with
	ESMTP id r6AEIwv5015854
	for <lttng-dev@lists.lttng.org>; Wed, 10 Jul 2013 08:18:59 -0600
In-Reply-To: <20130710135939.GA2331@Krystal>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

This is a multipart message in MIME format.
--===============2069545889==
Content-Type: multipart/alternative; boundary="=_alternative 004E8D5BC2257BA4_="

This is a multipart message in MIME format.
--=_alternative 004E8D5BC2257BA4_=
Content-Type: text/plain; charset="US-ASCII"

That explains a lot. Our SHM space is hard coded to 64MB, which limits me 
big-time.

It still doesn't explain why I was able to add procname to the context but 
adding also vpid and vtid failed when the number of cores was 24 rather 
than 12.

I mean - the formula you give (and we use per-UID buffers) doesn't seem to 
be related to what's in context and what's not...

Now, on the 12 core (6+HT) system, I would need - 

nb_traced_users(=1) * subbuf_size(=256KB) * nr_subbuf(=16) * nb_cpus(=12) 
= 1*256KB*16*16 = 48MB

But the same arguments worked just fine on the 24-core system, including 
adding procname to context. Adding vtid + vpid worked on the 12-core, but 
failed on the 24-core system.

Any ideas why?

Amit Margalit
IBM XIV - Storage Reinvented
XIV-NAS Development Team
Tel. 03-689-7774
Fax. 03-689-7230



From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Amit Margalit/Israel/IBM@IBMIL
Cc:     lttng-dev@lists.lttng.org
Date:   07/10/2013 04:59 PM
Subject:        Re: [lttng-dev] How much shared memory is used by LTTng 
(UST) ?



* Amit Margalit (AMITM@il.ibm.com) wrote:
> Hi,
> 
> Chasing down an issue with adding some context (see 
> https://bugs.lttng.org/issues/579), I've encountered something that 
makes 
> me think the failures I am seeing are related to amount of shared memory 

> that LTTng uses...
> 
> In short - when the subbuffers have a large enough size and number, 
adding 
> things to context on a multi-core system can cause libringbuffer/shm.c 
in 
> lttng-ust to complain about "No space left on device", leading to 
> everything looking OK, except that the trace directory stays empty.
> 
> I am working on a 6-core (12 with HT) system that has 24GB of RAM. This 
is 
> one configuration, but we also have dual-CPU systems (i.e. 12 cores / 24 

> with HT) with 96GB.
> 
> I am using 16 subbuffers of 256KB. In this setup, I have no problem 
adding 
> procname, vpid and vtid to the context.
> 
> When I tried the same on the 12-core dual-CPU system, it failed as 
> explained above. I tried reducing the subbuffer sizes to 64KB, and the 
> problem disappeared.
> 
> So - how can I tell how much shared memory LTTng wants, and - if you 
know 
> - how can I configure my system to allow more than the default?

First thing, try using per-uid buffers rather than the 2.2 default
(per-pid buffers).

If you do that, then you will need:
  nb_traced_users * subbuf_size * nr_subbuf * nb_cpus   as shm space.

If you stay with per-pid buffers, then you need
  nb_processes * subbuf_size * nr_subbuf * nb_cpus   as shm space.

On my system here, I notice that each shm creates files within /run/shm
(this location may differ on your system). It is a tmpfs filesystem. You
might want to increase its size. For instance, here, it is 1.6GB.

Thanks,

Mathieu

> 
> Thanks,
> 
> Amit Margalit
> IBM XIV - Storage Reinvented
> XIV-NAS Development Team
> Tel. 03-689-7774
> Fax. 03-689-7230
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev


-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com



--=_alternative 004E8D5BC2257BA4_=
Content-Type: text/html; charset="US-ASCII"

<font size=2 face="sans-serif">That explains a lot. Our SHM space is hard
coded to 64MB, which limits me big-time.</font>
<br>
<br><font size=2 face="sans-serif">It still doesn't explain why I was able
to add procname to the context but adding also vpid and vtid failed when
the number of cores was 24 rather than 12.</font>
<br>
<br><font size=2 face="sans-serif">I mean - the formula you give (and we
use per-UID buffers) doesn't seem to be related to what's in context and
what's not...</font>
<br>
<br><font size=2 face="sans-serif">Now, on the 12 core (6+HT) system, I
would need - </font>
<br>
<br><tt><font size=2>nb_traced_users(=1) * subbuf_size(=256KB) * nr_subbuf(=16)
* nb_cpus(=12) = 1*256KB*16*16 = 48MB</font></tt>
<br>
<br><font size=2 face="sans-serif">But the same arguments worked just fine
on the 24-core system, including adding procname to context. Adding vtid
+ vpid worked on the 12-core, but failed on the 24-core system.</font>
<br>
<br><font size=2 face="sans-serif">Any ideas why?</font>
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
&nbsp;</font><font size=1 face="sans-serif">Amit Margalit/Israel/IBM@IBMIL</font>
<br><font size=1 color=#5f5f5f face="sans-serif">Cc: &nbsp; &nbsp; &nbsp;
&nbsp;</font><font size=1 face="sans-serif">lttng-dev@lists.lttng.org</font>
<br><font size=1 color=#5f5f5f face="sans-serif">Date: &nbsp; &nbsp; &nbsp;
&nbsp;</font><font size=1 face="sans-serif">07/10/2013 04:59 PM</font>
<br><font size=1 color=#5f5f5f face="sans-serif">Subject: &nbsp; &nbsp;
&nbsp; &nbsp;</font><font size=1 face="sans-serif">Re: [lttng-dev]
How much shared memory is used by LTTng (UST) ?</font>
<br>
<hr noshade>
<br>
<br>
<br><tt><font size=2>* Amit Margalit (AMITM@il.ibm.com) wrote:<br>
&gt; Hi,<br>
&gt; <br>
&gt; Chasing down an issue with adding some context (see <br>
&gt; </font></tt><a href=https://bugs.lttng.org/issues/579><tt><font size=2>https://bugs.lttng.org/issues/579</font></tt></a><tt><font size=2>),
I've encountered something that makes <br>
&gt; me think the failures I am seeing are related to amount of shared
memory <br>
&gt; that LTTng uses...<br>
&gt; <br>
&gt; In short - when the subbuffers have a large enough size and number,
adding <br>
&gt; things to context on a multi-core system can cause libringbuffer/shm.c
in <br>
&gt; lttng-ust to complain about &quot;No space left on device&quot;, leading
to <br>
&gt; everything looking OK, except that the trace directory stays empty.<br>
&gt; <br>
&gt; I am working on a 6-core (12 with HT) system that has 24GB of RAM.
This is <br>
&gt; one configuration, but we also have dual-CPU systems (i.e. 12 cores
/ 24 <br>
&gt; with HT) with 96GB.<br>
&gt; <br>
&gt; I am using 16 subbuffers of 256KB. In this setup, I have no problem
adding <br>
&gt; procname, vpid and vtid to the context.<br>
&gt; <br>
&gt; When I tried the same on the 12-core dual-CPU system, it failed as
<br>
&gt; explained above. I tried reducing the subbuffer sizes to 64KB, and
the <br>
&gt; problem disappeared.<br>
&gt; <br>
&gt; So - how can I tell how much shared memory LTTng wants, and - if you
know <br>
&gt; - how can I configure my system to allow more than the default?<br>
<br>
First thing, try using per-uid buffers rather than the 2.2 default<br>
(per-pid buffers).<br>
<br>
If you do that, then you will need:<br>
 &nbsp;nb_traced_users * subbuf_size * nr_subbuf * nb_cpus &nbsp; as shm
space.<br>
<br>
If you stay with per-pid buffers, then you need<br>
 &nbsp;nb_processes * subbuf_size * nr_subbuf * nb_cpus &nbsp; as shm space.<br>
<br>
On my system here, I notice that each shm creates files within /run/shm<br>
(this location may differ on your system). It is a tmpfs filesystem. You<br>
might want to increase its size. For instance, here, it is 1.6GB.<br>
<br>
Thanks,<br>
<br>
Mathieu<br>
<br>
&gt; <br>
&gt; Thanks,<br>
&gt; <br>
&gt; Amit Margalit<br>
&gt; IBM XIV - Storage Reinvented<br>
&gt; XIV-NAS Development Team<br>
&gt; Tel. 03-689-7774<br>
&gt; Fax. 03-689-7230<br>
&gt; _______________________________________________<br>
&gt; lttng-dev mailing list<br>
&gt; lttng-dev@lists.lttng.org<br>
&gt; </font></tt><a href="http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev"><tt><font size=2>http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev</font></tt></a><tt><font size=2><br>
<br>
<br>
-- <br>
Mathieu Desnoyers<br>
EfficiOS Inc.<br>
</font></tt><a href=http://www.efficios.com/><tt><font size=2>http://www.efficios.com</font></tt></a><tt><font size=2><br>
<br>
</font></tt>
<br>
--=_alternative 004E8D5BC2257BA4_=--



--===============2069545889==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============2069545889==--
