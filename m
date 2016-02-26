From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Tracing/Profiling boot
Date: Fri, 26 Feb 2016 22:19:46 +0000 (UTC)
Message-ID: <1095711990.9541.1456525186327.JavaMail.zimbra__30929.131320636$1456525255$gmane$org@efficios.com>
References: <CABatt_wikOevABepAn8ruYDg63b4y+oD1e0nktGp=K85WHJiKA@mail.gmail.com>
 <1765918553.8311.1456435094786.JavaMail.zimbra@efficios.com>
 <CABatt_xa21vPN-89n9COVgRM+rcqKpFU-iqRWB2NL37bxFjYbg@mail.gmail.com>
 <1128834814.8994.1456509679501.JavaMail.zimbra@efficios.com>
 <1131485866.9244.1456519182086.JavaMail.zimbra@efficios.com>
 <CABatt_xXwcFVO+XzhYbqQKCaBzbNoxccB8y-1iqQ-HDABZKGwQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0884503642=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1aZQjs-00083Y-GV
 for lttng-dev@lists.lttng.org; Fri, 26 Feb 2016 17:19:58 -0500
In-Reply-To: <CABatt_xXwcFVO+XzhYbqQKCaBzbNoxccB8y-1iqQ-HDABZKGwQ@mail.gmail.com>
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

--===============0884503642==
Content-Type: multipart/alternative;
	boundary="----=_Part_9540_2014364593.1456525186326"

------=_Part_9540_2014364593.1456525186326
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

Hi, 

The timestamp source use by the lttng kernel and ust tracers is the 
monotonic clock. See clock_gettime(2) "CLOCK_MONOTONIC". 

However, both tracers sample both CLOCK_REALTIME and 
CLOCK_MONOTONIC at trace start to find the relationship 
(offset) of the monotonic clock with Epoch. 

If you start your tracing early at boot, before NTP has updated 
CLOCK_REALTIME, you might be depending on an unreliable 
offset from Epoch (e.g. system thinks it is in 1970, or your BIOS 
clock is a few hours wrong). 

One way to work around this is to use the new "lttng metadata regenerate" 
command after NTP has updated your realtime clock. So you basically 
start tracing with a "wrong" offset from Epoch, and then the lttng metadata 
regenerate command will fixup your metadata with the correct offset. 

We will merge the metadata regenerate command into lttng-tools master 
branch next week. 

Meanwhile, you can of course use the trace even though your offset from 
Epoch is not right, but it can make correlation with system logs (e.g. syslogd) 
a bit more cumbersome. 

Thanks, 

Mathieu 

----- On Feb 26, 2016, at 5:03 PM, Martin Townsend <mtownsend1973@gmail.com> wrote: 

> Hi Mathieu,

> Seeing the relationship between userspace and kernel would definitely be an
> advantage for this problem. As I will be looking into a lot of timing
> information and out of interest where does lttng get it's timestamps from?

> Once I have updated everything else to work happily with systemd I'll start to
> look into this. I'll start by seeing if I can bring up the lttng-sessiond
> user-space process within my custom init process and if this proves
> unsuccessful I will look into a custom lttng-module that's built into the
> kernel.

> Cheers,
> Martin.

> On Fri, Feb 26, 2016 at 8:39 PM, Mathieu Desnoyers <
> mathieu.desnoyers@efficios.com > wrote:

>> ----- On Feb 26, 2016, at 1:01 PM, Mathieu Desnoyers <
>> mathieu.desnoyers@efficios.com > wrote:

>>> Hi Martin,

>>> I would say that the main advantages of using LTTng in this case
>>> would be on the tooling side, with availability of Trace Compass
>>> and LTTng Analyses projects to navigate in the resulting CTF
>>> traces, and get high-level overview of the various metrics that
>>> could slow down your system.

>>> LTTng would also allow you to correlate your kernel trace with
>>> a user-space trace gathered with lttng-ust, which gives you
>>> deeper insight into your applications.

>> One more benefit of using lttng as builtin tracer rather than
>> ftrace is that LTTng gathers much more information about the
>> system call input/output parameters than ftrace. This can be
>> useful to get a better understanding of what userspace is
>> doing with the kernel.

>> Thanks,

