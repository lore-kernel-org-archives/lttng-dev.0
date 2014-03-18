From: Jonathan Rajotte <jonathan.r.julien@gmail.com>
Subject: Re: session create failed
Date: Tue, 18 Mar 2014 13:11:38 -0400
Message-ID: <CAF4oYfF_Y=GnhgEsyp87fiL6uDsDdxkezSm2sxm2Gt71kU0NoA__46787.1543173262$1395162774$gmane$org@mail.gmail.com>
References: <CACFGcbacSUM2LyVCtZQRZtJY2-0t6NCp9fvgFNQNSgOrcn8HAw@mail.gmail.com>
	<CAF4oYfEnUPU18SFgUn5_1rhyRpBwDq-ak=KjBw0tfszFn9QoXA@mail.gmail.com>
	<CACFGcbYMkpuKv5nGKRGwy+NDMHagErBOwOJP0_cNOTL5UharjQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0258054920=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-yh0-f47.google.com ([209.85.213.47])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jonathan.r.julien@gmail.com>) id 1WPxYG-0003Ys-BZ
	for lttng-dev@lists.lttng.org; Tue, 18 Mar 2014 13:11:50 -0400
Received: by mail-yh0-f47.google.com with SMTP id 29so7255313yhl.34
	for <lttng-dev@lists.lttng.org>; Tue, 18 Mar 2014 10:11:38 -0700 (PDT)
In-Reply-To: <CACFGcbYMkpuKv5nGKRGwy+NDMHagErBOwOJP0_cNOTL5UharjQ@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Lingyu Zhu <lynuszhu@gmail.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============0258054920==
Content-Type: multipart/alternative; boundary=089e014952960d7cda04f4e4a151

--089e014952960d7cda04f4e4a151
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

AFAIK if you want to use kernel tracing as a regular user you need:
1)  to be part of a tracing user group (default: tracing [1])
2) sessiond must be started by root

you can use "sudo lttng-sessiond -d" before doing any lttng related tasks
and/or you can add sessiond to your boot sequence.

[1] you might need to create it, you can also use another group via
lttng-sessiond -g <group_name>


On Tue, Mar 18, 2014 at 12:53 PM, Lingyu Zhu <lynuszhu@gmail.com> wrote:

>
>
> On Wed, Mar 19, 2014 at 12:35 AM, Jonathan Rajotte <
> jonathan.r.julien@gmail.com> wrote:
>
>> Hi Lingyu,
>>
>>  Does a sessiond is created on boot ?
>>> You can check via htop and filter for lttng or sessiond.
>>>
>> No sessiond is created on boot before I do these operations.
>> what else info should I provide?
>>
>>
>>
>>  On Tue, Mar 18, 2014 at 12:31 PM, Lingyu Zhu <lynuszhu@gmail.com> wrote=
:
>>
>>>   Hello,
>>> Sorry for being away a few days. My thesis opening proposal is hiting
>>> the deadline, which happens to be same date for GSoC. Now I can be full=
y
>>> devoted to lttng and compose my GSoC proposal.
>>>
>>> Anyway, I may have found a bug.I'm not very sure. Here is my log:
>>>
>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
>>>  [lynus@slave1 ~]$lttng create
>>> Spawning a session daemon
>>> Session auto-20140319-081547 created.
>>> Traces will be written in /home/lynus/lttng-traces/auto-20140319-081547
>>> [lynus@slave1 ~]$ lttng enable-event page_block -k
>>> Error: Event page_block: Tracing the kernel requires a root
>>> lttng-sessiond daemon, as well as "tracing" group membership or root us=
er
>>> ID for the lttng client. (channel channel0, session auto-20140319-08154=
7)
>>> Warning: Some command(s) went wrong
>>> [lynus@slave1 ~]$ lttng destroy
>>> Session auto-20140319-081547 destroyed
>>> [lynus@slave1 ~]$ sudo su -
>>> [sudo] password for lynus:
>>> root@slave1:~# lttng create
>>> Spawning a session daemon
>>> Warning: No tracing group detected
>>> Session auto-20140319-081615 created.
>>> Traces will be written in /root/lttng-traces/auto-20140319-081615
>>> PERROR [4774/4882]: bind inet: Address already in use (in
>>> lttcomm_bind_inet_sock() at inet.c:109)
>>> Warning: An other session daemon is using this JUL port. JUL support
>>> will be deactivated not interfering with the tracing.
>>> root@slave1:~# lttng create
>>> Session auto-20140319-081620 created.
>>> Traces will be written in /root/lttng-traces/auto-20140319-081620
>>> root@slave1:~#
>>> [END] 2014/3/19 0:04:31
>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
>>>
>>> These command is issued right after my machine is booted. And it failed
>>> every time if I try to enable kernel event as non-root user first then
>>> switch to root to create session.  If I directly switch to root and cre=
ate
>>> a seesion, everything is normal. So I guess I may have come across a bu=
g.
>>> Any comment?
>>>
>>> _______________________________________________
>>> lttng-dev mailing list
>>> lttng-dev@lists.lttng.org
>>> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>>>
>>>
>>
>>
>> --
>> Jonathan Rajotte Julien
>> Charg=E9 de laboratoire, INF1995
>> Polytechnique Montr=E9al
>>
>
>


