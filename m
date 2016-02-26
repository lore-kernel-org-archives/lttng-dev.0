From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Tracing/Profiling boot
Date: Fri, 26 Feb 2016 20:39:42 +0000 (UTC)
Message-ID: <1131485866.9244.1456519182086.JavaMail.zimbra__29796.0698292174$1456519257$gmane$org@efficios.com>
References: <CABatt_wikOevABepAn8ruYDg63b4y+oD1e0nktGp=K85WHJiKA@mail.gmail.com>
 <1765918553.8311.1456435094786.JavaMail.zimbra@efficios.com>
 <CABatt_xa21vPN-89n9COVgRM+rcqKpFU-iqRWB2NL37bxFjYbg@mail.gmail.com>
 <1128834814.8994.1456509679501.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0641540210=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1aZPB2-0007VH-Ir
 for lttng-dev@lists.lttng.org; Fri, 26 Feb 2016 15:39:59 -0500
In-Reply-To: <1128834814.8994.1456509679501.JavaMail.zimbra@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Martin Townsend <mtownsend1973@gmail.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============0641540210==
Content-Type: multipart/alternative;
	boundary="----=_Part_9243_1403418092.1456519182085"

------=_Part_9243_1403418092.1456519182085
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

----- On Feb 26, 2016, at 1:01 PM, Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote: 

> Hi Martin,

> I would say that the main advantages of using LTTng in this case
> would be on the tooling side, with availability of Trace Compass
> and LTTng Analyses projects to navigate in the resulting CTF
> traces, and get high-level overview of the various metrics that
> could slow down your system.

> LTTng would also allow you to correlate your kernel trace with
> a user-space trace gathered with lttng-ust, which gives you
> deeper insight into your applications.

One more benefit of using lttng as builtin tracer rather than 
ftrace is that LTTng gathers much more information about the 
system call input/output parameters than ftrace. This can be 
useful to get a better understanding of what userspace is 
doing with the kernel. 

Thanks, 

Mathieu 

> Thanks,

> Mathieu

> ----- On Feb 26, 2016, at 3:41 AM, Martin Townsend <mtownsend1973@gmail.com>
> wrote:

>> Hi Mathieu,
>> Thanks for the info, I didn't know about ftrace, I will take a look at this.

>> Out of interest would there be any benefits from using a built-in lttng module
>> over ftrace?

>> Cheers,
>> Martin.

>> On Thu, Feb 25, 2016 at 9:18 PM, Mathieu Desnoyers <
>> mathieu.desnoyers@efficios.com > wrote:

>>> Hi Martin,

>>> The main limitation LTTng currently has for early boot tracing is that
>>> you need to first spawn a lttng-sessiond user-space process, and setup
>>> tracing, before you can actually do any tracing. As long as you can
>>> fit within those constraints, you should be OK.

>>> If you really want to trace earlier than that, you might have to create
>>> a dedicated early-boot tracing module that would setup tracing
>>> buffers into a "dummy" session which exists only within lttng-modules,
>>> and then allow sessiond to later hook on those buffers when user-space
>>> is ready. Nothing exists for this at the moment. Note that since
>>> lttng-modules master (upcoming 2.8), you can now build lttng-modules
>>> into your kernel image, this might be useful for you. See the "kernel
>>> built-in support" section in
>>> https://github.com/lttng/lttng-modules/blob/master/README.md

>>> Since LTTng 2.0, we have left early boot tracing to other tools, such
>>> as Ftrace, which target kernel developers use-cases, and focused
>>> more on tracing of the system in its execution phases which are more
>>> relevant to application developers.

>>> If you want to go ahead and create a LTTng modules module that
>>> allow early boot tracing, I'd be happy to provide ideas and review.

>>> Thanks,

>>> Mathieu

>>> ----- On Feb 25, 2016, at 3:56 PM, Martin Townsend < mtownsend1973@gmail.com >
>>> wrote:

>>>> Hi,

>>>> This is a bit of a long shot but does LTTng allow you trace boot?

>>>> I'm seeing a weird problem where if I boot with systemd-bootchart if boots
>>>> faster than just using systemd as the init process. I created my own init
>>>> process based on systemd-bootchart and worked out it was down to the fact it
>>>> called nanosleep, so I now have my own init process which hands over to systemd
>>>> and creates a child that nanosleeps for the boot duration. I would really like
>>>> to trace/profile the scheduler and hrtimers understand what's happening and try
>>>> and get a proper fix :) Even if it means a bit of hacking kernel/LTTng, I would
>>>> be willing to do this.

