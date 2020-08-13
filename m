Return-Path: <SRS0=GH8+=BX=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2F05C433E1
	for <lttng-dev@archiver.kernel.org>; Thu, 13 Aug 2020 13:52:37 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5372D20774
	for <lttng-dev@archiver.kernel.org>; Thu, 13 Aug 2020 13:52:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.lttng.org header.i=@lists.lttng.org header.b="f7nBin2J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5372D20774
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4BS7LC3gtqz1v0b;
	Thu, 13 Aug 2020 09:52:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1597326756;
	bh=dHCXWDSVdIe3oDv+ceNQmcuLnfCFPRhW0k7JkUfNCm0=;
	h=Date:To:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=f7nBin2JnZ6wSGcnBmh2bRkAP/OWfT3x6i4HO/xMLZu9x+O55pblGK6QrqjcERzoI
	 E6mfCorqaYf2j3vzOoEoDBOqdj1Zn68RN16+7pESgvf+LBKYI/KlELFWddmuBlifJy
	 owR3MVSvKrvOq+1VLdZIS6FBAJBybA/88LMAzX1uMwBkTHTk9FdWU0xzq1cnl4OjOa
	 YJT2PeioD4htZlt39Is2+qH14RtJmFQIQWzWivIBo5qeTyeYE1v7NgPbxptbg9bTqg
	 kmxQQ238oN67qlKPz5CMJHds/ov4b/28IbF3iN02rEEA1kC6/LHVLd1aZNmq7ft0y6
	 6DzV6jVvDUOpw==
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com
 [IPv6:2607:f8b0:4864:20::231])
 by lists.lttng.org (Postfix) with ESMTPS id 4BS7L92BYTz1tkw
 for <lttng-dev@lists.lttng.org>; Thu, 13 Aug 2020 09:52:33 -0400 (EDT)
Received: by mail-oi1-x231.google.com with SMTP id u24so3952428oic.7
 for <lttng-dev@lists.lttng.org>; Thu, 13 Aug 2020 06:52:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=0hZYYerznSh7E3OwFOQKi8TpjALKqwqzMJynnD8ujhE=;
 b=m5M0vOUNVwBwQmI9CxvxaypgMpMmc6wygnz5hs4HtfiRk+wAcQO8U64t722w5hF+ii
 SSNuMs7qpb3yRjGkrMrCy1J/Z8qpCiBXQlJXoMJYWjmb7ZSGEby722H/qDFnyFqN92bh
 3KFhm8lapV6edftjSYa8RiDlJa0XwWRo56cw2X86vQYwcW0Wlg2svGP0eSZ5MsV963dL
 K04fo9s/eNw4zej/EiIP9rHMYEG5J7tlyJL6NxND8/VLpKlAYU7lRwnlf+0aSzEO7TKm
 fly5SQ1rfMr7t44oDIGMyfQ/4kJfbp1z2ZiChpd/B886IMM4CldKwDtqGZoc3/tqV+9W
 qkAA==
X-Gm-Message-State: AOAM532pXcQOrXfJ9QRb++jPl5S/5oZ0efkztiW+9U2rF8lSh4/kkh9S
 qgUvTT051mb+PbDBGmxzbdk98gHrh77/2KujPHTTImziu5P0/w==
X-Google-Smtp-Source: ABdhPJw64/QaVhUU8r4Gur6UXftUwle9SCS59rcXfVqpBY9TQmDgbiSlDMZPQIJ8BHTNXGdQUU/aZgYoZJDfvsu1ugg=
X-Received: by 2002:a05:6808:2d4:: with SMTP id
 a20mr3235688oid.151.1597326752105; 
 Thu, 13 Aug 2020 06:52:32 -0700 (PDT)
MIME-Version: 1.0
Date: Thu, 13 Aug 2020 16:52:16 +0300
Message-ID: <CABhb4uuzDD1srWvRbC915wGfpsWt9LAAue942-ppaKH3FJt6Gw@mail.gmail.com>
To: lttng-dev <lttng-dev@lists.lttng.org>
Subject: [lttng-dev] LTTng event identification
X-BeenThere: lttng-dev@lists.lttng.org
X-Mailman-Version: 2.1.31
Precedence: list
List-Id: LTTng development list <lttng-dev.lists.lttng.org>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
From: Valentin Grigorev via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Valentin Grigorev <valentin.grigorev@jetbrains.com>
Content-Type: multipart/mixed; boundary="===============4012737691831026536=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--===============4012737691831026536==
Content-Type: multipart/alternative; boundary="000000000000a6699305acc29d57"

