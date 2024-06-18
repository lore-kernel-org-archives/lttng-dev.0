Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E0CEC27C4F
	for <lttng-dev@archiver.kernel.org>; Tue, 18 Jun 2024 12:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1718715362;
	bh=g2+l0ri3GHxdtZnY16Y99suQIb9uGp5vVH8TWhR6m5I=;
	h=Date:To:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=sAtMYMhPbjnFqFwqbfLenaEUuTdMbN5lalLMpagathgN4icY1JqV4ADDC07GuUxib
	 /lvy6tGcGiZw0Pr0pMj5Dz72ptVItrnTxmXCkkedyI+jB+M760qmS/phmtdNf21WbB
	 AH+8f0IrqelNQMpiBAFAQ/LMfhLeV3cUHpUT7wRVV8YLe2/1G/Y5/yH6ExNn/QIVrX
	 3PTZkoyxWoJn3WTUsPpBqU8ZTxfwXj3V698ATN6qc16mR07ec6wnKGMfdBQBJB1xwZ
	 vJUV9A9oLNolUUuYstxb66T1Vk/wmbJCXbQMHjrDl6jKXDga79nr5NVhKoavOH5ULY
	 N3u7JenBjscCA==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4W3RZT3FmRz4MZ;
	Tue, 18 Jun 2024 08:56:01 -0400 (EDT)
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com
 [IPv6:2607:f8b0:4864:20::112f])
 by lists.lttng.org (Postfix) with ESMTPS id 4W3RZR3sYSz44t
 for <lttng-dev@lists.lttng.org>; Tue, 18 Jun 2024 08:55:59 -0400 (EDT)
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-6326f1647f6so37588007b3.0
 for <lttng-dev@lists.lttng.org>; Tue, 18 Jun 2024 05:55:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718715358; x=1719320158;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=z4nPsOwxKkjkoZUWmDH5IUDme0arwCaNQqvkJ5pFhRE=;
 b=gGpmcgBIVYYtWLocBkITobc04PS1RXNUl7ndze8Bz31u/Z9uQlFzyd7bqxtA7a0mic
 rUrVRIiOylyFhES+F+S6+SGCqIaIK265XOPkvgZJ9hHK4/YeExukmkNLABpKIDBVRVIK
 RoNYSuTX2iFIOfvrPyG/RlrlcBJAzVUsF5L5V1bNB/6D6o2Rwy7g3BbI4aI0RVABP5Sv
 a4eebmkH/KRLXZcn5NS678hAqO9LYNu1pqOI3QEehBJ0xrZ+t4K9uGN3vP2Qqhayau/G
 VxiGm/RVxDO7ZKM+gAL7r4e5O1mt+fKvewO+nZvitbL5uGRk+vDHmqYGXVZT6NsPMSYI
 VeLw==
X-Gm-Message-State: AOJu0YxhUyD38j+k12ORISGvkfw7hDrRF5FpwAk4iusYjGk30kS0bDrY
 lOhrb1rfIhYshDkrA/gDQSmI8tr69A7fQlKriALK70SaR1fZomhZvUP7LEydxtxepE0Y+//pSqZ
 UbEGfzXIzCtoP5XWJkNilFrMeiK0K4Nlc
X-Google-Smtp-Source: AGHT+IHbP8/ULhovlLAB50UlA1UOlJmyqfCHPIenKy9pIu2kkvyEPYaxVNTEPJLa7/+8Wc/Hc0iPf+zLbIZPWSXGAwI=
X-Received: by 2002:a81:f101:0:b0:620:3c10:527a with SMTP id
 00721157ae682-63222b53693mr118049377b3.15.1718715358327; Tue, 18 Jun 2024
 05:55:58 -0700 (PDT)
MIME-Version: 1.0
Date: Tue, 18 Jun 2024 18:25:50 +0530
Message-ID: <CAFV=bv=hp9n8fCxxWjHn_wKQZHyAizDzVbSkVhvjNJSE_LrmEQ@mail.gmail.com>
To: lttng-dev@lists.lttng.org
Subject: [lttng-dev] Is it possible to disable recording the CPU id for USTs?
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
From: Aditya Kurdunkar via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Aditya Kurdunkar <adityakurdunkar2@gmail.com>
Content-Type: multipart/mixed; boundary="===============5895462166588085941=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--===============5895462166588085941==
Content-Type: multipart/alternative; boundary="000000000000673f17061b299a2d"

--000000000000673f17061b299a2d
Content-Type: text/plain; charset="UTF-8"

Hello,

Please bear with me if this is a naive question. I am working on an
embedded ARM chip (1GB ram, 2CPUs) where I want to collect trace events for
a long duration of time. From the research that I have done (mostly reading
papers on LTTng tracing, conference talks and documentation) I have seen it
mentioned that for ARM the overhead is greater because the system call to
get the CPU is quite slow. In my use case I am okay with not having  this
information. The current benchmarks show a 3 microsecond overhead of a
single tracepoint on ARM in comparison to 150ns on a x86 machine. Hence, my
question is: Is it possible to disable recording the CPU somehow? Any
suggestions for decreasing the overhead other than this are welcome.

Regards,
Aditya

--000000000000673f17061b299a2d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div><div>Hello, <br><br></div>Please bear with me if=
 this is a naive question. I am working on an embedded ARM chip (1GB ram, 2=
CPUs) where I want to collect trace events for a long duration of time. Fro=
m the research that I have done (mostly reading papers on LTTng  tracing, c=
onference talks and documentation) I have seen it mentioned that for ARM th=
e overhead is greater because the system call to get the CPU is quite slow.=
 In my use case I am okay with not having=C2=A0 this information. The curre=
nt benchmarks show a 3 microsecond overhead of a single tracepoint on ARM i=
n comparison to 150ns on a x86 machine. Hence, my question is: Is it possib=
le to disable recording the CPU somehow? Any suggestions for decreasing the=
 overhead other than this are welcome.<br><br></div>Regards,<br></div>Adity=
a <br></div>

--000000000000673f17061b299a2d--

--===============5895462166588085941==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============5895462166588085941==--
