From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Performance impact using the "filter" option
Date: Thu, 20 Mar 2014 14:15:21 +0000 (UTC)
Message-ID: <1791150730.7577.1395324921713.JavaMail.zimbra__8891.28592466495$1395325034$gmane$org@efficios.com>
References: <CANRvXTMAYGjiQsRO+-4wsGQkaTVpBGtuuoUu=E-SVuMU5BXFLw@mail.gmail.com>
	<173115420.1939299.1395262124153.JavaMail.root@polymtl.ca>
	<OF2DF1AD2C.4026F6F2-ONC2257CA1.0029FCAA-C2257CA1.002A31CF@il.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2043640677=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@efficios.com>) id 1WQdkg-0000Sa-Lj
	for lttng-dev@lists.lttng.org; Thu, 20 Mar 2014 10:15:24 -0400
In-Reply-To: <OF2DF1AD2C.4026F6F2-ONC2257CA1.0029FCAA-C2257CA1.002A31CF@il.ibm.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Amit Margalit <AMITM@il.ibm.com>
Cc: Ilya Mirsky <ilya.mirsky@gmail.com>, lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--===============2043640677==
Content-Type: multipart/alternative;
	boundary="----=_Part_7576_192660737.1395324921712"

------=_Part_7576_192660737.1395324921712
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

Other relevant questions are: is the information kept in memory buffers (flight recorder tracing) 
or send to a disk/network output ? When not using the filter, is the ring buffer is "discard" mode, 
or "overwrite" (used for snapshot mode). 

If in discard mode, are there a lot of events discarded ? All those configuration options change 
the picture very significantly. If, for instance, we end up comparing "event discarded" hit most 
of the time with filtering out an event, it's very much possible that the event discard is faster. 
But this is just an artifact of testing in a condition where the data throughput produced by 
the application is larger than what the consumer can cope with (and thus not an expected 
scenario). 

On Intel i7, I had about 50ns runtime cost to filter out an event based on two integer 
comparisons, compared to approx. 250ns to trace the event to a ring buffer in "snapshot 
mode" (overwrite). Then, if we start adding network or disk I/O into the picture by 
configuring the buffers in non-snapshot mode (discard mode), then we have to make 
sure we benchmark in conditions where there are not plenty of discarded events. 

Thanks, 

Mathieu 

----- Original Message -----

> From: "Amit Margalit" <AMITM@il.ibm.com>
> To: "Michel Dagenais" <michel.dagenais@polymtl.ca>
> Cc: "Ilya Mirsky" <ilya.mirsky@gmail.com>, lttng-dev@lists.lttng.org
> Sent: Thursday, March 20, 2014 3:40:15 AM
> Subject: Re: [lttng-dev] Performance impact using the "filter" option

> I agree here - without knowledge of the exact scenario, it's hard to tell.

> Sometimes you need to run the test through many billions of events to see a
> difference.

> Consider this - the filter could be complicated and the event could be tiny
> (say, one integer). In this case, filtering would hurt you even if 99% of
> events are not written to the buffer.

> Amit Margalit
> IBM XIV - Storage Reinvented
> XIV-NAS Development Team
> Tel. 03 -689-7774
> Fax. 03-689-7230

> From: Michel Dagenais <michel.dagenais@polymtl.ca>
> To: Ilya Mirsky <ilya.mirsky@gmail.com>
> Cc: Amit Margalit/Israel/IBM@IBMIL, lttng-dev@lists.lttng.org
> Date: 03/19/2014 10:48 PM
> Subject: Re: [lttng-dev] Performance impact using the "filter" option

> That's what I thought, but benchmarking showed that there's practically no
> difference.
> The filter is a simple ID comparison of the form 'id % 1,000 == 0', so 999
> out of 1K tracepoints are filtered out.
> Could you please point me to some references on this topic?
> What is the running time and trace size with tracing disabled, with tracing
> enabled unconditionally, and with tracing under condition? If tracing takes
> negligible time, filtering will not change much. Note that I have not
> experimented with the current UST filter implementation but with a similar
> facility in GDB and an in-kernel prototype.
> This article is not directly related but discusses many of these issues
> http://benthamscience.com/open/tocsj/articles/V006/11TOCSJ.htm

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers 
EfficiOS Inc. 
http://www.efficios.com 

------=_Part_7576_192660737.1395324921712
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-family: times new roman, new york, times, se=
rif; font-size: 12pt; color: #000000"><div>Other relevant questions are: is=
 the information kept in memory buffers (flight recorder tracing)<br></div>=
<div>or send to a disk/network output ? When not using the filter, is the r=
ing buffer is "discard" mode,<br></div><div>or "overwrite" (used for snapsh=
ot mode).<br></div><div><br></div><div>If in discard mode, are there a lot =
of events discarded ? All those configuration options change</div><div>the =
picture very significantly. If, for instance, we end up comparing "event di=
scarded" hit most<br></div><div>of the time with filtering out an event, it=
's very much possible that the event discard is faster.<br></div><div>But t=
his is just an artifact of testing in a condition where the data throughput=
 produced by<br></div><div>the application is larger than what the consumer=
 can cope with (and thus not an expected<br></div><div>scenario).<br></div>=
