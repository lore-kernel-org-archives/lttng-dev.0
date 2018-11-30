From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Correct way to use the tpl file
Date: Fri, 30 Nov 2018 13:49:04 -0500 (EST)
Message-ID: <1164997754.17384.1543603744358.JavaMail.zimbra__4509.85342399708$1543603636$gmane$org@efficios.com>
References: <1543594140321.1890@BlackBox.com>
 <1761020244.17267.1543597963192.JavaMail.zimbra@efficios.com>
 <adedfbd3ae6b49a09e3a0db7071a0856@PGHPRDEXCH02.corp.bbns.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8942819584770498578=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 4363MX4mjVzwZZ
 for <lttng-dev@lists.lttng.org>; Fri, 30 Nov 2018 13:49:12 -0500 (EST)
In-Reply-To: <adedfbd3ae6b49a09e3a0db7071a0856@PGHPRDEXCH02.corp.bbns.com>
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

--===============8942819584770498578==
Content-Type: multipart/alternative;
	boundary="=_53b41548-a1a7-4995-882c-0a476517a97a"

--=_53b41548-a1a7-4995-882c-0a476517a97a
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

----- On Nov 30, 2018, at 12:30 PM, John OSullivan <John.OSullivan@BlackBox.com> wrote: 

> Hi Mathieu,

> Thank you for the reply and my apologies for the confusion. Let me try and
> clarify.

> I understood that the use of the class and instance concepts in the tpl file was
> to be able to declare a class with as you say a number of fields and then
> create instances of that class that provided a way of defining specific
> variants of that class.

> For example

> TRACEPOINT_EVENT_CLASS(
> /* Tracepoint provider name */
> core_event_trace,

> /* Tracepoint class name */
> core_event_tracepoint_class,

> /* Input arguments */
> TP_ARGS(
> int, event_type

> int, second_field
> int, third_field

> int, fourth_field
> ),

> /* Output event fields */
> TP_FIELDS(
> ctf_integer(int, event_type, event_type)
> ctf_integer(int, second_field, second_field)

> ctf_integer(int, third_field, third_field)
> )
> )

> Then we declare an instance

> TRACEPOINT_EVENT_INSTANCE(
> core_event_trace,
> core_event_tracepoint_class,
> first_event_tracepoint,
> TP_ARGS(
> int, event_type

> Int, first_field

> )
> )

> And a second one

> TRACEPOINT_EVENT_INSTANCE(
> core_event_trace,
> core_event_tracepoint_class,
> second_event_tracepoint,
> TP_ARGS(
> int, event_type

> Int, second_field

> )
> )

> So the two instances do not define all of the fields in the class definition,
> the first only defines first_field and the second only defines second_field,
> will this work or do the field in the instance always have to match the fields
> in the class?

I see from the examples above that when you say "field" in your question here, you actually mean "arguments to TP_ARGS". 

So the answer is that the arguments need to match exactly between the instances and the class they refer to. 

Thanks, 

Mathieu 

> From: Mathieu Desnoyers [mailto:mathieu.desnoyers@efficios.com]
> Sent: 30 November 2018 17:13
> To: John O'Sullivan
> Cc: lttng-dev
> Subject: [EXTERNAL] Re: [lttng-dev] Correct way to use the tpl file

> ----- On Nov 30, 2018, at 11:09 AM, John OSullivan <John.OSullivan@BlackBox.com>
> wrote:

>> Hi,

>> I am looking for some advice on the best way to manage the tracing of some user
>> space events.

>> I have a series of events that are fed to queues, they look something like the
>> following sample

>> EventEnd* event_end_new()
>> {
>> EventEnd* event_end = bb_xnew(EventEnd,__func__);

>> if (event_end != NULL)
>> {
>> event_end->type = EQ_EVENT_END;
>> . .. other event specific fields here

>> ..
>> }
>> #ifdef LTTNG_TRACE
>> tracepoint(core_event_trace, end_event_tracepoint, EQ_EVENT_END);
>> #endif
>> return event_end;
>> }

>> I want to try and trace these so created the following template shown below. My
>> question is, does the class have to have all of the possible members that the
>> different instances will have, as each unique event is likely to have different
>> members will the class have to have all of these members defines, and if this
>> is the case is it okay for an instance to just implement a subset of the
>> members the class defines?
> I am a bit confused by your use of the word "members" here. A tracepoint class
> has a provider name,

> a class name, input argument, and output fields.

> The event instance refers to the class by provider and class name, defines its
> own name, and needs to

> have a compatible input argument prototype (same number of arguments, same
> types). It will serialize

> the output fields in the exact layout described by the event class.

