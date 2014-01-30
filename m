From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Lttng state dump traces not present in 13.04 Ubuntu
 server distribution
Date: Thu, 30 Jan 2014 22:54:19 +0000 (UTC)
Message-ID: <275408743.15986.1391122459985.JavaMail.zimbra__44438.9630378739$1391122529$gmane$org@efficios.com>
References: <CAAoqFdREb-auZ90-w20adi8vrBSisFrZcVCREBDZwgjS0OK7dA@mail.gmail.com>
	<52E161A8.4070908@voxpopuli.im>
	<CAAoqFdRZaoLW_r2bdaZvU+wwMtMS1nHuBNkumznqRY-_yOPh6g@mail.gmail.com>
	<52E2AE2E.2020907@voxpopuli.im>
	<CAAoqFdTREawK0vSn1aVLCGs9PhFj8JJNjsHopiE8G8dYHv_6zQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0639168724=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@efficios.com>) id 1W90V7-0004Ct-73
	for lttng-dev@lists.lttng.org; Thu, 30 Jan 2014 17:54:31 -0500
In-Reply-To: <CAAoqFdTREawK0vSn1aVLCGs9PhFj8JJNjsHopiE8G8dYHv_6zQ@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Krishanth TJ <krishanthtj@gmail.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--===============0639168724==
Content-Type: multipart/alternative;
	boundary="----=_Part_15985_1034723507.1391122459984"

------=_Part_15985_1034723507.1391122459984
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

There are a few things to double-check: 

- that the module holding the statedump event does not taint the kernel (is it signed ?) 
- that there is no conflict between the lttng-modules from Ubuntu and the one you are using, 

Also, I fixed TRACE_EVENT_MAP type of event declaration recently, but I don't think 
it is related to your issue. This is only for the cases where the event name differs between the 
Linux kernel tracepoint and the LTTng name. 

Thanks, 

Mathieu 

----- Original Message -----

> From: "Krishanth TJ" <krishanthtj@gmail.com>
> To: "Alexandre Montplaisir" <alexmonthy@voxpopuli.im>
> Cc: lttng-dev@lists.lttng.org
> Sent: Monday, January 27, 2014 1:00:44 AM
> Subject: Re: [lttng-dev] Lttng state dump traces not present in 13.04 Ubuntu
> server distribution

> Yes, they do appear in "lttng list -k" event list.

> Regards,
> Krish.

> On Fri, Jan 24, 2014 at 11:47 PM, Alexandre Montplaisir <
> alexmonthy@voxpopuli.im > wrote:

> > Hmm, ok, if you use "lttng list -k" do they appear in the list of
> 
> > available events?
> 

> > One other thing I can think about is that the statedump itself takes a
> 
> > little bit of time to execute, so the statedump events are never at the
> 
> > very start of the trace. So if your traces are very short it's possible
> 
> > to miss them entirely.
> 

> > Cheers,
> 
> > Alexandre
> 

> > On 14-01-24 08:54 AM, Krishanth TJ wrote:
> 
> > > Hi,
> 
> > >
> 
> > > I have confirmed that the "lttng-modules-dkms" package was successfully
> 
> > > installed.
> 
> > >
> 
> > > $ cat /usr/src/lttng-modules-2.3.x+stable/ChangeLog | head -4
> 
> > > 2013-09-28 LTTng modules 2.3.2
> 
> > > * Blacklist kernels 3.10.13 and 3.11.2
> 
> > >
> 
> > > I have even confirmed with few debug printk's in lttng_statedump.ko that
> 
> > > the module is indeed loaded and the tracepoints are getting called. But
> 
> > > still babeltrace output fails to show lttng_statedump_events.
> 
> > >
> 
> > > Am I missing something here?
> 
> > >
> 
> > > Regards,
> 
> > > Krish.
> 
> > >
> 

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers 
EfficiOS Inc. 
http://www.efficios.com 

------=_Part_15985_1034723507.1391122459984
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-family: times new roman, new york, times, se=
rif; font-size: 12pt; color: #000000"><div>There are a few things to double=
-check:<br></div><div><br></div><div>- that the module holding the statedum=
p event does not taint the kernel (is it signed ?)<br></div><div>- that the=
re is no conflict between the lttng-modules from Ubuntu and the one you are=
 using,<br></div><div><br></div><div>Also, I fixed TRACE_EVENT_MAP type of =
