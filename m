Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [158.69.130.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05342C5B559
	for <lttng-dev@archiver.kernel.org>; Wed,  4 Jun 2025 16:22:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4bCCY50xcRz22BN
ARC-Seal: i=1; d=lists.lttng.org; s=arc1; a=rsa-sha256; cv=none; t=1749054169;
	b=G6eiAa8+iw29pydQVzrJVjK/pu3wGMtnq+j4dsToThHNSpijzMwybb03KIq4pot7NYVk
	 3cI73rNxipP00HNTTok7eOuN/jGePc6tnp63vKvPMYPTEppXsN6kLuoTINNwOCls/XcFW
	 vQ+QqJaUlgqRC18wqlXaGAxyIRHTGnUf0o66Xn3myTlw5v/ie0SdjgIuom2RL1FDmfDca
	 vj7e2yiawagmJh99BqyYQ59i/dcW4qny7Vg9Qv/79rqAigF2U72eofS8Sgsryl5c/mx+Q
	 5GiQzdHZn1hu8SbA3N3tTSVzi1f4cz+IjqipbuSc1GnQjRZysEVvyQz1W7lnwtMxflg==
ARC-Message-Signature: i=1; d=lists.lttng.org; s=arc1; a=rsa-sha256;
	c=relaxed/simple; t=1749054169;
	h=DKIM-Signature:MIME-Version:Date:Message-ID:Subject:To:From:From;
	bh=fqULIfSwIjB5iW4sCyYqHWVi9W+/0xnaN4Ki16ERc5E=;
	b=KjS9xCj5jKqZi1HWOf02rRIPaUHix7GwjfNc8dhS1dvwOVnK1glloaTXnoxhgRQYZ1ug
	 3ENZa1BUZKNkUx00DxxJpmwQSnyhIIB05HRYHSSvX5+F3fCafrBmex/S/ySARqRiFN7qb
	 bcJFl3xo3GM9vyP+XZpOhZzJAhvRI03W8oYtbD+X7FPHAeBoprnA+HdZIZbdCsDWFz0/q
	 NxR634W55ErrBFWBvjly4i9QJnLuyKHql0EyJNoL01pKGbhAsFPSIEBxOlZb29zByKAXs
	 54IMpYAHTPX1zQxXwWSYX90rX5cC/bhZhBdggNPhgzIfbw8Cef8B5F+bphEhOeZqEAg==
ARC-Authentication-Results: i=1; lists.lttng.org; arc=none smtp.remote-ip="::1"
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4bCCY50xcRz22BN
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1749054169;
	bh=fqULIfSwIjB5iW4sCyYqHWVi9W+/0xnaN4Ki16ERc5E=;
	h=References:In-Reply-To:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=lnO9396fXpsp1TZQoLJcAlx/fIrGK4ypgol2/FRtLV7iw0vO/ooS56F8KF+Gorzgx
	 c4X4WMH0RoOYy+RqHNqOWS86PcFXRdkaDD+smuwcMFnRqJSBXOAgls1mhxVJF7/tyf
	 dpDQpNt3R8ttLGilTefNxlWYXLPQLoSKidebeMgZDBakIvryEqrZVujb1fUsVpsq5k
	 n2ugB4KjPBiiyrftS7DEywHq9orwSzOn9ivYK6efC6IMvSlFVN2KvE6vLfOo9rK1NP
	 om0gPWCeWQfUPweAHDCnR7+wpXcmvs5aOi6qZXEAihB83EALYyscUv7SH9Zcv2o1+f
	 FValGpxrapGtQ==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4bCCY50xcRz22BN;
	Wed,  4 Jun 2025 12:22:49 -0400 (EDT)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4bCCY34kYhz22QF
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4bCCY34kYhz22QF
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com
 [IPv6:2607:f8b0:4864:20::b2b])
 by lists.lttng.org (Postfix) with ESMTPS id 4bCCY34kYhz22QF
 for <lttng-dev@lists.lttng.org>; Wed,  4 Jun 2025 12:22:47 -0400 (EDT)