> I know it does not directly answer your question, but I'm really unsure about
> what you mean

> by "members".

> Thanks,

> Mathieu

>> TRACEPOINT_EVENT_CLASS(
>> /* Tracepoint provider name */
>> core_event_trace,

>> /* Tracepoint class name */
>> core_event_tracepoint_class,

>> /* Input arguments */
>> TP_ARGS(
>> int, event_type

>> ),

>> /* Output event fields */
>> TP_FIELDS(
>> ctf_integer(int, event_type, event_type)

>> )
>> )

>> TRACEPOINT_EVENT_INSTANCE(
>> core_event_trace,
>> core_event_tracepoint_class,
>> end_event_tracepoint,
>> TP_ARGS(
>> int, event_type

>> )
>> )

>> TRACEPOINT_EVENT_INSTANCE(
>> core_event_trace,
>> core_event_tracepoint_class,
>> start_event_tracepoint,
>> TP_ARGS(
>> int, event_type
>> )
>> )

>> TRACEPOINT_EVENT_INSTANCE(
>> core_event_trace,
>> core_event_tracepoint_class,
>> foo_event_tracepoint,
>> TP_ARGS(
>> int, event_type
>> )
>> )

>> This email and any files transmitted with it are confidential and are intended
>> for the sole use of the individual to whom they are addressed. Black Box
>> Corporation reserves the right to scan all e-mail traffic for restricted
>> content and to monitor all e-mail in general. If you are not the intended
>> recipient or you have received this email in error, any use, dissemination or
>> forwarding of this email is strictly prohibited. If you have received this
>> email in error, please notify the sender by replying to this email.

>> _______________________________________________
>> lttng-dev mailing list
>> lttng-dev@lists.lttng.org
>> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> --

> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com

-- 
Mathieu Desnoyers 
EfficiOS Inc. 
http://www.efficios.com 

--=_53b41548-a1a7-4995-882c-0a476517a97a
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-family: arial, helvetica, sans-serif; font-s=
ize: 12pt; color: #000000"><div><style><!--

