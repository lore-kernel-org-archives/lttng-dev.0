Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D907C4706C
	for <lttng-dev@archiver.kernel.org>; Fri, 12 Jan 2024 13:12:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1705065157;
	bh=wEAMJ+jVEb7ewHc9/jIKTxPj7Wvh9cbUf0F4aR2P4cw=;
	h=Date:To:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=ueo/3UBQORV6rKzETRNj0m15P9jT503M3A51NIC/W15W0JnGHoS71UAtd+C9T/Oxa
	 FqNQta3CKhPTqjjwdwpzn+G8XiFeBGp5qmIsgs/rQOhQT9AP4debjyzNX+u5meFJLo
	 jE4jzJ+out/54yXJdrb7KDFIX+Ll3iKiJ4v+6jXoqbDFQ/qHAKxZUoMxBOIZ2nPrnG
	 J3NBIBjhy2+7j0jbUzWfY9mqVnihBSlDsdLMI//FSRz7fZ9cXzL5f8LXP3qfuRAY2y
	 10KCsfRU/JSR5UqbpRP2AD2xh1AOjKP/Ggdoov9tDD6tFUbdlCUZvkCxibDBMiJy68
	 jqsj4qqMQPv1w==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4TBMQX58Fbz1LCt;
	Fri, 12 Jan 2024 08:12:36 -0500 (EST)
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com
 [IPv6:2a00:1450:4864:20::22d])
 by lists.lttng.org (Postfix) with ESMTPS id 4TBMQW0chbz1LRV
 for <lttng-dev@lists.lttng.org>; Fri, 12 Jan 2024 08:12:34 -0500 (EST)
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-2cd703e9014so48028661fa.1
 for <lttng-dev@lists.lttng.org>; Fri, 12 Jan 2024 05:12:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705065153; x=1705669953;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HEufFkV6NVmLT/A4Nsc6TLiTq3v+nhPQlbJEyIuxnUQ=;
 b=QQJ9dPl/hbbRAwCPEWw80bpTLXeeB+3wJMXt2aQ8nhDm/eNvJ672Z3b2+5kiKvb66z
 gSWnHxOBjHVpECpeuTPq0WmFDWU/6I4Ag9F/MvacTLOkTe+u6uM3Qb/eYUYJmAIgIFv5
 dCUt0v87jKawmZMqcwb690TqQsajX34N0723yIg//U9FBDq9jDD1bWsmfzV9EkuBjQ3I
 ToW5dlQPkbNKszpAUBV5QoW612J3jgvbFE2nbPcabtFfrHbVuZJ+RdOQu3B2UPJpzAkV
 x5LJJbye6nsN0Ux/+xwCC6wtjUz1A3Mu0zgSSzAUFh5A6qzZ9dXOCuo4iwMYx465udLu
 HA6Q==
X-Gm-Message-State: AOJu0YyOQULX+NVWlr9jq6CtsSttzW1ZXnJjhoHhbC8KHyMduCCg/l9Z
 TGkecEafbUvfjvZTYF1IzBGCQGb/a0DhFtDDpRX287gA
X-Google-Smtp-Source: AGHT+IEHFqzTVgNbNqrLj6DGmujuI2brD0jtZA865cGh8ATn3y87hYo1F1DphNceXtS9TBTi8O90VL4N/5KDm1UdY+E=
X-Received: by 2002:a2e:7d15:0:b0:2cc:6d60:d7cf with SMTP id
 y21-20020a2e7d15000000b002cc6d60d7cfmr762924ljc.58.1705065152864; Fri, 12 Jan
 2024 05:12:32 -0800 (PST)
