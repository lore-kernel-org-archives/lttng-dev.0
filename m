Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [158.69.130.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3BC9C71157
	for <lttng-dev@archiver.kernel.org>; Tue, 17 Jun 2025 14:18:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4bM89x6S8Kz21x6
ARC-Seal: i=1; d=lists.lttng.org; s=arc1; a=rsa-sha256; cv=none; t=1750169925;
	b=gLLSNgkX39Qs2dzSb/ogISJW5wgRW8w8Aw6ggVi6In6alfEqtm4qAs+YQJR7UBTZ6mP8
	 1Gv9R8SOSRd6Y1goYDvUeW2HGH8+CNR78z4FHeHGRW3DtaqjDOsaEGpjocnE+NsY8PGJv
	 echdttUZfOpj0EBf4FjMauqZHZaGIh6MUqt5IfwGZvBk9vq51fjqXFvlOV+WnLKEXW7Rm
	 GcL/oz9tNGfcoYb3/E+Y6h10NRmG5mTPWHqkHnnlQ8rD/c0QGQFtigzd0BurtLD8VoGvX
	 pHP9a53b30D4PUJ+PV8TKURJ/gxVpzeiMVMhxj5Ff3unvcwDOv25Qb3eLMWcpg5tvKQ==
ARC-Message-Signature: i=1; d=lists.lttng.org; s=arc1; a=rsa-sha256;
	c=relaxed/simple; t=1750169925;
	h=DKIM-Signature:MIME-Version:Date:Message-ID:Subject:To:From:From;
	bh=GkshL4c2bGXfWYMNuZl/l1B6e7+mMUywsIoFtVSMQRY=;
	b=CVv/AkXwC/e37hdHxjd1MLwvE7P2V16TuXUNCly5eVuKnv+ZLIRmyy+K5xie07Vm/35Z
	 +6oHoLV+eH73s/CwLgtYhdgOnsbIW5+KilVMbM1z4X7xA1z29JUI71rOUZqq1ndhDn2Bm
	 Lhj4SqSrSV0bvni7f9ujcqd+Swns8xtjYIk6AtxIoKfIYR3H1VEpUywLsu7ii82rdxC4+
	 oxdRtTDV7hMdB7zrtjx+i5JILqXS25XIlRuFkXGNsTxmk0ijpi4pXJbD1Hio1sHvfCGFv
	 0AmgJrXUJ62iAocieqzgg0f8JZVh+faxFfOCEB2s4EYUUpuQDxZpwOPWpNyojYA5D6Q==
ARC-Authentication-Results: i=1; lists.lttng.org; arc=none smtp.remote-ip="::1"
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4bM89x6S8Kz21x6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1750169925;
	bh=GkshL4c2bGXfWYMNuZl/l1B6e7+mMUywsIoFtVSMQRY=;
	h=References:In-Reply-To:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=yEzTj/+8nIE9DY6kjHoid1pj3x+s4v8REOyBNVpPsw17nKqlEgpH9dr0qdJbQ9VRM
	 szZsXkzitIqEpcHpFvM2e5jVwV1V3Ip8D/A3wIDEAa59uHHWZSohFNGHkFZQP2Ld3y
	 sBftwjJw04feVG2TZm11e84qe7TWjGmOqkwvU5M2oKyX69TI1iISUe6YHGGNam7rAj
	 g+ibzFBVKCH//Kh9n7rsAyX0MFyawew6rJ1ZKQi4+glQ8uz8qoxlN9l0sEMgNmXo/0
	 cseww0U3qRxVWJsx74o2U6uYlyzlnOi8rMiB0ioc6codjPHQ+EoZzb6vPMBadN44St
	 yh3RVtiXUz5oQ==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4bM89x6S8Kz21x6;
	Tue, 17 Jun 2025 10:18:45 -0400 (EDT)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4bM89x0KWVz21x5
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4bM89x0KWVz21x5
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com
 [IPv6:2a00:1450:4864:20::12b])
 by lists.lttng.org (Postfix) with ESMTPS id 4bM89x0KWVz21x5
 for <lttng-dev@lists.lttng.org>; Tue, 17 Jun 2025 10:18:44 -0400 (EDT)
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-553bcba4ff8so2752604e87.2
 for <lttng-dev@lists.lttng.org>; Tue, 17 Jun 2025 07:18:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750169923; x=1750774723;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GkshL4c2bGXfWYMNuZl/l1B6e7+mMUywsIoFtVSMQRY=;
 b=Pbt0qb20d7hrUFX03FNbMfytEFlD+d8oSYyQ3ENIOFQQwP5bFe5DFkmbnZ+tLRb+nD
 DslaERJB+J/0IzAf3WwaoTDZWNVKYKGTET2b9owsT0a8pAsAYmO3Z3GRsHUSmPJIzvuf
 LTNE+ZbxSOsRtaaBhzWVfWOYJBLUueeiakszyplPMFMqgqaz3/X5Cyy5MCYfK4aEBPCD
 2qGgYqhSussYdnYLXxeMWtb63D8Ud/cuhdud3329BhyZU6dbH3pELHdI++x0n0sFaKlH
 riaemuxy2Uz+FB3qccl+eLro16mmAObZGhXgNEvPIh7B5E2rM9fKEzeUH3seKNboPmTE
 BYJA==
