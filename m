Return-Path: <SRS0=rLrG=MY=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38453C4338F
	for <lttng-dev@archiver.kernel.org>; Sun,  1 Aug 2021 09:11:21 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 601DC61057
	for <lttng-dev@archiver.kernel.org>; Sun,  1 Aug 2021 09:11:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 601DC61057
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4GcwNk4j5Fz555;
	Sun,  1 Aug 2021 05:11:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1627809079;
	bh=SRp6dfIUw+CJa4n8WuFX/xirtpiP7rt1mf5imC/f2Ng=;
	h=Date:To:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=RCbZ+QVooVniZ0WgGOTwZvplXJhQer6X3W1e60qcDipV/wzW+c3160IjnvsWZVIRe
	 QNOAWcDeo4OgpoDt2Pivf6P6epCISwFcWvFUzh7Cb0iP0kAvUmL/OnWFhTyLJTZ/xr
	 3chH9AixhNSb0hoORgX2Eqp0qIv/Ws9cTpYLVuTOErdvcC7uiutgModY+uuE3k3yTq
	 ZDGA4VI6OyahEFDqod8jF69N3ktDPVkKDFfV7LwZKwBUEhVM7ifNMS66aCEW7Eu4i5
	 3bdW3FjWQfsP8HJ17DV9TTe8L9F7rZUQ0buLTtOJJELnHW0LRiWmYh9AdMciKKny6p
	 OK5kEHoFCECbQ==
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com
 [IPv6:2607:f8b0:4864:20::233])
 by lists.lttng.org (Postfix) with ESMTPS id 4GcwNh4Gn5z4lJ
 for <lttng-dev@lists.lttng.org>; Sun,  1 Aug 2021 05:11:16 -0400 (EDT)
Received: by mail-oi1-x233.google.com with SMTP id 21so20414172oin.8
 for <lttng-dev@lists.lttng.org>; Sun, 01 Aug 2021 02:11:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=7jfqv47HCYzv0EDvoXYCKwfBu2bL8JHlWeo/E7THkyk=;
 b=Kpi3TJiY4HBcH/J92V4hvQqsU05DoIXUfnPZMQNVUi8MMjveJyV5CgOBuPne1LWNjK
 qQ+KNAAr0OkyKj6svyyvy3lfXDaxT1NeKFig0g5rRSSOpbMl+/mFTgy4cklStwMHwweV
 BlCAAutbp+5PGN3pwUzSqpBNsJ6RFPJJv3yu9u4b7g2oNtiYJnk2cu/kjlfLD+4DTE9h
 gYPJSM23WwR4bpasfFedejhKbf35S31RpFhj9uME62WkvtEL6gwtYezKRn2NQcHTbJmP
 B5MN+wsWv3LFJE2K1B9v5KkGnXu5sz7R8f+MSnxwpyx1PjfcWT5xo1HokuwJr3TN+XBQ
 2W7A==
X-Gm-Message-State: AOAM533l1GT6laBPAMuIuceDKVVLNZnxlJE2PA1K+JUTHdP38kjuhCRL
 hLZL4ViQ1l9iIeqigEKD520VM5BWsXlkbxc+dCpY8ZJknq5w9Q==
X-Google-Smtp-Source: ABdhPJwVfPaxTN5oRK0fiW6GkbBToTUz3RmrtnjQlbgwLf4L37KAS9mbkVaRAXBOtgNs5TvvT7rgXNeP2gGoThOHmlc=
X-Received: by 2002:a05:6808:4d6:: with SMTP id
 a22mr6984790oie.41.1627809075169; 
 Sun, 01 Aug 2021 02:11:15 -0700 (PDT)
MIME-Version: 1.0
Date: Sun, 1 Aug 2021 05:11:04 -0400
Message-ID: <CAA+-46pQev9-S0_htpu7QT8cVF_Rv25deDjRQGMzgnzvRMG9VQ@mail.gmail.com>
To: lttng-dev@lists.lttng.org
Subject: [lttng-dev] Assertion tgt_fc failed when trying to trace
 callstack-user
X-BeenThere: lttng-dev@lists.lttng.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: LTTng development list <lttng-dev.lists.lttng.org>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
From: Evan Galea via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Evan Galea <evanjamesgalea@gmail.com>
Content-Type: multipart/mixed; boundary="===============3309877655634725537=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--===============3309877655634725537==
Content-Type: multipart/alternative; boundary="000000000000b00c4905c87bd5a5"

--000000000000b00c4905c87bd5a5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi there

Thanks for help on my previous issue. I was able to get callstack-user to
work and see it in my traces. However, in order to get it to run I needed
to enable-event --kernel all. Is it necessary to have all kernel events
enabled to run callstack-user? Or is it just one specific event?

When I try to run it without enabling all kernel events the command is
accepted and it runs but I get the following error when trying to view my
traces:

 (=E2=95=AF=C2=B0=E2=96=A1=C2=B0)=E2=95=AF=EF=B8=B5 =E2=94=BB=E2=94=81=E2=
=94=BB ctf-meta-update-value-storing-indexes.c:65:
update_field_class_stored_value_index(): Assertion `tgt_fc` failed.
Aborted (core dumped)

What does this error mean? Should I just continue to enable all kernel
events?

My current command setup, not sure if relevant