event declaration recently, but I don't think<br></div><div>it is related t=
o your issue. This is only for the cases where the event name differs betwe=
en the<br></div><div>Linux kernel tracepoint and the LTTng name.<br></div><=
div><br></div><div>Thanks,<br></div><div><br></div><div>Mathieu<br></div><d=
iv><br></div><div><br></div><hr id=3D"zwchr"><blockquote style=3D"border-le=
ft:2px solid #1010FF;margin-left:5px;padding-left:5px;color:#000;font-weigh=
t:normal;font-style:normal;text-decoration:none;font-family:Helvetica,Arial=
,sans-serif;font-size:12pt;"><b>From: </b>"Krishanth TJ" &lt;krishanthtj@gm=
ail.com&gt;<br><b>To: </b>"Alexandre Montplaisir" &lt;alexmonthy@voxpopuli.=
im&gt;<br><b>Cc: </b>lttng-dev@lists.lttng.org<br><b>Sent: </b>Monday, Janu=
ary 27, 2014 1:00:44 AM<br><b>Subject: </b>Re: [lttng-dev] Lttng state dump=
 traces not present in 13.04 Ubuntu server distribution<br><div><br></div><=
div dir=3D"ltr"><br><div class=3D"gmail_extra">Yes, they do appear in "lttn=
g list -k" event list.<br><div><br></div></div><div class=3D"gmail_extra">R=
egards,<br></div><div class=3D"gmail_extra">Krish.<br></div><div class=3D"g=
mail_extra">
<br><div class=3D"gmail_quote">On Fri, Jan 24, 2014 at 11:47 PM, Alexandre =
Montplaisir <span dir=3D"ltr">&lt;<a href=3D"mailto:alexmonthy@voxpopuli.im=
" target=3D"_blank">alexmonthy@voxpopuli.im</a>&gt;</span> wrote:<br><block=
quote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1=
px solid rgb(204,204,204);padding-left:1ex">
Hmm, ok, if you use "lttng list -k" do they appear in the list of<br>
available events?<br>
<br>
One other thing I can think about is that the statedump itself takes a<br>
little bit of time to execute, so the statedump events are never at the<br>
very start of the trace. So if your traces are very short it's possible<br>
to miss them entirely.<br>
<br>
Cheers,<br>
Alexandre<br>
<div class=3D""><div class=3D"h5"><br>
<br>
On 14-01-24 08:54 AM, Krishanth TJ wrote:<br>
&gt; Hi,<br>
&gt;<br>
&gt; I have confirmed that the "lttng-modules-dkms" package was successfull=
y<br>
&gt; installed.<br>
&gt;<br>
&gt; $ cat /usr/src/lttng-modules-2.3.x+stable/ChangeLog | head -4<br>
&gt; 2013-09-28 LTTng modules 2.3.2<br>
&gt; &nbsp; &nbsp; * Blacklist kernels 3.10.13 and 3.11.2<br>
&gt;<br>
&gt; I have even confirmed with few debug printk's in lttng_statedump.ko th=
at<br>
&gt; the module is indeed loaded and the tracepoints are getting called. Bu=
t<br>
&gt; still babeltrace output fails to show lttng_statedump_events.<br>
&gt;<br>
&gt; Am I missing something here?<br>
&gt;<br>
&gt; Regards,<br>
&gt; Krish.<br>
&gt;<br>
<br>
</div></div></blockquote></div><br></div></div>
<br>_______________________________________________<br>lttng-dev mailing li=
st<br>lttng-dev@lists.lttng.org<br>http://lists.lttng.org/cgi-bin/mailman/l=
istinfo/lttng-dev<br></blockquote><div><br><br></div><div><br></div><div>--=
 <br></div><div><span name=3D"x"></span>Mathieu Desnoyers<br>EfficiOS Inc.<=
br>http://www.efficios.com<span name=3D"x"></span><br></div></div></body></=
html>
------=_Part_15985_1034723507.1391122459984--


--===============0639168724==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0639168724==--
