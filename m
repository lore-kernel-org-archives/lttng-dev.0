From: =?UTF-8?Q?Christophe_B=C3=A9dard?= <bedard.christophe@gmail.com>
Subject: Re: What is _prev_state in sched_switch?
Date: Mon, 29 Jul 2019 11:53:08 +0200
Message-ID: <CAAS9doa5ry0_Tuc0_SN03R7x6Ok8dEBfR+1pnjj4MoX+5AAyfg__11550.8973527298$1564394041$gmane$org@mail.gmail.com>
References: <CAEWVvOS48D3Jfp4==qrrODzdSSjo+-UOuvZyya1O_f2t9B9Z1A@mail.gmail.com>
 <0e850b02-3fec-a335-3f37-8579ad1b704d@gydle.com>
 <CAEWVvOSu4vbiDpMCCTHdP59xNaMsAJ74orA52amRaFfoN7jfXQ@mail.gmail.com>
 <18d63d8c-da2d-54c3-3a9a-1d77a5a3a675@gydle.com>
 <CAEWVvORgCQW8ScJZctu7dzT3QaO0PY50qmR-Aov9YHV1GkB+JQ@mail.gmail.com>
 <CAAS9doZ1AjBiVCPOZUPBZYVZ11hRohP5g9pmAU+pPU=EQo120Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7753988871739931320=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com
 [IPv6:2607:f8b0:4864:20::d31])
 by lists.lttng.org (Postfix) with ESMTPS id 45xw4T6GHgz16tm
 for <lttng-dev@lists.lttng.org>; Mon, 29 Jul 2019 05:53:45 -0400 (EDT)
Received: by mail-io1-xd31.google.com with SMTP id e20so88178000iob.9
 for <lttng-dev@lists.lttng.org>; Mon, 29 Jul 2019 02:53:45 -0700 (PDT)
In-Reply-To: <CAAS9doZ1AjBiVCPOZUPBZYVZ11hRohP5g9pmAU+pPU=EQo120Q@mail.gmail.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============7753988871739931320==
Content-Type: multipart/alternative; boundary="0000000000001fb72c058ecedec1"

--0000000000001fb72c058ecedec1
Content-Type: text/plain; charset="UTF-8"

Hi,

Re-sending since I previously used an email address not subscribed to the
ML.

On Mon, 29 Jul 2019 at 11:08, Ravindra Kumar Meena <rmeena840@gmail.com>
wrote:

> Okay. The above link was somewhat helpful but I still didn't get what is
> the meaning of {0, 1, 1026, 4096} values in _prev_state.
>
> In babeltrace output _prev_state have { 0, 1, 1026, 4096 } values.
>
>
I think the answer to your question was in Sebastien's email.

$ grep "#define TASK_" include/linux/sched.h
> #define TASK_RUNNING                    0x0000
> #define TASK_INTERRUPTIBLE              0x0001
> #define TASK_UNINTERRUPTIBLE            0x0002
> #define TASK_PARKED                     0x0040
> #define TASK_DEAD                       0x0080
> #define TASK_WAKEKILL                   0x0100
> #define TASK_WAKING                     0x0200
> #define TASK_NOLOAD                     0x0400
> #define TASK_NEW                        0x0800
> #define TASK_STATE_MAX                  0x1000
> #define TASK_KILLABLE                   (TASK_WAKEKILL |
> TASK_UNINTERRUPTIBLE)
> #define TASK_STOPPED                    (TASK_WAKEKILL | __TASK_STOPPED)
> #define TASK_TRACED                     (TASK_WAKEKILL | __TASK_TRACED)
> #define TASK_IDLE                       (TASK_UNINTERRUPTIBLE |
> TASK_NOLOAD)
> #define TASK_NORMAL                     (TASK_INTERRUPTIBLE |
> TASK_UNINTERRUPTIBLE)
> #define TASK_REPORT                     (TASK_RUNNING | TASK_INTERRUPTIBLE
> | \
>

