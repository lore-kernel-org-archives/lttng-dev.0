Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [158.69.130.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CE57C3ABC6
	for <lttng-dev@archiver.kernel.org>; Thu,  8 May 2025 21:30:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4Ztlfx6PH5z1qyd
ARC-Seal: i=1; d=lists.lttng.org; s=arc1; a=rsa-sha256; cv=none; t=1746739851;
	b=NSWbMtppqA6ftTMzzK1PCfFZp9A49W9HwL8RST/+HWc+aDvBzGnkSsYZRe0hYjhYACxJ
	 Vd/ASgf0OmgmWtghUGptZ7Q68Nm+D/neywIaal6w8UaxgK0xpf62M0BgTFT5qpe8XzR4V
	 TiHvb6nr+d62P193BZGC8oYHsgkPHil09Qe5JdcRPvlRLbOjsGNx5z6aZTtakfVanI5w3
	 PLO9yj14k/NyEb2vrwBaWr8/qjyvJlRmIwyTprjmKbmHJWfsdJseKmh1jB3x/ddy2SMUw
	 OEEDsoKyIyys9NvcLBrgiFTb1pYE7G/voKkp5XmuPF/6LtSySZqT9DHanUwAzPUo2Tw==
ARC-Message-Signature: i=1; d=lists.lttng.org; s=arc1; a=rsa-sha256;
	c=relaxed/simple; t=1746739851;
	h=DKIM-Signature:MIME-Version:Date:Message-ID:Subject:To:From:From;
	bh=1Ei5uPLrNdJbr800lZVeZkpNH6M5k3FSgv8aRyzwFUM=;
	b=eebr8jdCtp3UPS9NTw50+pwT11MZE2is2CcPjMHB94a4fpKW1lcBE/SXwJgyP/ysDq+B
	 eAynfa8gH2IkuKE1c5bVdEIfyC458q1sYm8NtMsVFZMdQjyo3ZZe1ct/GcPdplNYlEE2k
	 96EXtON1WHeuGW+ptoUSX+YKEF5YS7pL/+9Im85jc+UtjcG6ljGrgUAasStQUz56MfCEV
	 D3fIqSgZAjqIdSYH+c+/j6NgBmQRMhyVRSaBwMghcmQmrNNNHzGuP5Bc2NUQQqrDTrxPH
	 6cqzBlhT39qpQGFaFgi963Hl6uePkkVbkiCC4nUoy2Tkf1KZ26nRof/0qv3q9ZAA38Q==
ARC-Authentication-Results: i=1; lists.lttng.org; arc=none smtp.remote-ip="::1"
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4Ztlfx6PH5z1qyd
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1746739851;
	bh=1Ei5uPLrNdJbr800lZVeZkpNH6M5k3FSgv8aRyzwFUM=;
	h=References:In-Reply-To:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=mvQG7oAQ6uQ5GqgDGzUNjbUIadzX2G8s89rdn1P28iORWW+Ne12aJk9v+4FbLgYiU
	 UYOrr1dI4/eYXkD9Dfh0hG6oVNUD52hf5b+7IwyxA3ZIRmdg8VlJ6pON8lfTSkVFa2
	 8NY1/qOLyHS2IU86HKL9AwvkLc/KI9eBWOSWFAWax3B8U46sYebClkhPyyV5t+OqY6
	 htzU93AUjldq+e+P/5lqbunKm73Lh7utX4FiDyzi5o4MgoUujys2PJh6V9r/gyPcWo
	 nxXtbjpMnzp0b926Tc5sDdTQljLR1R/XcszHYrXjhdl203lp4Ck3aoNzOxj2OxHlha
	 4EVCk5C7jwF2w==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4Ztlfx6PH5z1qyd;
	Thu,  8 May 2025 17:30:49 -0400 (EDT)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4ZtdjG6zrKz1lsZ
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4ZtdjG6zrKz1lsZ
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com
 [IPv6:2607:f8b0:4864:20::b2d])
 by lists.lttng.org (Postfix) with ESMTPS id 4ZtdjG6zrKz1lsZ
 for <lttng-dev@lists.lttng.org>; Thu,  8 May 2025 13:02:26 -0400 (EDT)
