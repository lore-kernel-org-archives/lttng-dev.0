From: siddharth teotia <siddharthteotia@gmail.com>
Subject: Re: RCU Question
Date: Fri, 29 Apr 2016 12:10:27 -0700
Message-ID: <CAJw6sH0kFFVvmWm2vRQ+KNTgJaKVXS47OCATY2zHTA0AiSipiQ__43358.0241901383$1461972651$gmane$org@mail.gmail.com>
References: <CAJw6sH0=pZX__YaeMwozF673u3Dyn7Jzp3g9q2FuYurThO6paw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3878530651687734749=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-io0-f174.google.com (mail-io0-f174.google.com
 [209.85.223.174])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id 1CE8CA332E
 for <lttng-dev@lists.lttng.org>; Fri, 29 Apr 2016 19:10:29 +0000 (UTC)
Received: by mail-io0-f174.google.com with SMTP id d62so117107576iof.2
 for <lttng-dev@lists.lttng.org>; Fri, 29 Apr 2016 12:10:28 -0700 (PDT)
In-Reply-To: <CAJw6sH0=pZX__YaeMwozF673u3Dyn7Jzp3g9q2FuYurThO6paw@mail.gmail.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--===============3878530651687734749==
Content-Type: multipart/alternative; boundary=94eb2c055f684c5ca00531a4654f

--94eb2c055f684c5ca00531a4654f
Content-Type: text/plain; charset=UTF-8

The mail was accidentally sent. Here is more info:

My question really is that when writing a user space application that
leverages RCU, how do I ensure that I am using the proper
flavor/implementation of RCU ? I don't think so I can go ahead with
non-preemptive RCU. And the user space paper does not really tell or
distinguish clearly as to which of the following -- QSBR, MB, BP, signal
can be used for preemptive environments and do not restrict the reader to
not block or not sleep ?

Thanks,
Siddharth

On Fri, Apr 29, 2016 at 12:07 PM, siddharth teotia <
siddharthteotia@gmail.com> wrote:

> Hi Guys,
>
> I recently started exploring RCU to build a lock free hash table. I have
> read quite a bit of literature from LWN on RCU, its usage, API etc. I have
> the following question for which I have had mixed answers online:
>
> Does the user space implementation of RCU liburcu take care of preemptive
> v/s non-preemptive flavors of RCU. From what I understand RCU can be
> broadly divided into:
>
> 1. Classic RCU - High Performance but suitable for non-preemptive
> environments.
> 2. Preemptible RCU - Permits the reader to block on a resource or the read
> side critical sections to be preempted. But still does not allow any kind
> of sleep(). Moreover there seems to be some sort of limitation on the
> nature of blocking that can happen within RCU read side critical section.
> 3. Sleepable RCU - Seems to me an augmentation of preemptible RCU.
>
> The paper that describes the user space implementation of RCU suggests 4
> different flavors -- QSBR, Memory Barrier based, Bullet Proof, and Signal
> based.
>
> I don't think so in my application I can afford to not have the readers
> block or even sleep. If the reader wants to take some orthogonal lock/latch
> on an entirely different resource, it might end waiting for it.
>
> And because
>
>
>


-- 
*Best Regards,*
*SIDDHARTH TEOTIA*
*2008C6PS540G*
*BITS PILANI- GOA CAMPUS*

*+91 87911 75932*

--94eb2c055f684c5ca00531a4654f
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div><div>The mail was accidentally sent. Here is mor=
e info:<br><br></div>My question really is that when writing a user space a=
pplication that leverages RCU, how do I ensure that I am using the proper f=
lavor/implementation of RCU ? I don&#39;t think so I can go ahead with non-=
preemptive RCU. And the user space paper does not really tell or distinguis=
h clearly as to which of the following -- QSBR, MB, BP, signal can be used =
for preemptive environments and do not restrict the reader to not block or =
not sleep ?<br><br></div>Thanks,<br></div>Siddharth <br></div><div class=3D=
"gmail_extra"><br><div class=3D"gmail_quote">On Fri, Apr 29, 2016 at 12:07 =
PM, siddharth teotia <span dir=3D"ltr">&lt;<a href=3D"mailto:siddharthteoti=
a@gmail.com" target=3D"_blank">siddharthteotia@gmail.com</a>&gt;</span> wro=
te:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-=
left:1px #ccc solid;padding-left:1ex"><div dir=3D"ltr"><div><div><div><div>=
<div><div><div><div>Hi Guys,<br><br></div>I recently started exploring RCU =
to build a lock free hash table. I have read quite a bit of literature from=
 LWN on RCU, its usage, API etc. I have the following question for which I =
have had mixed answers online:<br><br></div>Does the user space implementat=
ion of RCU liburcu take care of preemptive v/s non-preemptive flavors of RC=
U. From what I understand RCU can be broadly divided into:<br><br></div>1. =
Classic RCU - High Performance but suitable for non-preemptive environments=
.<br></div>2. Preemptible RCU - Permits the reader to block on a resource o=
r the read side critical sections to be preempted. But still does not allow=
 any kind of sleep(). Moreover there seems to be some sort of limitation on=
 the nature of blocking that can happen within RCU read side critical secti=
on.<br></div>3. Sleepable RCU - Seems to me an augmentation of preemptible =
RCU.<br><br></div>The paper that describes the user space implementation of=
 RCU suggests 4 different flavors -- QSBR, Memory Barrier based, Bullet Pro=
of, and Signal based. <br><br></div>I don&#39;t think so in my application =
I can afford to not have the readers block or even sleep. If the reader wan=
ts to take some orthogonal lock/latch on an entirely different resource, it=
 might end waiting for it.<br><br></div>And because <br><div><div><div><div=
><div><div><div><div><div><br><br clear=3D"all"></div></div></div></div></d=
iv></div></div></div></div></div>
</blockquote></div><br><br clear=3D"all"><br>-- <br><div class=3D"gmail_sig=
nature"><div><strong><font color=3D"#000066">Best Regards,</font></strong><=
/div>
<div><strong><font color=3D"#000066">SIDDHARTH TEOTIA</font></strong></div>
<div><strong><font color=3D"#000066">2008C6PS540G</font></strong></div>
<div><strong><font color=3D"#000066">BITS PILANI- GOA CAMPUS</font></strong=
></div>
<div><strong><font color=3D"#000066"></font></strong>=C2=A0</div>
<div><strong><font color=3D"#000066">+91 87911 75932</font></strong></div><=
/div>
</div>

--94eb2c055f684c5ca00531a4654f--

--===============3878530651687734749==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============3878530651687734749==--