--=20
Jonathan Rajotte Julien
Charg=E9 de laboratoire, INF1995
Polytechnique Montr=E9al

--089e014952960d7cda04f4e4a151
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">AFAIK if you want to use kernel tracing as a regular user =
you need:<div>1) =A0to be part of a tracing user group (default: tracing [1=
])</div><div>2) sessiond must be started by root</div><div><br></div><div>y=
ou can use &quot;sudo lttng-sessiond -d&quot; before doing any lttng relate=
d tasks and/or you can add sessiond to your boot sequence.=A0</div>
<div><br></div><div>[1] you might need to create it, you can also use anoth=
er group via lttng-sessiond -g &lt;group_name&gt;</div></div><div class=3D"=
gmail_extra"><br><br><div class=3D"gmail_quote">On Tue, Mar 18, 2014 at 12:=
53 PM, Lingyu Zhu <span dir=3D"ltr">&lt;<a href=3D"mailto:lynuszhu@gmail.co=
m" target=3D"_blank">lynuszhu@gmail.com</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><br><br>
<div class=3D"gmail_quote"><div class=3D"">On Wed, Mar 19, 2014 at 12:35 AM=
, Jonathan Rajotte <span dir=3D"ltr">&lt;<a href=3D"mailto:jonathan.r.julie=
n@gmail.com" target=3D"_blank">jonathan.r.julien@gmail.com</a>&gt;</span> w=
rote:<br>

</div><blockquote style=3D"BORDER-LEFT:#ccc 1px solid;MARGIN:0px 0px 0px 0.=
8ex;PADDING-LEFT:1ex" class=3D"gmail_quote">
<div dir=3D"ltr">Hi Lingyu,=20
<div><br></div>
<div><div class=3D"">
<blockquote style=3D"BORDER-LEFT:#ccc 1px solid;MARGIN:0px 0px 0px 0.8ex;PA=
DDING-LEFT:1ex" class=3D"gmail_quote">
<div>Does a sessiond is created on boot ?=A0</div>
<div>You can check via htop and filter for lttng or sessiond.</div></blockq=
uote></div>No sessiond is created on boot before I do these operations.<br>=
what else info should I provide?=A0</div>
<div><br></div></div><div><div class=3D"h5">
<div class=3D"gmail_extra"><br><br>
<div class=3D"gmail_quote">
<div>
<div>On Tue, Mar 18, 2014 at 12:31 PM, Lingyu Zhu <span dir=3D"ltr">&lt;<a =
href=3D"mailto:lynuszhu@gmail.com" target=3D"_blank">lynuszhu@gmail.com</a>=
&gt;</span> wrote:<br></div></div>
<blockquote style=3D"BORDER-LEFT:#ccc 1px solid;MARGIN:0px 0px 0px 0.8ex;PA=
DDING-LEFT:1ex" class=3D"gmail_quote">
<div>
<div>
<div dir=3D"ltr">
<div>
<div><span style=3D"FONT-FAMILY:arial,sans-serif;FONT-SIZE:13px">Hello,</sp=
an>=20
<div style=3D"FONT-FAMILY:arial,sans-serif;FONT-SIZE:13px">Sorry for being =
away a few days. My thesis opening proposal is hiting the deadline, which h=
appens to be same date for GSoC. Now I can be fully devoted to lttng and co=
mpose my GSoC proposal.</div>


