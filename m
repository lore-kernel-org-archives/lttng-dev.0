From: Jonathan Rajotte <jonathan.r.julien@gmail.com>
Subject: Re: Beginner question: how to inspect scheduling of
 multi-threaded user application?
Date: Wed, 24 Aug 2016 12:35:58 -0400
Message-ID: <CAF4oYfHJCGnmmDfNokV2029Kp_8k7n1rCt4CX=OaLrLKEc_5wg__19855.8995187797$1472056573$gmane$org@mail.gmail.com>
References: <35de22c3d2034f3abb75596477b23e3a@EUX13SRV1.EU.NEC.COM>
 <CADcCL0hqkvEPZEu85GzJnJKi9nOi0wntpOYoVz37QhcRVpb+=g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5813182816606365033=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-it0-f53.google.com (mail-it0-f53.google.com
 [209.85.214.53])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id 73050A3D39
 for <lttng-dev@lists.lttng.org>; Wed, 24 Aug 2016 16:36:17 +0000 (UTC)
Received: by mail-it0-f53.google.com with SMTP id n128so43790413ith.1
 for <lttng-dev@lists.lttng.org>; Wed, 24 Aug 2016 09:36:01 -0700 (PDT)
In-Reply-To: <CADcCL0hqkvEPZEu85GzJnJKi9nOi0wntpOYoVz37QhcRVpb+=g@mail.gmail.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Francis Deslauriers <francis.deslauriers@mail.utoronto.ca>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============5813182816606365033==
Content-Type: multipart/alternative; boundary=94eb2c05c23e44120b053ad3e08e

--94eb2c05c23e44120b053ad3e08e
Content-Type: text/plain; charset=UTF-8

Hi,

On Aug 24, 2016 12:18 PM, "Francis Deslauriers" <francis.deslauriers@mail.
utoronto.ca> wrote:
>
> Hi David,
> If you specifically want to trace the scheduling of the threads of your
app, you don't need custom tracepoints.
> Enabling the sched_switch kernel event will give you both of cpu id and
thread id. Look at the cpu_id and next_tid fields.
>
> You can enable the sched_switch event using : lttng enable-event -k
sched_switch

In TraceCompass you can inspect this data with the control flow view and
the Ressource view under the Kernel analysis node under the trace node in
the project explorer.

I'm not sure of the base requirement for those views you can use the safe
enable-event:

lttng enable-event -k 'sched*'


You can also use "lttng track" to limi the gathering of event to a certain
pid.


Another way to reduce the scope would be to filter per procname:


lttng create
lttng add-context -k -t procname
lttng enable-event 'sched*' --filter '$ctx.procname == "PROCNAMEHERE"'

>
> Cheers,
> Francis
>
>
> 2016-08-24 3:17 GMT-04:00 David Aldrich <David.Aldrich@emea.nec.com>:
>>
>> Hi
>>
>>
>>
>> I am new to tracing in Linux and to lttng. I have a multi-threaded user
application and I want to see:
>>
>>
>>
>> 1)      When the threads are scheduled to run
>>
>> 2)      Which cores the threads are running on.
>>
>>
>>
>> I have installed lttng on Ubuntu 14.04 LTS.  I am expecting to visualise
the trace using TraceCompass.
>>
>>
>>
>> I have read the following doc section:
>>
>>
>>
>> http://lttng.org/docs/#doc-tracing-your-own-user-application
>>
>>
>>
>> In order to collect my trace, must I define custom tracepoint
definitions ( in a tracepoint provider header file ), and insert
tracepoints into my user application, or is there a simpler way of
achieving my goal?
>>
>>
>>
>> Best regards
>>
>>
>>
>> David
>>
>>
>>
>>
>> _______________________________________________
>> lttng-dev mailing list
>> lttng-dev@lists.lttng.org
>> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>>
>
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>

--94eb2c05c23e44120b053ad3e08e
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><p dir=3D"ltr">Hi,</p>
<p dir=3D"ltr">On Aug 24, 2016 12:18 PM, &quot;Francis Deslauriers&quot; &l=
t;<a href=3D"mailto:francis.deslauriers@mail.utoronto.ca" target=3D"_blank"=
>francis.deslauriers@mail.<wbr>utoronto.ca</a>&gt; wrote:<br>
&gt;<br>
&gt; Hi David,=C2=A0<br>
&gt; If you specifically want to trace the scheduling of the threads of you=
r app, you don&#39;t need custom tracepoints.<br>
&gt; Enabling the sched_switch kernel event will give you both of cpu id an=
d thread id. Look at the cpu_id and next_tid fields.<br>
&gt;<br>
&gt; You can enable the sched_switch event using : lttng enable-event -k sc=
hed_switch</p>
<p dir=3D"ltr">In TraceCompass you can inspect this data with the control f=
low view and the Ressource view under the Kernel analysis node under the tr=
ace node in the project explorer.</p>
<p dir=3D"ltr">I&#39;m not sure of the base requirement for those views you=
 can use the safe enable-event:</p>