@font-face
=09{font-family:Helvetica;
=09panose-1:2 11 6 4 2 2 2 2 2 4;}
@font-face
=09{font-family:"Cambria Math";
=09panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
=09{font-family:Calibri;
=09panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
=09{font-family:Tahoma;
=09panose-1:2 11 6 4 3 5 4 4 2 4;}

p.MsoNormal, li.MsoNormal, div.MsoNormal
=09{margin:0cm;
=09margin-bottom:.0001pt;
=09font-size:12.0pt;
=09font-family:"Times New Roman","serif";}
a:link, span.MsoHyperlink
=09{mso-style-priority:99;
=09color:blue;
=09text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
=09{mso-style-priority:99;
=09color:purple;
=09text-decoration:underline;}
p
=09{mso-style-priority:99;
=09margin:0cm;
=09margin-bottom:.0001pt;
=09font-size:12.0pt;
=09font-family:"Times New Roman","serif";}
span.EmailStyle18
=09{mso-style-type:personal-reply;
=09font-family:"Calibri","sans-serif";
=09color:#1F497D;}
.MsoChpDefault
=09{mso-style-type:export-only;
=09font-size:10.0pt;}
@page WordSection1
=09{size:612.0pt 792.0pt;
=09margin:72.0pt 72.0pt 72.0pt 72.0pt;}
div.WordSection1
=09{page:WordSection1;}
--></style></div><div><br></div><div><br></div><div><span id=3D"zwchr" data=
-marker=3D"__DIVIDER__">----- On Nov 30, 2018, at 12:30 PM, John OSullivan =
&lt;John.OSullivan@BlackBox.com&gt; wrote:<br></span></div><div data-marker=
=3D"__QUOTED_TEXT__"><blockquote style=3D"border-left:2px solid #1010FF;mar=
gin-left:5px;padding-left:5px;color:#000;font-weight:normal;font-style:norm=
al;text-decoration:none;font-family:Helvetica,Arial,sans-serif;font-size:12=
pt;">






<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,&quot;sans-serif&quot;;color:#1F497D">Hi Mathieu,</span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,&quot;sans-serif&quot;;color:#1F497D">Thank you for the reply a=
nd my apologies for the confusion. Let me try and clarify.</span></p>

<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,&quot;sans-serif&quot;;color:#1F497D">I understood that the use=
 of the class and instance concepts in the tpl file was to be able to decla=
re a class with as you say a number of fields and then create
 instances of that class that provided a way of defining specific variants =
of that class.</span></p>

<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,&quot;sans-serif&quot;;color:#1F497D">For example
</span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Helvetica&quot;,&qu=
ot;sans-serif&quot;;color:black">TRACEPOINT_EVENT_CLASS(<br>
&nbsp;&nbsp;&nbsp; /* Tracepoint provider name */<br>
&nbsp;&nbsp;&nbsp; core_event_trace,<br><br>
&nbsp;&nbsp;&nbsp; /* Tracepoint class name */<br>
&nbsp;&nbsp;&nbsp; core_event_tracepoint_class,<br><br>
/* Input arguments */<br>
&nbsp;&nbsp;&nbsp; TP_ARGS(<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int, event_type</span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Helvetica&quot;,&qu=
ot;sans-serif&quot;;color:black">&nbsp;&nbsp;&nbsp;&nbsp; int, second_field=
<br>
&nbsp;&nbsp;&nbsp;&nbsp; int, third_field</span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Helvetica&quot;,&qu=
ot;sans-serif&quot;;color:black">&nbsp;&nbsp;&nbsp;&nbsp; int, fourth_field=
<br>
&nbsp;&nbsp;&nbsp; ),<br><br>
&nbsp;&nbsp;&nbsp; /* Output event fields */<br>
&nbsp;&nbsp;&nbsp; TP_FIELDS(<br>
&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; ctf_integer(int, event_type, event_ty=
pe)<br>
&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; ctf_integer(int, second_field, second=
_field) &nbsp;</span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Helvetica&quot;,&qu=
ot;sans-serif&quot;;color:black">&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; ctf_intege=
r(int, third_field, third_field)<br>
&nbsp;&nbsp;&nbsp; )<br>
)<br><br></span></p>

<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,&quot;sans-serif&quot;;color:#1F497D">Then we declare an instan=
ce</span></p>

<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Helvetica&quot;,&qu=
ot;sans-serif&quot;;color:black">TRACEPOINT_EVENT_INSTANCE(<br>
&nbsp;&nbsp;&nbsp; core_event_trace,<br>
&nbsp;&nbsp;&nbsp; core_event_tracepoint_class,<br>
&nbsp;&nbsp;&nbsp; first_event_tracepoint,<br>
&nbsp;&nbsp;&nbsp; TP_ARGS(<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int, event_type</span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Helvetica&quot;,&qu=
ot;sans-serif&quot;;color:black">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Int, first_=
field<br><br>
&nbsp;&nbsp;&nbsp; )<br>
)</span></p>

<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,&quot;sans-serif&quot;;color:#1F497D">And a second one</span></=
p>

<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Helvetica&quot;,&qu=
ot;sans-serif&quot;;color:black">TRACEPOINT_EVENT_INSTANCE(<br>
&nbsp;&nbsp;&nbsp; core_event_trace,<br>
&nbsp;&nbsp;&nbsp; core_event_tracepoint_class,<br>
&nbsp;&nbsp;&nbsp; second_event_tracepoint,<br>
&nbsp;&nbsp;&nbsp; TP_ARGS(<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int, event_type</span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Helvetica&quot;,&qu=
ot;sans-serif&quot;;color:black">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Int, second=
_field<br><br>
&nbsp;&nbsp;&nbsp; )<br>
)</span></p>

<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,&quot;sans-serif&quot;;color:#1F497D">So the two instances do n=
ot define all of the fields in the class definition, the first only defines=
 first_field and the second only defines second_field, will
 this work or do the field in the instance always have to match the fields =
in the class?</span></p></div></blockquote><div>I see from the examples abo=
ve that when you say "field" in your question here, you actually mean "argu=
ments to TP_ARGS".<br></div><div><br data-mce-bogus=3D"1"></div><div>So the=
 answer is that the arguments need to match exactly between the instances a=
nd the class they refer to.<br data-mce-bogus=3D"1"></div><div><br data-mce=
-bogus=3D"1"></div><div>Thanks,<br data-mce-bogus=3D"1"></div><div><br data=
-mce-bogus=3D"1"></div><div>Mathieu<br data-mce-bogus=3D"1"></div><div><br =
data-mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"></div><div><br dat=
a-mce-bogus=3D"1"></div><blockquote style=3D"border-left:2px solid #1010FF;=
margin-left:5px;padding-left:5px;color:#000;font-weight:normal;font-style:n=
ormal;text-decoration:none;font-family:Helvetica,Arial,sans-serif;font-size=
:12pt;"><div class=3D"WordSection1">

<div>
<div style=3D"border:none;border-top:solid #B5C4DF 1.0pt;padding:3.0pt 0cm =
0cm 0cm">
<p class=3D"MsoNormal"><b><span style=3D"font-size:10.0pt;font-family:&quot=
;Tahoma&quot;,&quot;sans-serif&quot;" lang=3D"EN-US">From:</span></b><span =
style=3D"font-size:10.0pt;font-family:&quot;Tahoma&quot;,&quot;sans-serif&q=
uot;" lang=3D"EN-US"> Mathieu Desnoyers [mailto:mathieu.desnoyers@efficios.=
com]
<br><b>Sent:</b> 30 November 2018 17:13<br><b>To:</b> John O'Sullivan<br><b=
>Cc:</b> lttng-dev<br><b>Subject:</b> [EXTERNAL] Re: [lttng-dev] Correct wa=
y to use the tpl file</span></p>
</div>
</div>
<p class=3D"MsoNormal">&nbsp;</p>
<div>
<div>