MIME-Version: 1.0
Date: Fri, 12 Jan 2024 08:12:21 -0500
Message-ID: <CACJEY861mX+FerESW6O6pTU7CzadHGDSBF9HktNrXr_fGp-Hcw@mail.gmail.com>
To: lttng-dev <lttng-dev@lists.lttng.org>
Subject: [lttng-dev] LTTng sessiond daemon Assertion `buf' failed and killed
X-BeenThere: lttng-dev@lists.lttng.org
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: LTTng development list <lttng-dev.lists.lttng.org>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
From: Yonghong Yan via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Yonghong Yan <yanyh15@gmail.com>
Content-Type: multipart/mixed; boundary="===============0309750082188625648=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--===============0309750082188625648==
Content-Type: multipart/alternative; boundary="000000000000c16740060ebf6aba"

--000000000000c16740060ebf6aba
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I am not sure whether this is my setting problem or a bug with a
more recent kernel. lttng-sessiond was killed when I tried to "enable
event" after a session was created. See below part of the verbose output of
the sessiond. It is observed on Ubuntu 22.04, kernel 6.5.0-14-generic
#14~22.04.1-Ubuntu SMP PREEMPT_DYNAMIC, lttng (LTTng Trace Control) 2.13.10
- Nordicit=C3=A9.


The same version of LTTng works on another Ubuntu 22.04 machine, but with
kernel 6.2.0-33-generic. Any suggestion on what I should try?


Thank you

Yonghong



c:1016)

DBG1 - 00:24:25.134138433 [Client management]: Getting session
auto-20240112-002417 by name (in process_client_msg() at client.c:1133)

DBG1 - 00:24:25.134148894 [Client management]: Creating UST session (in
create_ust_session() at client.c:510)

DBG1 - 00:24:25.134267958 [Client management]: Spawning consumerd (in
spawn_consumerd() at client.c:204)

DBG1 - 00:24:25.135155823 [Client management]: Waiting for consumer
management thread to be ready (in wait_until_thread_is_ready() at
manage-consumer.c:46)

DBG1 - 00:24:25.135247552 [Consumer management]: Entering thread entry
point (in launch_thread() at thread.c:65)

DBG1 - 00:24:25.135293542 [Consumer management]: [thread] Manage consumer
started (in thread_consumer_management() at manage-consumer.c:65)

DBG1 - 00:24:25.135335776 [Client management]: Using 64-bit UST consumer
at: /usr/lib/x86_64-linux-gnu/lttng/libexec/lttng-consumerd (in
spawn_consumerd() at client.c:284)

DBG1 - 00:24:25.240725883 [Consumer management]: Consumer command socket
ready (fd: 61) (in thread_consumer_management() at manage-consumer.c:204)

DBG1 - 00:24:25.240746802 [Consumer management]: Consumer metadata socket
ready (fd: 62) (in thread_consumer_management() at manage-consumer.c:205)

DBG1 - 00:24:25.240775318 [Consumer management]: Sending consumer
initialization command (in consumer_init() at consumer.c:1791)

DBG1 - 00:24:25.241066762 [Consumer management]: Marking consumer
management thread as ready (in mark_thread_as_ready() at
manage-consumer.c:31)

DBG1 - 00:24:25.241100481 [Client management]: Consumer management thread
is ready (in wait_until_thread_is_ready() at manage-consumer.c:48)

DBG1 - 00:24:25.241138386 [Client management]: Setting relayd for session
auto-20240112-002417 (in cmd_setup_relayd() at cmd.c:1004)

lttng-sessiond: unix.c:185: lttcomm_recv_unix_sock: Assertion `buf' failed.

Error: Events: No session daemon is available (channel channel0, session
auto-20240112-002417)

[1]+  Aborted                 (core dumped) lttng-sessiond --verbose

DBG1 - 00:24:26.357769106 [Run-as worker]: run_as worker exiting (ret =3D 0=
)
(in run_as_create_worker_no_lock() at runas.c:1526)

--000000000000c16740060ebf6aba
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr" class=3D"gmail_signature" data-smartmail=
=3D"gmail_signature"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><di=
v dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr">





<p style=3D"margin:0px;font-variant-numeric:normal;font-variant-east-asian:=
normal;font-variant-alternates:normal;font-kerning:auto;font-feature-settin=
gs:normal;font-stretch:normal;line-height:normal;color:rgb(0,0,0)"><font fa=
ce=3D"times new roman, serif" style=3D""><span style=3D"font-variant-ligatu=
res:no-common-ligatures">I am not sure=C2=A0whether=C2=A0this is my setting=
 problem or a bug with a more=C2=A0recent=C2=A0kernel. lttng-sessiond was k=
illed when I tried to &quot;enable event&quot; after a session was created.=
 See below part of the verbose output of the sessiond. It is observed on Ub=