>> Mathieu

>>> Thanks,

>>> Mathieu

>>> ----- On Feb 26, 2016, at 3:41 AM, Martin Townsend < mtownsend1973@gmail.com >
>>> wrote:

>>>> Hi Mathieu,
>>>> Thanks for the info, I didn't know about ftrace, I will take a look at this.

>>>> Out of interest would there be any benefits from using a built-in lttng module
>>>> over ftrace?

>>>> Cheers,
>>>> Martin.

>>>> On Thu, Feb 25, 2016 at 9:18 PM, Mathieu Desnoyers <
>>>> mathieu.desnoyers@efficios.com > wrote:

>>>>> Hi Martin,

>>>>> The main limitation LTTng currently has for early boot tracing is that
>>>>> you need to first spawn a lttng-sessiond user-space process, and setup
>>>>> tracing, before you can actually do any tracing. As long as you can
>>>>> fit within those constraints, you should be OK.

>>>>> If you really want to trace earlier than that, you might have to create
>>>>> a dedicated early-boot tracing module that would setup tracing
>>>>> buffers into a "dummy" session which exists only within lttng-modules,
>>>>> and then allow sessiond to later hook on those buffers when user-space
>>>>> is ready. Nothing exists for this at the moment. Note that since
>>>>> lttng-modules master (upcoming 2.8), you can now build lttng-modules
>>>>> into your kernel image, this might be useful for you. See the "kernel
>>>>> built-in support" section in
>>>>> https://github.com/lttng/lttng-modules/blob/master/README.md

>>>>> Since LTTng 2.0, we have left early boot tracing to other tools, such
>>>>> as Ftrace, which target kernel developers use-cases, and focused
>>>>> more on tracing of the system in its execution phases which are more
>>>>> relevant to application developers.

>>>>> If you want to go ahead and create a LTTng modules module that
>>>>> allow early boot tracing, I'd be happy to provide ideas and review.

>>>>> Thanks,

>>>>> Mathieu

>>>>> ----- On Feb 25, 2016, at 3:56 PM, Martin Townsend < mtownsend1973@gmail.com >
>>>>> wrote:

>>>>>> Hi,

>>>>>> This is a bit of a long shot but does LTTng allow you trace boot?

>>>>>> I'm seeing a weird problem where if I boot with systemd-bootchart if boots
>>>>>> faster than just using systemd as the init process. I created my own init
>>>>>> process based on systemd-bootchart and worked out it was down to the fact it
>>>>>> called nanosleep, so I now have my own init process which hands over to systemd
>>>>>> and creates a child that nanosleeps for the boot duration. I would really like
>>>>>> to trace/profile the scheduler and hrtimers understand what's happening and try
>>>>>> and get a proper fix :) Even if it means a bit of hacking kernel/LTTng, I would
>>>>>> be willing to do this.

>>>>>> Many Thanks, Martin.

>>>>>> _______________________________________________
>>>>>> lttng-dev mailing list
>>>>>> lttng-dev@lists.lttng.org
>>>>>> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

>>>>> --
>>>>> Mathieu Desnoyers
>>>>> EfficiOS Inc.
>>>>> http://www.efficios.com

>>> --
>>> Mathieu Desnoyers
>>> EfficiOS Inc.
>>> http://www.efficios.com

>>> _______________________________________________
>>> lttng-dev mailing list
>>> lttng-dev@lists.lttng.org
>>> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

>> --
>> Mathieu Desnoyers
>> EfficiOS Inc.
>> http://www.efficios.com

-- 
Mathieu Desnoyers 
EfficiOS Inc. 
http://www.efficios.com 

------=_Part_9540_2014364593.1456525186326
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-family: arial, helvetica, sans-serif; font-s=
ize: 12pt; color: #000000"><div>Hi,</div><div><br data-mce-bogus=3D"1"></di=
v><div>The timestamp source use by the lttng kernel and ust tracers is the<=
/div><div>monotonic clock. See clock_gettime(2) "CLOCK_MONOTONIC".<br data-=
mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"></div><div>However, bot=
h tracers sample both CLOCK_REALTIME and<br data-mce-bogus=3D"1"></div><div=
>CLOCK_MONOTONIC at trace start to find the relationship</div><div>(offset)=
 of the monotonic clock with Epoch.<br data-mce-bogus=3D"1"></div><div><br =