<div style=3D"FONT-FAMILY:arial,sans-serif;FONT-SIZE:13px"><br></div>
<div style=3D"FONT-FAMILY:arial,sans-serif;FONT-SIZE:13px">Anyway, I may ha=
ve found a bug.I&#39;m not very sure. Here is my log:</div>
<div style=3D"FONT-FAMILY:arial,sans-serif;FONT-SIZE:13px"><br></div>
<div style=3D"FONT-FAMILY:arial,sans-serif;FONT-SIZE:13px">=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D</div>
<div style=3D"FONT-FAMILY:arial,sans-serif;FONT-SIZE:13px">
<div>[lynus@slave1 ~]$lttng create</div>
<div>Spawning a session daemon</div>
<div>Session auto-20140319-081547 created.</div>
<div>Traces will be written in /home/lynus/lttng-traces/auto-20140319-08154=
7</div>
<div>[lynus@slave1 ~]$ lttng enable-event page_block -k</div>
<div>Error: Event page_block: Tracing the kernel requires a root lttng-sess=
iond daemon, as well as &quot;tracing&quot; group membership or root user I=
D for the lttng client. (channel channel0, session auto-20140319-081547)</d=
iv>


<div>Warning: Some command(s) went wrong</div>
<div>[lynus@slave1 ~]$ lttng destroy</div>
<div>Session auto-20140319-081547 destroyed</div>
<div>[lynus@slave1 ~]$ sudo su -</div>
<div>[sudo] password for lynus:=A0</div>
<div>root@slave1:~# lttng create</div>
<div>Spawning a session daemon</div>
<div>Warning: No tracing group detected</div>
<div>Session auto-20140319-081615 created.</div>
<div>Traces will be written in /root/lttng-traces/auto-20140319-081615</div=
>
<div>PERROR [4774/4882]: bind inet: Address already in use (in lttcomm_bind=
_inet_sock() at inet.c:109)</div>
<div>Warning: An other session daemon is using this JUL port. JUL support w=
ill be deactivated not interfering with the tracing.</div>
<div>root@slave1:~# lttng create</div>
<div>Session auto-20140319-081620 created.</div>
<div>Traces will be written in /root/lttng-traces/auto-20140319-081620</div=
>
<div>root@slave1:~#=A0</div>
<div>[END] 2014/3/19 0:04:31</div></div>
<div style=3D"FONT-FAMILY:arial,sans-serif;FONT-SIZE:13px">=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D</d=
iv>
<div style=3D"FONT-FAMILY:arial,sans-serif;FONT-SIZE:13px"><br></div></div>=
</div>
<div style=3D"FONT-FAMILY:arial,sans-serif;FONT-SIZE:13px">These command is=
 issued right after my machine is booted. And it failed every time if I try=
 to enable kernel event as non-root user first then switch to root to creat=
e session. =A0If I directly switch to root and create a seesion, everything=
 is normal. So I guess I may have come across a bug.</div>


<div style=3D"FONT-FAMILY:arial,sans-serif;FONT-SIZE:13px">Any comment?</di=
v></div><br></div></div>_______________________________________________<br>=
lttng-dev mailing list<br><a href=3D"mailto:lttng-dev@lists.lttng.org" targ=
et=3D"_blank">lttng-dev@lists.lttng.org</a><br>

<a href=3D"http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev" targe=
t=3D"_blank">http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev</a><=
br><br></blockquote></div><span><font color=3D"#888888"><br><br clear=3D"al=
l">


<div><br></div>-- <br>
<div dir=3D"ltr">Jonathan Rajotte Julien=20
<div>Charg=E9 de laboratoire, INF1995<br>
<div>Polytechnique Montr=E9al</div></div></div></font></span></div></div></=
div></blockquote></div><br>
</blockquote></div><br><br clear=3D"all"><div><br></div>-- <br><div dir=3D"=
ltr">Jonathan Rajotte Julien<div>Charg=E9 de laboratoire, INF1995<br><div>P=
olytechnique Montr=E9al</div></div></div>
</div>

--089e014952960d7cda04f4e4a151--


--===============0258054920==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0258054920==--
