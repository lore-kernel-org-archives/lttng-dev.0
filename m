From: Jessica Foest <jessica.foest@gmail.com>
Subject: Re: PERF PARAMETERS
Date: Wed, 27 Aug 2014 15:53:32 -0400
Message-ID: <CAPxN80DvMN8LyJq7Z8z9PF93h5004eDeiTw_yOi9jS_1o3GaiA__33490.3353629217$1409169258$gmane$org@mail.gmail.com>
References: <CAPxN80B=S_dYb5kn_UA-sDyOZiMySrsvkWVtg5fDgdLd2V9z2Q@mail.gmail.com>
 <53FE15C0.1010004@efficios.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0578613422=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ob0-f182.google.com ([209.85.214.182])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jessica.foest@gmail.com>) id 1XMjHm-0002Ps-3S
 for lttng-dev@lists.lttng.org; Wed, 27 Aug 2014 15:53:38 -0400
Received: by mail-ob0-f182.google.com with SMTP id wm4so600984obc.27
 for <lttng-dev@lists.lttng.org>; Wed, 27 Aug 2014 12:53:32 -0700 (PDT)
In-Reply-To: <53FE15C0.1010004@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Julien Desfossez <jdesfossez@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============0578613422==
Content-Type: multipart/alternative; boundary=089e015371c453219a0501a1c60a

--089e015371c453219a0501a1c60a
Content-Type: text/plain; charset=UTF-8

Thanks :)


2014-08-27 13:30 GMT-04:00 Julien Desfossez <jdesfossez@efficios.com>:

> Hi,
>
> On 14-08-26 11:21 PM, Jessica Foest wrote:
> > Hi
> >
> > i tried to retrieve system calls traces with all perf context parameters
> > . the problem is that only a few PERF counters are activated and lttng
> > fails to activate  the other perf context parameters.
> > how can i solve it ?
>
> There is a hardware limit on the number perf PMU counters that can be
> activated at the same time. It depends on the CPU and if you are on a
> virtual machine.
> If I remember correctly it is 3 or 4 on the i7.
>
> Julien
>

--089e015371c453219a0501a1c60a
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Thanks :)</div><div class=3D"gmail_extra"><br><br><div cla=
ss=3D"gmail_quote">2014-08-27 13:30 GMT-04:00 Julien Desfossez <span dir=3D=
"ltr">&lt;<a href=3D"mailto:jdesfossez@efficios.com" target=3D"_blank">jdes=
fossez@efficios.com</a>&gt;</span>:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">Hi,<br>
<div><div class=3D"h5"><br>
On 14-08-26 11:21 PM, Jessica Foest wrote:<br>
&gt; Hi<br>
&gt;<br>
&gt; i tried to retrieve system calls traces with all perf context paramete=
rs<br>
&gt; . the problem is that only a few PERF counters are activated and lttng=
<br>
&gt; fails to activate=C2=A0 the other perf context parameters.<br>
&gt; how can i solve it ?<br>
<br>
</div></div>There is a hardware limit on the number perf PMU counters that =
can be<br>
activated at the same time. It depends on the CPU and if you are on a<br>
virtual machine.<br>
If I remember correctly it is 3 or 4 on the i7.<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
Julien<br>
</font></span></blockquote></div><br></div>

--089e015371c453219a0501a1c60a--


--===============0578613422==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0578613422==--
