Return-Path: <bounce+b7b410.602323-lttng-dev=archiver.kernel.org@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from m43-8.mailgun.net (m43-8.mailgun.net [69.72.43.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B3B1D216A3
	for <lttng-dev@archiver.kernel.org>; Thu,  4 Dec 2025 16:01:24 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=lists.lttng.org; q=dns/txt; s=mx; t=1764864083; x=1764871283;
 h=Sender: Sender: Reply-To: From: From: List-Subscribe: List-Help: List-Post: List-Archive: List-Unsubscribe: List-Id: Content-Transfer-Encoding: Content-Type: Cc: To: To: Subject: Subject: Message-ID: Date: In-Reply-To: References: MIME-Version;
 bh=Yx8Uu7SJ6BGa6AyNeIaOb3YJBHI/oxEMZWcAyuuW4do=;
 b=qKaNU6x5jfBsQPmo4P46lc96jdmJT0bPRMkhkm0bQuf6iKtqLnlPLkGOxqVijBf11t2L6zOXpB6n2dl8AY3NhG0nXuHlzULOxkJ3fonBoBoFz961mAIH5lMP8qk/rEQG9Q/gv3t14TRKgLy/0seF20gfY7zQDZMnuyPKF13Mj+XZScXwukGug0TUg6mEPlqEDtqA+CpG2//+mbgqhTrWdY/zVL8MytQHlYPea/SByHvCeLfc/tCEEDxPC0rY6t3YJbz/Go9Q1NGqWXCRoBFbOTe+aDJ2GgcWioeIKcQDY3MNfRnxPn/buMsxNgnSQvid5pTYvN/1L86ZxVzQ1XvSMQ==
X-Mailgun-Sid: WyJlYzgxZCIsImx0dG5nLWRldkBhcmNoaXZlci5rZXJuZWwub3JnIiwiNjAyMzIzIl0=
Received: from lists.lttng.org (lists.lttng.org [158.69.130.29]) by
 68aa2f30bc252b384e219dbbdaf35f0a0909c1c2be94a0f22848bde4adf9428a with SMTP id
 6931b048d6d262beba9ae60c (version=TLS1.3, cipher=TLS_AES_128_GCM_SHA256);
 Thu, 04 Dec 2025 16:01:12 GMT
X-Mailgun-Sending-Ip: 69.72.43.8
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4dMfPg6XLBz10nX
ARC-Seal: i=1; d=lists.lttng.org; s=arc1; a=rsa-sha256; cv=none; t=1764864071;
	b=JD0zjR0x7jN2hStifTIXVtoB5HzsYkpxFssaKS+rl0WzVMbVFNpWJN6JPbMbX+dRj0qL
	 oPwXcXoAGlQ1jp7Qiyb7zWmBlUtvJk9Z0OWPt809WP+He/SOE0m/rskAXPpzjZ5Abe4wG
	 DTfyCjNsbn3pIvF3u/MmZx3Xzf7XvItap8jyQqoeYaJrXOlvMnboKnQ5WK5MeJxYfdjkb
	 VZotLgkO/d9iJeumJzUPgmn/AOcfB4RRkvivlA05g6bO5j4LqRn/2SrrgeZ+LxqcP3An3
	 T01d/jwvtO/7AHfm5jB0HbBCnkLiUywiXxQhk0OgVhAzYQpT91IwNmv/OQ4AUkABrdQ==
ARC-Message-Signature: i=1; d=lists.lttng.org; s=arc1; a=rsa-sha256;
	c=relaxed/simple; t=1764864071;
	h=DKIM-Signature:MIME-Version:Date:Message-ID:Subject:To:From:From;
	bh=Yx8Uu7SJ6BGa6AyNeIaOb3YJBHI/oxEMZWcAyuuW4do=;
	b=ewzwHtNIy8cQXz9DdwcCjOq0T+4Af33oV0K4ssSVWpsxEskwlgi5XJ7yhaIDQGb9gIY6
	 +D3BWx/HOopAPCpzsaprcmAXA89GGPp4ZT0ghdJ2YcAluCrjL5PJ2mFIwbqSWGYGMW38u
	 3RQS6nQwwcdHsgQCtMXmIANiumR/hm/m0aHaq+0K5bxaevfHhYCxqrSb6PTy7BwWrIf1D
	 dlAPcv297U7Zgc+CBONBDFBZKZ+uuBvmNSMCM1mu+iEc9vvtVB3ReHUh/oCLuK8UfrYOp
	 hsLYaFO6u/Kb/kA+qvslvZREgi1H2FFX+4L2hpWVI66s6BhNFo/pj0HxpjFju4gL3zg==
ARC-Authentication-Results: i=1; lists.lttng.org; arc=none smtp.remote-ip="::1"
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4dMfPg6XLBz10nX
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1764864071;
	bh=Yx8Uu7SJ6BGa6AyNeIaOb3YJBHI/oxEMZWcAyuuW4do=;
	h=References:In-Reply-To:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=Kgd/bF+5POm4fzVEE6uMg4N0lZKkULrhwlfgFv6B7iBw5yrAk2LVtR3koa3BZC3gU
	 yPOytFsyfyHrmeTdYDKlODMvsOhcYU/1y9Qm2Fq27gvno+qd8oevtusfshVD5o7uDN
	 fNJ4b7qnxdas73n7ZMHvyfoX69R+dn6xwgTC+4zYNm4KPCIL3Ps1HBj29Cv+TBn55+
	 9ZR/ZLKMqfQzpPZgmYntlajWOJwl7Hf8uHlHVi5wFZNeAPDl7QQGKEFPLbzK0d9knk
	 d4mF53Cf42f7v+xtqivYAVypbp4qbu+N3SbSGo8p3zY+tEWnmOQ8MWSfRCt/SLOsBh
	 fEeuT+d7QkDpQ==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4dMfPg6XLBz10nX;
	Thu,  4 Dec 2025 11:01:11 -0500 (EST)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4dMfPf45T7z113M
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4dMfPf45T7z113M
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com
 [IPv6:2a00:1450:4864:20::12d])
 by lists.lttng.org (Postfix) with ESMTPS id 4dMfPf45T7z113M
 for <lttng-dev@lists.lttng.org>; Thu,  4 Dec 2025 11:01:10 -0500 (EST)
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-594285c6509so1166137e87.0
 for <lttng-dev@lists.lttng.org>; Thu, 04 Dec 2025 08:01:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764864069; x=1765468869;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Yx8Uu7SJ6BGa6AyNeIaOb3YJBHI/oxEMZWcAyuuW4do=;
 b=kDEbN+liaitaFgMFZgdquuSIg6Axiyz1fTQj/MjUwva14r59RW/KwwYCnXXBHGehXp
 cTQdjCmZq8qd42T2ADlWPkPqj5m6JgnN4QzfAhY05nHDQMiEz5nuhIjgWcb9cDvmBcT5
 3rNs/P2aw6csHYIcBIvuKve3nSp7Chc4OAWij9s5g2w871bcsR7NmodswA0ygeotx05Z
 tyKLMYoM0gz4vaMmTiuBkAyL765391GqdWDehd9OGk9qPuwPBi3/L+o/deRJHvn2Mt5o
 EfamT+XEeOqT1reh7F6DBD1eJfz6W/3EM5qkfqftDENgDpjrBRPFKu+3Mvj8AZ3mxis9
 yazA==
X-Gm-Message-State: AOJu0YxBGozQBZEXZ+L4/t/Hl+Ho4L8cikhmEpWnJcldbR+VaAfKI/Sa
 MD5wO+aC4HdVdSm4MMJge8Ytd36zt9esobcJSapNVAZyUBoW8UGNdt5nKrlFf4hKwpmhzgbNpTM
 +SDOtcCiokMGCxNdRXQgVB3iYNmZ0ICg=
X-Gm-Gg: ASbGncs4W7/Fq3pHuHNfX20erEukQxmYtEw+YfcPZMo5t0+TDc5TO8PfhEvbe6QV3FD
 z0S7Y8QkiGqejczKxA5nx3za5dl9RmpM8b1IK3jRm5JVWUs+Yo+7XRbd49ZwVBcAjSRd0m2yLco
 JtTZ22MmyvNAeuPp6iyIcmAP1UReNJrRfp+6DcWL0INCycAYfN6NDn27JS4bsfDUwVsLHqL7M6Q
 0g4++N509VuuJTUFHNL5lOCDMJwzRL1UGuFijZU1YzmvSZ2bbONK1xkoe2/UIBp+vveMqAakDdW
 Wolpsg==
X-Google-Smtp-Source: AGHT+IH8FT1fekoSVNSjPKPrV0djFju1+Ivruh+HAlH5iRUZ+QVhlNmFzHLoshKsoRs+dJplXwTO53gl7Uks4qVffUk=
X-Received: by 2002:a05:6512:10cc:b0:595:7e2d:9889 with SMTP id
 2adb3069b0e04-597d3f01804mr2440786e87.1.1764864068096; Thu, 04 Dec 2025
 08:01:08 -0800 (PST)
MIME-Version: 1.0
References: <ea1ffe7eed8afeed551e52e1d6dcac5d8e244c0b.camel@siemens.com>
 <CAB4xu_3fbK=-+B1=oo5oLk7jXVZgBEQjr99N6jpygX0SkuxAfA@mail.gmail.com>
 <6407e79bb0b5bc49f73b200d9a5f40eef14e70af.camel@siemens.com>
In-Reply-To: <6407e79bb0b5bc49f73b200d9a5f40eef14e70af.camel@siemens.com>
Date: Thu, 4 Dec 2025 11:01:05 -0500
X-Gm-Features: AWmQ_bmXRo4NF6CcvYXjNS7UyGLrN-1V1vgX2R-K97HgOnUEsTWNIN8EqkI8eE8
Message-ID: <CAB4xu_3+ve5iusvBMPhN2cv9K7N-r4qwa92k4RrFT_WNMPqi4w@mail.gmail.com>
Subject: Re: babeltrace | sink.ctf.fs escaping of struct member names
To: "MOESSBAUER, Felix" <felix.moessbauer@siemens.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>, "Kiszka,
 Jan" <jan.kiszka@siemens.com>, 
 "Poljakow, Andre" <andre.poljakow@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
From: Philippe Proulx via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Philippe Proulx <eeppeliteloop@gmail.com>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

On Thu, Dec 4, 2025 at 10:47=E2=80=AFAM MOESSBAUER, Felix
<felix.moessbauer@siemens.com> wrote:
>
> Well... This is a more generic question if it is really the job of the
> serializer to fix possible name clashes in the output. Anyways,
> unfortunately LTTng uses this field and does not allow escaping.

Although I understand the question, I will not take the time to
re-evaluate a design that involves CTF 1.8. I'm currently in a "quick
fixes only" mode for this format, with the sole aim of keeping existing
scenarios working.

> I would love to switch to CTF2, however we need support for it in
> trace-compass, which AFAIK is not even implemented yet.

We're currently investigating the status of CTF 2 support in Trace
Compass and what amount of work is remaining. We'll let you know.

> This is tricky, as we don't really know if the trace is an LTTng trace
> or not. However, we can hide it behind the proposed create-lttng-index
> flag, as it is anyways only needed in combination with an index (I
> still don't know why, but ok...).

Yes we know. Have a look at make_lttng_trace_path_rel().

`create-lttng-index` would be another hint, but the trace environment
has been good enough so far.

Phil
