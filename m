Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 166D8C433F5
	for <lttng-dev@archiver.kernel.org>; Thu,  3 Mar 2022 16:35:11 +0000 (UTC)
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4K8c6613h4z6KQ;
	Thu,  3 Mar 2022 11:35:10 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1646325310;
	bh=IyjUg1MESWUF8hvgBbaD+7d2ocWRDZJRiDruGI6Hjd0=;
	h=Date:To:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=yjzurMJxvexnea+ORuA3U2ColvsCUajMGcrKM349O/dEqEW2sTPu/giBhvkGZp8wc
	 r3HYIVD5vFStJdo6R+esfE2LAPHz2iYMOFLRMr9ZovkE2ZM+CoQ2OiiXXWbkUYP4BS
	 80SdSybS3Kppgg033fk7ZL8zorUKkp9Ue8lC14BGKVkI8HfVAXL4CW5Yz7hHS1WYTI
	 WN2rZcBpdEM6FzuMftC/qtqAGsH1ODBuNS16eBTPz0ONjCyN2RYn5tz24v/6vuq2X+
	 Yb3MpqGqZZWO8cOnV6OYrttbKu1LDSaH3X+wUNXWzm6WAdllRUrF422xyqu/wKKYPK
	 W1444b3hB8xAw==
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 by lists.lttng.org (Postfix) with ESMTPS id 4K8c6422f0z6k2
 for <lttng-dev@lists.lttng.org>; Thu,  3 Mar 2022 11:35:08 -0500 (EST)
Received: by mail-wr1-x42a.google.com with SMTP id ay10so8707378wrb.6
 for <lttng-dev@lists.lttng.org>; Thu, 03 Mar 2022 08:35:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=zWiKneF4dFWBGb7GE1i/ib5yFnoe7bBYAgKWEOSJBDs=;
 b=imDiRNfqHLkXzryF/qevHh3XI4+vklrNZahCtqk5ecLICofmjFVULGgB9I6IaPiwoS
 locaNrLk/8fLBFJay/S1AvpGKaufHHp+TYxrhYtm2TSEBiPD7JI7tQqmXPyVKvrL8FLF
 mWRPBqMZqXA9X9O4RyBIij881r9lsQ4XtziUsQh2bNsq2Q7r+Z3dsW5CIbsaAlQzBhbz
 sz5hM22LSdByshz0SdXAJF3gFyfyUG2SV/AvZEPh9QYgs1ZKGOW59jhZi5c2XDitqG1M
 F2EblA96STjfSpjh+8fS0I3cuFRlj1zk92NyKJrpkHJS5NcNNlueWFdfM5eV6b10HzF1
 ls6g==
X-Gm-Message-State: AOAM530uuC+N8yh6HrJptSkOymmtUTmb1RtGlvqT2bKLG0fbdYAbua+i
 l31iLmSbGSNSfso6fkvXo+ZNhjBURI/lMLfVhqB2HdmYz1Y=
X-Google-Smtp-Source: ABdhPJzcsOIgUCcbLCI6L5pfAU66DBHWuKm3bdsY2eMrrisKtO/biqBZUM7wwlEFyit4hkR/D6PdCrikuAU9UJq2U4w=
X-Received: by 2002:a5d:47a5:0:b0:1e8:88b3:16b7 with SMTP id
 5-20020a5d47a5000000b001e888b316b7mr27901494wrb.417.1646325306521; Thu, 03
 Mar 2022 08:35:06 -0800 (PST)
MIME-Version: 1.0
Date: Thu, 3 Mar 2022 08:34:55 -0800
Message-ID: <CAJMh_qV01v9X=Nos2za8hbQdLvXgG5J=ZYiE3_OPOP5A5SQ-Lw@mail.gmail.com>
To: lttng-dev@lists.lttng.org
Subject: [lttng-dev] [barectf] Is it possible to include a packet sequence
 count?
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
From: Jon Lamb via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Jon Lamb <lamb.jon.io@gmail.com>
Content-Type: multipart/mixed; boundary="===============9039425098044307516=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--===============9039425098044307516==
Content-Type: multipart/alternative; boundary="0000000000001479da05d952fb6e"

--0000000000001479da05d952fb6e
Content-Type: text/plain; charset="UTF-8"

Hi,

Looking through the docs under packet features, it doesn't look like
including a packet_seq_num is supported.
If I didn't overlook the docs, is this a feature that would be considered
given that it's called out in the spec?
It'd be really handy to have this in the CTF packet rather than having to
manage it elsewhere.

I thought I could manage this in my platform impl by adding packet_seq_num
to my packet-context-field-type-extra-members as a workaround, but it
appears to be a reserved field type member name.

Best,
Jon

--0000000000001479da05d952fb6e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr" class=3D"gmail_signature" data-smartmail=
=3D"gmail_signature"><div dir=3D"ltr">Hi,<br><br>Looking through the docs u=
nder packet features, it doesn&#39;t look like including a packet_seq_num i=
s supported.<br>If I didn&#39;t overlook the docs, is this a feature that w=
ould be considered given that it&#39;s called out in the spec?<br>It&#39;d =
be really handy to have this in the CTF packet rather than having to manage=
 it elsewhere.<br><br>I thought I could manage this in my platform impl by =
adding packet_seq_num to my packet-context-field-type-extra-members as a wo=
rkaround, but it appears to be a reserved field type member name.<br><br>Be=
st,<br>Jon</div></div></div>

--0000000000001479da05d952fb6e--

--===============9039425098044307516==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============9039425098044307516==--
