Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [158.69.130.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98BF8C71157
	for <lttng-dev@archiver.kernel.org>; Tue, 17 Jun 2025 10:52:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4bM3bm0G0xz20F8
ARC-Seal: i=1; d=lists.lttng.org; s=arc1; a=rsa-sha256; cv=none; t=1750157542;
	b=ISwx/YIREbJZN3CCxnxfhPIb2CvcC6h5UP6nZkgPMcFnMdmUxsmqUfwnOIyJmEEldIQX
	 ogxox2bx9unBdrAkpgL97AJ8oP+AfQ9GgrooGdC+lJmAuc7so/EFMGn6Pe0jN+Z5Kc4FZ
	 2A8gjzykGn3Fz0VbTZuE5Dav4ICygBv5JEPvhZNug6Xypp9trBApTY65Xv0nMCj3vWYrI
	 W0pcZPDG9wWillLzHE3bda7HOvU+LTGml+ZQ2m9tgKQXTR5CnTBl28mfuBdJlRaZiS6ef
	 Q5tV5oCj9WZ+E8qcBtWyw/htCHHqFUXGmPrEBQPsZzCZJ45pgzmj7ojKefcAaoZ/46Q==
ARC-Message-Signature: i=1; d=lists.lttng.org; s=arc1; a=rsa-sha256;
	c=relaxed/simple; t=1750157542;
	h=DKIM-Signature:MIME-Version:Date:Message-ID:Subject:To:From:From;
	bh=8klI4Ak9yxdA1R6pA9QG1ARfVDLKQG/kUyJjbBYkn8U=;
	b=TcvKWAFQXVV0KyGwotwTVbL7Jk/kqQUq2taKrgVBYBByNnBDQbLBPNzOcFzNaUkTDYfp
	 E8XoNR/0Iyai9kzgd2rywsQz7SaZryuGAnJaK4RpaPRZRbzaw+QeNqZecrNCMktnqeZWc
	 IE+xn6Eg6Q8WGw/Ige9kweYivpfA5FOP0K+kgIDaD7UonuhJ1ViZ8EYY6V/tZCwDM9ug+
	 LPR1JuWGecJTmi8eiVbYCX27Ndok58g1+4hsDL7KxYWWCKyy9aM1KSeD/yeNPYNzPMy6L
	 VC9Nwt2kSoRioLOXqjt1IFs5Ptywg9wmZAXv1AkoGy9cVYxOIASHEtOFF1gjRT1srSg==
ARC-Authentication-Results: i=1; lists.lttng.org; arc=none smtp.remote-ip="::1"
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4bM3bm0G0xz20F8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1750157542;
	bh=8klI4Ak9yxdA1R6pA9QG1ARfVDLKQG/kUyJjbBYkn8U=;
	h=Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=WEJEPe9+lFz8PyGy5zGJjkEdEAOUBeSFh7HrqxqyTBgmiQIlmJXuOwNOMLtQqkhwt
	 LHX/QrfcC8X/4S40JtTJCf9OssFxPPrNeW30UQxkUCZKVHZ8yu8StoTXKl8xjQFjxW
	 aYKmtcwdl0Aza85B76oe/KO881PkaVNn+P7AN6ykcyZG5EJEqZOioVEqUCTX+AspF8
	 daaySO3sFqaqGQFTOyvAmdo6mUgBXogdX1VpISeNpYiRJjqMrFPTyHNZsfeBZ98NjS
	 neRP3+MoGhayQ4ws68ajgN06uGMQu9kWnh4iqx8zuYQUZ98kE1eBIrK3R1a6st9Ey/
	 kKPt0gvmQihxw==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4bM3bm0G0xz20F8;
	Tue, 17 Jun 2025 06:52:19 -0400 (EDT)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4bM3bj08Wrz20F6
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4bM3bj08Wrz20F6
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com
 [IPv6:2a00:1450:4864:20::22b])
 by lists.lttng.org (Postfix) with ESMTPS id 4bM3bj08Wrz20F6
 for <lttng-dev@lists.lttng.org>; Tue, 17 Jun 2025 06:52:16 -0400 (EDT)
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-32934448e8bso46520841fa.3
 for <lttng-dev@lists.lttng.org>; Tue, 17 Jun 2025 03:52:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750157534; x=1750762334;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8klI4Ak9yxdA1R6pA9QG1ARfVDLKQG/kUyJjbBYkn8U=;
 b=I/uSCO74uFxzS0l+ZcqOTvBGly1KtTT0vuJ9CxNZUVaVWps/BUS8pMKdqEcl76wS51
 1oGu27jO0HLPTMtvo7gw5GBWDXdTe7BnNTcLkie7xtW1GCk4fP8epK9kuUP0FDjAqpnx
 y5mpZIG5bErCS8P7WJA2gfI1OV3ucx9zEVT/FRAJjUer/05V+ObBX9ipcqW5js1TPhio
 /AmYvXbHXowjfbvOLu9hudyQgcY3YtIU+9e2/w+cYmMgRuaICh2yld18/lCCKrccG6q2
 HByEc3l6NZd2V41M/lh79k1NqT4z+skE9Rx3+V/hrS0gLZnhzstWZeUYNjiPrQmcN/4Q
 RUJw==