lttng create &&
lttng enable-channel mychannel --subbuf-size 100000000
lttng enable-event --kernel --all &&
lttng add-context -u -t vpid -t vtid -t procname &&
lttng add-context --kernel --type callstack-user &&
lttng add-context --kernel --type callstack-kernel &&
lttng enable-event --jul jello

again thank you for your time

Evan Galea

--000000000000b00c4905c87bd5a5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div style=3D"box-sizing:border-box;font-family:&quot;Sego=
e UI&quot;,system-ui,&quot;Apple Color Emoji&quot;,&quot;Segoe UI Emoji&quo=
t;,sans-serif;font-size:14px">Hi there</div><div style=3D"box-sizing:border=
-box;font-family:&quot;Segoe UI&quot;,system-ui,&quot;Apple Color Emoji&quo=
t;,&quot;Segoe UI Emoji&quot;,sans-serif;font-size:14px"><br></div><div sty=
le=3D"box-sizing:border-box;font-family:&quot;Segoe UI&quot;,system-ui,&quo=
t;Apple Color Emoji&quot;,&quot;Segoe UI Emoji&quot;,sans-serif;font-size:1=
4px">Thanks for help on my previous issue. I was able to get callstack-user=
=C2=A0to work and see it in my traces. However, in order to get it to run I=
 needed to enable-event --kernel all. Is it necessary to have all kernel ev=
ents enabled to run callstack-user? Or is it just one specific event?</div>=
<div style=3D"box-sizing:border-box;font-family:&quot;Segoe UI&quot;,system=
-ui,&quot;Apple Color Emoji&quot;,&quot;Segoe UI Emoji&quot;,sans-serif;fon=
t-size:14px"><br></div><div style=3D"box-sizing:border-box;font-family:&quo=
t;Segoe UI&quot;,system-ui,&quot;Apple Color Emoji&quot;,&quot;Segoe UI Emo=
ji&quot;,sans-serif;font-size:14px">When I try to run it without enabling a=
ll kernel events the command is accepted and it runs but I get the followin=
g error when trying to view my traces:</div><div style=3D"box-sizing:border=
-box;font-family:&quot;Segoe UI&quot;,system-ui,&quot;Apple Color Emoji&quo=
t;,&quot;Segoe UI Emoji&quot;,sans-serif;font-size:14px"><br></div><div sty=
le=3D"box-sizing:border-box;font-family:&quot;Segoe UI&quot;,system-ui,&quo=
t;Apple Color Emoji&quot;,&quot;Segoe UI Emoji&quot;,sans-serif;font-size:1=
4px"><div style=3D"box-sizing:border-box">=C2=A0(=E2=95=AF=C2=B0=E2=96=A1=
=C2=B0)=E2=95=AF=EF=B8=B5 =E2=94=BB=E2=94=81=E2=94=BB  ctf-meta-update-valu=
e-storing-indexes.c:65: update_field_class_stored_value_index(): Assertion =
`tgt_fc` failed.<br>

Aborted (core dumped)</div><div style=3D"box-sizing:border-box"><br></div><=
div style=3D"box-sizing:border-box">What does this error mean? Should I jus=
t continue to enable all kernel events?</div><div style=3D"box-sizing:borde=
r-box"><br></div><div style=3D"box-sizing:border-box">My current command se=
tup, not sure if relevant</div></div><div style=3D"box-sizing:border-box;fo=
nt-family:&quot;Segoe UI&quot;,system-ui,&quot;Apple Color Emoji&quot;,&quo=
t;Segoe UI Emoji&quot;,sans-serif;font-size:14px"><br></div><div style=3D"b=
ox-sizing:border-box;font-family:&quot;Segoe UI&quot;,system-ui,&quot;Apple=
 Color Emoji&quot;,&quot;Segoe UI Emoji&quot;,sans-serif;font-size:14px">lt=
tng create &amp;&amp;<br>

lttng enable-channel mychannel --subbuf-size 100000000<br>

lttng enable-event --kernel --all &amp;&amp;<br>

lttng add-context -u -t vpid -t vtid -t procname &amp;&amp;<br>

lttng add-context --kernel --type callstack-user &amp;&amp;<br>

lttng add-context --kernel --type callstack-kernel &amp;&amp;<br>

lttng enable-event --jul jello</div><div style=3D"box-sizing:border-box;fon=
t-family:&quot;Segoe UI&quot;,system-ui,&quot;Apple Color Emoji&quot;,&quot=
;Segoe UI Emoji&quot;,sans-serif;font-size:14px"><br></div><div style=3D"bo=
x-sizing:border-box;font-family:&quot;Segoe UI&quot;,system-ui,&quot;Apple =
Color Emoji&quot;,&quot;Segoe UI Emoji&quot;,sans-serif;font-size:14px">aga=
in thank you for your time</div><div style=3D"box-sizing:border-box;font-fa=
mily:&quot;Segoe UI&quot;,system-ui,&quot;Apple Color Emoji&quot;,&quot;Seg=
oe UI Emoji&quot;,sans-serif;font-size:14px"><br></div><div style=3D"box-si=
zing:border-box;font-family:&quot;Segoe UI&quot;,system-ui,&quot;Apple Colo=
r Emoji&quot;,&quot;Segoe UI Emoji&quot;,sans-serif;font-size:14px">Evan Ga=
lea</div></div>

--000000000000b00c4905c87bd5a5--

--===============3309877655634725537==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============3309877655634725537==--
