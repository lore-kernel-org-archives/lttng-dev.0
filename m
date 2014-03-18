From: Lingyu Zhu <lynuszhu@gmail.com>
Subject: [bug]session create failed
Date: Wed, 19 Mar 2014 00:25:36 +0800
Message-ID: <CACFGcba=x_GVeVpOMbWyXq19FVKrMdeB7EZ87YxUVTUeH6yXbg__16476.3059503914$1395160002$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1279876643=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ve0-f196.google.com ([209.85.128.196])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <lynuszhu@gmail.com>) id 1WPwpi-00037O-HF
	for lttng-dev@lists.lttng.org; Tue, 18 Mar 2014 12:25:48 -0400
Received: by mail-ve0-f196.google.com with SMTP id cz12so1729502veb.7
	for <lttng-dev@lists.lttng.org>; Tue, 18 Mar 2014 09:25:37 -0700 (PDT)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============1279876643==
Content-Type: multipart/alternative; boundary=001a1133a9fe73142404f4e3fcba

--001a1133a9fe73142404f4e3fcba
Content-Type: text/plain; charset=UTF-8

Hello,
Sorry for being away a few days. My thesis opening proposal is hiting the
deadline, which happens to be same date for GSoC. Now I can be fully
devoted to lttng and compose my GSoC proposal.

Anyway, I may have found a bug.I'm not very sure. Here is my log:

===================================================
[lynus@slave1 ~]$lttng create
Spawning a session daemon
Session auto-20140319-081547 created.
Traces will be written in /home/lynus/lttng-traces/auto-20140319-081547
[lynus@slave1 ~]$ lttng enable-event page_block -k
Error: Event page_block: Tracing the kernel requires a root lttng-sessiond
daemon, as well as "tracing" group membership or root user ID for the lttng
client. (channel channel0, session auto-20140319-081547)
Warning: Some command(s) went wrong
[lynus@slave1 ~]$ lttng destroy
Session auto-20140319-081547 destroyed
[lynus@slave1 ~]$ sudo su -
[sudo] password for lynus:
root@slave1:~# lttng create
Spawning a session daemon
Warning: No tracing group detected
Session auto-20140319-081615 created.
Traces will be written in /root/lttng-traces/auto-20140319-081615
PERROR [4774/4882]: bind inet: Address already in use (in
lttcomm_bind_inet_sock() at inet.c:109)
Warning: An other session daemon is using this JUL port. JUL support will
be deactivated not interfering with the tracing.
root@slave1:~# lttng create
Session auto-20140319-081620 created.
Traces will be written in /root/lttng-traces/auto-20140319-081620
root@slave1:~#
[END] 2014/3/19 0:04:31
======================================================

These command is issued right after my machine is booted. And if I directly
switch to root and create a seesion, everything is normal. So I guess I may
have come across a bug.
Any comment?

--001a1133a9fe73142404f4e3fcba
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hello,<div>Sorry for being away a few days. My thesis open=
ing proposal is hiting the deadline, which happens to be same date for GSoC=
. Now I can be fully devoted to lttng and compose my GSoC proposal.</div><d=
iv>
<br></div><div>Anyway, I may have found a bug.I&#39;m not very sure. Here i=
s my log:</div><div><br></div><div>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D</div><div><div>[lynus@slave1 ~]$ltt=
ng create</div><div>Spawning a session daemon</div>
<div>Session auto-20140319-081547 created.</div><div>Traces will be written=
 in /home/lynus/lttng-traces/auto-20140319-081547</div><div>[lynus@slave1 ~=
]$ lttng enable-event page_block -k</div><div>Error: Event page_block: Trac=
ing the kernel requires a root lttng-sessiond daemon, as well as &quot;trac=
ing&quot; group membership or root user ID for the lttng client. (channel c=
hannel0, session auto-20140319-081547)</div>
<div>Warning: Some command(s) went wrong</div><div>[lynus@slave1 ~]$ lttng =
destroy</div><div>Session auto-20140319-081547 destroyed</div><div>[lynus@s=
lave1 ~]$ sudo su -</div><div>[sudo] password for lynus:=C2=A0</div><div>ro=
ot@slave1:~# lttng create</div>
<div>Spawning a session daemon</div><div>Warning: No tracing group detected=
</div><div>Session auto-20140319-081615 created.</div><div>Traces will be w=
ritten in /root/lttng-traces/auto-20140319-081615</div><div>PERROR [4774/48=
82]: bind inet: Address already in use (in lttcomm_bind_inet_sock() at inet=
.c:109)</div>
<div>Warning: An other session daemon is using this JUL port. JUL support w=
ill be deactivated not interfering with the tracing.</div><div>root@slave1:=
~# lttng create</div><div>Session auto-20140319-081620 created.</div><div>
Traces will be written in /root/lttng-traces/auto-20140319-081620</div><div=
>root@slave1:~#=C2=A0</div><div>[END] 2014/3/19 0:04:31</div></div><div>=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D</div><div><br></div><div>
These command is issued right after my machine is booted. And if I directly=
 switch to root and create a seesion, everything is normal. So I guess I ma=
y have come across a bug.</div><div>Any comment?</div></div>

--001a1133a9fe73142404f4e3fcba--


--===============1279876643==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1279876643==--