untu 22.04, kernel=C2=A0</span><span style=3D"font-variant-ligatures:no-com=
mon-ligatures">6.5.0-14-generic #14~22.04.1-Ubuntu SMP PREEMPT_DYNAMIC,=C2=
=A0</span><span style=3D"font-variant-ligatures:no-common-ligatures">lttng =
(LTTng Trace Control) 2.13.10 - Nordicit=C3=A9.=C2=A0</span></font></p><p s=
tyle=3D"margin:0px;font-variant-numeric:normal;font-variant-east-asian:norm=
al;font-variant-alternates:normal;font-kerning:auto;font-feature-settings:n=
ormal;font-stretch:normal;line-height:normal;color:rgb(0,0,0)"><span style=
=3D"font-variant-ligatures:no-common-ligatures"><font face=3D"times new rom=
an, serif"><br></font></span></p><p style=3D"margin:0px;font-variant-numeri=
c:normal;font-variant-east-asian:normal;font-variant-alternates:normal;font=
-kerning:auto;font-feature-settings:normal;font-stretch:normal;line-height:=
normal;color:rgb(0,0,0)"><span style=3D"font-variant-ligatures:no-common-li=
gatures"><font face=3D"times new roman, serif">The same version of LTTng wo=
rks on another Ubuntu 22.04 machine, but with kernel 6.2.0-33-generic. Any =
suggestion on what I should try?</font></span></p><p style=3D"margin:0px;fo=
nt-variant-numeric:normal;font-variant-east-asian:normal;font-variant-alter=
nates:normal;font-kerning:auto;font-feature-settings:normal;font-stretch:no=
rmal;line-height:normal;color:rgb(0,0,0)"><span style=3D"font-variant-ligat=
ures:no-common-ligatures"><font face=3D"times new roman, serif"><br></font>=
</span></p><p style=3D"margin:0px;font-variant-numeric:normal;font-variant-=
east-asian:normal;font-variant-alternates:normal;font-kerning:auto;font-fea=
ture-settings:normal;font-stretch:normal;line-height:normal;color:rgb(0,0,0=
)"><span style=3D"font-variant-ligatures:no-common-ligatures"><font face=3D=
"times new roman, serif">Thank you</font></span></p><p style=3D"margin:0px;=
font-variant-numeric:normal;font-variant-east-asian:normal;font-variant-alt=
ernates:normal;font-kerning:auto;font-feature-settings:normal;font-stretch:=
normal;line-height:normal;color:rgb(0,0,0)"><span style=3D"font-variant-lig=
atures:no-common-ligatures"><font face=3D"times new roman, serif">Yonghong<=
/font></span></p><p style=3D"margin:0px;font-variant-numeric:normal;font-va=
riant-east-asian:normal;font-variant-alternates:normal;font-kerning:auto;fo=
nt-feature-settings:normal;font-stretch:normal;font-size:17px;line-height:n=
ormal;font-family:Menlo;color:rgb(0,0,0)"><span style=3D"font-variant-ligat=
ures:no-common-ligatures"><br></span></p>











<p style=3D"margin:0px;font-variant-numeric:normal;font-variant-east-asian:=
normal;font-variant-alternates:normal;font-kerning:auto;font-feature-settin=
gs:normal;font-stretch:normal;font-size:17px;line-height:normal;font-family=
:Menlo;color:rgb(0,0,0)"><span style=3D"font-variant-ligatures:no-common-li=
gatures"><br></span></p><p style=3D"margin:0px;font:17px Menlo;color:rgb(0,=
0,0)"><span style=3D"font-variant-ligatures:no-common-ligatures">c:1016)</s=
pan></p><p style=3D"margin:0px;font:17px Menlo;color:rgb(0,0,0)"><span styl=
e=3D"font-variant-ligatures:no-common-ligatures">DBG1 - 00:24:25.134138433 =
[Client management]: Getting session auto-20240112-002417 by name (in proce=
ss_client_msg() at client.c:1133)</span></p><p style=3D"margin:0px;font:17p=
x Menlo;color:rgb(0,0,0)"><span style=3D"font-variant-ligatures:no-common-l=
igatures">DBG1 - 00:24:25.134148894 [Client management]: Creating UST sessi=
on (in create_ust_session() at client.c:510)</span></p><p style=3D"margin:0=
px;font:17px Menlo;color:rgb(0,0,0)"><span style=3D"font-variant-ligatures:=
no-common-ligatures">DBG1 - 00:24:25.134267958 [Client management]: Spawnin=
g consumerd (in spawn_consumerd() at client.c:204)</span></p><p style=3D"ma=
rgin:0px;font:17px Menlo;color:rgb(0,0,0)"><span style=3D"font-variant-liga=
tures:no-common-ligatures">DBG1 - 00:24:25.135155823 [Client management]: W=
aiting for consumer management thread to be ready (in wait_until_thread_is_=
ready() at manage-consumer.c:46)</span></p><p style=3D"margin:0px;font:17px=
 Menlo;color:rgb(0,0,0)"><span style=3D"font-variant-ligatures:no-common-li=
