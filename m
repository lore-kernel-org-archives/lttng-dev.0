From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Correct way to use the tpl file
Date: Fri, 30 Nov 2018 12:12:43 -0500 (EST)
Message-ID: <1761020244.17267.1543597963192.JavaMail.zimbra__35252.161944709$1543597854$gmane$org@efficios.com>
References: <1543594140321.1890@BlackBox.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6207755198341442734=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 4361DM2FQQzwVZ
 for <lttng-dev@lists.lttng.org>; Fri, 30 Nov 2018 12:12:51 -0500 (EST)
In-Reply-To: <1543594140321.1890@BlackBox.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: John OSullivan <John.OSullivan@BlackBox.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============6207755198341442734==
Content-Type: multipart/alternative;
	boundary="=_65c8bfb4-ef2c-4bee-aea5-5708c7e53f12"

--=_65c8bfb4-ef2c-4bee-aea5-5708c7e53f12
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

----- On Nov 30, 2018, at 11:09 AM, John OSullivan <John.OSullivan@BlackBox.com> wrote: 

> Hi,

> I am looking for some advice on the best way to manage the tracing of some user
> space events.

> I have a series of events that are fed to queues, they look something like the
> following sample

> EventEnd* event_end_new()
> {
> EventEnd* event_end = bb_xnew(EventEnd,__func__);

> if (event_end != NULL)
> {
> event_end->type = EQ_EVENT_END;
> . .. other event specific fields here

> ..
> }
> #ifdef LTTNG_TRACE
> tracepoint(core_event_trace, end_event_tracepoint, EQ_EVENT_END);
> #endif
> return event_end;
> }

> I want to try and trace these so created the following template shown below. My
> question is, does the class have to have all of the possible members that the
> different instances will have, as each unique event is likely to have different
> members will the class have to have all of these members defines, and if this
> is the case is it okay for an instance to just implement a subset of the
> members the class defines?
I am a bit confused by your use of the word "members" here. A tracepoint class has a provider name, 
a class name, input argument, and output fields. 

The event instance refers to the class by provider and class name, defines its own name, and needs to 
have a compatible input argument prototype (same number of arguments, same types). It will serialize 
the output fields in the exact layout described by the event class. 

I know it does not directly answer your question, but I'm really unsure about what you mean 
by "members". 

Thanks, 

Mathieu 

> TRACEPOINT_EVENT_CLASS(
> /* Tracepoint provider name */
> core_event_trace,

> /* Tracepoint class name */
> core_event_tracepoint_class,

> /* Input arguments */
> TP_ARGS(
> int, event_type

> ),

> /* Output event fields */
> TP_FIELDS(
> ctf_integer(int, event_type, event_type)

> )
> )

> TRACEPOINT_EVENT_INSTANCE(
> core_event_trace,
> core_event_tracepoint_class,
> end_event_tracepoint,
> TP_ARGS(
> int, event_type

> )
> )

> TRACEPOINT_EVENT_INSTANCE(
> core_event_trace,
> core_event_tracepoint_class,
> start_event_tracepoint,
> TP_ARGS(
> int, event_type
> )
> )

> TRACEPOINT_EVENT_INSTANCE(
> core_event_trace,
> core_event_tracepoint_class,
> foo_event_tracepoint,
> TP_ARGS(
> int, event_type
> )
> )

> This email and any files transmitted with it are confidential and are intended
> for the sole use of the individual to whom they are addressed. Black Box
> Corporation reserves the right to scan all e-mail traffic for restricted
> content and to monitor all e-mail in general. If you are not the intended
> recipient or you have received this email in error, any use, dissemination or
> forwarding of this email is strictly prohibited. If you have received this
> email in error, please notify the sender by replying to this email.

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers 
EfficiOS Inc. 
http://www.efficios.com 

--=_65c8bfb4-ef2c-4bee-aea5-5708c7e53f12
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-family: arial, helvetica, sans-serif; font-s=
ize: 12pt; color: #000000"><div><style style=3D"display:none"><!--P{margin-=
top:0;margin-bottom:0;} --></style></div><div><br></div><div><br></div><div=
><span id=3D"zwchr" data-marker=3D"__DIVIDER__">----- On Nov 30, 2018, at 1=
1:09 AM, John OSullivan &lt;John.OSullivan@BlackBox.com&gt; wrote:<br></spa=
n></div><div data-marker=3D"__QUOTED_TEXT__"><blockquote style=3D"border-le=
ft:2px solid #1010FF;margin-left:5px;padding-left:5px;color:#000;font-weigh=
t:normal;font-style:normal;text-decoration:none;font-family:Helvetica,Arial=
,sans-serif;font-size:12pt;">


<p>Hi,</p>
<p>I am looking for some advice on the best way to manage the tracing of so=
me user space events.</p>
<p><br>
</p>
<p>I have a series of events that are fed to queues, they look something li=
ke the following sample<br>
</p>
<p><br>
</p>
<p><br>
</p>
<p>EventEnd* event_end_new()<br>
{<br>
&nbsp;&nbsp; &nbsp;EventEnd* event_end =3D bb_xnew(EventEnd,__func__);<br>
<br>
&nbsp;&nbsp; &nbsp;if (event_end !=3D NULL)<br>
&nbsp;&nbsp; &nbsp;{<br>
&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;event_end-&gt;type =3D EQ_EVENT_END;<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;. &nbsp; .. other event specific fields here</p>
<p>&nbsp; &nbsp; &nbsp; &nbsp; ..<br>
&nbsp;&nbsp; &nbsp;}<br>
#ifdef LTTNG_TRACE<br>
&nbsp;&nbsp; &nbsp;tracepoint(core_event_trace, end_event_tracepoint, EQ_EV=
ENT_END);<br>
#endif<br>
&nbsp;&nbsp; &nbsp;return event_end;<br>
}<br>
</p>
<p><br>
</p>
<p><br>
</p>
<p><br>
</p>
<p>I want to try and trace these so created the following template shown be=
low. My question is, does the class have to have all of the possible member=
s that the different instances will have, as each unique event is likely to=
 have different members will the
 class have to have all of these members defines, and if this is the case i=