--000000000000a6699305acc29d57
Content-Type: text/plain; charset="UTF-8"

Hello!

I'm using LTTng live session and Babeltrace 2 C API to analyze events in
online mode.

I would like to route event processing statically (using IDs, without
parsing strings). And currently, I don't understand if it is possible with
LTTng.

Babeltrace 2 C API provides bt_event_class_get_id function, but the only
guarantee about IDs received from this function is "All the event classes
of a given stream class have unique numeric IDs
<https://babeltrace.org/docs/v2.0/libbabeltrace2/group__api-tir-ev-cls.html#api-tir-ev-cls-prop-id>".
And even more, it is mentioned further that stream class can automatically
assign event class IDs in some cases (q.v.
https://babeltrace.org/docs/v2.0/libbabeltrace2/group__api-tir-ev-cls.html).
If I understand correctly, it means, that these IDs are assigned by
Babeltrace library, not by LTTng itself or tracepoint provider, and as
result, the same tracepoints can produce events with different event class
IDs even within the same tracing session. Am I right?

At the same time, in ETW (Event Tracing for Windows) event type is fully
identified by 3 parameters: provider GUID, event id, event version. I would
like to have something like this. At least I need to know that ID for the
same tracepoint is constant, unique within a tracepoint provider, and not
depends on a session configuration, other providers, etc.

Summarizing, I'm interested in the following questions:
  * Do event class IDs depend on a session configuration (which events were
enabled)?
  * If so, maybe there are some other IDs satisfying the above requirements
in LTTng/Babeltrace?
  * Do any IDs for tracepoint providers exist in LTTng? Or parsing event
name is the only way to identify it?

Best regards,
Valentin Grigorev

--000000000000a6699305acc29d57
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div di=
r=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"lt=
r"><div>Hello!</div><div><br></div><div>I&#39;m using LTTng live session an=
d Babeltrace 2 C API to analyze events in online mode.=C2=A0</div><div><br>=
</div><div>I would like to route event=C2=A0processing statically (using ID=
s, without parsing strings). And currently, I don&#39;t understand if it is=
 possible with LTTng.</div><div><br></div><div>Babeltrace 2 C API provides =
bt_event_class_get_id function, but the=C2=A0only guarantee=C2=A0about IDs =
received from this function is &quot;<span style=3D"color:rgb(0,0,0);font-f=
amily:Roboto,sans-serif">All the event classes of a given stream class have=
 unique=C2=A0</span><a target=3D"_blank" style=3D"color:rgb(47,68,109);font=
-weight:bold;font-family:Roboto,sans-serif" href=3D"https://babeltrace.org/=
docs/v2.0/libbabeltrace2/group__api-tir-ev-cls.html#api-tir-ev-cls-prop-id"=
>numeric IDs</a>&quot;. And even more, it is mentioned further that stream =
class can automatically assign event class IDs in some cases (q.v. <a targe=
t=3D"_blank" href=3D"https://babeltrace.org/docs/v2.0/libbabeltrace2/group_=
_api-tir-ev-cls.html">https://babeltrace.org/docs/v2.0/libbabeltrace2/group=
__api-tir-ev-cls.html</a>). If I understand correctly, it means, that=C2=A0=
these IDs are=C2=A0assigned=C2=A0by Babeltrace library, not by LTTng itself=
 or tracepoint provider, and as result, the same tracepoints can produce ev=
ents with different event class IDs even within the same tracing session.=
=C2=A0Am I right?</div><div><br></div><div>At the same time, in ETW (Event =
Tracing for Windows) event type is fully identified by 3 parameters: provid=
er GUID, event id, event version. I would like to have something like this.=
 At least I need to know that ID for the same tracepoint is constant,=C2=A0=
unique within a tracepoint=C2=A0provider, and not depends on a session conf=
iguration, other providers, etc.=C2=A0</div><div><br></div><div>Summarizing=
, I&#39;m interested in the following questions:</div><div>=C2=A0 * Do even=
t class IDs=C2=A0depend on a session configuration (which events were enabl=
ed)?</div><div>=C2=A0 * If so, maybe there are some other IDs satisfying th=
e above requirements in LTTng/Babeltrace?</div><div>=C2=A0 * Do any IDs for=
 tracepoint providers exist in LTTng? Or parsing event name is the only way=
 to identify it?</div><br clear=3D"all"><div><div dir=3D"ltr"><div>Best reg=
ards,</div><div>Valentin Grigorev</div></div></div></div></div></div></div>=
</div></div></div></div></div>

--000000000000a6699305acc29d57--

--===============4012737691831026536==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============4012737691831026536==--
