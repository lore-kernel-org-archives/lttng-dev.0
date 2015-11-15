From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: LTTng ring buffer library.
Date: Sun, 15 Nov 2015 15:57:29 +0000 (UTC)
Message-ID: <767221134.96044.1447603049237.JavaMail.zimbra__28437.8635501072$1447603127$gmane$org@efficios.com>
References: <CAGJivuq1TxtJr8U0At46Zo2_T8JbURAcSykXL+rDAzq=EBTqxg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0887757907=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1ZxzgW-0000RI-Rq
 for lttng-dev@lists.lttng.org; Sun, 15 Nov 2015 10:57:46 -0500
In-Reply-To: <CAGJivuq1TxtJr8U0At46Zo2_T8JbURAcSykXL+rDAzq=EBTqxg@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mike <melon.aerial@gmail.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============0887757907==
Content-Type: multipart/alternative;
	boundary="----=_Part_96043_1230863694.1447603049236"

------=_Part_96043_1230863694.1447603049236
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

----- On Nov 6, 2015, at 4:09 PM, Mike <melon.aerial@gmail.com> wrote: 

> Hello.
> I'd like to use your library for ring buffers between kernel and userspace. I'd
> found that this library is in lttng-modules repo on github. But i haven't found
> any examples of codes in docs. I just want to use this libray. Have u got some
> easy example of using it or maybe u can say what files in repo ot watch to
> faster understand how it works?

Hi Mike, 

I'll reply to your private email questions below the lttng-dev thread, since there 
appears to be more questions than initially posted in the lttng-dev email. 

----- On Nov 13, 2015, at 10:05 AM, Mike <melon.aerial@gmail.com> wrote: 

> Hello.
> I've tried to send to mail-list. but i haven't received any answer.

We've been busy with a workshop last week, hence the delayed answers. 

> So you are the mainterner of github repo, that' why i'm writing you. So the
> first question about documentation about "Generic Ring Buffer Library". I've
> been searching internet and haven't found it.

The generic ring buffer library was initially created as a library (modules) 
for the Linux kernel. Its github repo can be found here: 
https://github.com/compudj/linux-libringbuffer/commits/tip-current-ringbuffer-0.240 

However, it's not actively maintained, and the updated libringbuffer code for 
the Linux kernel now sits in lttng-modules under /lib/. There are a few commits 
of lib ring buffer clients examples that were never integrated from the ringbuffer 
github repo to lttng-modules though. 

> Also i've seen code on github, understand it a little bit. But i haven't found
> and client code there, only kernel one.

The lib ring buffer "client" code is actually a in-kernel "client" of the library. 
A ring buffer "client" selects a ring buffer configuration, and chooses the 
data layout in the ring buffer. It also implements the userspace-visible interfaces 
to read from the ring buffer. 

> i'd like to use library for interaction from kernel-space to user-space. Is it
> for it?

No. The in-kernel library has in-kernel clients, and interfaces to read the buffer 
content from user-space, but user-space cannot write into the kernel buffers. 

I also did a port of libringbuffer from lttng-modules into lttng-ust, the lttng 
user-space tracer. However, this is only for writing into the buffer from 
user-space, not from the kernel. Reading the buffers is done by a user-space 
consumer daemon. 

> Or i've unserstood something wrong maybe. Also another question about LTTng.
> I've seen that is a big framework, but i'm only need to trace system calls. Can
> i use it with tracing only system calls?

Yes, you can use it to trace only syscalls. You will need lttng-tools 
and lttng-modules, and do 

(as root) 
lttng-sessiond -d 

(as root or user part of the tracing group) 
lttng create 
lttng enable-event --syscall '*' 
lttng start 
[....] 
lttng stop 
lttng view 

more details at http://lttng.org/docs 

You can replace '*' with e.g. 'open' or 'op*'. The wildcard needs to be 
at the end of the string. 

> And if i can, where it is usually save logs? Have it got any parameters for that
> or maybe u can say where i can find it it code, cause it will really help me.

$HOME/lttng-traces/ 

It can be changed by passing parameters to lttng create. See manpages or website doc. 
Thanks, 

Mathieu 

-- 
Mathieu Desnoyers 
EfficiOS Inc. 
http://www.efficios.com 