</div>
<div>

</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Arial&quot;,&quot;s=
ans-serif&quot;;color:black">----- On Nov 30, 2018, at 11:09 AM, John OSull=
ivan &lt;John.OSullivan@BlackBox.com&gt; wrote:<br><br></span></p>
</div>
<div>
<blockquote style=3D"border:none;border-left:solid #1010FF 1.5pt;padding:0c=
m 0cm 0cm 4.0pt;margin-left:3.75pt;margin-top:5.0pt;margin-bottom:5.0pt">
<p><span style=3D"font-family:&quot;Helvetica&quot;,&quot;sans-serif&quot;;=
color:black">Hi,</span></p>
<p><span style=3D"font-family:&quot;Helvetica&quot;,&quot;sans-serif&quot;;=
color:black">I am looking for some advice on the best way to manage the tra=
cing of some user space events.</span></p>

<p><span style=3D"font-family:&quot;Helvetica&quot;,&quot;sans-serif&quot;;=
color:black">I have a series of events that are fed to queues, they look so=
mething like the following sample</span></p>


<p><span style=3D"font-family:&quot;Helvetica&quot;,&quot;sans-serif&quot;;=
color:black">EventEnd* event_end_new()<br>
{<br>
&nbsp;&nbsp; &nbsp;EventEnd* event_end =3D bb_xnew(EventEnd,__func__);<br><=
br>
&nbsp;&nbsp; &nbsp;if (event_end !=3D NULL)<br>
&nbsp;&nbsp; &nbsp;{<br>
&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;event_end-&gt;type =3D EQ_EVENT_END;<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;. &nbsp; .. other event specific fields here</span>=
</p>
<p><span style=3D"font-family:&quot;Helvetica&quot;,&quot;sans-serif&quot;;=
color:black">&nbsp; &nbsp; &nbsp; &nbsp; ..<br>
&nbsp;&nbsp; &nbsp;}<br>
#ifdef LTTNG_TRACE<br>
&nbsp;&nbsp; &nbsp;tracepoint(core_event_trace, end_event_tracepoint, EQ_EV=
ENT_END);<br>
#endif<br>
&nbsp;&nbsp; &nbsp;return event_end;<br>
}</span></p>



<p><span style=3D"font-family:&quot;Helvetica&quot;,&quot;sans-serif&quot;;=
color:black">I want to try and trace these so created the following templat=
e shown below. My question is, does the class have to have all of the possi=
ble members that the different instances will have, as
 each unique event is likely to have different members will the class have =
to have all of these members defines, and if this is the case is it okay fo=
r an instance to just implement a subset of the members the class defines?<=
/span></p>
</blockquote>
<div>

</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Arial&quot;,&quot;s=
ans-serif&quot;;color:black">I am a bit confused by your use of the word "m=
embers" here. A tracepoint class has a provider name,</span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Arial&quot;,&quot;s=
ans-serif&quot;;color:black">a class name, input argument, and output field=
s.</span></p>
</div>
<div>

</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Arial&quot;,&quot;s=
ans-serif&quot;;color:black">The event instance refers to the class by prov=
ider and class name, defines its own name, and needs to</span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Arial&quot;,&quot;s=
ans-serif&quot;;color:black">have a compatible input argument prototype (sa=
me number of arguments, same types). It will serialize</span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Arial&quot;,&quot;s=
ans-serif&quot;;color:black">the output fields in the exact layout describe=
d by the event class.</span></p>
</div>
<div>

</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Arial&quot;,&quot;s=
ans-serif&quot;;color:black">I know it does not directly answer your questi=
on, but I'm really unsure about what you mean</span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Arial&quot;,&quot;s=
ans-serif&quot;;color:black">by "members".</span></p>
</div>
<div>

</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Arial&quot;,&quot;s=
ans-serif&quot;;color:black">Thanks,</span></p>
</div>
<div>