<div><br></div><div>On Intel i7, I had about 50ns runtime cost to filter ou=
t an event based on two integer</div><div>comparisons, compared to approx. =
250ns to trace the event to a ring buffer in "snapshot<br></div><div>mode" =
(overwrite). Then, if we start adding network or disk I/O into the picture =
by<br></div><div>configuring the buffers in non-snapshot mode (discard mode=
), then we have to make<br></div><div>sure we benchmark in conditions where=
 there are not plenty of discarded events.<br></div><div><br></div><div>Tha=
nks,<br></div><div><br></div><div>Mathieu<br></div><div><br></div><div><br>=
</div><hr id=3D"zwchr"><blockquote style=3D"border-left:2px solid #1010FF;m=
argin-left:5px;padding-left:5px;color:#000;font-weight:normal;font-style:no=
rmal;text-decoration:none;font-family:Helvetica,Arial,sans-serif;font-size:=
12pt;"><b>From: </b>"Amit Margalit" &lt;AMITM@il.ibm.com&gt;<br><b>To: </b>=
"Michel Dagenais" &lt;michel.dagenais@polymtl.ca&gt;<br><b>Cc: </b>"Ilya Mi=
rsky" &lt;ilya.mirsky@gmail.com&gt;, lttng-dev@lists.lttng.org<br><b>Sent: =
</b>Thursday, March 20, 2014 3:40:15 AM<br><b>Subject: </b>Re: [lttng-dev] =
Performance impact using the "filter" option<br><div><br></div><span style=
=3D"font-family: sans-serif; font-size: small;" data-mce-style=3D"font-fami=
ly: sans-serif; font-size: small;" face=3D"sans-serif" size=3D"2">I agree h=
ere - without knowledge of the
exact scenario, it's hard to tell.</span>
<br>
<br><span style=3D"font-family: sans-serif; font-size: small;" data-mce-sty=
le=3D"font-family: sans-serif; font-size: small;" face=3D"sans-serif" size=
=3D"2">Sometimes you need to run the test through
many billions of events to see a difference.</span>
<br>
<br><span style=3D"font-family: sans-serif; font-size: small;" data-mce-sty=
le=3D"font-family: sans-serif; font-size: small;" face=3D"sans-serif" size=
=3D"2">Consider this - the filter could be
complicated and the event could be tiny (say, one integer). In this case,
filtering would hurt you even if 99% of events are not written to the buffe=
r.</span>
<br>
<br><span style=3D"color: #000080; font-family: sans-serif; font-size: smal=
l;" data-mce-style=3D"color: #000080; font-family: sans-serif; font-size: s=
mall;" color=3D"#000080" face=3D"sans-serif" size=3D"2">Amit Margalit</span=
>
<br><span style=3D"color: #808000; font-family: sans-serif; font-size: smal=
l;" data-mce-style=3D"color: #808000; font-family: sans-serif; font-size: s=
mall;" color=3D"#808000" face=3D"sans-serif" size=3D"2">IBM XIV </span><spa=
n style=3D"font-family: sans-serif; font-size: small;" data-mce-style=3D"fo=
nt-family: sans-serif; font-size: small;" face=3D"sans-serif" size=3D"2">-
<i>Storage Reinvented</i></span>
<br><span style=3D"font-family: sans-serif; font-size: small;" data-mce-sty=
le=3D"font-family: sans-serif; font-size: small;" face=3D"sans-serif" size=
=3D"2">XIV-NAS Development Team</span>
<br><span style=3D"font-family: sans-serif; font-size: small;" data-mce-sty=
le=3D"font-family: sans-serif; font-size: small;" face=3D"sans-serif" size=
=3D"2">Tel. 03</span><span style=3D"font-family: Arial; font-size: small;" =
data-mce-style=3D"font-family: Arial; font-size: small;" face=3D"Arial" siz=
e=3D"2">-689-7774</span>
<br><span style=3D"font-family: Arial; font-size: small;" data-mce-style=3D=
"font-family: Arial; font-size: small;" face=3D"Arial" size=3D"2">Fax. 03-6=
89-7230</span>
<br>
<br>
<br>
<br><span style=3D"color: #5f5f5f; font-family: sans-serif; font-size: xx-s=
mall;" data-mce-style=3D"color: #5f5f5f; font-family: sans-serif; font-size=
: xx-small;" color=3D"#5f5f5f" face=3D"sans-serif" size=3D"1">From: &nbsp; =
&nbsp; &nbsp;
&nbsp;</span><span style=3D"font-family: sans-serif; font-size: xx-small;" =
data-mce-style=3D"font-family: sans-serif; font-size: xx-small;" face=3D"sa=
ns-serif" size=3D"1">Michel Dagenais &lt;michel.dagenais@polymtl.ca&gt;</sp=
an>
<br><span style=3D"color: #5f5f5f; font-family: sans-serif; font-size: xx-s=
mall;" data-mce-style=3D"color: #5f5f5f; font-family: sans-serif; font-size=
: xx-small;" color=3D"#5f5f5f" face=3D"sans-serif" size=3D"1">To: &nbsp; &n=
bsp; &nbsp;
&nbsp;</span><span style=3D"font-family: sans-serif; font-size: xx-small;" =
data-mce-style=3D"font-family: sans-serif; font-size: xx-small;" face=3D"sa=
ns-serif" size=3D"1">Ilya Mirsky &lt;ilya.mirsky@gmail.com&gt;</span>
<br><span style=3D"color: #5f5f5f; font-family: sans-serif; font-size: xx-s=
mall;" data-mce-style=3D"color: #5f5f5f; font-family: sans-serif; font-size=
: xx-small;" color=3D"#5f5f5f" face=3D"sans-serif" size=3D"1">Cc: &nbsp; &n=
bsp; &nbsp;
&nbsp;</span><span style=3D"font-family: sans-serif; font-size: xx-small;" =
data-mce-style=3D"font-family: sans-serif; font-size: xx-small;" face=3D"sa=
ns-serif" size=3D"1">Amit Margalit/Israel/IBM@IBMIL,
lttng-dev@lists.lttng.org</span>
<br><span style=3D"color: #5f5f5f; font-family: sans-serif; font-size: xx-s=
mall;" data-mce-style=3D"color: #5f5f5f; font-family: sans-serif; font-size=
: xx-small;" color=3D"#5f5f5f" face=3D"sans-serif" size=3D"1">Date: &nbsp; =
&nbsp; &nbsp;
&nbsp;</span><span style=3D"font-family: sans-serif; font-size: xx-small;" =
data-mce-style=3D"font-family: sans-serif; font-size: xx-small;" face=3D"sa=
ns-serif" size=3D"1">03/19/2014 10:48 PM</span>
<br><span style=3D"color: #5f5f5f; font-family: sans-serif; font-size: xx-s=
mall;" data-mce-style=3D"color: #5f5f5f; font-family: sans-serif; font-size=
: xx-small;" color=3D"#5f5f5f" face=3D"sans-serif" size=3D"1">Subject: &nbs=
p; &nbsp;
&nbsp; &nbsp;</span><span style=3D"font-family: sans-serif; font-size: xx-s=
mall;" data-mce-style=3D"font-family: sans-serif; font-size: xx-small;" fac=
e=3D"sans-serif" size=3D"1">Re: [lttng-dev]
Performance impact using the "filter" option</span>
<br>
<hr noshade=3D"">
<br>
<br>
<br>
<br><span style=3D"font-family: Arial; font-size: medium;" data-mce-style=
=3D"font-family: Arial; font-size: medium;" face=3D"Arial" size=3D"3">That'=
s what I thought, but benchmarking showed
that there's practically no difference.</span>
<br><span style=3D"font-family: Arial; font-size: medium;" data-mce-style=
=3D"font-family: Arial; font-size: medium;" face=3D"Arial" size=3D"3">The f=
ilter is a simple ID comparison of the
form 'id % 1,000 =3D=3D 0', so 999 out of 1K tracepoints are filtered out.<=
/span>
<br><span style=3D"font-family: Arial; font-size: medium;" data-mce-style=
=3D"font-family: Arial; font-size: medium;" face=3D"Arial" size=3D"3">Could=
 you please point me to some references
