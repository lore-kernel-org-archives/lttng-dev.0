From: Martin Townsend <mtownsend1973@gmail.com>
Subject: Re: Tracing/Profiling boot
Date: Fri, 26 Feb 2016 22:03:40 +0000
Message-ID: <CABatt_xXwcFVO+XzhYbqQKCaBzbNoxccB8y-1iqQ-HDABZKGwQ__44496.9276934446$1456524285$gmane$org@mail.gmail.com>
References: <CABatt_wikOevABepAn8ruYDg63b4y+oD1e0nktGp=K85WHJiKA@mail.gmail.com>
 <1765918553.8311.1456435094786.JavaMail.zimbra@efficios.com>
 <CABatt_xa21vPN-89n9COVgRM+rcqKpFU-iqRWB2NL37bxFjYbg@mail.gmail.com>
 <1128834814.8994.1456509679501.JavaMail.zimbra@efficios.com>
 <1131485866.9244.1456519182086.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0895360878=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-lb0-f170.google.com ([209.85.217.170])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <mtownsend1973@gmail.com>) id 1aZQUE-0007w8-Ea
 for lttng-dev@lists.lttng.org; Fri, 26 Feb 2016 17:03:48 -0500
Received: by mail-lb0-f170.google.com with SMTP id bc4so53835101lbc.2
 for <lttng-dev@lists.lttng.org>; Fri, 26 Feb 2016 14:03:46 -0800 (PST)
In-Reply-To: <1131485866.9244.1456519182086.JavaMail.zimbra@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============0895360878==
Content-Type: multipart/alternative; boundary=001a11c3195cc15982052cb37890

--001a11c3195cc15982052cb37890
Content-Type: text/plain; charset=UTF-8

Hi Mathieu,

Seeing the relationship between userspace and kernel would definitely be an
advantage for this problem.  As I will be looking into a lot of timing
information and out of interest where does lttng get it's timestamps from?

Once I have updated everything else to work happily with systemd I'll start
to look into this.  I'll start by seeing if I can bring up the
lttng-sessiond user-space process within my custom init process and if this
proves unsuccessful I will look into a custom lttng-module that's built
into the kernel.

Cheers,
Martin.

On Fri, Feb 26, 2016 at 8:39 PM, Mathieu Desnoyers <
mathieu.desnoyers@efficios.com> wrote:

