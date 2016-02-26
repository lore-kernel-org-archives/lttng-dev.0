From: Martin Townsend <mtownsend1973@gmail.com>
Subject: Re: Tracing/Profiling boot
Date: Fri, 26 Feb 2016 08:41:48 +0000
Message-ID: <CABatt_xa21vPN-89n9COVgRM+rcqKpFU-iqRWB2NL37bxFjYbg__17048.591891262$1456476174$gmane$org@mail.gmail.com>
References: <CABatt_wikOevABepAn8ruYDg63b4y+oD1e0nktGp=K85WHJiKA@mail.gmail.com>
 <1765918553.8311.1456435094786.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1330660836=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-lf0-f50.google.com ([209.85.215.50])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <mtownsend1973@gmail.com>) id 1aZDyE-0003Uk-Bq
 for lttng-dev@lists.lttng.org; Fri, 26 Feb 2016 03:41:55 -0500
Received: by mail-lf0-f50.google.com with SMTP id l143so49010183lfe.2
 for <lttng-dev@lists.lttng.org>; Fri, 26 Feb 2016 00:41:54 -0800 (PST)
In-Reply-To: <1765918553.8311.1456435094786.JavaMail.zimbra@efficios.com>
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

--===============1330660836==
Content-Type: multipart/alternative; boundary=001a113ec1801166c9052ca845d1

--001a113ec1801166c9052ca845d1
Content-Type: text/plain; charset=UTF-8

Hi Mathieu,

Thanks for the info, I didn't know about ftrace, I will take a look at
this.

Out of interest would there be any benefits from using a built-in lttng
module over ftrace?

Cheers,
Martin.

On Thu, Feb 25, 2016 at 9:18 PM, Mathieu Desnoyers <
mathieu.desnoyers@efficios.com> wrote:

> Hi Martin,
>
> The main limitation LTTng currently has for early boot tracing is that
> you need to first spawn a lttng-sessiond user-space process, and setup
> tracing, before you can actually do any tracing. As long as you can
> fit within those constraints, you should be OK.
>
> If you really want to trace earlier than that, you might have to create
> a dedicated early-boot tracing module that would setup tracing
> buffers into a "dummy" session which exists only within lttng-modules,
> and then allow sessiond to later hook on those buffers when user-space
> is ready. Nothing exists for this at the moment. Note that since
> lttng-modules master (upcoming 2.8), you can now build lttng-modules
> into your kernel image, this might be useful for you. See the "kernel
> built-in support" section in
> https://github.com/lttng/lttng-modules/blob/master/README.md
>
> Since LTTng 2.0, we have left early boot tracing to other tools, such
> as Ftrace, which target kernel developers use-cases, and focused
> more on tracing of the system in its execution phases which are more
> relevant to application developers.
>
> If you want to go ahead and create a LTTng modules module that
> allow early boot tracing, I'd be happy to provide ideas and review.
>
> Thanks,
>
> Mathieu
>
> ----- On Feb 25, 2016, at 3:56 PM, Martin Townsend <
> mtownsend1973@gmail.com> wrote:
>
> Hi,
>
> This is a bit of a long shot but does LTTng allow you trace boot?
>
> I'm seeing a weird problem where if I boot with systemd-bootchart if boots
> faster than just using systemd as the init process.  I created my own init
> process based on  systemd-bootchart and worked out it was down to the fact
> it called nanosleep, so I now have my own init process which hands over to
> systemd and creates a child that nanosleeps for the boot duration.  I would
> really like to trace/profile the scheduler and hrtimers understand what's
> happening and try and get a proper fix :)  Even if it means a bit of
> hacking kernel/LTTng, I would be willing to do this.
>
> Many Thanks, Martin.
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

--001a113ec1801166c9052ca845d1
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Mathieu,<div><br></div><div>Thanks for the info, I didn=
&#39;t know about ftrace, I will take a look at this.=C2=A0</div><div><br><=
/div><div>Out of interest would there be any benefits from using a built-in=
 lttng module over ftrace?</div><div><br></div><div>Cheers,<br>Martin.</div=