s it okay for an instance to just implement a subset of the members the cla=
ss defines?</p></blockquote><div><br></div><div>I am a bit confused by your=
 use of the word "members" here. A tracepoint class has a provider name,<br=
 data-mce-bogus=3D"1"></div><div>a class name, input argument, and output f=
ields.<br data-mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"></div><d=
iv>The event instance refers to the class by provider and class name, defin=
es its own name, and needs to</div><div>have a compatible input argument pr=
ototype (same number of arguments, same types). It will serialize</div><div=
>the output fields in the exact layout described by the event class.<br dat=
a-mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"></div><div>I know it =
does not directly answer your question, but I'm really unsure about what yo=
u mean<br data-mce-bogus=3D"1"></div><div>by "members".<br data-mce-bogus=
=3D"1"></div><div><br data-mce-bogus=3D"1"></div><div>Thanks,<br data-mce-b=
ogus=3D"1"></div><div><br data-mce-bogus=3D"1"></div><div>Mathieu<br data-m=
ce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"></div><blockquote style=
=3D"border-left:2px solid #1010FF;margin-left:5px;padding-left:5px;color:#0=
00;font-weight:normal;font-style:normal;text-decoration:none;font-family:He=
lvetica,Arial,sans-serif;font-size:12pt;">
<p><br>
</p>
<p><br>
</p>
<p><br>
</p>
<p><br>
</p>
<p>TRACEPOINT_EVENT_CLASS(<br>
&nbsp;&nbsp;&nbsp; /* Tracepoint provider name */<br>
&nbsp;&nbsp;&nbsp; core_event_trace,<br>
<br>
&nbsp;&nbsp;&nbsp; /* Tracepoint class name */<br>
&nbsp;&nbsp;&nbsp; core_event_tracepoint_class,<br>
<br>
/* Input arguments */<br>
&nbsp;&nbsp;&nbsp; TP_ARGS(<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int, event_type<br>
<br>
&nbsp;&nbsp;&nbsp; ),<br>
<br>
&nbsp;&nbsp;&nbsp; /* Output event fields */<br>
&nbsp;&nbsp;&nbsp; TP_FIELDS(<br>
&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; ctf_integer(int, event_type, event_ty=
pe)<br>
<br>
&nbsp;&nbsp;&nbsp; )<br>
)<br>
<br>
<br>
<br>
<br>
<br>
TRACEPOINT_EVENT_INSTANCE(<br>
&nbsp;&nbsp;&nbsp; core_event_trace,<br>
&nbsp;&nbsp;&nbsp; core_event_tracepoint_class,<br>
&nbsp;&nbsp;&nbsp; end_event_tracepoint,<br>
&nbsp;&nbsp;&nbsp; TP_ARGS(<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int, event_type<br>
<br>
&nbsp;&nbsp;&nbsp; )<br>
)<br>
<br>
TRACEPOINT_EVENT_INSTANCE(<br>
&nbsp;&nbsp;&nbsp; core_event_trace,<br>
&nbsp;&nbsp;&nbsp; core_event_tracepoint_class,<br>
&nbsp;&nbsp;&nbsp; start_event_tracepoint,<br>
&nbsp;&nbsp;&nbsp; TP_ARGS(<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int, event_type<br>
&nbsp;&nbsp;&nbsp; )<br>
)<br>
<br>
<br>
<br>
TRACEPOINT_EVENT_INSTANCE(<br>
&nbsp;&nbsp;&nbsp; core_event_trace,<br>
&nbsp;&nbsp;&nbsp; core_event_tracepoint_class,<br>
&nbsp;&nbsp;&nbsp; foo_event_tracepoint,<br>
&nbsp;&nbsp;&nbsp; TP_ARGS(<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int, event_type<br>
&nbsp;&nbsp;&nbsp; )<br>
)<br>
</p>
<br>
<hr>
<font size=3D"1" face=3D"Arial" color=3D"Gray"><br>
This email and any files transmitted with it are confidential and are inten=
ded for the sole use of the individual to whom they are addressed. Black Bo=
x Corporation reserves the right to scan all e-mail traffic for restricted =
content and to monitor all e-mail
 in general. If you are not the intended recipient or you have received thi=
s email in error, any use, dissemination or forwarding of this email is str=
ictly prohibited. If you have received this email in error, please notify t=
he sender by replying to this email.<br></font>


<br>_______________________________________________<br>lttng-dev mailing li=
st<br>lttng-dev@lists.lttng.org<br>https://lists.lttng.org/cgi-bin/mailman/=
listinfo/lttng-dev<br></blockquote></div><div><br></div><div data-marker=3D=
"__SIG_POST__">-- <br></div><div>Mathieu Desnoyers<br>EfficiOS Inc.<br>http=
://www.efficios.com</div></div></body></html>
--=_65c8bfb4-ef2c-4bee-aea5-5708c7e53f12--

--===============6207755198341442734==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============6207755198341442734==--