>
>
> ----- On Feb 26, 2016, at 1:01 PM, Mathieu Desnoyers <
> mathieu.desnoyers@efficios.com> wrote:
>
> Hi Martin,
>
> I would say that the main advantages of using LTTng in this case
> would be on the tooling side, with availability of Trace Compass
> and LTTng Analyses projects to navigate in the resulting CTF
> traces, and get high-level overview of the various metrics that
> could slow down your system.
>
> LTTng would also allow you to correlate your kernel trace with
> a user-space trace gathered with lttng-ust, which gives you
> deeper insight into your applications.
>
>
> One more benefit of using lttng as builtin tracer rather than
> ftrace is that LTTng gathers much more information about the
> system call input/output parameters than ftrace. This can be
> useful to get a better understanding of what userspace is
> doing with the kernel.
>
> Thanks,
>
> Mathieu
>
>
>
> Thanks,
>
> Mathieu
>
> ----- On Feb 26, 2016, at 3:41 AM, Martin Townsend <
> mtownsend1973@gmail.com> wrote:
>
> Hi Mathieu,
> Thanks for the info, I didn't know about ftrace, I will take a look at
> this.
>
> Out of interest would there be any benefits from using a built-in lttng
> module over ftrace?
>
> Cheers,
> Martin.
>
> On Thu, Feb 25, 2016 at 9:18 PM, Mathieu Desnoyers <
> mathieu.desnoyers@efficios.com> wrote:
>
>> Hi Martin,
>>
>> The main limitation LTTng currently has for early boot tracing is that
>> you need to first spawn a lttng-sessiond user-space process, and setup
>> tracing, before you can actually do any tracing. As long as you can
>> fit within those constraints, you should be OK.
>>
>> If you really want to trace earlier than that, you might have to create
>> a dedicated early-boot tracing module that would setup tracing
>> buffers into a "dummy" session which exists only within lttng-modules,
>> and then allow sessiond to later hook on those buffers when user-space
>> is ready. Nothing exists for this at the moment. Note that since
>> lttng-modules master (upcoming 2.8), you can now build lttng-modules
>> into your kernel image, this might be useful for you. See the "kernel
>> built-in support" section in
>> https://github.com/lttng/lttng-modules/blob/master/README.md
>>
>> Since LTTng 2.0, we have left early boot tracing to other tools, such
>> as Ftrace, which target kernel developers use-cases, and focused
>> more on tracing of the system in its execution phases which are more
>> relevant to application developers.
>>
>> If you want to go ahead and create a LTTng modules module that
>> allow early boot tracing, I'd be happy to provide ideas and review.
>>
>> Thanks,
>>
>> Mathieu
>>
>> ----- On Feb 25, 2016, at 3:56 PM, Martin Townsend <
>> mtownsend1973@gmail.com> wrote:
>>
>> Hi,
>>
>> This is a bit of a long shot but does LTTng allow you trace boot?
>>
>> I'm seeing a weird problem where if I boot with systemd-bootchart if
>> boots faster than just using systemd as the init process.  I created my own
>> init process based on  systemd-bootchart and worked out it was down to the
>> fact it called nanosleep, so I now have my own init process which hands
>> over to systemd and creates a child that nanosleeps for the boot duration.
>> I would really like to trace/profile the scheduler and hrtimers understand
>> what's happening and try and get a proper fix :)  Even if it means a bit of
>> hacking kernel/LTTng, I would be willing to do this.
>>
>> Many Thanks, Martin.
>>
>> _______________________________________________
>> lttng-dev mailing list
>> lttng-dev@lists.lttng.org
>> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>>
>>
>> --
>> Mathieu Desnoyers
>> EfficiOS Inc.
>> http://www.efficios.com
>>
>
>
> --
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>
>
> --
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com
>

--001a11c3195cc15982052cb37890
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div>Hi Mathieu,<br><br></div>Seeing the relationship=
 between userspace and kernel would definitely be an advantage for this pro=
blem.=C2=A0 As I will be looking into a lot of timing information and out o=
f interest where does lttng get it&#39;s timestamps from?<br><br>Once I hav=
e updated everything else to work happily with systemd I&#39;ll start to lo=
ok into this.=C2=A0 I&#39;ll start by seeing if I can bring up the=C2=A0 lt=
tng-sessiond user-space process within my custom init process and if this p=
roves unsuccessful I will look into a custom lttng-module that&#39;s built =
into the kernel.<br><br></div><div>Cheers,<br></div><div>Martin.<br></div><=
/div><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">On Fri, Feb =
26, 2016 at 8:39 PM, Mathieu Desnoyers <span dir=3D"ltr">&lt;<a href=3D"mai=
lto:mathieu.desnoyers@efficios.com" target=3D"_blank">mathieu.desnoyers@eff=
icios.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=
=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div><di=
v style=3D"font-family:arial,helvetica,sans-serif;font-size:12pt;color:#000=
000"><span class=3D""><div><br></div><div><br></div><span>----- On Feb 26, =
2016, at 1:01 PM, Mathieu Desnoyers &lt;<a href=3D"mailto:mathieu.desnoyers=
@efficios.com" target=3D"_blank">mathieu.desnoyers@efficios.com</a>&gt; wro=
te:<br></span></span><div><blockquote style=3D"border-left:2px solid #1010f=
f;margin-left:5px;padding-left:5px;color:#000;font-weight:normal;font-style=
:normal;text-decoration:none;font-family:Helvetica,Arial,sans-serif;font-si=
ze:12pt"><div style=3D"font-family:arial,helvetica,sans-serif;font-size:12p=
t;color:#000000"><div>Hi Martin,<br></div><br><span class=3D""><div>I would=
 say that the main advantages of using LTTng in this case</div><div>would b=
