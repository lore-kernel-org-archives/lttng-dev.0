Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4DDCC004C0
	for <lttng-dev@archiver.kernel.org>; Mon, 23 Oct 2023 13:43:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1698068632;
	bh=NdzxAYUL8lzw8SZ9GDhRJMMlwNQC9tZyHLOdRJ5uI04=;
	h=Date:To:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=OmxNzZuyog1mbdWTCLCfQgM7//r7/CfMydHFfB22PMmSK8+Wev8uhHw6X+sKnwhfy
	 SBBoN8Bg53IvGu3hL3o2LA3a1MwEDBXPbScTjBG+WdJ3v8jO0PzfjXUNnLaEMrxXn2
	 XqfCXDFvIbZGRWq9M/H/96NkyrmV+cCssB4K5eGDMkuhvLJtjx1QUs4RP2Y/cp9ufY
	 +JYEmu5lA1QPTgIOsEBnGDSQdIJV44UKGa/kv3rwheUYfRo5lr0xwCm1wUTlzMKYyd
	 g621i+2kfdoz2vndGqIpzyuvpWXMW3den0Uir60sA3PXqN64G+QbeDE90GGcdcupIX
	 hPk+SavoHby/w==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4SDby00Xdbz51m;
	Mon, 23 Oct 2023 09:43:52 -0400 (EDT)
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com
 [IPv6:2001:4860:4864:20::2e])
 by lists.lttng.org (Postfix) with ESMTPS id 4SDbxy6YV6z4nr
 for <lttng-dev@lists.lttng.org>; Mon, 23 Oct 2023 09:43:50 -0400 (EDT)
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-1ea05b3f228so2299944fac.1
 for <lttng-dev@lists.lttng.org>; Mon, 23 Oct 2023 06:43:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698068630; x=1698673430;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+omtnl+mo6RFHOXXmr0CVsS1jR41mSlFs4PoW7Wxze0=;
 b=RfBFeaE/nIMUzm7i4Y6B6YUBMxA11OiwmE2bePdZPCxFrj2b6h7eZugZpTiC76dIwz
 DbfAAcjQ6ZxcMbCvTHv4cpdRxv9cUP/evF5iD/M0PHkOfk+w3HQvGHSN0ksga1DvwX9Z
 IwKi7Ztgs3fr9s1NUjGjBz9CaPqkP3DU6NFeWF47lA1z63KGSBlRIxkirEtp6hjlHj2L
 CF9a5qCBqfgmTK5H8YfBpvCIrghuPBoPNxeXGU8SMc4zjeIRymSuRZO0l+DR1wkHQcIy
 8R9BsFUUFuTbRQDXr/dgtCnFDq7a7dWgDZ9BnMm8vhNNeMq9hk0URzxjGE48wA4ZeCX1
 Dg7Q==
X-Gm-Message-State: AOJu0YyFNyIZEQne56pXiYSFNeK7BW5x6F6kImpfEoTtpO6PVyBDiwch
 ByGU8bflhTz6PGNHf7xOLU7xss/4fxKYnJL/n578vGCVz46HD9EavMs=
X-Google-Smtp-Source: AGHT+IHUTsVJZQme/349qwfebgPKMIW08QLdMzXGUY4BhMX6xPhbXAVJyjo0Q8iYXcY2kd5W8TsrfSIqXBCScpn9aCA=
X-Received: by 2002:a05:6870:1399:b0:1eb:192b:e75a with SMTP id
 25-20020a056870139900b001eb192be75amr8021269oas.22.1698068629688; Mon, 23 Oct
 2023 06:43:49 -0700 (PDT)
MIME-Version: 1.0
Date: Mon, 23 Oct 2023 15:43:38 +0200
Message-ID: <CALBKf8Jv-QRwbZ0ATdPzj1KyzDQT6SqG9G_4-5-QfG35iJyetQ@mail.gmail.com>
To: lttng-dev@lists.lttng.org
Subject: [lttng-dev] Can't receive a lot of functions that i registerd as
 trace-points
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
From: Lin ArcX via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Lin ArcX <linarcx@gmail.com>
Content-Type: multipart/mixed; boundary="===============0108785013763168811=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--===============0108785013763168811==
Content-Type: multipart/alternative; boundary="0000000000007a165e060862698f"

--0000000000007a165e060862698f
Content-Type: text/plain; charset="UTF-8"

Hello,

I have a simple udp server/client and I want to trace these functions:

    Event rules:
      netif_rx_ni_entry (loglevel: TRACE_EMERG (0)) (type: tracepoint)
[enabled]
      netif_rx_entry (loglevel: TRACE_EMERG (0)) (type: tracepoint)
[enabled]
      napi_gro_receive_entry (loglevel: TRACE_EMERG (0)) (type: tracepoint)
