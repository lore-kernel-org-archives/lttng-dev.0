Return-Path: <SRS0=1I1X=62=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F0A3CA90AF
	for <lttng-dev@archiver.kernel.org>; Tue, 12 May 2020 18:15:21 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8494206B8
	for <lttng-dev@archiver.kernel.org>; Tue, 12 May 2020 18:15:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.lttng.org header.i=@lists.lttng.org header.b="Y4h5t1wh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8494206B8
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 49M5ZH0Mh2z21Nv;
	Tue, 12 May 2020 14:15:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1589307319;
	bh=8GnHFVS92nSNbU19HCVaEseVo3Mt4x4M2wtjvY+vTOo=;
	h=Date:To:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=Y4h5t1whQ0oIU6+5tYvNAnyK5ZVwF1AEiuDelpole9aT2udddbLqmyzJiHf1EVJRi
	 ifwY1sSqt+Tfb9jZ9ytriPnq10p4RFhlEuzUSvVnWM08wxQKJ/Dz/ak8F8NGqPw63Q
	 0dr72SjdZsQd5syncY1eoiCxUaeIpl44lxNIs8ItuePlFizWRN6XaBOJd33YKa53Qj
	 a/riCiegMbpr7yk5hcsEG65UersR0V3SgXL19ZQW/sESp9ftF+6CQ3YcsJYkEX/jm0
	 vW8G2eZo6aulXOKxIL75L0DAiR0Mn/PvPO+/0w+UXK/a2uDdaUb79CwrVnoO+uxV90
	 +quyubOUa51rw==
Received: from mail-qk1-f194.google.com (mail-qk1-f194.google.com
 [209.85.222.194])
 by lists.lttng.org (Postfix) with ESMTPS id 49M5ZG038dz21Ns
 for <lttng-dev@lists.lttng.org>; Tue, 12 May 2020 14:15:17 -0400 (EDT)
Received: by mail-qk1-f194.google.com with SMTP id c64so14614637qkf.12
 for <lttng-dev@lists.lttng.org>; Tue, 12 May 2020 11:15:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition;
 bh=5LGuK+bDXsGsveL3BOz/arMXgpX9Hfbj/cLfmTS34uE=;
 b=fDSFu7JmYEVsOoPfKxyu4thyCRN1CPzu3B2PRC8LLSynnS+0zyBo9HlMrB6SwQGSaD
 0jjmCbeWl+SEtGr/W2zWF9k0tMV2xK9G6q/XI4NjO6wMcp9UrmnA99AWnov3Ro4Em3VJ
 t/LHbYJQhElrRYz0hbIQ/7EHCBvrCP4WiJZUqfFCnsUyoQ8YqrpG7dXaFXyQIdJjqlT+
 WK2XdeE5trHprXEz1BpU0mQKrPOGxK2srZKnMbhB4/QIFmFEr9Rl513rEz9IlnYGITyL
 wrvJBfRXluGsQjFE89L1HnnddP0+xlXQv6E2MKgi+tBtzq4miOYqLPnOImrqjb4/4qMc
 +lWw==
X-Gm-Message-State: AGi0PuZQEzldsKK7bjiWDTlPh2zOwnHAkHdHyf3+cIj0w3J95n1UpCCi
 89iOUQc6eVCYYYwJ2whrJ+sLm65w
X-Google-Smtp-Source: APiQypJF0FnEfbeUhKLMUDro/SLpgsRKjyVdzf1d1euEaw+J1LSUmlFElLAvtgo70HTQ4ADtfbTD2w==
X-Received: by 2002:a05:620a:2091:: with SMTP id
 e17mr21837210qka.70.1589307316406; 
 Tue, 12 May 2020 11:15:16 -0700 (PDT)
Received: from gmail.com (192-222-251-19.qc.cable.ebox.net. [192.222.251.19])
 by smtp.gmail.com with ESMTPSA id
 i5sm6796911qtp.66.2020.05.12.11.15.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2020 11:15:15 -0700 (PDT)
Date: Tue, 12 May 2020 14:15:13 -0400
To: lttng-dev@lists.lttng.org
Cc: diamon-discuss@lists.linuxfoundation.org, linux-trace-users@vger.kernel.org
Message-ID: <20200512181513.GA243139@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
Subject: [lttng-dev] [RELEASE] LTTng 2.12.1 - (Ta) Meilleure
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
From: =?utf-8?q?J=C3=A9r=C3=A9mie_Galarneau_via_lttng-dev?=
 <lttng-dev@lists.lttng.org>
Reply-To: =?iso-8859-1?Q?J=E9r=E9mie?= Galarneau
 <jeremie.galarneau@efficios.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
Message-ID: <20200512181513.vuBoL-ILdagvrz_UtaK_VGoNtRnN0ZPkExEcyZwq0y8@z>

Hi all,

The first bug-fix release of LTTng-tools 2.12 - (Ta) Meilleure has
just been released. This release addresses a number of issues listed
below.

2020-05-12 lttng-tools 2.12.1 (International Nurses' Day)
	* API: missing includes in lttng.h
	* API: missing clear and clear-handle includes in lttng.h
	* API: sort lttng.h includes
	* Fix: API: missing end brace for C++ linkage specification.
	* Fix: tests: `-Wstringop-overflow` warning
	* Fix: load: incomplete error handling for load_session_from_file

As always, please report any issue you may encounter to bugs.lttng.org
or on this mailing list.

Project website: https://lttng.org

Download link:
https://lttng.org/files/lttng-tools/lttng-tools-2.12.1.tar.bz2

GPG signature:
https://lttng.org/files/lttng-tools/lttng-tools-2.12.1.tar.bz2.asc
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