data-mce-bogus=3D"1"></div><div>If you start your tracing early at boot, be=
fore NTP has updated<br data-mce-bogus=3D"1"></div><div>CLOCK_REALTIME, you=
 might be depending on an unreliable<br data-mce-bogus=3D"1"></div><div>off=
set from Epoch (e.g. system thinks it is in 1970, or your BIOS<br data-mce-=
bogus=3D"1"></div><div>clock is a few hours wrong).<br data-mce-bogus=3D"1"=
></div><div><br data-mce-bogus=3D"1"></div><div>One way to work around this=
 is to use the new "lttng metadata regenerate"<br data-mce-bogus=3D"1"></di=
v><div>command after NTP has updated your realtime clock. So you basically<=
br></div><div>start tracing with a "wrong" offset from Epoch, and then the =
lttng metadata<br data-mce-bogus=3D"1"></div><div>regenerate command will f=
ixup your metadata with the correct offset.<br data-mce-bogus=3D"1"></div><=
div><br data-mce-bogus=3D"1"></div><div>We will merge the metadata regenera=
te command into lttng-tools master</div><div>branch next week.<br data-mce-=
bogus=3D"1"></div><div><br data-mce-bogus=3D"1"></div><div>Meanwhile, you c=
an of course use the trace even though your offset from<br></div><div>Epoch=
 is not right, but it can make correlation with system logs (e.g. syslogd)<=
/div><div>a bit more cumbersome.<br data-mce-bogus=3D"1"></div><div><br dat=
a-mce-bogus=3D"1"></div><div>Thanks,<br data-mce-bogus=3D"1"></div><div><br=
 data-mce-bogus=3D"1"></div><div>Mathieu<br data-mce-bogus=3D"1"></div><div=
><br></div><div><br></div><div><span id=3D"zwchr" data-marker=3D"__DIVIDER_=
_">----- On Feb 26, 2016, at 5:03 PM, Martin Townsend &lt;mtownsend1973@gma=
il.com&gt; wrote:<br></span></div><div data-marker=3D"__QUOTED_TEXT__"><blo=
ckquote style=3D"border-left:2px solid #1010FF;margin-left:5px;padding-left=
:5px;color:#000;font-weight:normal;font-style:normal;text-decoration:none;f=
ont-family:Helvetica,Arial,sans-serif;font-size:12pt;"><div dir=3D"ltr"><di=
v><div>Hi Mathieu,<br><br></div>Seeing the relationship between userspace a=
nd kernel would definitely be an advantage for this problem.&nbsp; As I wil=
l be looking into a lot of timing information and out of interest where doe=
s lttng get it's timestamps from?<br><br>Once I have updated everything els=
e to work happily with systemd I'll start to look into this.&nbsp; I'll sta=
rt by seeing if I can bring up the&nbsp; lttng-sessiond user-space process =
within my custom init process and if this proves unsuccessful I will look i=
nto a custom lttng-module that's built into the kernel.<br><br></div><div>C=
heers,<br></div><div>Martin.<br></div></div><div class=3D"gmail_extra"><br>=
<div class=3D"gmail_quote">On Fri, Feb 26, 2016 at 8:39 PM, Mathieu Desnoye=
rs <span dir=3D"ltr">&lt;<a href=3D"mailto:mathieu.desnoyers@efficios.com" =
target=3D"_blank">mathieu.desnoyers@efficios.com</a>&gt;</span> wrote:<br><=
blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px=
 #ccc solid;padding-left:1ex"><div><div style=3D"font-family:arial,helvetic=