States can be combined (OR'd).

1026 in decimal is 0x402 which is 0x400 | 0x002. That is TASK_NOLOAD |
TASK_UNINTERRUPTIBLE, or, as defined above, it's simply TASK_IDLE.

I'm not sure what other answer you're expecting.


Christophe

--0000000000001fb72c058ecedec1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi,</div><div dir=3D"ltr"><br></div><div>=
Re-sending since I previously used an email address not subscribed to the M=
L.<br><span class=3D"gmail-im" style=3D"color:rgb(80,0,80)"><div><br></div>=
<div><div><div dir=3D"ltr" class=3D"gmail-m_8377487403042040598gmail_signat=
ure"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div><div dir=3D"lt=
r" style=3D"font-size:12.8px"><span style=3D"font-size:small">On Mon, 29 Ju=
l 2019 at 11:08, Ravindra Kumar Meena &lt;<a href=3D"mailto:rmeena840@gmail=
.com" target=3D"_blank">rmeena840@gmail.com</a>&gt; wrote:</span></div></di=
v></div></div></div></div></div></div></span></div><div class=3D"gmail_quot=
e"><span class=3D"gmail-im" style=3D"color:rgb(80,0,80)"><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex"><div dir=3D"ltr"><div class=3D"gmail_quote=
"><div>Okay. The above link was somewhat helpful but I still didn&#39;t get=
 what is the meaning of {0, 1, 1026, 4096} values in _prev_state.=C2=A0</di=
v><div><br></div><div>In babeltrace output _prev_state have { 0, 1, 1026, 4=
096 } values.</div></div></div><br></blockquote><div><br></div></span><div>=
I think the answer to your question was in Sebastien&#39;s email.</div><spa=
n class=3D"gmail-im" style=3D"color:rgb(80,0,80)"><div><br></div><blockquot=
e class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px s=
olid rgb(204,204,204);padding-left:1ex">$ grep &quot;#define TASK_&quot; in=
clude/linux/sched.h<br>#define TASK_RUNNING=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x0000<br>#define TASK_INTERRUPTIBLE=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x0001<br>#define TASK_UNI=
NTERRUPTIBLE=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x0002<br>#define TAS=
K_PARKED=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A00x0040<br>#define TASK_DEAD=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x0080<br>#define TASK_WAKEKIL=
L=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x010=
0<br>#define TASK_WAKING=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A00x0200<br>#define TASK_NOLOAD=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x0400<br>#defin=
e TASK_NEW=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 0x0800<br>#define TASK_STATE_MAX=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x1000<br>#define TASK_KILLABLE=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(TASK_=
WAKEKILL | TASK_UNINTERRUPTIBLE)<br>#define TASK_STOPPED=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (TASK_WAKEKILL | __TAS=
K_STOPPED)<br>#define TASK_TRACED=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(TASK_WAKEKILL | __TASK_TRACED)<br>#defin=
e TASK_IDLE=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0(TASK_UNINTERRUPTIBLE | TASK_NOLOAD)<br>#define TASK_NO=
RMAL=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0(TASK_INTERRUPTIBLE | TASK_UNINTERRUPTIBLE)<br>#define TASK_REPORT=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(T=
ASK_RUNNING | TASK_INTERRUPTIBLE | \<br></blockquote><div><br></div></span>=
<div>States can be combined (OR&#39;d).</div><div><br></div><div>1026 in de=
cimal is 0x402 which is 0x400 | 0x002. That is TASK_NOLOAD | TASK_UNINTERRU=
PTIBLE, or, as defined above, it&#39;s simply TASK_IDLE.</div><div><br></di=
v><div>I&#39;m not sure what other answer you&#39;re expecting.</div><div><=
br></div><div><br></div><div>Christophe</div></div></div>

--0000000000001fb72c058ecedec1--

--===============7753988871739931320==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============7753988871739931320==--
