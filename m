From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Tracing/Profiling boot
Date: Thu, 25 Feb 2016 21:18:14 +0000 (UTC)
Message-ID: <1765918553.8311.1456435094786.JavaMail.zimbra__27262.0064476088$1456435162$gmane$org@efficios.com>
References: <CABatt_wikOevABepAn8ruYDg63b4y+oD1e0nktGp=K85WHJiKA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1927516095=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1aZ3Im-0008J3-SN
 for lttng-dev@lists.lttng.org; Thu, 25 Feb 2016 16:18:26 -0500
In-Reply-To: <CABatt_wikOevABepAn8ruYDg63b4y+oD1e0nktGp=K85WHJiKA@mail.gmail.com>
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

--===============1927516095==
Content-Type: multipart/alternative;
	boundary="----=_Part_8310_1004008375.1456435094785"

------=_Part_8310_1004008375.1456435094785
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

Hi Martin, 

The main limitation LTTng currently has for early boot tracing is that 
you need to first spawn a lttng-sessiond user-space process, and setup 
tracing, before you can actually do any tracing. As long as you can 
fit within those constraints, you should be OK. 

If you really want to trace earlier than that, you might have to create 
a dedicated early-boot tracing module that would setup tracing 
buffers into a "dummy" session which exists only within lttng-modules, 
and then allow sessiond to later hook on those buffers when user-space 
is ready. Nothing exists for this at the moment. Note that since 
lttng-modules master (upcoming 2.8), you can now build lttng-modules 
into your kernel image, this might be useful for you. See the "kernel 
built-in support" section in 
https://github.com/lttng/lttng-modules/blob/master/README.md 

Since LTTng 2.0, we have left early boot tracing to other tools, such 
as Ftrace, which target kernel developers use-cases, and focused 
more on tracing of the system in its execution phases which are more 
relevant to application developers. 

If you want to go ahead and create a LTTng modules module that 
allow early boot tracing, I'd be happy to provide ideas and review. 

Thanks, 

Mathieu 

----- On Feb 25, 2016, at 3:56 PM, Martin Townsend <mtownsend1973@gmail.com> wrote: 

> Hi,

> This is a bit of a long shot but does LTTng allow you trace boot?

> I'm seeing a weird problem where if I boot with systemd-bootchart if boots
> faster than just using systemd as the init process. I created my own init
> process based on systemd-bootchart and worked out it was down to the fact it
> called nanosleep, so I now have my own init process which hands over to systemd
> and creates a child that nanosleeps for the boot duration. I would really like
> to trace/profile the scheduler and hrtimers understand what's happening and try
> and get a proper fix :) Even if it means a bit of hacking kernel/LTTng, I would
> be willing to do this.

> Many Thanks, Martin.

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers 
EfficiOS Inc. 
http://www.efficios.com 

------=_Part_8310_1004008375.1456435094785
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-family: arial, helvetica, sans-serif; font-s=
ize: 12pt; color: #000000"><div>Hi Martin,<br></div><div><br data-mce-bogus=
=3D"1"></div><div>The main limitation LTTng currently has for early boot tr=
acing is that<br data-mce-bogus=3D"1"></div><div>you need to first spawn a =
lttng-sessiond user-space process, and setup<br data-mce-bogus=3D"1"></div>=
<div>tracing, before you can actually do any tracing. As long as you can<br=
 data-mce-bogus=3D"1"></div><div>fit within those constraints, you should b=
e OK.<br data-mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"></div><di=
v>If you really want to trace earlier than that, you might have to create<b=
r data-mce-bogus=3D"1"></div><div>a dedicated early-boot tracing module tha=
t would setup tracing<br data-mce-bogus=3D"1"></div><div>buffers into a "du=
mmy" session which exists only within lttng-modules,</div><div>and then all=
ow sessiond to later hook on those buffers when user-space</div><div>is rea=
dy. Nothing exists for this at the moment. Note that since</div><div>lttng-=
modules master (upcoming 2.8), you can now build lttng-modules</div><div>in=
to your kernel image, this might be useful for you. See the "kernel</div><d=
iv>built-in support" section in</div><div>https://github.com/lttng/lttng-mo=
dules/blob/master/README.md<br data-mce-bogus=3D"1"></div><div><br data-mce=
-bogus=3D"1"></div><div>Since LTTng 2.0, we have left early boot tracing to=
 other tools, such</div><div>as Ftrace, which target kernel developers use-=
cases, and focused</div><div>more on tracing of the system in its execution=
 phases which are more</div><div>relevant to application developers.<br dat=
a-mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"></div><div>If you wan=
t to go ahead and create a LTTng modules module that<br data-mce-bogus=3D"1=
"></div><div>allow early boot tracing, I'd be happy to provide ideas and re=
view.<br data-mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"></div><di=
v>Thanks,<br data-mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"></div=
><div>Mathieu<br data-mce-bogus=3D"1"></div><div><br></div><span id=3D"zwch=
r" data-marker=3D"__DIVIDER__">----- On Feb 25, 2016, at 3:56 PM, Martin To=
wnsend &lt;mtownsend1973@gmail.com&gt; wrote:<br></span><div data-marker=3D=
"__QUOTED_TEXT__"><blockquote style=3D"border-left:2px solid #1010FF;margin=
-left:5px;padding-left:5px;color:#000;font-weight:normal;font-style:normal;=
text-decoration:none;font-family:Helvetica,Arial,sans-serif;font-size:12pt;=
"><div dir=3D"ltr"><div><div>Hi,<br><br></div>This is a bit of a long shot =
but does LTTng allow you trace boot?<br><br>I'm seeing a weird problem wher=
e if I boot with systemd-bootchart if boots faster than just using systemd =
as the init process.&nbsp; I created my own init process based on&nbsp; sys=
temd-bootchart and worked out it was down to the fact it called nanosleep, =
so I now have my own init process which hands over to systemd and creates a=
 child that nanosleeps for the boot duration.&nbsp; I would really like to =
trace/profile the scheduler and hrtimers understand what's happening and tr=
y and get a proper fix :)&nbsp; Even if it means a bit of hacking kernel/LT=
Tng, I would be willing to do this.<br><br></div>Many Thanks, Martin.<br></=
div>
<br>_______________________________________________<br>lttng-dev mailing li=
st<br>lttng-dev@lists.lttng.org<br>http://lists.lttng.org/cgi-bin/mailman/l=
istinfo/lttng-dev<br></blockquote></div><br><div data-marker=3D"__SIG_POST_=
_">-- <br></div><div>Mathieu Desnoyers<br>EfficiOS Inc.<br>http://www.effic=
ios.com</div></div></body></html>
------=_Part_8310_1004008375.1456435094785--


--===============1927516095==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1927516095==--