>>>> Many Thanks, Martin.

>>>> _______________________________________________
>>>> lttng-dev mailing list
>>>> lttng-dev@lists.lttng.org
>>>> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

>>> --
>>> Mathieu Desnoyers
>>> EfficiOS Inc.
>>> http://www.efficios.com

> --
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers 
EfficiOS Inc. 
http://www.efficios.com 

------=_Part_9243_1403418092.1456519182085
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-family: arial, helvetica, sans-serif; font-s=
ize: 12pt; color: #000000"><div><br></div><div><br></div><span id=3D"zwchr"=
 data-marker=3D"__DIVIDER__">----- On Feb 26, 2016, at 1:01 PM, Mathieu Des=
noyers &lt;mathieu.desnoyers@efficios.com&gt; wrote:<br></span><div data-ma=
rker=3D"__QUOTED_TEXT__"><blockquote style=3D"border-left:2px solid #1010FF=
;margin-left:5px;padding-left:5px;color:#000;font-weight:normal;font-style:=
normal;text-decoration:none;font-family:Helvetica,Arial,sans-serif;font-siz=
e:12pt;"><div style=3D"font-family: arial, helvetica, sans-serif; font-size=
: 12pt; color: #000000"><div>Hi Martin,<br></div><br><div>I would say that =
the main advantages of using LTTng in this case</div><div>would be on the t=
ooling side, with availability of Trace Compass</div><div>and LTTng Analyse=
s projects to navigate in the resulting CTF</div><div>traces, and get high-=
level overview of the various metrics that</div><div>could slow down your s=
ystem.<br></div><br><div>LTTng would also allow you to correlate your kerne=
l trace with<br></div><div>a user-space trace gathered with lttng-ust, whic=
h gives you<br></div><div>deeper insight into your applications.</div></div=
></blockquote><div><br></div><div>One more benefit of using lttng as builti=
n tracer rather than<br data-mce-bogus=3D"1"></div><div>ftrace is that LTTn=
g gathers much more information about the<br data-mce-bogus=3D"1"></div><di=
v>system call input/output parameters than ftrace. This can be<br data-mce-=
bogus=3D"1"></div><div>useful to get a better understanding of what userspa=
ce is<br data-mce-bogus=3D"1"></div><div>doing with the kernel.<br data-mce=
-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"></div><div>Thanks,<br data=
-mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"></div><div>Mathieu<br =
data-mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"></div><blockquote =
style=3D"border-left:2px solid #1010FF;margin-left:5px;padding-left:5px;col=
or:#000;font-weight:normal;font-style:normal;text-decoration:none;font-fami=
ly:Helvetica,Arial,sans-serif;font-size:12pt;"><div style=3D"font-family: a=
rial, helvetica, sans-serif; font-size: 12pt; color: #000000"><div><br></di=
v><br><div>Thanks,<br></div><br><div>Mathieu<br></div><br><span id=3D"zwchr=
">----- On Feb 26, 2016, at 3:41 AM, Martin Townsend &lt;mtownsend1973@gmai=
l.com&gt; wrote:<br></span><div><blockquote style=3D"border-left:2px solid =
#1010FF;margin-left:5px;padding-left:5px;color:#000;font-weight:normal;font=
-style:normal;text-decoration:none;font-family:Helvetica,Arial,sans-serif;f=
ont-size:12pt;"><div dir=3D"ltr">Hi Mathieu,<br><div>Thanks for the info, I=
 didn't know about ftrace, I will take a look at this.&nbsp;</div><br><div>=
Out of interest would there be any benefits from using a built-in lttng mod=
ule over ftrace?</div><br><div>Cheers,<br>Martin.</div></div><div class=3D"=
gmail_extra"><br><div class=3D"gmail_quote">On Thu, Feb 25, 2016 at 9:18 PM=
, Mathieu Desnoyers <span dir=3D"ltr">&lt;<a href=3D"mailto:mathieu.desnoye=
rs@efficios.com" target=3D"_blank">mathieu.desnoyers@efficios.com</a>&gt;</=
span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8e=
x;border-left:1px #ccc solid;padding-left:1ex"><div><div style=3D"font-fami=
ly:arial,helvetica,sans-serif;font-size:12pt;color:#000000"><div>Hi Martin,=
<br></div><br><div>The main limitation LTTng currently has for early boot t=
racing is that<br></div><div>you need to first spawn a lttng-sessiond user-=
space process, and setup<br></div><div>tracing, before you can actually do =
any tracing. As long as you can<br></div><div>fit within those constraints,=
 you should be OK.<br></div><br><div>If you really want to trace earlier th=
