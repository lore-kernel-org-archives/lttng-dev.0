From: Michel Dagenais <michel.dagenais@polymtl.ca>
Subject: Re: Monitor threads with lttng
Date: Wed, 15 May 2019 13:21:09 -0400 (EDT)
Message-ID: <2013253114.9075074.1557940869814.JavaMail.zimbra__20196.1517495633$1557941326$gmane$org@polymtl.ca>
References: <CABRndgyfAyQ=t1==vPY9UHv8wZjMhrsu9bOtnwLu6f=ARjEj4w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7927758304744423668=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.polymtl.ca (smtp.polymtl.ca [132.207.4.11])
 by lists.lttng.org (Postfix) with ESMTPS id 4541jq4Rcmz12Pf
 for <lttng-dev@lists.lttng.org>; Wed, 15 May 2019 13:28:31 -0400 (EDT)
In-Reply-To: <CABRndgyfAyQ=t1==vPY9UHv8wZjMhrsu9bOtnwLu6f=ARjEj4w@mail.gmail.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Zvi Vered <veredz72@gmail.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--===============7927758304744423668==
Content-Type: multipart/alternative;
	boundary="=_6a34e08b-90e2-401f-8a08-11ab33c018f7"

--=_6a34e08b-90e2-401f-8a08-11ab33c018f7
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Linux, with pthreads, thread scheduling takes place in the kernel. You c=
an then obtain this information through lttng tracing in the kernel domain =
(scheduling events) and view the trace in Trace Compass.=20

----- Le 15 Mai 19, =C3=A0 12:42, Zvi Vered <veredz72@gmail.com> a =C3=A9cr=
it :=20

> Hello,
> Can I use lttng to monitor threads in my process ?
> For example, I want to see when a thread is active and when it is blocked
> (waiting for a signal or an IOCL to complete).

> Is it possible doing it without linking the application with libust and c=
alling
> UST API ?

> Thank you,
> Zvika

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--=_6a34e08b-90e2-401f-8a08-11ab33c018f7
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-family: arial, helvetica, sans-serif; font-s=
ize: 12pt; color: #000000"><div>On Linux, with pthreads, thread scheduling =
takes place in the kernel. You can then obtain this information through ltt=
ng tracing in the kernel domain (scheduling events) and view the trace in T=
race Compass.</div><div><br></div><div><span id=3D"zwchr" data-marker=3D"__=
DIVIDER__">----- Le 15 Mai 19, =C3=A0 12:42, Zvi Vered &lt;veredz72@gmail.c=
om&gt; a =C3=A9crit :<br></span></div><div data-marker=3D"__QUOTED_TEXT__">=
<blockquote style=3D"border-left:2px solid #1010FF;margin-left:5px;padding-=
left:5px;color:#000;font-weight:normal;font-style:normal;text-decoration:no=
ne;font-family:Helvetica,Arial,sans-serif;font-size:12pt;"><div dir=3D"ltr"=
>Hello,<br><div>Can I use lttng to monitor threads in my process ?</div><di=
v>For example, I want to see when a thread is active and when it is blocked=
 (waiting for a signal or an IOCL to complete).&nbsp;</div><br><div>Is it p=
ossible doing it without linking the application with libust and calling US=
T API ?</div><br><div>Thank you,</div><div>Zvika&nbsp;</div></div>
<br>_______________________________________________<br>lttng-dev mailing li=
st<br>lttng-dev@lists.lttng.org<br>https://lists.lttng.org/cgi-bin/mailman/=
listinfo/lttng-dev<br></blockquote></div></div></body></html>
--=_6a34e08b-90e2-401f-8a08-11ab33c018f7--

--===============7927758304744423668==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============7927758304744423668==--
