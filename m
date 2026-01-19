Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [158.69.130.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1695D29C2E
	for <lttng-dev@archiver.kernel.org>; Mon, 19 Jan 2026 16:01:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4dvwDJ591Tz28XP
ARC-Seal: i=2; d=lists.lttng.org; s=arc1; a=rsa-sha256; cv=fail; t=1768838467;
	b=YEL1pzUrQczV5yxBgwvCjH7JHgUt+ASfDiXY419XMeeQ1iZ/8yxJL97W5RHcpWaNuLBQ
	 BGzIc/Y+778DmP2RXgAOuLYU5gJGCvINCn+x037jYNK7b3B6ZmfHuFvrC+L3u18Uhz92C
	 BqDk9/3xIBbORp2hvUKeZLjr0T2DhN3Sab05h8FgidTrORAbDT1v8a4AHpjtKWW42GCpN
	 JnrVKCbK1cheeztti1szu3opOpjMPAYgqJ6yBM0w3tGW7pLi/M9+E1kfJ10otX79ft7g2
	 q2k0Y0N5dBdEl1YSgqzSIX4wEMR7zjKLFqWU21UsjgxYQ7pMbeGL+3rjyBif5Rx1Dxw==
ARC-Message-Signature: i=2; d=lists.lttng.org; s=arc1; a=rsa-sha256;
	c=relaxed/simple; t=1768838467;
	h=DKIM-Signature:MIME-Version:Date:Message-ID:Subject:To:From:From;
	bh=EQRdsZhP7Xs3jAUJmhg1U5ER+fOpWpGg9LePWV0wbHo=;
	b=GZdxMx9J1XP056H4mXA45wOBSm1pOsploFEIP64mbAEtNhToS/q03uqKCs6n3XnNOktH
	 rGrvRzfAWU4Z9CT+gPVylBaQZzTnDz6MGs2r2Ro7Ylz3WnxfczBZCeoD2NuoNeejN/jBL
	 36vAULhNuSATy+Eg8bp5RJUJSf4B2yHtTvlBhfcCMu5p5dgfy54edJ4vDSUCa66gcEN74
	 fBz64NFnp7Q5N6LJBtyDLokuKyy9eh1tyUQPHCN2k5JiEF5BXHkbjCkR0J6DpgYhk0FtR
	 GyOXgzQvNM3s0DcGnN82QjlLQe2dREs3R0+IMhsYXBnGZJZcDzLWg5VG6fMI6G8HBsQ==
ARC-Authentication-Results: i=2; lists.lttng.org; arc=fail smtp.remote-ip="::1"
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4dvwDJ591Tz28XP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.lttng.org;
	s=default; t=1768838467;
	bh=xw5bRF9BpKIZCiTWmdyFtOKBCIdLEAY5jHDS0Cy+oiQ=;
	h=Date:Subject:To:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=NsJ5zy5uAOzpOWjsEfqMp5L99y5oejKM62/TRoeKdlitlAyAd30nOuMkwsu4j7CXa
	 b+gXLVfjTu3LeakKmymWXPKxlKcb923WgWvNxFg3LN1PWiHzVDD7hEHl3dpv3hp+vw
	 rMDeprjlMKOYxaQOT5Io2+vLL2etsQFWsEEDhMN0wDgslHH7mQv+lldK6ZHd59axHL
	 W0/odwcVaDAgPL1b0fg2yGGKaKsEl3Q2wngWA81Ho9GD0iSvC/I7DEXgvGKe2FrYDc
	 neKF5rGGKdbnTOIgquOJLdt3HuMQOuVuIxH9OfjyKPZsyy9nYvFpyY7MPCxDzEVK87
	 EQRwfVfgc8gLw==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4dvwDJ591Tz28XP;
	Mon, 19 Jan 2026 11:01:04 -0500 (EST)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4dvwDG3ZqZz28RF
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4dvwDG3ZqZz28RF
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com
 [IPv6:2607:f8b0:4864:20::112b])
 by lists.lttng.org (Postfix) with ESMTPS id 4dvwDG3ZqZz28RF
 for <lttng-dev@lists.lttng.org>; Mon, 19 Jan 2026 11:01:02 -0500 (EST)
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-78c66bdf675so40193537b3.2
 for <lttng-dev@lists.lttng.org>; Mon, 19 Jan 2026 08:01:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768838460; cv=none;
 d=google.com; s=arc-20240605;
 b=UpblYTAMskILljlrr5oqDDEOjx2chlrvxFUG3VQlHDXTpmy3jUDgk1kqsY2nRC/DlD
 dWsbQDftrLKWam2MTj8lBYceoy84y2FzrZuCoV4Wqx5MuJqZZhW9zurx0b0ujxuE3A+h
 kV904fRQv+WCHr5RmmIQ8LXpPhB6tb9bDdO/DU9hACTCPgHhDkPodysDNzBWLzzuLcZO
 cCkjOFuJqlyGf0Rfv6bGeRuY7FPy2kZm4+nscw9qbAC+cRlXqk+dntGGNCxLr7LpOTgK
 1Em3LalFCPgCEN1Ggf5dFa0JFpCy5WHsR1ZFexYYy09ZdLqOImZqiQCKD72JE0Bqmwtx
 QuZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:to:subject:message-id:date:from
 :mime-version:dkim-signature;
 bh=xw5bRF9BpKIZCiTWmdyFtOKBCIdLEAY5jHDS0Cy+oiQ=;
 fh=Vi3MF25LmiCIknQyyhXLxIEZ5vqn+bls1ZIgHxHgtRU=;
 b=ULmheyrcjtpnD58hJ+6lTSpI9cnDY9FrmT7TOSQGaFt4QEhWSeE+gnP28sWQNajIEb
 MeoeXjgOxhD8RjWI/HNEEUvcqlk0w7tYUFlq+oVrISBQEZjHC1D+GnFMNOD2ZNQ0+2iG
 U9XyqzZf5xeQl/VFDHk6kNqJFZmZ0rMzxMdZtLYt03YcE++0I+PAOk0rZ4wCjX8XEkEF
 yLtRaJ29+K8LY/Cub/Valekq5Bl0ZXOd6rz837B6e3dLC8VQuKcNVyzY7msMvJoml2Md
 6vAWCb1l/iS0b9TurXy7H+MJn7dArG/J+xK7jnZhvbI9AcDSGMw9Z4QDRefO3rEdkS/i
 dL1Q==; darn=lists.lttng.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768838460; x=1769443260;
 h=content-transfer-encoding:to:subject:message-id:date:from
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xw5bRF9BpKIZCiTWmdyFtOKBCIdLEAY5jHDS0Cy+oiQ=;
 b=ReUn3ntnysOZMaOOCx1/spCzpOAquiX/oDyqq0/HfG1VQXqUhEODopXAIJnHXXXpIH
 xekKLEbBnaQKPxmFOm05YiDzavoyepVSO5DfHHxSjV252yhRV183xFw7gBdnILvLdJBp
 8Pm21z+n8zHd/re6NR19HE0bac4V1dCy2A4Lia87Hab5avgvZ8Z73zfSO2qZw6IzosyI
 g957SS92i3QoTDdhFk+ngmHaW8Fx+wBGiYBubz95bOZZ8/ReLnQD4h17YM8VqJdPyJ4p
 5zLqJi8YALlfdfiD68zWTrU1tvGHLFLraHrLCgK4jwa5c6gf0yxwH/OVGAi7NiDHI2ed
 z+Fw==