------=_Part_96043_1230863694.1447603049236
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-family: arial, helvetica, sans-serif; font-s=
ize: 12pt; color: #000000"><div><br></div><div><span id=3D"zwchr" data-mark=
er=3D"__DIVIDER__">----- On Nov 6, 2015, at 4:09 PM, Mike &lt;melon.aerial@=
gmail.com&gt; wrote:<br></span></div><div data-marker=3D"__QUOTED_TEXT__"><=
blockquote style=3D"border-left:2px solid #1010FF;margin-left:5px;padding-l=
eft:5px;color:#000;font-weight:normal;font-style:normal;text-decoration:non=
e;font-family:Helvetica,Arial,sans-serif;font-size:12pt;"><div dir=3D"ltr">=
<div style=3D"font-size:12.8000001907349px">Hello.<br></div><span style=3D"=
font-size:12.8000001907349px">I'd like to use your library for ring buffers=
 between kernel and userspace. I'd found that this library is in lttng-modu=
les repo on github. But i haven't found any examples of codes in docs. I ju=
st want to use this libray. Have u got some easy example of using it or may=
be u can say what files in repo ot watch to faster understand how it works?=
</span><br></div></blockquote><div><br></div><div><div>Hi Mike,</div><div><=
br data-mce-bogus=3D"1"></div><div>I'll reply to your private email questio=
ns below the lttng-dev thread, since there<br></div><div>appears to be more=
 questions than initially posted in the lttng-dev email.<br></div><div><br>=
</div><div><span id=3D"zwchr" data-marker=3D"__DIVIDER__">----- On Nov 13, =
2015, at 10:05 AM, Mike &lt;melon.aerial@gmail.com&gt; wrote:<br></span></d=
iv><div data-marker=3D"__QUOTED_TEXT__"><blockquote style=3D"border-left: 2=
px solid #1010FF; margin-left: 5px; padding-left: 5px; color: #000; font-we=
ight: normal; font-style: normal; text-decoration: none; font-family: Helve=
tica,Arial,sans-serif; font-size: 12pt;" data-mce-style=3D"border-left: 2px=
 solid #1010FF; margin-left: 5px; padding-left: 5px; color: #000; font-weig=
ht: normal; font-style: normal; text-decoration: none; font-family: Helveti=
ca,Arial,sans-serif; font-size: 12pt;"><div dir=3D"ltr"><div><div><div>Hell=
o.<br></div>I've tried to send to mail-list. but i haven't received any ans=
wer.</div></div></div></blockquote><div>We've been busy with a workshop las=
t week, hence the delayed answers.<br></div><div><br></div><blockquote styl=
e=3D"border-left: 2px solid #1010FF; margin-left: 5px; padding-left: 5px; c=
olor: #000; font-weight: normal; font-style: normal; text-decoration: none;=
 font-family: Helvetica,Arial,sans-serif; font-size: 12pt;" data-mce-style=
=3D"border-left: 2px solid #1010FF; margin-left: 5px; padding-left: 5px; co=
lor: #000; font-weight: normal; font-style: normal; text-decoration: none; =
font-family: Helvetica,Arial,sans-serif; font-size: 12pt;"><div dir=3D"ltr"=
><div><div>So you are the mainterner of github repo, that' why i'm writing =
you. So the first question about documentation about "Generic Ring Buffer L=
ibrary". I've been searching internet and haven't found it.</div></div></di=
v></blockquote><div>The generic ring buffer library was initially created a=
s a library (modules)</div><div>for the Linux kernel. Its github repo can b=
e found here:<br></div><div>https://github.com/compudj/linux-libringbuffer/=
commits/tip-current-ringbuffer-0.240</div><div><br></div><div>However, it's=
 not actively maintained, and the updated libringbuffer code for</div><div>=
the Linux kernel now sits in lttng-modules under /lib/. There are a few com=
mits</div><div>of lib ring buffer clients examples that were never integrat=
ed from the ringbuffer</div><div>github repo to lttng-modules though.</div>=
<div><br></div><blockquote style=3D"border-left: 2px solid #1010FF; margin-=
left: 5px; padding-left: 5px; color: #000; font-weight: normal; font-style:=
 normal; text-decoration: none; font-family: Helvetica,Arial,sans-serif; fo=
