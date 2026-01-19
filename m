Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [158.69.130.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A705D29C4C
	for <lttng-dev@archiver.kernel.org>; Mon, 19 Jan 2026 17:14:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4dvxrm5bNrz29Pm
ARC-Seal: i=1; d=lists.lttng.org; s=arc1; a=rsa-sha256; cv=none; t=1768842856;
	b=asa3SA4voD6D/MOToT2PGivPEfvU30DKGwv0K2E8SF1hcEubWn9ApvtLZtf1pPPvxwVx
	 O3JKEiVXkbL0prXLihwDxIMAOLs4fNCY0r5e7VuuwsbZqpRS/wcw8fl7TxBWTbex21cTC
	 1J74LWpxmixn7QvbPQFGdMmrsdac0Txz5nLMTyE++CKFCrSS1ekIV529F5f54tyINpqTj
	 l+vE8vFDuzlUlidM77VeihEtLoviTHIn/xaHs4QP2oekxRoeFQxXKY263FHo5kaxnRTBw
	 VIy45XDK3iKcKHu5FatN/VPl8GYYMEO0Ea/UxvSamFz2xlolAQpa29r/Kg2u1OsGB3Q==
ARC-Message-Signature: i=1; d=lists.lttng.org; s=arc1; a=rsa-sha256;
	c=relaxed/simple; t=1768842856;
	h=DKIM-Signature:MIME-Version:Date:Message-ID:Subject:To:From:From;
	bh=ZB+9Yn1oLS4yYBZQqXyT1mrYxEoKMcap6zaQ34IHjD4=;
	b=V4QK9fn5lnzAyv33RrmWGW89zdaurJufbsfyO13GkpLWiA6wDPd56DtB6iHpW55Q/dmG
	 OkyfTeHGnz+xaQtyeq86c8jNiW1lVZKdkBgTh4ZEv5jgDrhYuS3BfKpm/lTNNJoDBFSU1
	 BCKYSPiVkfX2dHCuR+WxiU3qKvLvkZyIJcjYBFiLpfxujxvWqQMoENymZdvIeO63xOZyT
	 1IeDK+dJV5virDZCwAgrlCSpz9wpkyCAgGpmsw8zWRre6V9ZzsYgCCO+dGHDALsZT/jgK
	 dJlzchzYmz9INjGjWjx2A8glKk5I1+7Mn1k695tfbKaUzo+UEgUludLXEDFMIDGNEDw==
ARC-Authentication-Results: i=1; lists.lttng.org; arc=none smtp.remote-ip="::1"
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4dvxrm5bNrz29Pm
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.lttng.org;
	s=default; t=1768842856;
	bh=ZB+9Yn1oLS4yYBZQqXyT1mrYxEoKMcap6zaQ34IHjD4=;
	h=References:In-Reply-To:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=imRbkyvfEV189JqICnh3FSVPesYAzWzgxDUIg5LHCcZfyZ7Utt11mwzJQDFa9zS77
	 tfcBDyb50Ip272LRSm3dJ09BJNFN9L6z5sBvmTD1FK/PP4cy8DvlSfWNMfFIsYdqNT
	 TMXA1ncH++cnHvix22yaJsWm6zz1c8qY8/CGukz5Ab5P2AgUC2fQ/mKHSv9zabeIso
	 C+uVsXeudJfpoXajfOC6IE/nCQQAj+ZYUIS1WAb3/cxSMm9GX0CppS+ArGP8hgi3WE
	 efalZ9NmtL4rMzTN7jxtJTLX8Xgzfz64dFR5Ar1eRJp1XtJ5TVTrapo11hyIWmKAc2
	 2IXszjyKEWWbg==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4dvxrm5bNrz29Pm;
	Mon, 19 Jan 2026 12:14:16 -0500 (EST)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4dvxrl3wW0z28th
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4dvxrl3wW0z28th
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com
 [IPv6:2607:f8b0:4864:20::1134])
 by lists.lttng.org (Postfix) with ESMTPS id 4dvxrl3wW0z28th
 for <lttng-dev@lists.lttng.org>; Mon, 19 Jan 2026 12:14:15 -0500 (EST)
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-7927b1620ddso63845227b3.0
 for <lttng-dev@lists.lttng.org>; Mon, 19 Jan 2026 09:14:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768842854; x=1769447654;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZB+9Yn1oLS4yYBZQqXyT1mrYxEoKMcap6zaQ34IHjD4=;
 b=ukOGPK9J9GQJALBgOzlN36Ns7rosrBATXpnP0NUhBhoAdHbr8MghwgVf4q0OxtOBo+
 1KI9fahIuJiixk6drxaijGM04n3Mwm470Yqsuq2ZHY81O1PTZxGVFP0RHzYdSm37Ur6A
 u5j3XGf9GOsUe6IMptR7tVYwM7s7AB0TpYqDcqzrrMyxTNxJYFPocFIDBpC9I+xtja9F
 ddSEMCBGXAlLWdUdyMr37QJl5O0iNnNbMHwXbba8FMBKWvhHQJPtWiFAMqfX7lFrN/rU
 1aMNDNkCSEXOL72Z/35fV17vj9IJEFVbW1F0mIkIlznxDSwkJ9ZpNYYVTooHr+bpJ4Mt
 6qXg==
