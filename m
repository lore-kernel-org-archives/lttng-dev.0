Return-Path: <SRS0=pdKY=65=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_REPLYTO_END_DIGIT,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32CE1C433DF
	for <lttng-dev@archiver.kernel.org>; Fri, 15 May 2020 17:17:04 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AFC8A20709
	for <lttng-dev@archiver.kernel.org>; Fri, 15 May 2020 17:17:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.lttng.org header.i=@lists.lttng.org header.b="sQIrWzs2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFC8A20709
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 49Nw7f1Mx0z23pT;
	Fri, 15 May 2020 13:17:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1589563022;
	bh=ZBSefGjcLm0ZoJJ8hf8fwsvRkrzwALvUTtcjvuGPGqw=;
	h=Date:To:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=sQIrWzs2mTtKLJ5CCu2mNvNCX1Q0YmEtf7Q2rdzB9ZfBfo1BGsQIYI0PsIJ3DDnph
	 KldpAjthT8qZKInxfLRc1blWb21JUwshqQZ5fVUXdcaml6xT8OD2TiD831rVQQp71V
	 xRXmd8R/Ay94bBEccCRi4QnlSao6Uh9dPtUfAA73W6ziCHdajsTbP/RJ2cttgBkGnz
	 5d12+Qa90GFSLCTVj9i0EXqz0szLRy7ITGeMXdhOgkKAKkSdHt8gIkZ0CJ5/SC28ji
	 hJDTRGvUR5kj+5ZoYBJlSlAWRYjngnMNqYc0SKnC4dZTO2XBfXGIjXk56liEtB/KFN
	 zBuXfuXJ1nmCA==
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com
 [IPv6:2607:f8b0:4864:20::130])
 by lists.lttng.org (Postfix) with ESMTPS id 49Nw7b3HgLz2411
 for <lttng-dev@lists.lttng.org>; Fri, 15 May 2020 13:16:59 -0400 (EDT)
Received: by mail-il1-x130.google.com with SMTP id j3so3268118ilk.11
 for <lttng-dev@lists.lttng.org>; Fri, 15 May 2020 10:16:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=F/OXPvUnIN/SmH8KwhuO3F+NTGkMg9a1aVpeBJC+1ss=;
 b=btMirlFxgPWfCEOp5QJg9dNJhh3oOleRmxpTOfi5MEzN9DK9hKjGE+nMFlWSvURzM5
 e8uV+uKJzZ330iICic4vLhpGjR4WtbXdI3zgEFfWo0bFJXD/6sQB6rELaAp6c3lVQDT6
 pdaThCJYnWAmi2CNrVn9j8TJ2TM+/JF4dd3azwrWpy1F+XWt0NWV6fI4VhNRiBBdQRTS
 hB2am1FvpLU7Qeqg9iKZWKpuLjW3jb0rdl9GMTW2nsMJEVAhZohKCVTTYxIv/7Som+E1
 SNcb0s/9d91b329YclJx4PqywiTZZ/v3insKaA1J9MzyK3g2stit0C29GjjfdwMclAyh
 jjIQ==
X-Gm-Message-State: AOAM532uVcq/6mMvPH8EVqMv9nmAgDNzpZj15HSm4Y3CMjs2sya0u0o9
 8MjjgEGoVP2kKV88xJk82oi9f+V5n/TQPM3cd5Ra7g==
X-Google-Smtp-Source: ABdhPJzCHQsIFih8dg470FmJ2fCKIt5RBra/TQ9d1x9fRT0XMZeaxVVJDMXR8sxPNrzJ6B4kasuTD24ytxCjEZXDNK0=
X-Received: by 2002:a92:8752:: with SMTP id d18mr4616820ilm.224.1589563018317; 
 Fri, 15 May 2020 10:16:58 -0700 (PDT)
MIME-Version: 1.0
Date: Fri, 15 May 2020 13:16:47 -0400
Message-ID: <CACJEY85H4OMTz9ggfZZP3QCXoWgLiJgsMVNTP8LNBAF67mQTEQ@mail.gmail.com>
To: lttng-dev <lttng-dev@lists.lttng.org>
Subject: [lttng-dev] process/thread-specific UST tracing
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
From: Yonghong Yan via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Yonghong Yan <yanyh15@gmail.com>
Content-Type: multipart/mixed; boundary="===============8374015916871231770=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
Message-ID: <20200515171647.bEW6JBZcfxnOV5E896RFe3ZSl-2Crf8nyqXwvRhEfxE@z>

--===============8374015916871231770==
Content-Type: multipart/alternative; boundary="0000000000000e13fe05a5b2fba7"

--0000000000000e13fe05a5b2fba7
Content-Type: text/plain; charset="UTF-8"

I am tracing a multiprocess/multithreaded code (MPI/OpenMP) using
lttng-ust. Right now, I need to include process id and thread id for each
event in order to generate process/thread indexed view of the traces. Is
there a way that I can store per-process events into a specific buffer
without mixing the events with other events that are generated on the same
CPU? The same thing for per-thread events, I would like lttng or CTF to
allow to store per-thread events in a specific buffer without mixing the
events with other events on the same CPU channel. With that feature, I do
not need to store process id and thread id in each event and then need to
query all the events in order to collect per-process or per-thread event.

Thank you
Yonghong

--0000000000000e13fe05a5b2fba7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">I am tracing a multiprocess/multithreaded code (MPI/OpenMP=
) using lttng-ust. Right now, I need to include process id and thread id fo=
r each event in order to=C2=A0generate process/thread indexed view of the t=
races. Is there a way that I can store per-process events into a specific b=
uffer without mixing the events with other events that are generated on the=
 same CPU? The same thing for per-thread events, I would like lttng or CTF =
to allow to store per-thread events in a specific buffer without mixing the=
 events with other events on the same CPU channel. With that feature, I do =
not need to store process id and thread id in each event and then need to q=
uery all the events in order to collect per-process or per-thread event.=C2=
=A0<div><br></div><div>Thank you</div><div>Yonghong<div><div><div dir=3D"lt=
r" class=3D"gmail_signature" data-smartmail=3D"gmail_signature"><div dir=3D=
"ltr"><div><div dir=3D"ltr"><div><div dir=3D"ltr"><div dir=3D"ltr"><div dir=
=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"></div><div dir=3D"ltr"><div dir=
=3D"ltr"><p style=3D"font-size:12.8px"></p></div><div dir=3D"ltr"></div></d=
iv></div></div></div></div></div></div></div></div></div></div></div></div>=
</div>

--0000000000000e13fe05a5b2fba7--

--===============8374015916871231770==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============8374015916871231770==--