on this topic?</span>
<br><span style=3D"font-size: medium;" data-mce-style=3D"font-size: medium;=
" size=3D"3">What is the running time and trace size with tracing disabled,
with tracing enabled unconditionally, and with tracing under condition?
If tracing takes negligible time, filtering will not change much. Note
that I have not experimented with the current UST filter implementation
but with a similar facility in GDB and an in-kernel prototype.</span>
<br><span style=3D"font-size: medium;" data-mce-style=3D"font-size: medium;=
" size=3D"3">This article is not directly related but discusses many
of these issues<br>
</span><a href=3D"http://benthamscience.com/open/tocsj/articles/V006/11TOCS=
J.htm" target=3D"_blank"><span style=3D"font-size: medium;" data-mce-style=
=3D"font-size: medium;" size=3D"3">http://benthamscience.com/open/tocsj/art=
icles/V006/11TOCSJ.htm</span></a>
<br><div><br></div>_______________________________________________<br>lttng=
-dev mailing list<br>lttng-dev@lists.lttng.org<br>http://lists.lttng.org/cg=
i-bin/mailman/listinfo/lttng-dev<br></blockquote><div><br><br></div><div><b=
r></div><div>-- <br></div><div><span name=3D"x"></span>Mathieu Desnoyers<br=
>EfficiOS Inc.<br>http://www.efficios.com<span name=3D"x"></span><br></div>=
</div></body></html>
------=_Part_7576_192660737.1395324921712--


--===============2043640677==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============2043640677==--
