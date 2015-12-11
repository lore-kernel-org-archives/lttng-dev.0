From: Philippe Proulx <eeppeliteloop@gmail.com>
Subject: Re: LTTng hourly/weekly/monthly tracing
Date: Thu, 10 Dec 2015 19:58:47 -0500
Message-ID: <CAB4xu_0UQ1=jdtzBMgqtu5yfcuz3bZzh9YZWRF3m_g6hw3ZoXQ__19591.1291092218$1449795606$gmane$org@mail.gmail.com>
References: <BLU169-W447A3DEAC7E4B31C9336F9ABEA0@phx.gbl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1995739528=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-lf0-f54.google.com ([209.85.215.54])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <eeppeliteloop@gmail.com>) id 1a7C3O-0005Ui-W7
 for lttng-dev@lists.lttng.org; Thu, 10 Dec 2015 19:59:25 -0500
Received: by lfap203 with SMTP id p203so930688lfa.0
 for <lttng-dev@lists.lttng.org>; Thu, 10 Dec 2015 16:59:16 -0800 (PST)
In-Reply-To: <BLU169-W447A3DEAC7E4B31C9336F9ABEA0@phx.gbl>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Jeffrey Chen <cpthk@hotmail.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============1995739528==
Content-Type: multipart/alternative; boundary=001a1140118e2a95cf052694d510

--001a1140118e2a95cf052694d510
Content-Type: text/plain; charset=UTF-8

I believe the closest you can get is trace file rotation. It's a rotation
of trace files using a maximum size/stream file though, it's not time-based
like you want.

See the --tracefile-size and --tracefile-count options of lttng(1)'s create
command.

Philippe Proulx

On Thu, Dec 10, 2015 at 7:55 PM, Jeffrey Chen <cpthk@hotmail.com> wrote:

> Hi:
>
> I am using LTTng for tracing user-space application. Does LTTng support
> hourly/weekly/monthly rollover tracing? Some of the tracing libraries like
> log4j supports this, it will separate traces into different files for each
> hour/week/month depending on your setup. You could start to read the older
> traces while the user application is still running and writing traces. Does
> LTTng support this kind of feature? If not, what is the closest I could
> get? Ideally, I need to read the trace while the trace session is still
> running. It doesn't have to be real-time trace, could be couple hours old.
> I saw that LTTng has the snapshot mode, but it is still not exactly the
> same as the one I need, Snapshot mode could suffer from event lost, since
> it keeps overwriting old events. Thanks.
>
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>
>

--001a1140118e2a95cf052694d510
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">I believe the closest you can get is trace file rotation. =
It&#39;s a rotation of trace files using a maximum size/stream file though,=
 it&#39;s not time-based like you want.<div><br></div><div>See the --tracef=
ile-size and --tracefile-count options of lttng(1)&#39;s create command.</d=
iv></div><div class=3D"gmail_extra"><br clear=3D"all"><div><div class=3D"gm=
ail_signature">Philippe Proulx</div></div>
<br><div class=3D"gmail_quote">On Thu, Dec 10, 2015 at 7:55 PM, Jeffrey Che=
n <span dir=3D"ltr">&lt;<a href=3D"mailto:cpthk@hotmail.com" target=3D"_bla=
nk">cpthk@hotmail.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_q=
uote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1e=
x">


<div><div dir=3D"ltr">Hi:<br><br>I am using LTTng for tracing user-space ap=
plication. Does LTTng support hourly/weekly/monthly rollover tracing? Some =
of the tracing libraries like log4j supports this, it will separate traces =
into different files for each hour/week/month depending on your setup. You =
could start to read the older traces while the user application is still ru=
nning and writing traces. Does LTTng support this kind of feature? If not, =
what is the closest I could get? Ideally, I need to read the trace while th=
e trace session is still running. It doesn&#39;t have to be real-time trace=
, could be couple hours old. I saw that LTTng has the snapshot mode, but it=
 is still not exactly the same as the one I need, Snapshot mode could suffe=
r from event lost, since it keeps overwriting old events. Thanks.<br><br> 	=
	 	   		  </div></div>
<br>_______________________________________________<br>
lttng-dev mailing list<br>
<a href=3D"mailto:lttng-dev@lists.lttng.org">lttng-dev@lists.lttng.org</a><=
br>
<a href=3D"http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev" rel=
=3D"noreferrer" target=3D"_blank">http://lists.lttng.org/cgi-bin/mailman/li=
stinfo/lttng-dev</a><br>
<br></blockquote></div><br></div>

--001a1140118e2a95cf052694d510--


--===============1995739528==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1995739528==--