e on the tooling side, with availability of Trace Compass</div><div>and LTT=
ng Analyses projects to navigate in the resulting CTF</div><div>traces, and=
 get high-level overview of the various metrics that</div><div>could slow d=
own your system.<br></div><br><div>LTTng would also allow you to correlate =
your kernel trace with<br></div><div>a user-space trace gathered with lttng=
-ust, which gives you<br></div><div>deeper insight into your applications.<=
/div></span></div></blockquote><div><br></div><div>One more benefit of usin=
g lttng as builtin tracer rather than<br></div><div>ftrace is that LTTng ga=
thers much more information about the<br></div><div>system call input/outpu=
t parameters than ftrace. This can be<br></div><div>useful to get a better =
understanding of what userspace is<br></div><div>doing with the kernel.<br>=
</div><div><br></div><div>Thanks,<br></div><div><br></div><div>Mathieu<br><=
/div><div><div class=3D"h5"><div><br></div><blockquote style=3D"border-left=
:2px solid #1010ff;margin-left:5px;padding-left:5px;color:#000;font-weight:=
normal;font-style:normal;text-decoration:none;font-family:Helvetica,Arial,s=
ans-serif;font-size:12pt"><div style=3D"font-family:arial,helvetica,sans-se=
rif;font-size:12pt;color:#000000"><div><br></div><br><div>Thanks,<br></div>=
<br><div>Mathieu<br></div><br><span>----- On Feb 26, 2016, at 3:41 AM, Mart=
in Townsend &lt;<a href=3D"mailto:mtownsend1973@gmail.com" target=3D"_blank=
">mtownsend1973@gmail.com</a>&gt; wrote:<br></span><div><blockquote style=
=3D"border-left:2px solid #1010ff;margin-left:5px;padding-left:5px;color:#0=
00;font-weight:normal;font-style:normal;text-decoration:none;font-family:He=
lvetica,Arial,sans-serif;font-size:12pt"><div dir=3D"ltr">Hi Mathieu,<br><d=
iv>Thanks for the info, I didn&#39;t know about ftrace, I will take a look =
at this.=C2=A0</div><br><div>Out of interest would there be any benefits fr=
om using a built-in lttng module over ftrace?</div><br><div>Cheers,<br>Mart=
in.</div></div><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">On=
 Thu, Feb 25, 2016 at 9:18 PM, Mathieu Desnoyers <span dir=3D"ltr">&lt;<a h=
ref=3D"mailto:mathieu.desnoyers@efficios.com" target=3D"_blank">mathieu.des=
noyers@efficios.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quo=
te" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"=
><div><div style=3D"font-family:arial,helvetica,sans-serif;font-size:12pt;c=
olor:#000000"><div>Hi Martin,<br></div><br><div>The main limitation LTTng c=
urrently has for early boot tracing is that<br></div><div>you need to first=
 spawn a lttng-sessiond user-space process, and setup<br></div><div>tracing=
