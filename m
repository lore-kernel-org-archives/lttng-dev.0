Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [158.69.130.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E19B5C7115A
	for <lttng-dev@archiver.kernel.org>; Tue, 17 Jun 2025 10:55:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4bM3fy0z46z20cY
ARC-Seal: i=1; d=lists.lttng.org; s=arc1; a=rsa-sha256; cv=none; t=1750157706;
	b=QqaQFSy7JNDYX7TyR1tb1hqj4sa1cuYoK3QqbZ8YX1vl+Gl2mfN/qbtIk0Ov6DhvPvhZ
	 UeHK2JIo3qwgkOIeH3fHf4Pr4u83wrqSOWJF56NbJPP3f6j9bhhMqmDUQdl2D6BxNYIy0
	 6edHcvhOzRMZ8vCYr5iiaka6Bs4RCr5SI35vb9c12jdGD/eG1D7wamf2dby3Sf+9qIdjA
	 VXzSvPGO52hfA5NLmLQwOn7r+Ym+RAkBGqk0wO62naBQsXzJBd5UM4tc3V6aIdJV5Hivw
	 V2qI5sm7FF5cdF908saY8u4LcNdtfnvbrivqHxxJOz0HIS3BYNn9fFEVlL4s0byywvg==
ARC-Message-Signature: i=1; d=lists.lttng.org; s=arc1; a=rsa-sha256;
	c=relaxed/simple; t=1750157706;
	h=DKIM-Signature:MIME-Version:Date:Message-ID:Subject:To:From:From;
	bh=QMKP0nKD1TamuzPV4zJirnhDmqjc4zdtkI6pFwfbx3w=;
	b=RSc9BNCaJqE6krSAWhj82uGm0hTq+hxtSN7X6sVnIRkeFxPssBNvJnfNiKNJlS43I0UF
	 /dWtvECrAHdQT3Lb0MTbKo/c0nSCaAQ1X8XfqRJkwVUMwReF/2nSZQBFCcPfXSGwp5oN/
	 FChZyDgVlRjuEi9Yoey1vG6XQ7OpR2dEqsDBzVyOCBnvldrm1WU/XM5RSq/xAyxyca0V+
	 8CZNu1YKqtw02xlinqiwUY3acgOQ1Gt7FWMTqkE2YTymC5evGu9aix5nzPNTnMZvcr2Eu
	 EGXZwdjBZYqIxmEGFOgzjVvW8cxUBbMXemTjX5wNun56CK7HAmGIlbsdmyxkM5MWJvA==
ARC-Authentication-Results: i=1; lists.lttng.org; arc=none smtp.remote-ip="::1"
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4bM3fy0z46z20cY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1750157706;
	bh=QMKP0nKD1TamuzPV4zJirnhDmqjc4zdtkI6pFwfbx3w=;
	h=Date:Subject:To:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=aSusZbZ6XzxZQxmmqKN/Jdb+ujehhTKKWO8/FHk7Ycw7YPacUj8FsCv8MFGhWsP9d
	 K9HmySTFz2aOSRGsMVG7++Fh3yW2NGj6JavaVFRnA0eQztzcN+eO1XuPI3ZbGO2MIp
	 c1EtdmNH/53wnq7R2tI+oFxFXnu6i+CTmEHfVt+vhDYgDdZzLb+Ig4dsU0kwpozJ9o
	 LwupSVXGlDRKXdG0FUTHTL6jUz6vvxnzRrWLJ1Pi98Z7766vIgOxh/RKAeu45Y4YVM
	 vMB6kQD9F1gZmaleegCWHXpZhffVl3kyb0JS5YpI/ZZ5hjBCN3mibi5I6VjaALWmFm
	 A0p2Xez48DWgQ==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4bM3fy0z46z20cY;
	Tue, 17 Jun 2025 06:55:06 -0400 (EDT)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4bM3fw29XNz20cR
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4bM3fw29XNz20cR
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com
 [IPv6:2a00:1450:4864:20::22a])
 by lists.lttng.org (Postfix) with ESMTPS id 4bM3fw29XNz20cR
 for <lttng-dev@lists.lttng.org>; Tue, 17 Jun 2025 06:55:04 -0400 (EDT)
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-32b43846e8cso30553841fa.0
 for <lttng-dev@lists.lttng.org>; Tue, 17 Jun 2025 03:55:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750157702; x=1750762502;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QMKP0nKD1TamuzPV4zJirnhDmqjc4zdtkI6pFwfbx3w=;
 b=cmrEW8vBa9JiX1DCVIWGYKskHpd54jkRI5updTcHVWg/Rmd5GwRDUnZVi1jhyCeMIY
 K99Xay/FekKssHF9sAcsHq748pI0jHZw0LfKpzgelOPXhKTfBg284g0t+Oc7R/7gohYm
 w5LdHzOre4M5FENXRjIhB5vroO5WFnQY1wucPUCKGyULuKU/bctH2Ef2b8a0by6JcMkh
 ScHN1DHIaJgu4Qfycf8Z0vcjgzKydDDrgTkzqC31yi5XcCI44FrZhFD5CszdZRq4Se6m
 m2AVlJGe+g/mEoTfyspV2ISjsbrFUb2UJcSPjvWT8F5iveCMSaOld92ICnAX0Bcjkapl
 LIsA==
X-Gm-Message-State: AOJu0YxoutktBEYYRALoyibpSTL4l9XrGlWQb5Pe/WnBnEo/B604oQbP
 +/DVU3hvUwM+hhTPSEU5cGMiMCihXKCJbpJLrlAcrmjrlIEd+xbgiSwgB/z2FpZAzY6NLDG9pTS
 178CigP6qbah9Twq+Frlm6ND0gQMH7uDQZa6N
X-Gm-Gg: ASbGncuWGPO7ExWyPxsLQecBt9QaJEPOX8bf2e+bOCibNxUyNcNVwruShRIdxJGnyxP
 FhnynWfnVqHrmQeG3+BKAcsjJ3si4bUolyBmuTDvcO+2lrHQDHv/RXtQc1Vxcu7yw4EYzs6q5ud
 sSZ/sAePAaQGjC5wN7foVKG3fMTCeCcSF56YE7pa7f1tw=
X-Google-Smtp-Source: AGHT+IF3Qt604Z9GjWWzsMzwy7mTdNek2/aGhNkcJGfs42usFOKu3eDIgER1Pc3Kkp5v/TXY/DKlQomAi5TE7da5j2Y=
X-Received: by 2002:a05:651c:1a0a:b0:32b:50c5:2593 with SMTP id
 38308e7fff4ca-32b50c52793mr26454851fa.18.1750157702337; Tue, 17 Jun 2025
 03:55:02 -0700 (PDT)
MIME-Version: 1.0
Date: Tue, 17 Jun 2025 12:54:51 +0200
X-Gm-Features: AX0GCFueu-eKow-FJxUq1XYN4NQGdjiO9Yr37aIfI8nkTWxjx4lqel3zC7Y7pYM
Message-ID: <CADYdroN6cD9sLE-8QMqFQiVB=RzPFav8owkuihZ-o7JxyK5uuQ@mail.gmail.com>
Subject: lttng-tools-2.14.0-rc1: Not possible to disable babeltrace2 dependency
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

Hello,

I had to add babeltrace2_CFLAGS="-DA" babeltrace2_LIBS="-lm" to the
configure line
to be able to build.

There should be a --without-babeltrace2 switch and possible automatic detection.

Regards, Norbert