[enabled]
      softirq_raise (loglevel: TRACE_EMERG (0)) (type: tracepoint) [enabled]
      irq_handler_entry (loglevel: TRACE_EMERG (0)) (type: tracepoint)
[enabled]
      napi_poll (loglevel: TRACE_EMERG (0)) (type: tracepoint) [enabled]
      softirq_entry (loglevel: TRACE_EMERG (0)) (type: tracepoint) [enabled]
      e1000_xmit_frame (loglevel: TRACE_EMERG (0)) (type: tracepoint)
[enabled]
      ndo_start_xmit (loglevel: TRACE_EMERG (0)) (type: tracepoint)
[enabled]
      net_dev_start_xmit (loglevel: TRACE_EMERG (0)) (type: tracepoint)
[enabled]
      dev_queue_xmit (loglevel: TRACE_EMERG (0)) (type: tracepoint)
[enabled]
      net_dev_queue (loglevel: TRACE_EMERG (0)) (type: tracepoint) [enabled]
      netif_receive_skb_list_entry (loglevel: TRACE_EMERG (0)) (type:
tracepoint) [enabled]
      netif_receive_skb (loglevel: TRACE_EMERG (0)) (type: tracepoint)
[enabled]
      inet_sock_set_state (loglevel: TRACE_EMERG (0)) (type: tracepoint)
[enabled]

I start tracing, and when it is finished, I will open my trace directory
into TraceCompass, But I can see just some traces from these functions:

- irq_handler_entry
- napi_poll
- net_dev_queue

I'm using  2.12.14.

Do you have any idea?

Regards,

--0000000000007a165e060862698f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hello,<br><br>I have a simple udp server/client and I want=
 to trace these functions:<br><br>=C2=A0 =C2=A0 Event rules:<br>=C2=A0 =C2=
=A0 =C2=A0 netif_rx_ni_entry (loglevel: TRACE_EMERG (0)) (type: tracepoint)=
 [enabled]<br>=C2=A0 =C2=A0 =C2=A0 netif_rx_entry (loglevel: TRACE_EMERG (0=
)) (type: tracepoint) [enabled]<br>=C2=A0 =C2=A0 =C2=A0 napi_gro_receive_en=
try (loglevel: TRACE_EMERG (0)) (type: tracepoint) [enabled]<br>=C2=A0 =C2=
=A0 =C2=A0 softirq_raise (loglevel: TRACE_EMERG (0)) (type: tracepoint) [en=
abled]<br>=C2=A0 =C2=A0 =C2=A0 irq_handler_entry (loglevel: TRACE_EMERG (0)=
) (type: tracepoint) [enabled]<br>=C2=A0 =C2=A0 =C2=A0 napi_poll (loglevel:=
 TRACE_EMERG (0)) (type: tracepoint) [enabled]<br>=C2=A0 =C2=A0 =C2=A0 soft=
irq_entry (loglevel: TRACE_EMERG (0)) (type: tracepoint) [enabled]<br>=C2=
=A0 =C2=A0 =C2=A0 e1000_xmit_frame (loglevel: TRACE_EMERG (0)) (type: trace=
point) [enabled]<br>=C2=A0 =C2=A0 =C2=A0 ndo_start_xmit (loglevel: TRACE_EM=
ERG (0)) (type: tracepoint) [enabled]<br>=C2=A0 =C2=A0 =C2=A0 net_dev_start=
_xmit (loglevel: TRACE_EMERG (0)) (type: tracepoint) [enabled]<br>=C2=A0 =
=C2=A0 =C2=A0 dev_queue_xmit (loglevel: TRACE_EMERG (0)) (type: tracepoint)=
 [enabled]<br>=C2=A0 =C2=A0 =C2=A0 net_dev_queue (loglevel: TRACE_EMERG (0)=
) (type: tracepoint) [enabled]<br>=C2=A0 =C2=A0 =C2=A0 netif_receive_skb_li=
st_entry (loglevel: TRACE_EMERG (0)) (type: tracepoint) [enabled]<br>=C2=A0=
 =C2=A0 =C2=A0 netif_receive_skb (loglevel: TRACE_EMERG (0)) (type: tracepo=
int) [enabled]<br>=C2=A0 =C2=A0 =C2=A0 inet_sock_set_state (loglevel: TRACE=
_EMERG (0)) (type: tracepoint) [enabled]<br><br>I start tracing, and when i=
t is finished, I will open my trace directory into TraceCompass, But I can =
see just some traces from these functions:<br><br>- irq_handler_entry<br>- =
napi_poll<br>- net_dev_queue<br><br>I&#39;m using=C2=A0=C2=A02.12.14.<br><b=
r>Do you have any idea?<br><br>Regards,</div>

--0000000000007a165e060862698f--

--===============0108785013763168811==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0108785013763168811==--
