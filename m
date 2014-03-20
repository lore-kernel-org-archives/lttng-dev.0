From: Amit Margalit <AMITM@il.ibm.com>
Subject: Re: Performance impact using the "filter" option
Date: Thu, 20 Mar 2014 09:40:15 +0200
Message-ID: <OF2DF1AD2C.4026F6F2-ONC2257CA1.0029FCAA-C2257CA1.002A31CF__42524.2533012808$1395301287$gmane$org@il.ibm.com>
References: <CANRvXTMAYGjiQsRO+-4wsGQkaTVpBGtuuoUu=E-SVuMU5BXFLw@mail.gmail.com>
	<173115420.1939299.1395262124153.JavaMail.root@polymtl.ca>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1410005708=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from e06smtp13.uk.ibm.com ([195.75.94.109])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <amitm@il.ibm.com>) id 1WQXae-0005Hr-6m
	for lttng-dev@lists.lttng.org; Thu, 20 Mar 2014 03:40:37 -0400
Received: from /spool/local
	by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <lttng-dev@lists.lttng.org> from <amitm@il.ibm.com>;
	Thu, 20 Mar 2014 07:40:30 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com
	(d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
	by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id 56BEC2190041
	for <lttng-dev@lists.lttng.org>; Thu, 20 Mar 2014 07:40:23 +0000 (GMT)
Received: from d06av07.portsmouth.uk.ibm.com (d06av07.portsmouth.uk.ibm.com
	[9.149.37.248])
	by b06cxnps4076.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with
	ESMTP id s2K7eGvl56229976
	for <lttng-dev@lists.lttng.org>; Thu, 20 Mar 2014 07:40:16 GMT
Received: from d06av07.portsmouth.uk.ibm.com (localhost [127.0.0.1])
	by d06av07.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with
	ESMTP id s2K7eRan013976
	for <lttng-dev@lists.lttng.org>; Thu, 20 Mar 2014 03:40:27 -0400
Received: from d06ml311.portsmouth.uk.ibm.com (d06ml311.portsmouth.uk.ibm.com
	[9.149.104.181])
	by d06av07.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with
	ESMTP id s2K7eR2m013973
	for <lttng-dev@lists.lttng.org>; Thu, 20 Mar 2014 03:40:27 -0400
In-Reply-To: <173115420.1939299.1395262124153.JavaMail.root@polymtl.ca>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Michel Dagenais <michel.dagenais@polymtl.ca>
Cc: Ilya Mirsky <ilya.mirsky@gmail.com>, lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

This is a multipart message in MIME format.
--===============1410005708==
Content-Type: multipart/alternative; boundary="=_alternative 002A3190C2257CA1_="

This is a multipart message in MIME format.
--=_alternative 002A3190C2257CA1_=
Content-Type: text/plain; charset="US-ASCII"

I agree here - without knowledge of the exact scenario, it's hard to tell.

Sometimes you need to run the test through many billions of events to see 
a difference.

Consider this - the filter could be complicated and the event could be 
tiny (say, one integer). In this case, filtering would hurt you even if 
99% of events are not written to the buffer.

Amit Margalit
IBM XIV - Storage Reinvented
XIV-NAS Development Team
Tel. 03-689-7774
Fax. 03-689-7230



From:   Michel Dagenais <michel.dagenais@polymtl.ca>
To:     Ilya Mirsky <ilya.mirsky@gmail.com>
Cc:     Amit Margalit/Israel/IBM@IBMIL, lttng-dev@lists.lttng.org
Date:   03/19/2014 10:48 PM
Subject:        Re: [lttng-dev] Performance impact using the "filter" 
option




That's what I thought, but benchmarking showed that there's practically no 
difference.
The filter is a simple ID comparison of the form 'id % 1,000 == 0', so 999 
out of 1K tracepoints are filtered out.
Could you please point me to some references on this topic?
What is the running time and trace size with tracing disabled, with 
tracing enabled unconditionally, and with tracing under condition? If 
tracing takes negligible time, filtering will not change much. Note that I 
have not experimented with the current UST filter implementation but with 
a similar facility in GDB and an in-kernel prototype.
This article is not directly related but discusses many of these issues
http://benthamscience.com/open/tocsj/articles/V006/11TOCSJ.htm

--=_alternative 002A3190C2257CA1_=
Content-Type: text/html; charset="US-ASCII"

<font size=2 face="sans-serif">I agree here - without knowledge of the
exact scenario, it's hard to tell.</font>
<br>
<br><font size=2 face="sans-serif">Sometimes you need to run the test through
many billions of events to see a difference.</font>
<br>
<br><font size=2 face="sans-serif">Consider this - the filter could be
complicated and the event could be tiny (say, one integer). In this case,
filtering would hurt you even if 99% of events are not written to the buffer.</font>
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
&nbsp;</font><font size=1 face="sans-serif">Michel Dagenais &lt;michel.dagenais@polymtl.ca&gt;</font>
<br><font size=1 color=#5f5f5f face="sans-serif">To: &nbsp; &nbsp; &nbsp;
&nbsp;</font><font size=1 face="sans-serif">Ilya Mirsky &lt;ilya.mirsky@gmail.com&gt;</font>
<br><font size=1 color=#5f5f5f face="sans-serif">Cc: &nbsp; &nbsp; &nbsp;
&nbsp;</font><font size=1 face="sans-serif">Amit Margalit/Israel/IBM@IBMIL,
lttng-dev@lists.lttng.org</font>
<br><font size=1 color=#5f5f5f face="sans-serif">Date: &nbsp; &nbsp; &nbsp;
&nbsp;</font><font size=1 face="sans-serif">03/19/2014 10:48 PM</font>
<br><font size=1 color=#5f5f5f face="sans-serif">Subject: &nbsp; &nbsp;
&nbsp; &nbsp;</font><font size=1 face="sans-serif">Re: [lttng-dev]
Performance impact using the &quot;filter&quot; option</font>
<br>
<hr noshade>
<br>
<br>
<br>
<br><font size=3 face="Arial">That's what I thought, but benchmarking showed
that there's practically no difference.</font>
<br><font size=3 face="Arial">The filter is a simple ID comparison of the
form 'id % 1,000 == 0', so 999 out of 1K tracepoints are filtered out.</font>
<br><font size=3 face="Arial">Could you please point me to some references
on this topic?</font>
<br><font size=3>What is the running time and trace size with tracing disabled,
with tracing enabled unconditionally, and with tracing under condition?
If tracing takes negligible time, filtering will not change much. Note
that I have not experimented with the current UST filter implementation
but with a similar facility in GDB and an in-kernel prototype.</font>
<br><font size=3>This article is not directly related but discusses many
of these issues<br>
</font><a href=http://benthamscience.com/open/tocsj/articles/V006/11TOCSJ.htm><font size=3>http://benthamscience.com/open/tocsj/articles/V006/11TOCSJ.htm</font></a>
<br>
--=_alternative 002A3190C2257CA1_=--



--===============1410005708==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1410005708==--