X-Gm-Message-State: AOJu0YxTuJE8ZR/1Gdn//4HF3hRC0qPynLvZeZM/Wdwt1XFNRJC0xavu
 1kM0qXD2KOhpqFTswqWVSBn71VsqZptUEVMPYIC2UpcQFes995B/oSa60yKYbQ9f4E+Ue24ehKy
 oqSqVQD8dYOqzrSd9hvKJLYuOz1BsLCZvb/qN
X-Gm-Gg: AZuq6aJAINSC2pEc93B1w/zCtsNCl1KYdgQrKTsCwEqLapW4yKr+om++QYwidxZFs2K
 UXfSrAMowIo/VKherb4XryoRYqDu8KmFd5PBcHds2M3QBEMin9toCdhrKLgEDHFaBogr1ljnALv
 ASj3q+r1t3B9GSonq8m3AjS0y9/eWSUV22SDQr+VrMK6uJBT1bI2HnV6qZ/yNH+2Kt6MpLgmI4T
 nDGWodMVmYpxrW1iBjzhLriqfsrCCogIcE4QypJoL/ud3KGZHnOWKOse++sS5SfUjrPMKmCqw==
X-Received: by 2002:a05:690c:660d:b0:793:d0b5:9bcb with SMTP id
 00721157ae682-793d0b59d3fmr72087027b3.24.1768838454948; Mon, 19 Jan 2026
 08:00:54 -0800 (PST)
MIME-Version: 1.0
Date: Mon, 19 Jan 2026 16:00:44 +0000
X-Gm-Features: AZwV_Qg3VodCx1P5CFc15iFh5KtalrqepXoLtK78FYP29hyREfvjewoM0Sa_twQ
Message-ID: <CAJK_ieh7GpnMBe-J3ktiU4EmE2puqafgx4pmEBoJsbqKz9LEEA@mail.gmail.com>
Subject: How to build lttng on RHEL 9?
To: lttng-dev@lists.lttng.org
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
From: David Aldrich via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: David Aldrich <david.aldrich.ntml@gmail.com>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

Hi

I have a build error for lttng-modules-2.14.3 on RHEL 9.6:

lttng-modules-2.14.3/src/lttng-statedump-impl.c:408:20: error:
=E2=80=98dev_base_lock=E2=80=99 undeclared (first use in this function); di=
d you mean
=E2=80=98device_lock=E2=80=99?
  408 |         read_lock(&dev_base_lock);
      |                    ^~~~~~~~~~~~~

Please can you advise me how to fix this?

(I am only building from source because I assume lttng packages aren't
available for RHEL 9).

Thanks in advance
David