a,sans-serif;font-size:12pt;color:#000000"><span class=3D""><br><br><span>-=
---- On Feb 26, 2016, at 1:01 PM, Mathieu Desnoyers &lt;<a href=3D"mailto:m=
athieu.desnoyers@efficios.com" target=3D"_blank">mathieu.desnoyers@efficios=
.com</a>&gt; wrote:<br></span></span><div><blockquote style=3D"border-left:=
2px solid #1010ff;margin-left:5px;padding-left:5px;color:#000;font-weight:n=
ormal;font-style:normal;text-decoration:none;font-family:Helvetica,Arial,sa=
ns-serif;font-size:12pt"><div style=3D"font-family:arial,helvetica,sans-ser=
if;font-size:12pt;color:#000000"><div>Hi Martin,<br></div><br><span class=
=3D""><div>I would say that the main advantages of using LTTng in this case=
</div><div>would be on the tooling side, with availability of Trace Compass=
</div><div>and LTTng Analyses projects to navigate in the resulting CTF</di=
v><div>traces, and get high-level overview of the various metrics that</div=
><div>could slow down your system.<br></div><br><div>LTTng would also allow=
 you to correlate your kernel trace with<br></div><div>a user-space trace g=
athered with lttng-ust, which gives you<br></div><div>deeper insight into y=
our applications.</div></span></div></blockquote><br><div>One more benefit =
of using lttng as builtin tracer rather than<br></div><div>ftrace is that L=
TTng gathers much more information about the<br></div><div>system call inpu=
t/output parameters than ftrace. This can be<br></div><div>useful to get a =
better understanding of what userspace is<br></div><div>doing with the kern=
el.<br></div><br><div>Thanks,<br></div><br><div>Mathieu<br></div><div><div =
class=3D"h5"><br><blockquote style=3D"border-left:2px solid #1010ff;margin-=
left:5px;padding-left:5px;color:#000;font-weight:normal;font-style:normal;t=
ext-decoration:none;font-family:Helvetica,Arial,sans-serif;font-size:12pt">=
<div style=3D"font-family:arial,helvetica,sans-serif;font-size:12pt;color:#=
000000"><br><br><div>Thanks,<br></div><br><div>Mathieu<br></div><br><span>-=
---- On Feb 26, 2016, at 3:41 AM, Martin Townsend &lt;<a href=3D"mailto:mto=
wnsend1973@gmail.com" target=3D"_blank">mtownsend1973@gmail.com</a>&gt; wro=
te:<br></span><div><blockquote style=3D"border-left:2px solid #1010ff;margi=
n-left:5px;padding-left:5px;color:#000;font-weight:normal;font-style:normal=
;text-decoration:none;font-family:Helvetica,Arial,sans-serif;font-size:12pt=
"><div dir=3D"ltr">Hi Mathieu,<br><div>Thanks for the info, I didn't know a=
bout ftrace, I will take a look at this.&nbsp;</div><br><div>Out of interes=
t would there be any benefits from using a built-in lttng module over ftrac=
e?</div><br><div>Cheers,<br>Martin.</div></div><div class=3D"gmail_extra"><=
br><div class=3D"gmail_quote">On Thu, Feb 25, 2016 at 9:18 PM, Mathieu Desn=
oyers <span dir=3D"ltr">&lt;<a href=3D"mailto:mathieu.desnoyers@efficios.co=
m" target=3D"_blank">mathieu.desnoyers@efficios.com</a>&gt;</span> wrote:<b=
r><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:=
1px #ccc solid;padding-left:1ex"><div><div style=3D"font-family:arial,helve=
tica,sans-serif;font-size:12pt;color:#000000"><div>Hi Martin,<br></div><br>=
<div>The main limitation LTTng currently has for early boot tracing is that=
<br></div><div>you need to first spawn a lttng-sessiond user-space process,=
 and setup<br></div><div>tracing, before you can actually do any tracing. A=
s long as you can<br></div><div>fit within those constraints, you should be=
 OK.<br></div><br><div>If you really want to trace earlier than that, you m=
ight have to create<br></div><div>a dedicated early-boot tracing module tha=
t would setup tracing<br></div><div>buffers into a "dummy" session which ex=
ists only within lttng-modules,</div><div>and then allow sessiond to later =
hook on those buffers when user-space</div><div>is ready. Nothing exists fo=
r this at the moment. Note that since</div><div>lttng-modules master (upcom=
ing 2.8), you can now build lttng-modules</div><div>into your kernel image,=
 this might be useful for you. See the "kernel</div><div>built-in support" =