X-Gm-Message-State: AOJu0YzfvLWMknPGdH0MB7fGcCmlfphRKN8pPIbm4OjpoaZOAWo9sL1Q
 s298kmm7EXoZaJUn0P7JD3UMPcBTPdR3LBkWrATevVVVEf9qTexfJjZ1qt2O0PrJJt0okj1gHIr
 +3O2QfxeHBNKuJwielEaILIiamKmrQq6JscvJ
X-Gm-Gg: ASbGncvIXHwKEuXVtuO+nhwFLp4QqEEgxQLbiy0idFxjk0TWd0c9Aq3kvULHPxEdWCp
 naK9d5ljtdm+dSaPTuZhw7AV4sTZwftfPSFBXjmvr7WkPhpRqgtI6MqNjeMcRc0yKDrMfUe4ecj
 rNmKOqFVeU0aNurMG8eKjys7y/we9incNl1CkGByglu+0=
X-Google-Smtp-Source: AGHT+IHLK3JLGjS573wgp5uYWZpipsorWmIfm4m0rscAyRgBVFBUC+g2Md1WvFuMstWMdXyPDH0D5IBz4o1xqpulRHM=
X-Received: by 2002:a05:6512:15a4:b0:553:50c6:b86c with SMTP id
 2adb3069b0e04-553b6f6b5ebmr3606014e87.57.1750169922862; Tue, 17 Jun 2025
 07:18:42 -0700 (PDT)
MIME-Version: 1.0
References: <CADYdroN6cD9sLE-8QMqFQiVB=RzPFav8owkuihZ-o7JxyK5uuQ@mail.gmail.com>
 <52a0f346-47d4-454a-8696-c5f0be73b43b@efficios.com>
In-Reply-To: <52a0f346-47d4-454a-8696-c5f0be73b43b@efficios.com>
Date: Tue, 17 Jun 2025 16:18:31 +0200
X-Gm-Features: AX0GCFvliKYOCS-zjN6Sftf7xzBQFonCYnbx5q6Fa1Z75xbagzxHCz3i2IcxKF8
Message-ID: <CADYdroPaw5bMAinD203xd3mOO001izA==UDu+C1Jso32jFAEOQ@mail.gmail.com>
Subject: Re: lttng-tools-2.14.0-rc1: Not possible to disable babeltrace2
 dependency
To: Kienan Stewart <kstewart@efficios.com>
Cc: lttng-dev@lists.lttng.org
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

Am Di., 17. Juni 2025 um 16:13 Uhr schrieb Kienan Stewart via
lttng-dev <lttng-dev@lists.lttng.org>:
>
> Hi Norbert,
>
> could you describe more about the context of the system you were
> building on, and which version of babeltrace you had installed?
>
> thanks,
> kienan
>
> On 6/17/25 6:54 AM, Norbert Lange via lttng-dev wrote:
> > Hello,
> >
> > I had to add babeltrace2_CFLAGS="-DA" babeltrace2_LIBS="-lm" to the
> > configure line
> > to be able to build.
> >
> > There should be a --without-babeltrace2 switch and possible automatic detection.
> >
> > Regards, Norbert

Its a crosstool-ng toolchain based on gcc 10.5.
There is NO babeltrace2 available, and that is what is not handled, I
have to define babeltrace2_CFLAGS and babeltrace2_LIBS to make it
through the checks.

Regards, Norbert