, before you can actually do any tracing. As long as you can<br></div><div>=
fit within those constraints, you should be OK.<br></div><br><div>If you re=
ally want to trace earlier than that, you might have to create<br></div><di=
v>a dedicated early-boot tracing module that would setup tracing<br></div><=
div>buffers into a &quot;dummy&quot; session which exists only within lttng=
-modules,</div><div>and then allow sessiond to later hook on those buffers =
when user-space</div><div>is ready. Nothing exists for this at the moment. =
Note that since</div><div>lttng-modules master (upcoming 2.8), you can now =
build lttng-modules</div><div>into your kernel image, this might be useful =
for you. See the &quot;kernel</div><div>built-in support&quot; section in</=
div><div><a href=3D"https://github.com/lttng/lttng-modules/blob/master/READ=
ME.md" target=3D"_blank">https://github.com/lttng/lttng-modules/blob/master=
/README.md</a><br></div><br><div>Since LTTng 2.0, we have left early boot t=
racing to other tools, such</div><div>as Ftrace, which target kernel develo=
pers use-cases, and focused</div><div>more on tracing of the system in its =
execution phases which are more</div><div>relevant to application developer=
s.<br></div><br><div>If you want to go ahead and create a LTTng modules mod=
ule that<br></div><div>allow early boot tracing, I&#39;d be happy to provid=
e ideas and review.<br></div><br><div>Thanks,<br></div><br><div>Mathieu<br>=
</div><div><div><br><span>----- On Feb 25, 2016, at 3:56 PM, Martin Townsen=
d &lt;<a href=3D"mailto:mtownsend1973@gmail.com" target=3D"_blank">mtownsen=
d1973@gmail.com</a>&gt; wrote:<br></span></div></div><div><blockquote style=
=3D"border-left:2px solid #1010ff;margin-left:5px;padding-left:5px;color:#0=
00;font-weight:normal;font-style:normal;text-decoration:none;font-family:He=
lvetica,Arial,sans-serif;font-size:12pt"><div><div><div dir=3D"ltr"><div><d=
iv>Hi,<br><br></div>This is a bit of a long shot but does LTTng allow you t=
race boot?<br><br>I&#39;m seeing a weird problem where if I boot with syste=
md-bootchart if boots faster than just using systemd as the init process.=
=C2=A0 I created my own init process based on=C2=A0 systemd-bootchart and w=
orked out it was down to the fact it called nanosleep, so I now have my own=
 init process which hands over to systemd and creates a child that nanoslee=
ps for the boot duration.=C2=A0 I would really like to trace/profile the sc=
heduler and hrtimers understand what&#39;s happening and try and get a prop=
er fix :)=C2=A0 Even if it means a bit of hacking kernel/LTTng, I would be =
willing to do this.<br><br></div>Many Thanks, Martin.<br></div><br></div></=
div>_______________________________________________<br>lttng-dev mailing li=
st<br><a href=3D"mailto:lttng-dev@lists.lttng.org" target=3D"_blank">lttng-=
dev@lists.lttng.org</a><br><a href=3D"http://lists.lttng.org/cgi-bin/mailma=
n/listinfo/lttng-dev" target=3D"_blank">http://lists.lttng.org/cgi-bin/mail=
man/listinfo/lttng-dev</a><span><span style=3D"color:#888888"><br></span></=
span></blockquote></div><span><span style=3D"color:#888888"><br><div>-- <br=
></div><div>Mathieu Desnoyers<br>EfficiOS Inc.<br><a href=3D"http://www.eff=
icios.com" target=3D"_blank">http://www.efficios.com</a><br></div></span></=
span></div></div></blockquote></div></div><br></blockquote></div><br><div>-=
- <br></div><div>Mathieu Desnoyers<br>EfficiOS Inc.<br><a href=3D"http://ww=
w.efficios.com" target=3D"_blank">http://www.efficios.com</a></div></div><b=
r>_______________________________________________<br>lttng-dev mailing list=
<br><a href=3D"mailto:lttng-dev@lists.lttng.org" target=3D"_blank">lttng-de=
v@lists.lttng.org</a><br><a href=3D"http://lists.lttng.org/cgi-bin/mailman/=
listinfo/lttng-dev" target=3D"_blank">http://lists.lttng.org/cgi-bin/mailma=
n/listinfo/lttng-dev</a><br></blockquote></div></div></div><div><div class=
=3D"h5"><br><div>-- <br></div><div>Mathieu Desnoyers<br>EfficiOS Inc.<br><a=
 href=3D"http://www.efficios.com" target=3D"_blank">http://www.efficios.com=
</a></div></div></div></div></div></blockquote></div><br></div>

--001a11c3195cc15982052cb37890--


--===============0895360878==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0895360878==--