an that, you might have to create<br></div><div>a dedicated early-boot trac=
ing module that would setup tracing<br></div><div>buffers into a "dummy" se=
ssion which exists only within lttng-modules,</div><div>and then allow sess=
iond to later hook on those buffers when user-space</div><div>is ready. Not=
hing exists for this at the moment. Note that since</div><div>lttng-modules=
 master (upcoming 2.8), you can now build lttng-modules</div><div>into your=
 kernel image, this might be useful for you. See the "kernel</div><div>buil=
t-in support" section in</div><div><a href=3D"https://github.com/lttng/lttn=
g-modules/blob/master/README.md" target=3D"_blank">https://github.com/lttng=
/lttng-modules/blob/master/README.md</a><br></div><br><div>Since LTTng 2.0,=
 we have left early boot tracing to other tools, such</div><div>as Ftrace, =
which target kernel developers use-cases, and focused</div><div>more on tra=
cing of the system in its execution phases which are more</div><div>relevan=
t to application developers.<br></div><br><div>If you want to go ahead and =
create a LTTng modules module that<br></div><div>allow early boot tracing, =
I'd be happy to provide ideas and review.<br></div><br><div>Thanks,<br></di=
v><br><div>Mathieu<br></div><div><div class=3D"h5"><br><span>----- On Feb 2=
5, 2016, at 3:56 PM, Martin Townsend &lt;<a href=3D"mailto:mtownsend1973@gm=
ail.com" target=3D"_blank">mtownsend1973@gmail.com</a>&gt; wrote:<br></span=
></div></div><div><blockquote style=3D"border-left:2px solid #1010ff;margin=
-left:5px;padding-left:5px;color:#000;font-weight:normal;font-style:normal;=
text-decoration:none;font-family:Helvetica,Arial,sans-serif;font-size:12pt"=
><div><div class=3D"h5"><div dir=3D"ltr"><div><div>Hi,<br><br></div>This is=
 a bit of a long shot but does LTTng allow you trace boot?<br><br>I'm seein=
g a weird problem where if I boot with systemd-bootchart if boots faster th=
an just using systemd as the init process.&nbsp; I created my own init proc=
ess based on&nbsp; systemd-bootchart and worked out it was down to the fact=
 it called nanosleep, so I now have my own init process which hands over to=
 systemd and creates a child that nanosleeps for the boot duration.&nbsp; I=
 would really like to trace/profile the scheduler and hrtimers understand w=
hat's happening and try and get a proper fix :)&nbsp; Even if it means a bi=
t of hacking kernel/LTTng, I would be willing to do this.<br><br></div>Many=
 Thanks, Martin.<br></div><br></div></div>_________________________________=
______________<br>lttng-dev mailing list<br><a href=3D"mailto:lttng-dev@lis=
ts.lttng.org" target=3D"_blank">lttng-dev@lists.lttng.org</a><br><a href=3D=
"http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev" target=3D"_blan=
k">http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev</a><span class=
=3D"HOEnZb"><span style=3D"color: #888888;"><br></span></span></blockquote>=
</div><span class=3D"HOEnZb"><span style=3D"color: #888888;"><br><div>-- <b=
r></div><div>Mathieu Desnoyers<br>EfficiOS Inc.<br><a href=3D"http://www.ef=
ficios.com" target=3D"_blank">http://www.efficios.com</a><br></div></span><=
/span></div></div></blockquote></div></div><br></blockquote></div><br><div>=
-- <br></div><div>Mathieu Desnoyers<br>EfficiOS Inc.<br>http://www.efficios=
.com</div></div><br>_______________________________________________<br>lttn=
g-dev mailing list<br>lttng-dev@lists.lttng.org<br>http://lists.lttng.org/c=
gi-bin/mailman/listinfo/lttng-dev<br></blockquote></div><br><div data-marke=
r=3D"__SIG_POST__">-- <br></div><div>Mathieu Desnoyers<br>EfficiOS Inc.<br>=
http://www.efficios.com</div></div></body></html>
------=_Part_9243_1403418092.1456519182085--


--===============0641540210==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0641540210==--