Received: by mail-yb1-xb2b.google.com with SMTP id
 3f1490d57ef6-e81749142b3so54179276.3
 for <lttng-dev@lists.lttng.org>; Wed, 04 Jun 2025 09:22:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749054166; x=1749658966;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fqULIfSwIjB5iW4sCyYqHWVi9W+/0xnaN4Ki16ERc5E=;
 b=UciiMYflyVmGTLtqvpBmfQZWmR8SkuGGnyIgfwup8oMIiUjBEt17KZaz/2lmHw3rTt
 qxxdW8u2ULym7OqPD35db2wLYSaYsEt1kHNh1bSqYuve/AcDlEIsoGYoC+u/vQYqlRfm
 D6CxaRD164rJKmH86m+ClOh++4/ykFwTRb+d2Oo2cU73S6goN6gIdLNIKh/d1YxCYbWr
 ImFVzkaUVO672KSQNyg+bvh4Xu7PrGvNNU0pCQhcw1XR/vNpY/94jvRH1unMqmwjzdhQ
 JIDONxwzQ8iGv8FcFl6mSnKNuGtceIGMC7MbjMMOFGzg7AHRNlcYmJpHB9b+gI3k5aiV
 VYBQ==
X-Gm-Message-State: AOJu0YyD9kDsIDWwajPBuB4mMDaTGL0pJkS7ewQ1sOHB2ly2EY+LEG+o
 i1e9PR9oR1afHP9sSa4RsSr3QKkg93z/n4TmjF7BPcX3/OJ9+hzSUy40nC6QEogjGHCU+XHciFR
 zH05/1DiVc+HUWGb/5NFGF/Hq21Zske7rKa7W
X-Gm-Gg: ASbGncsHHjDvRUNpXWDBToFchaXWuVxS9UKDkrTVgLV13wbquXtSoE2UqTs74eLeOkb
 FASWf6USsFDOpSbyfdNzoHWvoaD/gN7vdtXF6SGqDp0Pcc1mL+KLW/2yHEXSn7/yeQiuML8SZWL
 iDklZ34NqQ0K7ep/cGPIYx0lg9kN4iwMcjr325nkdeINWG
X-Google-Smtp-Source: AGHT+IFOwmbiHEFmf4iQ4ugfYZWZKzQgk8sMdSgqGPDXRcPaeYcN8WFaJCwVdkfyOcXEG1wE8Ss8L75MuZBNav71ZWY=
X-Received: by 2002:a05:6902:1021:b0:e75:6409:aded with SMTP id
 3f1490d57ef6-e8179dd9932mr4684110276.39.1749054165942; Wed, 04 Jun 2025
 09:22:45 -0700 (PDT)
MIME-Version: 1.0
References: <CAJK_ieigCAaowdcwmLbkdL1J3eFgHE7t1W=ZKRvoKhgABM46yw@mail.gmail.com>
 <cc6438cc-1836-4983-8f09-c569ee2cf11d@efficios.com>
In-Reply-To: <cc6438cc-1836-4983-8f09-c569ee2cf11d@efficios.com>
Date: Wed, 4 Jun 2025 17:22:35 +0100
X-Gm-Features: AX0GCFvU4h87fFvNJU7c6qiHYVgyHIs1qS-HNQbOwXezPTVpgFYTQpUsuce3wWs
Message-ID: <CAJK_ieiG5yDoyg8TetipUJZNMhrpteZuY5CBv5eeUNE18AJq9Q@mail.gmail.com>
Subject: Re: Function tracing not working
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
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
From: David Aldrich via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: David Aldrich <david.aldrich.ntml@gmail.com>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

Hi Mathieu

> > Any idea what I am doing wrong please?
>
> AFAIK, the "LD_PRELOAD" environment variable is cleared by
> sudo when running its child process for security purposes.

Thanks for your answer, that does help. However, I have now adjusted
the code so that sudo is not required, but when I import the trace the
UST-CallStacks are still strikethrough.

Any thoughts why this is happening?

I don't see any runtime errors whether or not I specify the prefix:

LD_PRELOAD=liblttng-ust-cyg-profile.so

Is that expected?

Best regards, David