section in</div><div><a href=3D"https://github.com/lttng/lttng-modules/blob=
/master/README.md" target=3D"_blank">https://github.com/lttng/lttng-modules=
/blob/master/README.md</a><br></div><br><div>Since LTTng 2.0, we have left =
early boot tracing to other tools, such</div><div>as Ftrace, which target k=
ernel developers use-cases, and focused</div><div>more on tracing of the sy=
stem in its execution phases which are more</div><div>relevant to applicati=
on developers.<br></div><br><div>If you want to go ahead and create a LTTng=
 modules module that<br></div><div>allow early boot tracing, I'd be happy t=
o provide ideas and review.<br></div><br><div>Thanks,<br></div><br><div>Mat=
hieu<br></div><div><div><br><span>----- On Feb 25, 2016, at 3:56 PM, Martin=
 Townsend &lt;<a href=3D"mailto:mtownsend1973@gmail.com" target=3D"_blank">=
mtownsend1973@gmail.com</a>&gt; wrote:<br></span></div></div><div><blockquo=
te style=3D"border-left:2px solid #1010ff;margin-left:5px;padding-left:5px;=
color:#000;font-weight:normal;font-style:normal;text-decoration:none;font-f=
amily:Helvetica,Arial,sans-serif;font-size:12pt"><div><div><div dir=3D"ltr"=
><div><div>Hi,<br><br></div>This is a bit of a long shot but does LTTng all=
ow you trace boot?<br><br>I'm seeing a weird problem where if I boot with s=
ystemd-bootchart if boots faster than just using systemd as the init proces=
s.&nbsp; I created my own init process based on&nbsp; systemd-bootchart and=
 worked out it was down to the fact it called nanosleep, so I now have my o=
wn init process which hands over to systemd and creates a child that nanosl=
eeps for the boot duration.&nbsp; I would really like to trace/profile the =
scheduler and hrtimers understand what's happening and try and get a proper=
 fix :)&nbsp; Even if it means a bit of hacking kernel/LTTng, I would be wi=
lling to do this.<br><br></div>Many Thanks, Martin.<br></div><br></div></di=
v>_______________________________________________<br>lttng-dev mailing list=
<br><a href=3D"mailto:lttng-dev@lists.lttng.org" target=3D"_blank">lttng-de=
v@lists.lttng.org</a><br><a href=3D"http://lists.lttng.org/cgi-bin/mailman/=
listinfo/lttng-dev" target=3D"_blank">http://lists.lttng.org/cgi-bin/mailma=
n/listinfo/lttng-dev</a><span><span style=3D"color:#888888"><br></span></sp=
an></blockquote></div><span><span style=3D"color:#888888"><br><div>-- <br><=
/div><div>Mathieu Desnoyers<br>EfficiOS Inc.<br><a href=3D"http://www.effic=
ios.com" target=3D"_blank">http://www.efficios.com</a><br></div></span></sp=
an></div></div></blockquote></div></div><br></blockquote></div><br><div>-- =
<br></div><div>Mathieu Desnoyers<br>EfficiOS Inc.<br><a href=3D"http://www.=
efficios.com" target=3D"_blank">http://www.efficios.com</a><br data-mce-bog=
us=3D"1"></div></div><br>_______________________________________________<br=
>lttng-dev mailing list<br><a href=3D"mailto:lttng-dev@lists.lttng.org" tar=
get=3D"_blank">lttng-dev@lists.lttng.org</a><br><a href=3D"http://lists.ltt=
ng.org/cgi-bin/mailman/listinfo/lttng-dev" target=3D"_blank">http://lists.l=
ttng.org/cgi-bin/mailman/listinfo/lttng-dev</a><br></blockquote></div></div=
></div><div><div class=3D"h5"><br><div>-- <br></div><div>Mathieu Desnoyers<=
br>EfficiOS Inc.<br><a href=3D"http://www.efficios.com" target=3D"_blank">h=
ttp://www.efficios.com</a><br data-mce-bogus=3D"1"></div></div></div></div>=
</div></blockquote></div></div><br></blockquote></div><div><br></div><div d=
ata-marker=3D"__SIG_POST__">-- <br></div><div>Mathieu Desnoyers<br>EfficiOS=
 Inc.<br>http://www.efficios.com</div></div></body></html>
------=_Part_9540_2014364593.1456525186326--


--===============0884503642==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0884503642==--
