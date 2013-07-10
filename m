From: Amit Margalit <AMITM@il.ibm.com>
Subject: Re: Question about performance and tracepoint structure
Date: Wed, 10 Jul 2013 22:15:58 +0300
Message-ID: <OF0B2972A5.1A6DD673-ONC2257BA4.00624452-C2257BA4.0069C420__16347.8542272516$1373483824$gmane$org@il.ibm.com>
References: <OFA2CEA64A.AB33A759-ONC2257BA4.005E65A6-C2257BA4.005EDCF5@il.ibm.com>
	<20130710172554.GA8938@Krystal>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1695412091=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from e06smtp15.uk.ibm.com ([195.75.94.111])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <amitm@il.ibm.com>) id 1UwzsC-0006Dq-21
	for lttng-dev@lists.lttng.org; Wed, 10 Jul 2013 15:16:20 -0400
Received: from /spool/local
	by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <lttng-dev@lists.lttng.org> from <amitm@il.ibm.com>;
	Wed, 10 Jul 2013 20:11:23 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com
	(d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
	by d06dlp03.portsmouth.uk.ibm.com (Postfix) with ESMTP id 9C97A1B0805D
	for <lttng-dev@lists.lttng.org>; Wed, 10 Jul 2013 20:16:12 +0100 (BST)
Received: from d06av07.portsmouth.uk.ibm.com (d06av07.portsmouth.uk.ibm.com
	[9.149.37.248])
	by b06cxnps4076.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with
	ESMTP id r6AJG1x350659572
	for <lttng-dev@lists.lttng.org>; Wed, 10 Jul 2013 19:16:01 GMT
Received: from d06av07.portsmouth.uk.ibm.com (localhost [127.0.0.1])
	by d06av07.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with
	ESMTP id r6AJGBVQ028217
	for <lttng-dev@lists.lttng.org>; Wed, 10 Jul 2013 15:16:12 -0400
In-Reply-To: <20130710172554.GA8938@Krystal>
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
--===============1695412091==
Content-Type: multipart/alternative; boundary="=_alternative 0069C3EBC2257BA4_="

This is a multipart message in MIME format.
--=_alternative 0069C3EBC2257BA4_=
Content-Type: text/plain; charset="US-ASCII"

Thanks, that helps a lot.

By the way - how do strings fit in this? Is it best that they are last? 
Maybe best they are first being the largest?

Amit Margalit
IBM XIV - Storage Reinvented
XIV-NAS Development Team
Tel. 03-689-7774
Fax. 03-689-7230



From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Amit Margalit/Israel/IBM@IBMIL
Cc:     lttng-dev@lists.lttng.org
Date:   07/10/2013 08:25 PM
Subject:        Re: [lttng-dev] Question about performance and tracepoint 
structure



* Amit Margalit (AMITM@il.ibm.com) wrote:
> Hi,
> 
> This may be a bit of a noob question, and I think I read about this 
> somewhere but I can't find it now.
> 
> When I declare a tracepoint that's made up of a uint8_t, followed by a 
> uint16_t followed by a uint32_t, for example, there are 2 ways to handle 

> this - packed or unpacked.
> 
> If we're doing packed, then we have to include some code that does the 
> packing properly as alignment issues can creep up. This code causes us 
to 
> incur some CPU cycles at that point.

it's not code. it's just that cpus are slightly slower at doing
unaligned accesses than aligned accesses.

> If we're doing unpacked, then we incur some cycles on passing the event 
to 
> the sessiond, and sessiond suffers by having to write down some extra 
> bytes, which is less efficient.

yes

> 
> Either way, I think it means I can gain some minor performance 
> improvements if I reorder my tracepoint arguments to a more efficient 
> order - alignment-wise.

Well, yes. You will want to reorder the tracepoint "TP_FIELDS" so the
largest fields come first, followed by the smaller fields.

The order of arguments (TP_ARGS) does not matter.

Thanks,

Mathieu

> 
> Am I barking up the wrong tree here?
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



--=_alternative 0069C3EBC2257BA4_=
Content-Type: text/html; charset="US-ASCII"

<font size=2 face="sans-serif">Thanks, that helps a lot.</font>
<br>
<br><font size=2 face="sans-serif">By the way - how do strings fit in this?
Is it best that they are last? Maybe best they are first being the largest?</font>
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
&nbsp;</font><font size=1 face="sans-serif">07/10/2013 08:25 PM</font>
<br><font size=1 color=#5f5f5f face="sans-serif">Subject: &nbsp; &nbsp;
&nbsp; &nbsp;</font><font size=1 face="sans-serif">Re: [lttng-dev]
Question about performance and tracepoint structure</font>
<br>
<hr noshade>
<br>
<br>
<br><tt><font size=2>* Amit Margalit (AMITM@il.ibm.com) wrote:<br>
&gt; Hi,<br>
&gt; <br>
&gt; This may be a bit of a noob question, and I think I read about this
<br>
&gt; somewhere but I can't find it now.<br>
&gt; <br>
&gt; When I declare a tracepoint that's made up of a uint8_t, followed
by a <br>
&gt; uint16_t followed by a uint32_t, for example, there are 2 ways to
handle <br>
&gt; this - packed or unpacked.<br>
&gt; <br>
&gt; If we're doing packed, then we have to include some code that does
the <br>
&gt; packing properly as alignment issues can creep up. This code causes
us to <br>
&gt; incur some CPU cycles at that point.<br>
<br>
it's not code. it's just that cpus are slightly slower at doing<br>
unaligned accesses than aligned accesses.<br>
<br>
&gt; If we're doing unpacked, then we incur some cycles on passing the
event to <br>
&gt; the sessiond, and sessiond suffers by having to write down some extra
<br>
&gt; bytes, which is less efficient.<br>
<br>
yes<br>
<br>
&gt; <br>
&gt; Either way, I think it means I can gain some minor performance <br>
&gt; improvements if I reorder my tracepoint arguments to a more efficient
<br>
&gt; order - alignment-wise.<br>
<br>
Well, yes. You will want to reorder the tracepoint &quot;TP_FIELDS&quot;
so the<br>
largest fields come first, followed by the smaller fields.<br>
<br>
The order of arguments (TP_ARGS) does not matter.<br>
<br>
Thanks,<br>
<br>
Mathieu<br>
<br>
&gt; <br>
&gt; Am I barking up the wrong tree here?<br>
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
--=_alternative 0069C3EBC2257BA4_=--



--===============1695412091==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1695412091==--
