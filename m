Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [158.69.130.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E9FEC71136
	for <lttng-dev@archiver.kernel.org>; Tue, 17 Jun 2025 14:15:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4bM86T6QTgz227n
ARC-Seal: i=1; d=lists.lttng.org; s=arc1; a=rsa-sha256; cv=none; t=1750169745;
	b=aeDi+KoRqmIsmF9aNFozZvmaBSK56+VaZTL2FuRHp5jFGLEx/qJ/3yW7dm5wIaSR/95J
	 Y/ml7kO0MVCNdHCf8KtWoLSR355bffVEYDKVh9bQaWe3JGEVOSsNdYHOwXPWkGuIbaQBB
	 OZbuFCWBA73mvdh+rURyEe7p+3ZoEv9aozFtL0Wr7QEalimkQzPj/P/7jibp4xEGz95br
	 G/qgAr8HMk0FE8IQYSK6EMvjgyRRpsrrlNtZHpE2zUUngBGDZTLnG4CzyQgITLjHhkRrR
	 9x1hpHVt0mYXwwoty8JBp+9u4AvoBGtDFqp28s/bjGEJNZIXwWZjiCweL4+9EuSfo1A==
ARC-Message-Signature: i=1; d=lists.lttng.org; s=arc1; a=rsa-sha256;
	c=relaxed/simple; t=1750169745;
	h=DKIM-Signature:MIME-Version:Date:Message-ID:Subject:To:From:From;
	bh=297uADFsADJ2iprvnAfu/mMNwzk6rstPMZGiDcGMn4M=;
	b=pdxS7TSmHHtA+KzbKbKIJdM7ZkF4vly710APKbxVLncxFbME1OQTbGrW2rcDo3YMM9IN
	 BdB2uLQ91176guZg6/xYh8uMnq/RAkvZxC+LYYRvCO/0ThsfEX/o8uFbpyqjQf0cMBdSg
	 dr2XlNAJEBDnNlx5qq2Bq0InU11iN2NTPnbtioOff0ePMoR7v9A6BFfCKXgNxlBZ0/wrZ
	 jW18fiOyew/Ln/j0UayNqFGNgWYDl3izQdpk2lEh6QlXlGv6FoOuQxZPIbE9nSQl2J7Is
	 R7Vy35j1qokuaXc9Di1CG/GZtxr8Kd0rkHyuLL8h2oCSdUn53/omgtW32gj1Ob4aNWQ==
ARC-Authentication-Results: i=1; lists.lttng.org; arc=none smtp.remote-ip="::1"
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4bM86T6QTgz227n
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1750169745;
	bh=297uADFsADJ2iprvnAfu/mMNwzk6rstPMZGiDcGMn4M=;
	h=Date:Subject:To:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=yKNtV+B9OUxQaO8ZDJx7+dnidZQKckUwondA8T90iZT7GQW0RGP9cEmbkp5fZZce9
	 31SLiTP9VD2HCA4ZsWVZUvbci2doOIsYd5HvoT8hcsYqushG5cBTxZfkbIj+iaNaKm
	 1lwWfj2nu8jJtYRz9ah4uYIhfjQns+xcJvsmS7MObGzYzHIcG/8MJiYbPE65uACSlr
	 a27p4gHjIsyIzy68A9jUAC+Nj/sJMZevljP6Pg/kg2bv4eqDArnKw3A/Zgaxh7jKxE
	 R5U0h0L1VzUHbcvOkue6dvlTYN/NCPgarOKOpDlG64O6gJyl1P1b3gzbJAookDjAQX
	 SQUPjeJLgmEPw==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4bM86T6QTgz227n;
	Tue, 17 Jun 2025 10:15:45 -0400 (EDT)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4bM86S4Ppzz227l
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4bM86S4Ppzz227l
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com
 [IPv6:2a00:1450:4864:20::236])
 by lists.lttng.org (Postfix) with ESMTPS id 4bM86S4Ppzz227l
 for <lttng-dev@lists.lttng.org>; Tue, 17 Jun 2025 10:15:44 -0400 (EDT)
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-32b4876dfecso34136711fa.1
 for <lttng-dev@lists.lttng.org>; Tue, 17 Jun 2025 07:15:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750169742; x=1750774542;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=i04wSjGHjcVVTTAxKlDNqX/bPl/g3ssHSdaASDt6duY=;
 b=h8+aTLYGTffQbOXGiYIfz/yMVipAIimkYhNFeGVJC/olyj2BB5Rl1aMbaYJ/GO6an2
 vytdViwsD9atoVAoDym9oY0mJ56x3lSMsNHee10OX7OyDCFU73VgNMTVUmARO4HccdAV
 IEzlQ8G4CFM0us9FSUFykWyn0qODXG9R0x0uwKlEq1rmE0sdWsM3VArNcGvA+yq0dwX9
 Izt1XPXG+g5WzpVxvdRPrtD+jnpsie2i1rVxCraJLNQ6itJVkvzHXfGM3cKR9l5SJMT4
 tOPEZlumMeVxf8cWQfPC5CRF0wpzCq8PHxVsEkPlr5bWLN5vAJc+Ff3BWflwTcsJyxc/
 vjkQ==