nt-size: 12pt;" data-mce-style=3D"border-left: 2px solid #1010FF; margin-le=
ft: 5px; padding-left: 5px; color: #000; font-weight: normal; font-style: n=
ormal; text-decoration: none; font-family: Helvetica,Arial,sans-serif; font=
-size: 12pt;"><div dir=3D"ltr"><div><div>Also i've seen code on github, und=
erstand it a little bit. But i haven't found and client code there, only ke=
rnel one.</div></div></div></blockquote><div>The lib ring buffer "client" c=
ode is actually a in-kernel "client" of the library.<br></div><div>A ring b=
uffer "client" selects a ring buffer configuration, and chooses the<br></di=
v><div>data layout in the ring buffer. It also implements the userspace-vis=
ible interfaces</div><div> to read from the ring buffer.<br data-mce-bogus=
=3D"1"></div><div><br data-mce-bogus=3D"1"></div><blockquote style=3D"borde=
r-left: 2px solid #1010FF; margin-left: 5px; padding-left: 5px; color: #000=
; font-weight: normal; font-style: normal; text-decoration: none; font-fami=
ly: Helvetica,Arial,sans-serif; font-size: 12pt;" data-mce-style=3D"border-=
left: 2px solid #1010FF; margin-left: 5px; padding-left: 5px; color: #000; =
font-weight: normal; font-style: normal; text-decoration: none; font-family=
: Helvetica,Arial,sans-serif; font-size: 12pt;"><div dir=3D"ltr"><div><div>=
i'd like to use library for interaction from kernel-space to user-space. Is=
 it for it?</div></div></div></blockquote><div>No. The in-kernel library ha=
s in-kernel clients, and interfaces to read the buffer<br></div><div>conten=
t from user-space, but user-space cannot write into the kernel buffers.</di=
v><div><br></div><div>I also did a port of libringbuffer from lttng-modules=
 into lttng-ust, the lttng</div><div>user-space tracer. However, this is on=
ly for writing into the buffer from</div><div>user-space, not from the kern=
el. Reading the buffers is done by a user-space</div><div>consumer daemon.<=
/div><div><br></div><blockquote style=3D"border-left: 2px solid #1010FF; ma=
rgin-left: 5px; padding-left: 5px; color: #000; font-weight: normal; font-s=
tyle: normal; text-decoration: none; font-family: Helvetica,Arial,sans-seri=
f; font-size: 12pt;" data-mce-style=3D"border-left: 2px solid #1010FF; marg=
in-left: 5px; padding-left: 5px; color: #000; font-weight: normal; font-sty=
le: normal; text-decoration: none; font-family: Helvetica,Arial,sans-serif;=
 font-size: 12pt;"><div dir=3D"ltr"><div><div>Or i've unserstood something =
wrong maybe. Also another question about LTTng. I've seen that is a big fra=
mework, but i'm only need to trace system calls. Can i use it with tracing =
only system calls?</div></div></div></blockquote><div>Yes, you can use it t=
o trace only syscalls. You will need lttng-tools</div><div>and lttng-module=
s, and do<br></div><div><br></div><div>(as root)</div><div>lttng-sessiond -=
d</div><div><br></div><div>(as root or user part of the tracing group)</div=
><div>lttng create</div><div>lttng enable-event --syscall '*'</div><div>ltt=
ng start</div><div>[....]</div><div>lttng stop</div><div>lttng view</div><d=
iv><br></div><div>more details at http://lttng.org/docs</div><div><br></div=
><div>You can replace '*' with e.g. 'open' or 'op*'. The wildcard needs to =
be</div><div>at the end of the string.</div><div><br></div><blockquote styl=
e=3D"border-left: 2px solid #1010FF; margin-left: 5px; padding-left: 5px; c=
olor: #000; font-weight: normal; font-style: normal; text-decoration: none;=
 font-family: Helvetica,Arial,sans-serif; font-size: 12pt;" data-mce-style=
=3D"border-left: 2px solid #1010FF; margin-left: 5px; padding-left: 5px; co=
lor: #000; font-weight: normal; font-style: normal; text-decoration: none; =
font-family: Helvetica,Arial,sans-serif; font-size: 12pt;"><div dir=3D"ltr"=
><div><div>And if i can, where it is usually save logs? Have it got any par=
ameters for that or maybe u can say where i can find it it code, cause it w=
ill really help me.</div></div></div></blockquote><div><br></div><div>$HOME=
/lttng-traces/</div><div><br></div><div>It can be changed by passing parame=
ters to lttng create. See manpages or website doc.</div></div><div data-mar=
ker=3D"__QUOTED_TEXT__">Thanks,</div><div data-marker=3D"__QUOTED_TEXT__"><=
br></div><div data-marker=3D"__QUOTED_TEXT__">Mathieu</div><div data-marker=
=3D"__QUOTED_TEXT__"><br></div></div><div><br data-mce-bogus=3D"1"></div></=
div><div data-marker=3D"__SIG_POST__">-- <br></div><div>Mathieu Desnoyers<b=
r>EfficiOS Inc.<br>http://www.efficios.com</div></div></body></html>
------=_Part_96043_1230863694.1447603049236--


--===============0887757907==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0887757907==--