></div><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">On Thu, Fe=
b 25, 2016 at 9:18 PM, Mathieu Desnoyers <span dir=3D"ltr">&lt;<a href=3D"m=
ailto:mathieu.desnoyers@efficios.com" target=3D"_blank">mathieu.desnoyers@e=
fficios.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div><d=
iv style=3D"font-family:arial,helvetica,sans-serif;font-size:12pt;color:#00=
0000"><div>Hi Martin,<br></div><div><br></div><div>The main limitation LTTn=
g currently has for early boot tracing is that<br></div><div>you need to fi=
rst spawn a lttng-sessiond user-space process, and setup<br></div><div>trac=
ing, before you can actually do any tracing. As long as you can<br></div><d=
iv>fit within those constraints, you should be OK.<br></div><div><br></div>=
<div>If you really want to trace earlier than that, you might have to creat=
e<br></div><div>a dedicated early-boot tracing module that would setup trac=
ing<br></div><div>buffers into a &quot;dummy&quot; session which exists onl=
y within lttng-modules,</div><div>and then allow sessiond to later hook on =
those buffers when user-space</div><div>is ready. Nothing exists for this a=
t the moment. Note that since</div><div>lttng-modules master (upcoming 2.8)=
, you can now build lttng-modules</div><div>into your kernel image, this mi=
ght be useful for you. See the &quot;kernel</div><div>built-in support&quot=
; section in</div><div><a href=3D"https://github.com/lttng/lttng-modules/bl=
ob/master/README.md" target=3D"_blank">https://github.com/lttng/lttng-modul=
es/blob/master/README.md</a><br></div><div><br></div><div>Since LTTng 2.0, =
we have left early boot tracing to other tools, such</div><div>as Ftrace, w=
hich target kernel developers use-cases, and focused</div><div>more on trac=
ing of the system in its execution phases which are more</div><div>relevant=
 to application developers.<br></div><div><br></div><div>If you want to go =
ahead and create a LTTng modules module that<br></div><div>allow early boot=
 tracing, I&#39;d be happy to provide ideas and review.<br></div><div><br><=
/div><div>Thanks,<br></div><div><br></div><div>Mathieu<br></div><div><div c=
lass=3D"h5"><div><br></div><span>----- On Feb 25, 2016, at 3:56 PM, Martin =
Townsend &lt;<a href=3D"mailto:mtownsend1973@gmail.com" target=3D"_blank">m=
townsend1973@gmail.com</a>&gt; wrote:<br></span></div></div><div><blockquot=
e style=3D"border-left:2px solid #1010ff;margin-left:5px;padding-left:5px;c=
olor:#000;font-weight:normal;font-style:normal;text-decoration:none;font-fa=
mily:Helvetica,Arial,sans-serif;font-size:12pt"><div><div class=3D"h5"><div=
 dir=3D"ltr"><div><div>Hi,<br><br></div>This is a bit of a long shot but do=
es LTTng allow you trace boot?<br><br>I&#39;m seeing a weird problem where =
if I boot with systemd-bootchart if boots faster than just using systemd as=
 the init process.=C2=A0 I created my own init process based on=C2=A0 syste=
md-bootchart and worked out it was down to the fact it called nanosleep, so=
 I now have my own init process which hands over to systemd and creates a c=
hild that nanosleeps for the boot duration.=C2=A0 I would really like to tr=
ace/profile the scheduler and hrtimers understand what&#39;s happening and =
try and get a proper fix :)=C2=A0 Even if it means a bit of hacking kernel/=
LTTng, I would be willing to do this.<br><br></div>Many Thanks, Martin.<br>=
</div>
<br></div></div>_______________________________________________<br>lttng-de=
v mailing list<br><a href=3D"mailto:lttng-dev@lists.lttng.org" target=3D"_b=
lank">lttng-dev@lists.lttng.org</a><br><a href=3D"http://lists.lttng.org/cg=
i-bin/mailman/listinfo/lttng-dev" target=3D"_blank">http://lists.lttng.org/=
cgi-bin/mailman/listinfo/lttng-dev</a><span class=3D"HOEnZb"><font color=3D=
"#888888"><br></font></span></blockquote></div><span class=3D"HOEnZb"><font=
 color=3D"#888888"><br><div>-- <br></div><div>Mathieu Desnoyers<br>EfficiOS=
 Inc.<br><a href=3D"http://www.efficios.com" target=3D"_blank">http://www.e=
fficios.com</a></div></font></span></div></div></blockquote></div><br></div=
>

--001a113ec1801166c9052ca845d1--


--===============1330660836==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1330660836==--