Received: by mail-yb1-xb2d.google.com with SMTP id
 3f1490d57ef6-e78e6396d36so922486276.3
 for <lttng-dev@lists.lttng.org>; Thu, 08 May 2025 10:02:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746723745; x=1747328545;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qtmTYOERDTuEtvB4uUBK3X57/+xnTW7KlxJQMAJDjec=;
 b=i8gBca2xtCyVQX23e//EYbIDN7w/MRC7iMeTXhtRNV+bqHQ+oX976xmqflIQxhaV7u
 gdJmGoPEOcLxKysfYpsv3GBYUN++lpa/XXlC6/J78OVZ3bPpTtdti96m1AFuvTHzn09P
 RYjHfxAzCq3dbLfFxcrmtm/gbNH7eqCFWdU6eoNaBZL5f1KO6DeGK0aJRpyTWrOLTAkA
 ucum1/kbn8dejVB96xvkE6s9oT2/eKCFmfksPT/IAU/vAs5HMtFyxFYMlSAhO4wzkdyq
 0k50OWx/rjGgMD1vMtWnHDs5Xz2JaGLUIGD5zuEF88gkgNDwPSKG4jlg0c0Xw5djpsfw
 l0qg==
X-Gm-Message-State: AOJu0Yx4EhjzW0rVD20RQGu+AL6IYHqcrZftuBCdM8lSEAzn8tHegZW8
 vFs62gTmXpm8AQ9JGV/oUt+kdHXSN6KNYVergRItuRaqQarzNgf9lZ4JSVJnPDKbwYGOVzYV4nh
 +hEHeg33xkiQHgsvA3HDz7awQJYM=
X-Gm-Gg: ASbGncuI2bp8NDu10l7lfDx/lmlF+ss4F5X7ZAGcKxKnEGURvhY39e7m2stsX+ahQwg
 euhm2oKDsviTm2qXSRfnWG5RZHrAIAafCo9i//5/8QyIr/uGcgVuHIerLLDocd6NVOgrSaxTJRG
 mLtzTsf/KvxMe9GgQQ70+g3E8S2e+W2Im52g==
X-Google-Smtp-Source: AGHT+IHpzwXf6SSeBzgOuHYGz8QPu9xRh1fm6nLhyazk+7gbmK8/3UTcCIaXsCDaj4FMIc6wa/Au5NbhPucnHNu2aT4=
X-Received: by 2002:a05:6902:2490:b0:e73:11a0:4b7c with SMTP id
 3f1490d57ef6-e78fdba6f70mr266110276.4.1746723745059; Thu, 08 May 2025
 10:02:25 -0700 (PDT)
MIME-Version: 1.0
References: <CAJK_iejrz-U0-XK1hmoH9=TCLcErZTVE16XdyKzXX0buJuuoCQ@mail.gmail.com>
 <90aac2a4-0a4f-4d2a-a90f-c96c9be820af@efficios.com>
In-Reply-To: <90aac2a4-0a4f-4d2a-a90f-c96c9be820af@efficios.com>
Date: Thu, 8 May 2025 18:02:12 +0100
X-Gm-Features: ATxdqUHVK2QVn1-2E_5iK9UsJn9qR5krnPklYTpAZf7ES6nUAJKkPQR9_fKkSnc
Message-ID: <CAJK_ieibZJjJus6PdOnWAiLFOymm6D8AmkG3vdpDnuazG1wAbA@mail.gmail.com>
Subject: Re: Not capturing ust events
To: Kienan Stewart <kstewart@efficios.com>
Cc: lttng-dev@lists.lttng.org
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Thu, 08 May 2025 17:30:47 -0400
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

Hi Kienan

Thanks very much for your reply. I can now capture UST events. (My
actual problem was that I was not linking to lttng-ust).

I am now using the method you described:

> lttng create my_proj
> lttng enable-event --userspace 'lttng_ust_tracef:*'
> lttng start
> ./my_app
> lttng stop
> lttng view # [Optional]

This works and captures UST events but I am not capturing Kernel
events.  My reason for running this experiment is that occasionally
our application shows glitches where a task takes longer than
expected. So I want to see what happens in that occurrence - perhaps
an ISR is running or something like that. So I assume that I need to
capture Kernel and UST events.

Can you please advise me why Kernel events aren't being captured?

Best regards
David