<p dir=3D"ltr">lttng enable-event -k &#39;sched*&#39;</p><p dir=3D"ltr"><br=
></p><p>You can also use &quot;lttng track&quot; to limi the gathering of e=
vent to a certain pid.</p><p><br></p><p>Another way to reduce the scope wou=
ld be to filter per procname:</p><p><br></p><p>lttng create<br>lttng add-co=
ntext -k -t procname<br>lttng enable-event &#39;sched*&#39; --filter &#39;$=
ctx.procname =3D=3D &quot;PROCNAMEHERE&quot;&#39;</p><p dir=3D"ltr">
&gt;<br>
&gt; Cheers,<br>
&gt; Francis<br>
&gt;<br>
&gt;<br>
&gt; 2016-08-24 3:17 GMT-04:00 David Aldrich &lt;<a href=3D"mailto:David.Al=
drich@emea.nec.com" target=3D"_blank">David.Aldrich@emea.nec.com</a>&gt;:<b=
r>
&gt;&gt;<br>
&gt;&gt; Hi<br>
&gt;&gt;<br>
&gt;&gt; =C2=A0<br>
&gt;&gt;<br>
&gt;&gt; I am new to tracing in Linux and to lttng. I have a multi-threaded=
 user application and I want to see:<br>
&gt;&gt;<br>
&gt;&gt; =C2=A0<br>
&gt;&gt;<br>
&gt;&gt; 1)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 When the threads are scheduled to=
 run<br>
&gt;&gt;<br>
&gt;&gt; 2)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Which cores the threads are runni=
ng on.<br>
&gt;&gt;<br>
&gt;&gt; =C2=A0<br>
&gt;&gt;<br>
&gt;&gt; I have installed lttng on Ubuntu 14.04 LTS.=C2=A0 I am expecting t=
o visualise the trace using TraceCompass.<br>
&gt;&gt;<br>
&gt;&gt; =C2=A0<br>
&gt;&gt;<br>
&gt;&gt; I have read the following doc section:<br>
&gt;&gt;<br>
&gt;&gt; =C2=A0<br>
&gt;&gt;<br>
&gt;&gt; <a href=3D"http://lttng.org/docs/#doc-tracing-your-own-user-applic=
ation" target=3D"_blank">http://lttng.org/docs/#doc-<wbr>tracing-your-own-u=
ser-<wbr>application</a><br>
&gt;&gt;<br>
&gt;&gt; =C2=A0<br>
&gt;&gt;<br>
&gt;&gt; In order to collect my trace, must I define custom tracepoint defi=
nitions (=C2=A0in a tracepoint provider=C2=A0header file ), and insert trac=
epoints into my user application, or is there a simpler way of achieving my=
 goal?<br>
&gt;&gt;<br>
&gt;&gt; =C2=A0<br>
&gt;&gt;<br>
&gt;&gt; Best regards<br>
&gt;&gt;<br>
&gt;&gt; =C2=A0<br>
&gt;&gt;<br>
&gt;&gt; David<br>
&gt;&gt;<br>
&gt;&gt; =C2=A0<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; ______________________________<wbr>_________________<br>
&gt;&gt; lttng-dev mailing list<br>
&gt;&gt; <a href=3D"mailto:lttng-dev@lists.lttng.org" target=3D"_blank">ltt=
ng-dev@lists.lttng.org</a><br>
&gt;&gt; <a href=3D"https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-=
dev" target=3D"_blank">https://lists.lttng.org/cgi-<wbr>bin/mailman/listinf=
o/lttng-dev</a><br>
&gt;&gt;<br>
&gt;<br>
&gt;<br>
&gt; ______________________________<wbr>_________________<br>
&gt; lttng-dev mailing list<br>
&gt; <a href=3D"mailto:lttng-dev@lists.lttng.org" target=3D"_blank">lttng-d=
ev@lists.lttng.org</a><br>
&gt; <a href=3D"https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev"=
 target=3D"_blank">https://lists.lttng.org/cgi-<wbr>bin/mailman/listinfo/lt=
tng-dev</a><br>
&gt;</p>
</div>

--94eb2c05c23e44120b053ad3e08e--

--===============5813182816606365033==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============5813182816606365033==--