X-Gm-Message-State: AOJu0Yyi0OEEXppqP/n5rktQtIKDQJW2IA4atKGTXozVwnzl642XpeiJ
 uQLDR6FfwEXj2X+ESylyRBZjvSxBvY9sMIMhlqr62Jw9XemjVeLvrs6stvCiNs5V04e8F+OOhEj
 1xY4bKnMcGJgOfS+DxsNszvJsgZvCe8wTlMSI
X-Gm-Gg: ASbGncuyIjQoolIP1PGKxBZgXW8xzSiG42bamgJCcRWCje/AvQroviSSfiV2Pgqzfwx
 SdBgLXP3OmLlWlsLWVDjL+K5Iab9YPsksQnFHfRRXNaSChIHJyiFKKwoR0e2sHdYGIzj9XBmTVc
 0gc6/d8K8KTFyGiuwjWnsFtk4neVagtY1RwWWcKzNjHS8=
X-Google-Smtp-Source: AGHT+IEdTPGxEo5m4x6ycjjnVX7mmuL09M06a7IwQaHJCU38Y5JgqUIRyP6WBr5guRudUhEsNlPDBzvvO2Rk6wjFpXU=
X-Received: by 2002:a2e:a9a1:0:b0:32b:4521:73d1 with SMTP id
 38308e7fff4ca-32b4952cf8fmr39489761fa.20.1750169741953; Tue, 17 Jun 2025
 07:15:41 -0700 (PDT)
MIME-Version: 1.0
Date: Tue, 17 Jun 2025 16:15:30 +0200
X-Gm-Features: AX0GCFts1fQmDGDtZ4IpdOKiHdBQn_yFI6G-7OiRMQ_dcjhgBxzlGgK8ORQ-h7U
Message-ID: <CADYdroM27zgM1RWHoCocru7VY6kHi1=g3PK4QJ0D67Wra1tc8A@mail.gmail.com>
Subject: lttng-tools-2.14.0-rc1: fails to compile with libxml2-2.14.4
To: lttng-dev <lttng-dev@lists.lttng.org>
Content-Type: text/plain; charset="UTF-8"
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
From: Norbert Lange via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Norbert Lange <nolange79@gmail.com>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

/tmp/dev_develop_libxml2/usr/include/libxml2/libxml/encoding.h:173:7:
note: declared here
  173 |     } input XML_DEPRECATED_MEMBER;
      |       ^~~~~
../../../src/common/config/session-config.cpp:297:75: error: no match
for call to '(_xmlCharEncodingHandler::<unnamed union>) (xmlChar*&,
int*, const xmlChar*, int*)'
  297 |  ret = handler->input(out_str, &out_len, (const xmlChar *)
in_str, &in_len);
      |
           ^

Changing the call to handler->input.legacyFunc seems to fix it.

Also lttng seems to need libxml2, but doesnt add the necessary flags.

Regards, Norbert