X-Gm-Message-State: AOJu0YwHMt04SoGmo3NGOpkOTLrRU/6/uggHLUv8kbrcs3ZpeCV8Wn2I
 18nMLV/DnAIFxoLmMnEw48lmhRrAnXnooBQVFh7JvYCKeULrs/pLw77cb2uH12Ktf/EjvCrscXb
 D8/y2VwSGqQ47Z0HbqA/lM4A8h+xKWCUE+IZZ
X-Gm-Gg: AZuq6aJMYdMibsbtOK62/wlNg7aZMmGQu0kmak/DmLoLM8epeCR54q2xc5PGlXeajVT
 ihVflxi82lWJI0rlBhwH0wI/jTclsVmn/c0YKbcIWwEzvLzpXjD+3YrbYZAuhas3Qy9W/hybEEr
 o2gd4GuZxX+xiBI7CmeDnWdB9o08xcrX8XpzAq2aVwF/2/+YAge1KBlQeXzAdj8xF1UZTKwh2wE
 XLg1rkUEncPOek2UEa/guiCGLOrfS6iG+fyXo/F8ESHiHdswfgRmJ0Q7sM7iR5aS8gVORcCRMDg
 ybsl4c2z
X-Received: by 2002:a05:690c:4b8c:b0:791:6d18:3bfe with SMTP id
 00721157ae682-793b354ea94mr122795877b3.28.1768842854296; Mon, 19 Jan 2026
 09:14:14 -0800 (PST)
MIME-Version: 1.0
References: <CAJK_ieh7GpnMBe-J3ktiU4EmE2puqafgx4pmEBoJsbqKz9LEEA@mail.gmail.com>
 <c3a11b9b-5cd1-4a0c-b15c-d86a5f0d3924@efficios.com>
In-Reply-To: <c3a11b9b-5cd1-4a0c-b15c-d86a5f0d3924@efficios.com>
Date: Mon, 19 Jan 2026 17:14:02 +0000
X-Gm-Features: AZwV_QhaYIADCtLx0dQ1RM8k7a3XAI6q8MBizvWXYI_dVR5Yrg946FvxXWS01rg
Message-ID: <CAJK_ieg60p6=3sdLSQGoPPEYGx8J=VdFS5vHx-=0APvpnOUmuw@mail.gmail.com>
Subject: Re: How to build lttng on RHEL 9?
To: Kienan Stewart <kstewart@efficios.com>
Cc: lttng-dev@lists.lttng.org
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
From: David Aldrich via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: David Aldrich <david.aldrich.ntml@gmail.com>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

Hi Kienan

> What's the exact version number of the kernel you're trying to build for?

Thanks for your reply. Our kernel version is:

$ uname -r
5.14.0-570.60.1.el9_6.x86_64

David