X-Gm-Message-State: AOJu0Yy3eT27fT1cJCxS2uSPi97urniJponrNvOFOK6v/JDpOXrntLD8
 zoTDMsP19yZ5vqGVZA6AYBSkzGBldQvhOqKNJ91JJyi2CcbivgQn40XkNxz4pfY9GDeCxyVJ4Q5
 Jvz7kyrpnLCZ2k8LpF743q+glPtHIbWCgMEK+
X-Gm-Gg: ASbGncus1TRpK7Vaxbj0Z5CuBrVQmuCOteINR1BtWubS6/ddzqsEs/en05fI36oZioV
 nRz7UdjUFJON9XUf9aSDAHL60GSBVmmLKLHGIQx0MNVFu73ELg7WiYAL++77HQ1bosIAfgq3Lr4
 xYvfUD4aB4vH4qSGgcD53dJtzduenkh4ME5aEh2YdgOEM=
X-Google-Smtp-Source: AGHT+IGvevHXXJ6vG6eieA4jD5mluq222XGEvdR1cAyruhql8jY3WVTZuU88YhC8y0CxMZVDQjoFHY631/op7o1u/nE=
X-Received: by 2002:a05:651c:4019:b0:32a:ee4e:56ad with SMTP id
 38308e7fff4ca-32b4a5b9218mr25534841fa.33.1750157533384; Tue, 17 Jun 2025
 03:52:13 -0700 (PDT)
MIME-Version: 1.0
Date: Tue, 17 Jun 2025 12:52:01 +0200
X-Gm-Features: AX0GCFvFlQSfLL7Q1wUP09N_11c3licvwRvAJ16RdjA1tGwOuy2NCI-UMjycPD4
Message-ID: <CADYdroMbjORvxZMZnNW=dZZsCvNhf9PEo9Bg2RYjN68ynwn-iA@mail.gmail.com>
Subject: Re: A question regarding isolated cpus and software interrupts
To: lttng-dev <lttng-dev@lists.lttng.org>
Cc: david.aldrich.ntml@gmail.com
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

Hello David,

You cant fully isolate a core in Linux, there are some timekeeping
functions that will always run (Linux needs some basic runtime
accounting).

The things you can do is avoiding IRQ handlers and "lazy" subsystems
that depend on background updates via timer or IPI. You already do
this via kernel parameters.
Maybe you can look at disabling membarrier too.

isolcpu just takes the core out of the scheduler, threads wont be
moved in or out automatically.

if you want to find out what causes the interrupts... use ftrace + kernelshark?

Norbert
