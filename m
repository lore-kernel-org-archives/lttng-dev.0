From: Lingyu Zhu <lynuszhu@gmail.com>
Subject: Re: session create failed
Date: Wed, 19 Mar 2014 00:53:00 +0800
Message-ID: <CACFGcbYMkpuKv5nGKRGwy+NDMHagErBOwOJP0_cNOTL5UharjQ__23209.7919485115$1395161654$gmane$org@mail.gmail.com>
References: <CACFGcbacSUM2LyVCtZQRZtJY2-0t6NCp9fvgFNQNSgOrcn8HAw@mail.gmail.com>
	<CAF4oYfEnUPU18SFgUn5_1rhyRpBwDq-ak=KjBw0tfszFn9QoXA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0266280281=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-vc0-f172.google.com ([209.85.220.172])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <lynuszhu@gmail.com>) id 1WPxGE-0003Mu-CI
	for lttng-dev@lists.lttng.org; Tue, 18 Mar 2014 12:53:12 -0400
Received: by mail-vc0-f172.google.com with SMTP id la4so7711930vcb.3
	for <lttng-dev@lists.lttng.org>; Tue, 18 Mar 2014 09:53:01 -0700 (PDT)
In-Reply-To: <CAF4oYfEnUPU18SFgUn5_1rhyRpBwDq-ak=KjBw0tfszFn9QoXA@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Jonathan Rajotte <jonathan.r.julien@gmail.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--===============0266280281==
Content-Type: multipart/alternative; boundary=001a1136b5e470b45504f4e45ebe

--001a1136b5e470b45504f4e45ebe
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 19, 2014 at 12:35 AM, Jonathan Rajotte <
jonathan.r.julien@gmail.com> wrote:

> Hi Lingyu,
>
>  Does a sessiond is created on boot ?
>> You can check via htop and filter for lttng or sessiond.
>>
> No sessiond is created on boot before I do these operations.
> what else info should I provide?
>
>
>
>  On Tue, Mar 18, 2014 at 12:31 PM, Lingyu Zhu <lynuszhu@gmail.com> wrote:
>
>>   Hello,
>> Sorry for being away a few days. My thesis opening proposal is hiting th=
e
>> deadline, which happens to be same date for GSoC. Now I can be fully
>> devoted to lttng and compose my GSoC proposal.
>>
>> Anyway, I may have found a bug.I'm not very sure. Here is my log:
>>
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
>>  [lynus@slave1 ~]$lttng create
>> Spawning a session daemon
>> Session auto-20140319-081547 created.
>> Traces will be written in /home/lynus/lttng-traces/auto-20140319-081547
>> [lynus@slave1 ~]$ lttng enable-event page_block -k
>> Error: Event page_block: Tracing the kernel requires a root
>> lttng-sessiond daemon, as well as "tracing" group membership or root use=
r
>> ID for the lttng client. (channel channel0, session auto-20140319-081547=
)
>> Warning: Some command(s) went wrong
>> [lynus@slave1 ~]$ lttng destroy
>> Session auto-20140319-081547 destroyed
>> [lynus@slave1 ~]$ sudo su -
>> [sudo] password for lynus:
>> root@slave1:~# lttng create
>> Spawning a session daemon
>> Warning: No tracing group detected
>> Session auto-20140319-081615 created.
>> Traces will be written in /root/lttng-traces/auto-20140319-081615
>> PERROR [4774/4882]: bind inet: Address already in use (in
>> lttcomm_bind_inet_sock() at inet.c:109)
>> Warning: An other session daemon is using this JUL port. JUL support wil=
l
>> be deactivated not interfering with the tracing.
>> root@slave1:~# lttng create
>> Session auto-20140319-081620 created.
>> Traces will be written in /root/lttng-traces/auto-20140319-081620
>> root@slave1:~#
>> [END] 2014/3/19 0:04:31
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
>>
>> These command is issued right after my machine is booted. And it failed
>> every time if I try to enable kernel event as non-root user first then
>> switch to root to create session.  If I directly switch to root and crea=
te
>> a seesion, everything is normal. So I guess I may have come across a bug=
.
>> Any comment?
>>
>> _______________________________________________
>> lttng-dev mailing list
>> lttng-dev@lists.lttng.org
>> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>>
>>
>
>
> --
> Jonathan Rajotte Julien
> Charg=C3=A9 de laboratoire, INF1995
> Polytechnique Montr=C3=A9al
>

--001a1136b5e470b45504f4e45ebe
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<br><br>
<div class=3D"gmail_quote">On Wed, Mar 19, 2014 at 12:35 AM, Jonathan Rajot=
te <span dir=3D"ltr">&lt;<a href=3D"mailto:jonathan.r.julien@gmail.com" tar=
get=3D"_blank">jonathan.r.julien@gmail.com</a>&gt;</span> wrote:<br>
<blockquote style=3D"BORDER-LEFT:#ccc 1px solid;MARGIN:0px 0px 0px 0.8ex;PA=
DDING-LEFT:1ex" class=3D"gmail_quote">
<div dir=3D"ltr">Hi Lingyu,=20
<div><br></div>
<div>
<blockquote style=3D"BORDER-LEFT:#ccc 1px solid;MARGIN:0px 0px 0px 0.8ex;PA=
DDING-LEFT:1ex" class=3D"gmail_quote">
<div>Does a sessiond is created on boot ?=C2=A0</div>
<div>You can check via htop and filter for lttng or sessiond.</div></blockq=
uote>No sessiond is created on boot before I do these operations.<br>what e=
lse info should I provide?=C2=A0</div>
<div><br></div></div>
<div class=3D"gmail_extra"><br><br>
<div class=3D"gmail_quote">
<div>
<div class=3D"h5">On Tue, Mar 18, 2014 at 12:31 PM, Lingyu Zhu <span dir=3D=
"ltr">&lt;<a href=3D"mailto:lynuszhu@gmail.com" target=3D"_blank">lynuszhu@=
gmail.com</a>&gt;</span> wrote:<br></div></div>
<blockquote style=3D"BORDER-LEFT:#ccc 1px solid;MARGIN:0px 0px 0px 0.8ex;PA=
DDING-LEFT:1ex" class=3D"gmail_quote">
<div>
<div class=3D"h5">
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
<div>[sudo] password for lynus:=C2=A0</div>
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
<div>root@slave1:~#=C2=A0</div>
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
e session. =C2=A0If I directly switch to root and create a seesion, everyth=
ing is normal. So I guess I may have come across a bug.</div>

<div style=3D"FONT-FAMILY:arial,sans-serif;FONT-SIZE:13px">Any comment?</di=
v></div><br></div></div>_______________________________________________<br>=
lttng-dev mailing list<br><a href=3D"mailto:lttng-dev@lists.lttng.org" targ=
et=3D"_blank">lttng-dev@lists.lttng.org</a><br>
<a href=3D"http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev" targe=
t=3D"_blank">http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev</a><=
br><br></blockquote></div><span class=3D"HOEnZb"><font color=3D"#888888"><b=
r><br clear=3D"all">

<div><br></div>-- <br>
<div dir=3D"ltr">Jonathan Rajotte Julien=20
<div>Charg=C3=A9 de laboratoire, INF1995<br>
<div>Polytechnique Montr=C3=A9al</div></div></div></font></span></div></blo=
ckquote></div><br>

--001a1136b5e470b45504f4e45ebe--


--===============0266280281==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0266280281==--
