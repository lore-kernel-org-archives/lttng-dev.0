Return-Path: <SRS0=GH8+=BX=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.7 required=3.0 tests=BAYES_50,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24CC0C433DF
	for <lttng-dev@archiver.kernel.org>; Thu, 13 Aug 2020 22:38:58 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8140A207DA
	for <lttng-dev@archiver.kernel.org>; Thu, 13 Aug 2020 22:38:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.lttng.org header.i=@lists.lttng.org header.b="qfLJIvRg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8140A207DA
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4BSM1X0V73z1v11;
	Thu, 13 Aug 2020 18:38:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1597358336;
	bh=pjUJxfAfHApZ8gjc68Jo6AfriiUX5pwpYQyHQAhMsGI=;
	h=Date:To:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=qfLJIvRgBxju+ARFQCWHG92BDFgLkzvzJd1bwuRY0e2fy17aLaQJijmGhzXl9NWQH
	 Na5Lm4mjpTfcbT7pkGaA+LEgHledk7BKOfo/NNEpa3c+vZ/qFr+rLcl0VOfjgmOSQp
	 Zep4bu5P858GU3Z0llPHSh4pockAymfDkHpg1HEPKHLY9z1Xv+ZYhf0QYlK+hdgKXZ
	 nF37DszNl6sDPriQyberlxBEEhq67ksDIOok0XuZwna7n0ilxNTqpKi97unhE0/XW7
	 cPr1BsA0SLxnp7XCyEMhTgRd5wW0zJ4IUZ3eaUsm5h+xTITkNZ1yU+RWBkPT1ZmVmK
	 /U/amKvFq7jaw==
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com
 [IPv6:2607:f8b0:4864:20::132])
 by lists.lttng.org (Postfix) with ESMTPS id 4BSLXp0G2Tz1vVg
 for <lttng-dev@lists.lttng.org>; Thu, 13 Aug 2020 18:17:29 -0400 (EDT)
Received: by mail-il1-x132.google.com with SMTP id q14so3452515ilm.2
 for <lttng-dev@lists.lttng.org>; Thu, 13 Aug 2020 15:17:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=fOBrbs8Ab09xXlQLo/rgS/j6+Myq3OQNb6mcCbY7DNI=;
 b=QonmVj3kdnoUjxZVpGr6NNs8npHFgVnZti8JQVr/A+a0KX1tYwhFbE0LmL7InJVxU6
 J9f9yqDZkaHbS6EE6sfSiUR97eV0W5XbGvvJQYDXzgpPmH9Z3xAgDhyiRmEp+2CP5cTL
 sfBIeCE2Nkpw1y5Iij6YnPbY0mecU6Q74GiY/w08InrYKGxm7Hr1ahV0RmDlWxKLIAQy
 Oxoga7T1uPGFzC6Sisp3gbbqnifnZ/ieqaMOEvpQRPQaGk8z7RnJfxgrW80sYXYjIzFs
 5gAN68Axx1YacCEyzArLNqgzo4KEtmvC5+yCbgBeHLPbcHUL94X59qOsGtSR189CjcOy
 elsQ==
X-Gm-Message-State: AOAM533HGgFEaLx8JVqiXe0DRxD/6t8ls/98GZzqLYP+URYUprweLqwY
 TGTC005Acsq/CGZnCamLd+OKWhM5PPkMb64jT2qCRlp4LeQ=
X-Google-Smtp-Source: ABdhPJxzT2IiQAgqz9drdku9A/OHwjjMBfwNGOv31vUPhHYgk2Ol+brtiW+mXfH3PLGPycHICoEd4rGoqc2fwBv5Z7g=
X-Received: by 2002:a05:6e02:e13:: with SMTP id
 a19mr12997ilk.172.1597357048798; 
 Thu, 13 Aug 2020 15:17:28 -0700 (PDT)
MIME-Version: 1.0
Date: Thu, 13 Aug 2020 18:17:18 -0400
Message-ID: <CACV+naq0k9Szvs_vPyB98uMh5v=CNYbuEZ7nq9dDJoPR=LL5Cw@mail.gmail.com>
To: lttng-dev@lists.lttng.org
X-Mailman-Approved-At: Thu, 13 Aug 2020 18:38:54 -0400
Subject: [lttng-dev] How to report a bug?
X-BeenThere: lttng-dev@lists.lttng.org
X-Mailman-Version: 2.1.31
Precedence: list
List-Id: LTTng development list <lttng-dev.lists.lttng.org>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
From: Jin Huang via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Jin Huang <andy.jinhuang@gmail.com>
Content-Type: multipart/mixed; boundary="===============8872156605442355729=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--===============8872156605442355729==
Content-Type: multipart/alternative; boundary="00000000000079231305acc9ab3d"

--00000000000079231305acc9ab3d
Content-Type: text/plain; charset="UTF-8"

Hi, My name is Jin Huang.
I find 2 data races in the Master branch of userspace-rcu.

But I do not figure out how to report a bug here,
https://bugs.lttng.org/projects/urcu .
I do not know how to add a new bug description.
Could you help me?

Thank You
Best
Jin Huang

--00000000000079231305acc9ab3d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi, My name is Jin Huang.<div>I find 2 data races in the M=
aster branch of userspace-rcu.</div><div><br></div><div>But I do not figure=
 out how to report a bug here,=C2=A0

<a href=3D"https://bugs.lttng.org/projects/urcu">https://bugs.lttng.org/pro=
jects/urcu</a>=C2=A0.</div><div>I do not know how to add a new bug descript=
ion.</div><div>Could you help me?=C2=A0<br clear=3D"all"><div><div dir=3D"l=
tr" class=3D"gmail_signature" data-smartmail=3D"gmail_signature"><div dir=
=3D"ltr"><div><br></div><div>Thank You</div>Best<div>Jin Huang</div></div><=
/div></div></div></div>

--00000000000079231305acc9ab3d--

--===============8872156605442355729==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============8872156605442355729==--
