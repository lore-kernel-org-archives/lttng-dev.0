Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [158.69.130.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA65EC71157
	for <lttng-dev@archiver.kernel.org>; Tue, 17 Jun 2025 11:01:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4bM3nm19rpz20fj
ARC-Seal: i=1; d=lists.lttng.org; s=arc1; a=rsa-sha256; cv=none; t=1750158060;
	b=k4auTbaHbCnHFBGmVPAztROu3irhrFQjSSBFm33itJM/2fXHB0KMnDThU2fcMA9L3Nhn
	 nl54z05L67WZabobRXj1ThN+5/e5k/zpiDZZ5Hy8XuRhyzoKwu8oQE/pxdMx2DCGl9QLl
	 ziehMq2il5GB4PyXiWfKZIecOlYa7b3RsTCMS4il9p6ghn+kGfxvBaN7K44OeI6F+YIy8
	 54RaSSquk6pI7gxW12hbQdjVYO+GurGRlgRoip4bZooScHc2Tfwoi5Di7w4MagzdCgRqi
	 OFUON5mImcyKNleybdnA/LqBNTVFhneEVvvPZdtvMiWPH5b52FpCdbzjRPejxOjaBDg==
ARC-Message-Signature: i=1; d=lists.lttng.org; s=arc1; a=rsa-sha256;
	c=relaxed/simple; t=1750158060;
	h=DKIM-Signature:MIME-Version:Date:Message-ID:Subject:To:From:From;
	bh=rRWSqa2didnu5lHSjuLwaLBYpyyhbK6uEZlUxQRKwOQ=;
	b=LKBRiry4YAqajfOJ+wwMFy7oM15nsqZjXiE0iJ8FtfAuPWLvoEEbgKHCqhK/SfC8zTTS
	 xdEQtOVlW6z1hDPfdC9DM4zE8Eg9CXBNWVIduVZ7KOuv+YZWEHZqUPiscnCN8LcTgJB2G
	 mFzO8qcK+iJvJnbJkl/VEDIABqUHh7QcS0N5bYwCf+kteZXpAnJ73rI15lA3KStm0JgD1
	 A0yGxgegmuV88PTwOxvFsYkZOk033mSgStPDS7CD5JYBq86IDGC+zR2+BxVgJxQiYZVRU
	 I1SEsYCrQiEZXYNAS3zmcT/4uE8Y0+3h9uXugjlR17AHmSnjtojupmqYUtIBwhhYSnA==
ARC-Authentication-Results: i=1; lists.lttng.org; arc=none smtp.remote-ip="::1"
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4bM3nm19rpz20fj
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1750158060;
	bh=rRWSqa2didnu5lHSjuLwaLBYpyyhbK6uEZlUxQRKwOQ=;
	h=Date:Subject:To:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=VfXWb6NBmXST4wyDfSAUCRfWhFpxiyaP5Evshf2NFf4h8QMqvKQKdvpBvFnWSxYNl
	 mMWVUHsx/9APvLXgCLmI40CSm4i38Nf37F2w8Aq3Cmd5HlSwTLnSTK5elLnR5EuQsC
	 KCKBsW1pfHLTonaJ/doCaUU0q+Mm03JZ0y5w7LrulEK/KrIkoEOXdzqI2P+nbapqTY
	 OHO9tZd1daS/M1EX0GUtQUcbHQFBDIs5eH8CLrufgI9ClC7dZfLbhhpsPN66ajXDq8
	 NM82KZXwdubIQuc4Iu4b9nCqgM5BqPCB//tAmpIkB/TyhgQRtvwiWhoODp201wYebH
	 srCI5+tg5nERA==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4bM3nm19rpz20fj;
	Tue, 17 Jun 2025 07:01:00 -0400 (EDT)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4bM3nl1f9Zz20fW
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4bM3nl1f9Zz20fW
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com
 [IPv6:2a00:1450:4864:20::22e])
 by lists.lttng.org (Postfix) with ESMTPS id 4bM3nl1f9Zz20fW
 for <lttng-dev@lists.lttng.org>; Tue, 17 Jun 2025 07:00:58 -0400 (EDT)
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-32b2e49b62fso34207151fa.1
 for <lttng-dev@lists.lttng.org>; Tue, 17 Jun 2025 04:00:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750158057; x=1750762857;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rVP8w9H7zpujj3Y9dEixoPtZi9gKPH917MSJ8EAz2vw=;
 b=SCvGT1xGEyWRx6Mehezg8madBx9OAIojaU0bWan/B6ddwNM2xkGDBTICEHvZ6TAKPG
 U6c5SszAmN1EeSykOfkget9vinW+qbikv3TaO2MkacDUiSCO3F+EipEJK/oLyeB17EHa
 fmPW6XM5etTXyLlc2LjWZEddutRAn9mgNaVOPIjQoUUK39Kqe+Eyu7Z+U84dBbewgNHS
 AinIeI/8ltMuIBfRF2XAM8hEN2nsfcOS1mNaIviRpvDJLxgIkMwuR6IOvy548onzkkFY
 9NWcr2L9vezgjR/a+sxnWeArsb/02vRJEokLfh4oCjiSGMtnI3ac8SmbTSzNM5/ypwoW
 ysrg==
