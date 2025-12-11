Return-Path: <bounce+b7b410.602323-lttng-dev=archiver.kernel.org@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from m43-8.mailgun.net (m43-8.mailgun.net [69.72.43.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94F94D41C37
	for <lttng-dev@archiver.kernel.org>; Thu, 11 Dec 2025 13:52:27 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=lists.lttng.org; q=dns/txt; s=mx; t=1765461146; x=1765468346;
 h=Sender: Sender: Reply-To: From: From: List-Subscribe: List-Help: List-Post: List-Archive: List-Unsubscribe: List-Id: Content-Type: To: To: Subject: Subject: Message-ID: Date: MIME-Version;
 bh=IIkHyEP1q8MIfgnrAaw8ENyCwgd2GyBvr/3vro/2Riw=;
 b=jqEK/FlbjSO2aaVSawpe2Rdl/8uhOPy1a0EFztPEZm+C4lmcIJFgELqgQqDYZCStD10TPQ7A0BpZiQ6eqwdQ29aC3dDG74gbllZe0img7xjF1A/pOF3YPQAMk3emm+oswyqwpwtF938QrHL9w55fUb2hJZcVk2js9QBhGMbfFP7WWKF2PbN1l212xlikkfbgAouHd4V7zgkuBUsFZXApEp72fp2ujXnAF/So5lOSfg/VYaYOmQe0hDZr+1Eu9JzQ6A7qPi62LKgCU45+B18dyYP9W7FIGtIsTlcnpwwULDNI2v96RbUffMbXGVXKpEIHuNic+e4ikdgxx3aTu8hZHQ==
X-Mailgun-Sid: WyJlYzgxZCIsImx0dG5nLWRldkBhcmNoaXZlci5rZXJuZWwub3JnIiwiNjAyMzIzIl0=
Received: from lists.lttng.org (lists.lttng.org [158.69.130.29]) by
 24f98f1a4cec0d16304675dc31b03f3f2f57fa9dd2494ef672f2a7ad004ea611 with SMTP id
 693acc9aaa60c1e98a7b60a5 (version=TLS1.3, cipher=TLS_AES_128_GCM_SHA256);
 Thu, 11 Dec 2025 13:52:26 GMT
X-Mailgun-Sending-Ip: 69.72.43.8
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4dRvCr3QHGz1vm0
ARC-Seal: i=1; d=lists.lttng.org; s=arc1; a=rsa-sha256; cv=none; t=1765461146;
	b=S7rPNZrNeu+Zf8yLo4xjtSauSgOmx3Q0Rpy5y51cl7dZO+6ZaZKJ8fzXD7ZokM0BCd46
	 c7foXFYKseYgV5aN9d+0aKh/w1F8U4wQLp4GnBKwQSTQoudquUFRC8ehXAhpvzSmSDZ35
	 xzr7KaYtUN+h7DxP1Te6IFg2pKHZPcrVt0r866atYuwnVMpQbJw+KLkejz1qC3S6/a68a
	 bksr//LL802211dr9+aYwLLhHXJu9uXsPID2AtOVXRMK5yUCxNZJWS373jBwK4vRWRkhZ
	 TZwdUC/RYgptVf6cywt/VrBqR5RTKt3A3Ghn2NZ1Lh9Cqy0QGu3X53WUPfuo5cM2nLA==
ARC-Message-Signature: i=1; d=lists.lttng.org; s=arc1; a=rsa-sha256;
	c=relaxed/simple; t=1765461146;
	h=DKIM-Signature:MIME-Version:Date:Message-ID:Subject:To:From:From;
	bh=IIkHyEP1q8MIfgnrAaw8ENyCwgd2GyBvr/3vro/2Riw=;
	b=NJGnKuYx6169oe7wqM9Tnk+LpqVId6r2ht3eaw7H3UMY7UDjhzN/62l4CAZeH4+zjOo3
	 jbbW0oTjt8scbPr7ClmiV1th/pGiqUoGQalm9IsqQhejlaQ7iBZ9nzbAT+rqE9pOgbkQB
	 IDkGw7UdJ8I1EszQgT5c8Hn37KpPvn4/a2serkpV4n5rvFp0dsXA4q8rW7xGLNwmiOgPt
	 RVn5uzUGJybzgOH4mhzRFk6tvUhz1Ld+Q+oZMwYRL3/ZoPfsNUchde3622HD58HXnQ4ny
	 I7AbI+l5svGn+hh2ysDJda8G245EMZQkeJDbAb13yuWYE1+aX3wFKML08HtJ6u+4X0g==
ARC-Authentication-Results: i=1; lists.lttng.org; arc=none smtp.remote-ip="::1"
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4dRvCr3QHGz1vm0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1765461146;
	bh=IIkHyEP1q8MIfgnrAaw8ENyCwgd2GyBvr/3vro/2Riw=;
	h=Date:Subject:To:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=u70DQN4WYp+IAXxRu+tSeDqWxy9KytEe4IYpDC1rAqp+qPTyyUmKVhnmKsrclPd7s
	 guB9ScIoc6wICA6/OKwjakwNnQgptPiskDrrcJbuDrv9QBEFNrxeHSJ6n6+VVxYRfC
	 EmR7lOpKZtcgv0q7/pAc55zBwdJSToywpPLq8aTXXQUxC5zLMt2X7E/pFA8bPTAeZf
	 fQu8npqD/KpUpz5cUhoVrOKOwBt2rkZ7oI0WV5n5JWqxXYO2ZT+uZRX6EvZdokoQOr
	 9mi2rxg5RX0CPFD9JG4AqofCfE2K9yzex1a0Z/x2eMeo2lWkPKLMtHoukinqStKiMY
	 mMWEwdPeuUC3g==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4dRvCr3QHGz1vm0;
	Thu, 11 Dec 2025 08:52:24 -0500 (EST)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4dRcK70y2Xz1nWQ
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4dRcK70y2Xz1nWQ
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com
 [IPv6:2607:f8b0:4864:20::c29])
 by lists.lttng.org (Postfix) with ESMTPS id 4dRcK70y2Xz1nWQ
 for <lttng-dev@lists.lttng.org>; Wed, 10 Dec 2025 21:40:58 -0500 (EST)
Received: by mail-oo1-xc29.google.com with SMTP id
 006d021491bc7-65b2cc63b0bso289585eaf.1
 for <lttng-dev@lists.lttng.org>; Wed, 10 Dec 2025 18:40:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765420857; x=1766025657;
 h=to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IIkHyEP1q8MIfgnrAaw8ENyCwgd2GyBvr/3vro/2Riw=;
 b=VHLt4D6yXe7n1cBpJBtmYTdDHmvM1Fu5MntkX6B35mbZopE3JwkGVwu+S5JpdFBHA0
 5LJxgS7vD9EvJNf14isBml5mq3j1OvUFlbEvh/jnKAL77TWJPMIUWsbY01xVKQ48x4YF
 4vgPbhbWXAGlqZQmSdmlDYIPb7USoBmh5JgOGntz4xfJWnJYf7pBeEiXQdnzd79ix6ve
 V3zmxof2BEnkkFwEwMaPfhYHA63hdWveCCNgqlKcL1aPKZwumgJZI9pJUcXHj7ODBW1c
 rkU7YphBSde3YLhUd6hob4b5DOflMZ3tIM/5uQ0Eme/9Zb8XK44vR4oll8Mb0juN/Dhq
 38Yg==
X-Gm-Message-State: AOJu0YxwNi+wUk0MQuVtBqOKpfQdiRbsvV/DjCmtD23v1WIMm1iHFGL2
 IkUdlInUP993ELcTL+U7IBFLBbN/mEtfzLWV8KH3uwtKbB2ZWPO08xpSPE+30dmE4paUrI5Bi6u
 8EuaRkVWFNDK76uOUvg8AplbgfXMdtcrBBg37wj2wgvqVUzoVh1m1XFQ=
X-Gm-Gg: ASbGncvd4DZB4gR1Q3n/RGSMHdDtGeIdoop5FDOdH6AeGBX2wA5dmu5Y76/lqN++au+
 P8BW+yf+oIHV77i3PKUyunnEZ+Lk1wntTjhXJiD/dnZCnPAT56it7nTnzzcmKxLG3QN0IfM9UGr
 xv7VX5J+QkMaO8Tzkt7pwYC98cO1iJEdeiHF5yWcsNV0/0Nf7Q1ngELqOARB6bhQ2Rupr4kKt29
 lnBlY7gPU5645eWe9KNGEnJqf5YOmj3xfVGQJo0MT6McwviD4VEcBbDaEPZv8GHy2pVXTXvnV/S
 gNF2GTu1gVkXzd3TQRhSh9rOGcY=
X-Google-Smtp-Source: AGHT+IGdc1B9zMcOpJT1LAv9rMg9+ks+alJiMaJ9OkdbbDoomA0SdQ4fSQyQC8Ih8u8hjx0ijsZUC4B2dBuxBqV8TVU=
X-Received: by 2002:a05:6820:811:b0:659:9a49:8f1f with SMTP id
 006d021491bc7-65b2ad46c37mr2501919eaf.48.1765420856533; Wed, 10 Dec 2025
 18:40:56 -0800 (PST)
MIME-Version: 1.0
Date: Wed, 10 Dec 2025 21:40:45 -0500
X-Gm-Features: AQt7F2pEvGGXnXjBDdA0T3faYEy-ZMtWM_hdneccPBIP3W4Wei-pmg6eSSHbHUY
Message-ID: <CAOQX81f1zGCsnr3Ksjv0WoO-J4-OULanefNxzWdrxP8b4+aqJg@mail.gmail.com>
Subject: Question about LTTng Context
To: lttng-dev@lists.lttng.org
Content-Type: multipart/alternative; boundary="0000000000000872c80645a41312"
X-Mailman-Approved-At: Thu, 11 Dec 2025 08:52:22 -0500
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
From: Amir Najafi Zadeh via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Amir Najafi Zadeh <anajafizadeh@cs.stonybrook.edu>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--0000000000000872c80645a41312
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello everyone,

I hope you=E2=80=99re doing well. My name is Amir, and I=E2=80=99m a PhD st=
udent in the
Computer Science department at Stony Brook University, New York.

I have a question about the LTTng context that I haven=E2=80=99t been able =
to find
an answer for in the docs or man pages. Does LTTng support adding the
cgroup ID or cgroup path as a context field? I want to filter my trace
results based on cgroups.

If this isn=E2=80=99t supported, are there any plans to add it in future ve=
rsions,
such as 2.14?

For reference, I=E2=80=99m currently using LTTng 2.13 on Ubuntu 24.04 with =
kernel
6.8.0-87-generic.
Cheers,
Amir
--=20
*Amirhossein Najafizadeh*



*PhD Student, Computer Science Department, Stony Brook University, N.Y.File
systems and Storage Lab (FSL)*
najafizadeh21@gmail.com
https://amirhnajafiz.github.io/

--0000000000000872c80645a41312
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><p>Hello everyone,</p>
<p>I hope you=E2=80=99re doing well. My name is Amir, and I=E2=80=99m a PhD=
 student in the Computer Science department at Stony Brook University, New =
York.</p>
<p>I have a question about the LTTng context that I haven=E2=80=99t been ab=
le to find an answer for in the docs or man pages. Does LTTng support addin=
g the cgroup ID or cgroup path as a context field? I want to filter my trac=
e results based on cgroups.</p>
<p>If this isn=E2=80=99t supported, are there any plans to add it in future=
 versions, such as 2.14?</p>
<p>For reference, I=E2=80=99m currently using LTTng 2.13 on Ubuntu 24.04 wi=
th kernel 6.8.0-87-generic.</p></div><div>Cheers,<br>Amir</div><span class=
=3D"gmail_signature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_s=
ignature" data-smartmail=3D"gmail_signature"><div dir=3D"ltr"><b><font face=
=3D"garamond, times new roman, serif">Amirhossein Najafizadeh</font></b><di=
v><font face=3D"garamond, times new roman, serif"><b>PhD Student, Computer =
Science Department, Stony Brook University, N.Y.<br>File systems and Storag=
e Lab (FSL)<br><br></b></font><div><font face=3D"garamond, times new roman,=
 serif"><a href=3D"mailto:najafizadeh21@gmail.com" target=3D"_blank">najafi=
zadeh21@gmail.com</a></font></div><div><a href=3D"https://amirhnajafiz.gith=
ub.io/" target=3D"_blank"><font face=3D"garamond, times new roman, serif">h=
ttps://amirhnajafiz.github.io/</font></a></div></div></div></div></div>

--0000000000000872c80645a41312--