</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Arial&quot;,&quot;s=
ans-serif&quot;;color:black">Mathieu</span></p>
</div>
<div>

</div>
<blockquote style=3D"border:none;border-left:solid #1010FF 1.5pt;padding:0c=
m 0cm 0cm 4.0pt;margin-left:3.75pt;margin-top:5.0pt;margin-bottom:5.0pt">




<p><span style=3D"font-family:&quot;Helvetica&quot;,&quot;sans-serif&quot;;=
color:black">TRACEPOINT_EVENT_CLASS(<br>
&nbsp;&nbsp;&nbsp; /* Tracepoint provider name */<br>
&nbsp;&nbsp;&nbsp; core_event_trace,<br><br>
&nbsp;&nbsp;&nbsp; /* Tracepoint class name */<br>
&nbsp;&nbsp;&nbsp; core_event_tracepoint_class,<br><br>
/* Input arguments */<br>
&nbsp;&nbsp;&nbsp; TP_ARGS(<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int, event_type<br><br>
&nbsp;&nbsp;&nbsp; ),<br><br>
&nbsp;&nbsp;&nbsp; /* Output event fields */<br>
&nbsp;&nbsp;&nbsp; TP_FIELDS(<br>
&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; ctf_integer(int, event_type, event_ty=
pe)<br><br>
&nbsp;&nbsp;&nbsp; )<br>
)<br><br><br><br><br><br>
TRACEPOINT_EVENT_INSTANCE(<br>
&nbsp;&nbsp;&nbsp; core_event_trace,<br>
&nbsp;&nbsp;&nbsp; core_event_tracepoint_class,<br>
&nbsp;&nbsp;&nbsp; end_event_tracepoint,<br>
&nbsp;&nbsp;&nbsp; TP_ARGS(<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int, event_type<br><br>
&nbsp;&nbsp;&nbsp; )<br>
)<br><br>
TRACEPOINT_EVENT_INSTANCE(<br>
&nbsp;&nbsp;&nbsp; core_event_trace,<br>
&nbsp;&nbsp;&nbsp; core_event_tracepoint_class,<br>
&nbsp;&nbsp;&nbsp; start_event_tracepoint,<br>
&nbsp;&nbsp;&nbsp; TP_ARGS(<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int, event_type<br>
&nbsp;&nbsp;&nbsp; )<br>
)<br><br><br><br>
TRACEPOINT_EVENT_INSTANCE(<br>
&nbsp;&nbsp;&nbsp; core_event_trace,<br>
&nbsp;&nbsp;&nbsp; core_event_tracepoint_class,<br>
&nbsp;&nbsp;&nbsp; foo_event_tracepoint,<br>
&nbsp;&nbsp;&nbsp; TP_ARGS(<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int, event_type<br>
&nbsp;&nbsp;&nbsp; )<br>
)</span></p>

<div class=3D"MsoNormal" style=3D"text-align:center" align=3D"center"><span=
 style=3D"font-family:&quot;Helvetica&quot;,&quot;sans-serif&quot;;color:bl=
ack"><hr width=3D"100%" size=3D"2" align=3D"center"></span></div>
<p class=3D"MsoNormal"><span style=3D"font-size:7.5pt;font-family:&quot;Ari=
al&quot;,&quot;sans-serif&quot;;color:gray"><br>
This email and any files transmitted with it are confidential and are inten=
ded for the sole use of the individual to whom they are addressed. Black Bo=
x Corporation reserves the right to scan all e-mail traffic for restricted =
content and to monitor all e-mail
 in general. If you are not the intended recipient or you have received thi=
s email in error, any use, dissemination or forwarding of this email is str=
ictly prohibited. If you have received this email in error, please notify t=
he sender by replying to this email.<br></span><span style=3D"font-family:&=
quot;Helvetica&quot;,&quot;sans-serif&quot;;color:black"><br>
_______________________________________________<br>
lttng-dev mailing list<br>
lttng-dev@lists.lttng.org<br>
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev</span></p>
</blockquote>
</div>
<div>

</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Arial&quot;,&quot;s=
ans-serif&quot;;color:black">--
</span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Arial&quot;,&quot;s=
ans-serif&quot;;color:black">Mathieu Desnoyers<br>
EfficiOS Inc.<br>
http://www.efficios.com</span></p>
</div>
</div>
</div><br></blockquote></div><div><br></div><div data-marker=3D"__SIG_POST_=
_">-- <br></div><div>Mathieu Desnoyers<br>EfficiOS Inc.<br>http://www.effic=
ios.com</div></div></body></html>
--=_53b41548-a1a7-4995-882c-0a476517a97a--

--===============8942819584770498578==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============8942819584770498578==--