X-Gm-Message-State: AOJu0YwCEwxhkmhO+tHiKOoXUKpL6waeYqdj48g5BdB27Ev0ZrL/5WrL
 83yGi9bPoVdmM1KSGIB1wf6b6ayqHB2LZpEePtof44T06S+19ckkb0O7eT+Lr3bNRCVwuMOi7ft
 6pu6J+XDyPaxteeIRmHn7W6JX4MZnv58zdekA
X-Gm-Gg: ASbGncuYYfE/+MN+yNhCGWn8iKfG5N0MY+zA2cNY4Iui00eQKKrSwm0NGl4d5wVLQXQ
 KO6ZEqyQRmUaJZtf1DfH0ZLfgR5hBgwtTfVuuN9OzLFMFFQQsUsR0NKqsQOVQUSHvotpnQD8utx
 pEO5v8/5V3n576hZNjAElul1e0LC1wTcxMwAmvDfiuAD4hb3mPIunPKA==
X-Google-Smtp-Source: AGHT+IEhOZwsKbq2YA2NZpoEH7fxm4nXXx9sOjsLIU/nlAcn42EJbu7I69xoms1WMVoJ3F8VM7mwpOJHrYBlgpbQ9oE=
X-Received: by 2002:a05:651c:150b:b0:32b:5930:fd48 with SMTP id
 38308e7fff4ca-32b5931057amr33188441fa.28.1750158055954; Tue, 17 Jun 2025
 04:00:55 -0700 (PDT)
MIME-Version: 1.0
Date: Tue, 17 Jun 2025 13:00:44 +0200
X-Gm-Features: AX0GCFt7OK68QIxv4fEXAV7N9KgJUefotnbfn_1D-AMAyQcEXGu6DmUGAeRtkm8
Message-ID: <CADYdroPQ-E4JGj=mhQkkRNv4PVgpXuN07fQpg9-r0TifsJpQ5w@mail.gmail.com>
Subject: lttng-tools-2.14.0-rc1: ODR violation
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

enum communication_state exists twice with already diverging definitions.
I am not sure if its a functional issue now, but this sound like it
can cause fun bughunts in the future.

(enabling lto helps finding that kinda stuff)

../../../../src/lib/lttng-ctl/clear.cpp:26:6: warning: type
'communication_state' violates the C++ One Definition Rule [-Wodr]
   26 | enum communication_state {
      |      ^
../../../../src/lib/lttng-ctl/destruction-handle.cpp:25:6: note: an
enum with different value name is defined in another translation unit
   25 | enum communication_state {
      |      ^
../../../../src/lib/lttng-ctl/clear.cpp:29:2: note: name
'COMMUNICATION_STATE_END' differs from name
'COMMUNICATION_STATE_RECEIVE_PAYLOAD' defined in another translation
unit
   29 |  COMMUNICATION_STATE_END,
      |  ^
../../../../src/lib/lttng-ctl/destruction-handle.cpp:28:2: note:
mismatching definition
   28 |  COMMUNICATION_STATE_RECEIVE_PAYLOAD,
      |  ^

Regards, Norbert
