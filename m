From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: tracing is stalled
Date: Wed, 4 Mar 2015 14:41:45 -0500
Message-ID: <CA+jJMxvHvxn6XNw0oxP6ZNJKDYL3F9+pE=mV3=++iMF=VQnLQQ__22182.1729479872$1425498191$gmane$org@mail.gmail.com>
References: <CAM5kDqxg7pJ1P7aijGVY+f66Hc9cv2ODAOs5D-1LLXTyUXXxAw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0827492609=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qc0-f169.google.com ([209.85.216.169])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jeremie.galarneau@gmail.com>) id 1YTFB0-0006Eg-Nf
 for lttng-dev@lists.lttng.org; Wed, 04 Mar 2015 14:41:58 -0500
Received: by qcxm20 with SMTP id m20so39219602qcx.0
 for <lttng-dev@lists.lttng.org>; Wed, 04 Mar 2015 11:41:45 -0800 (PST)
In-Reply-To: <CAM5kDqxg7pJ1P7aijGVY+f66Hc9cv2ODAOs5D-1LLXTyUXXxAw@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Anand Neeli <anand.neeli@gmail.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============0827492609==
Content-Type: multipart/alternative; boundary=001a1147e75231a55f05107ba479

--001a1147e75231a55f05107ba479
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

What do you mean by "tracing using relayd"? Do you mean live tracing?

Running the daemons in verbose mode (-vvv option) would be a good first
step.

Thanks,
J=C3=A9r=C3=A9mie




On Wed, Mar 4, 2015 at 2:13 PM, Anand Neeli <anand.neeli@gmail.com> wrote:

> Hi All,
>
> I'm using 2.6 and tracing using relayd. Very frequently i see that the
> tracing is stalled and doesnt trace anything, i dont see the trace file
> size increasing and i dont see any console errors.
> Can anyone tell me what debug-traces will be needed to debug this. I will
> collect those debug-traces next time i see the issue.
>
> Thanks,
> Anand Neeli
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>
>


--=20
J=C3=A9r=C3=A9mie Galarneau
EfficiOS Inc.
http://www.efficios.com

--001a1147e75231a55f05107ba479
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">What do you mean by &quot;tracing using relayd&quot;? Do y=
ou mean live tracing?<div><br></div><div>Running the daemons in verbose mod=
e (-vvv option) would be a good first step.</div><div><br></div><div>Thanks=
,</div><div>J=C3=A9r=C3=A9mie</div><div><br><div><br></div><div><br></div><=
/div></div><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">On Wed=
, Mar 4, 2015 at 2:13 PM, Anand Neeli <span dir=3D"ltr">&lt;<a href=3D"mail=
to:anand.neeli@gmail.com" target=3D"_blank">anand.neeli@gmail.com</a>&gt;</=
span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8e=
x;border-left:1px #ccc solid;padding-left:1ex"><div dir=3D"ltr">Hi All,<div=
><br></div><div>I&#39;m using 2.6 and tracing using relayd. Very frequently=
 i see that the tracing is stalled and doesnt trace anything, i dont see th=
e trace file size increasing and i dont see any console errors.</div><div>C=
an anyone tell me what debug-traces will be needed to debug this. I will co=
llect those debug-traces next time i see the issue.</div><div><br></div><di=
v>Thanks,</div><div>Anand Neeli</div></div>
<br>_______________________________________________<br>
lttng-dev mailing list<br>
<a href=3D"mailto:lttng-dev@lists.lttng.org">lttng-dev@lists.lttng.org</a><=
br>
<a href=3D"http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev" targe=
t=3D"_blank">http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev</a><=
br>
<br></blockquote></div><br><br clear=3D"all"><div><br></div>-- <br><div cla=
ss=3D"gmail_signature">J=C3=A9r=C3=A9mie Galarneau<br>EfficiOS Inc.<br><a h=
ref=3D"http://www.efficios.com" target=3D"_blank">http://www.efficios.com</=
a></div>
</div>

--001a1147e75231a55f05107ba479--


--===============0827492609==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0827492609==--