gatures">DBG1 - 00:24:25.135247552 [Consumer management]: Entering thread e=
ntry point (in launch_thread() at thread.c:65)</span></p><p style=3D"margin=
:0px;font:17px Menlo;color:rgb(0,0,0)"><span style=3D"font-variant-ligature=
s:no-common-ligatures">DBG1 - 00:24:25.135293542 [Consumer management]: [th=
read] Manage consumer started (in thread_consumer_management() at manage-co=
nsumer.c:65)</span></p><p style=3D"margin:0px;font:17px Menlo;color:rgb(0,0=
,0)"><span style=3D"font-variant-ligatures:no-common-ligatures">DBG1 - 00:2=
4:25.135335776 [Client management]: Using 64-bit UST consumer at: /usr/lib/=
x86_64-linux-gnu/lttng/libexec/lttng-consumerd (in spawn_consumerd() at cli=
ent.c:284)</span></p><p style=3D"margin:0px;font:17px Menlo;color:rgb(0,0,0=
)"><span style=3D"font-variant-ligatures:no-common-ligatures">DBG1 - 00:24:=
25.240725883 [Consumer management]: Consumer command socket ready (fd: 61) =
(in thread_consumer_management() at manage-consumer.c:204)</span></p><p sty=
le=3D"margin:0px;font:17px Menlo;color:rgb(0,0,0)"><span style=3D"font-vari=
ant-ligatures:no-common-ligatures">DBG1 - 00:24:25.240746802 [Consumer mana=
gement]: Consumer metadata socket ready (fd: 62) (in thread_consumer_manage=
ment() at manage-consumer.c:205)</span></p><p style=3D"margin:0px;font:17px=
 Menlo;color:rgb(0,0,0)"><span style=3D"font-variant-ligatures:no-common-li=
gatures">DBG1 - 00:24:25.240775318 [Consumer management]: Sending consumer =
initialization command (in consumer_init() at consumer.c:1791)</span></p><p=
 style=3D"margin:0px;font:17px Menlo;color:rgb(0,0,0)"><span style=3D"font-=
variant-ligatures:no-common-ligatures">DBG1 - 00:24:25.241066762 [Consumer =
management]: Marking consumer management thread as ready (in mark_thread_as=
_ready() at manage-consumer.c:31)</span></p><p style=3D"margin:0px;font:17p=
x Menlo;color:rgb(0,0,0)"><span style=3D"font-variant-ligatures:no-common-l=
igatures">DBG1 - 00:24:25.241100481 [Client management]: Consumer managemen=
t thread is ready (in wait_until_thread_is_ready() at manage-consumer.c:48)=
</span></p><p style=3D"margin:0px;font:17px Menlo;color:rgb(0,0,0)"><span s=
tyle=3D"font-variant-ligatures:no-common-ligatures">DBG1 - 00:24:25.2411383=
86 [Client management]: Setting relayd for session auto-20240112-002417 (in=
 cmd_setup_relayd() at cmd.c:1004)</span></p><p style=3D"margin:0px;font:17=
px Menlo;color:rgb(0,0,0)"><span style=3D"font-variant-ligatures:no-common-=
ligatures">lttng-sessiond: unix.c:185: lttcomm_recv_unix_sock: Assertion `b=
uf&#39; failed.</span></p><p style=3D"margin:0px;font:17px Menlo;color:rgb(=
0,0,0)"><span style=3D"font-variant-ligatures:no-common-ligatures">Error: E=
vents: No session daemon is available (channel channel0, session auto-20240=
112-002417)</span></p><p style=3D"margin:0px;font:17px Menlo;color:rgb(0,0,=
0)"><span style=3D"font-variant-ligatures:no-common-ligatures">[1]+<span>=
=C2=A0 </span>Aborted <span>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 </span>(core dumped) lttng-sessiond --verbose</span></p><p style=
=3D"margin:0px;font-variant-numeric:normal;font-variant-east-asian:normal;f=
ont-variant-alternates:normal;font-kerning:auto;font-feature-settings:norma=
l;font-stretch:normal;font-size:17px;line-height:normal;font-family:Menlo;c=
olor:rgb(0,0,0)">






















</p><p style=3D"margin:0px;font-variant-numeric:normal;font-variant-east-as=
ian:normal;font-variant-alternates:normal;font-kerning:auto;font-feature-se=
ttings:normal;font-stretch:normal;font-size:17px;line-height:normal;font-fa=
mily:Menlo;color:rgb(0,0,0)"><span style=3D"font-variant-ligatures:no-commo=
n-ligatures">DBG1 - 00:24:26.357769106 [Run-as worker]: run_as worker exiti=
ng (ret =3D 0) (in run_as_create_worker_no_lock() at runas.c:1526)</span></=
p><p style=3D"margin:0px;font-variant-numeric:normal;font-variant-east-asia=
n:normal;font-variant-alternates:normal;font-kerning:auto;font-feature-sett=
ings:normal;font-stretch:normal;font-size:17px;line-height:normal;font-fami=
ly:Menlo;color:rgb(0,0,0)"><span style=3D"font-variant-ligatures:no-common-=
ligatures"><br></span></p><div dir=3D"ltr"><div dir=3D"ltr"><p style=3D"fon=
t-size:12.8px"></p></div><div dir=3D"ltr"></div></div></div></div></div></d=
iv></div></div></div></div>

--000000000000c16740060ebf6aba--

--===============0309750082188625648==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0309750082188625648==--
