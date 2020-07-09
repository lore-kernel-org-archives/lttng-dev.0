Return-Path: <SRS0=4dcy=AU=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D4AFC433DF
	for <lttng-dev@archiver.kernel.org>; Thu,  9 Jul 2020 13:22:58 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44BA52074B
	for <lttng-dev@archiver.kernel.org>; Thu,  9 Jul 2020 13:22:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.lttng.org header.i=@lists.lttng.org header.b="ezdAiKmR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44BA52074B
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4B2cL86zqwz1CPv;
	Thu,  9 Jul 2020 09:22:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1594300977;
	bh=ycGAPCFeyON4xZfdQ7XHLDbNW++x5+MiiFBrPySNKbY=;
	h=References:In-Reply-To:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=ezdAiKmR/pMYl3RFEzihtnd0ZDUBOcKlw3f3d5wCFLvjM2OCiSG+pC0Z1KkRvV8ZJ
	 V2V/d2rJlOMEE3VIlSidljr8z/FJZjuHCs8d9cojJUDxGhFdsNbtzLvQl6ataOU+jQ
	 5819YqnZUpE66zuOilVLNVm8rgpl5RiZ3fCNOh0a9xM6hQVsvvwsax+QSvhFHzGLEA
	 KxStt0yEs0CaJ9SsocezEBMLS3OvB+QuZFWsx8laqaaZVt8C0NrAmifrj6vBAvdMC3
	 SKe7Hi/7JmcLa4MyeXty1agvtgifmARu/X8uVc37GhTP30PoImpApJ6zoZUBw4vmgG
	 D96Cu9baMFbEA==
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com
 [IPv6:2607:f8b0:4864:20::229])
 by lists.lttng.org (Postfix) with ESMTPS id 4B2cL746CGz1CDD
 for <lttng-dev@lists.lttng.org>; Thu,  9 Jul 2020 09:22:55 -0400 (EDT)
Received: by mail-oi1-x229.google.com with SMTP id k6so1815375oij.11
 for <lttng-dev@lists.lttng.org>; Thu, 09 Jul 2020 06:22:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=qYjCBBBNWD8dv8IFQp6cfVqtVTOsAizJ8Q5saio9jkc=;
 b=VSVt6livBQJDP6zU90TPi5XlUemcu0INKI7URcZ7t//heiPMIDHNmTDEeSDJgBKUlj
 eBU+55CSggl3/RJunmtjqwSi2KYG4ajtDu4ie9Exw7PLx+2CHheBVOeIw9Fhd5Z7ti0V
 ouVxxXeySmXROhOxG2ff7gUEumBzwXoYyytjGYy4Ejze+uoUwXwnyN3nW2mTiCwXmE2l
 RuS7e7rtIo0zUw8BqcqnGSU4j4XXRcNoIHXFcCBIypABm5aHGZp4WBjRDS1d+sB4frq+
 8/dsmXhFdyQmIlgHVkPZkhSA4d4G5moAwS56R6y9uxD6SPo5i4/QOjzZhVnevnVfWruK
 71bA==
X-Gm-Message-State: AOAM533oHWH5mtjUTm7HZvkY5bdOYNiUlGpqT65sgQnUUiLaedRVSEBN
 Jz1T0D5ZDdOaF1Jxck+ofOwkRouXIYuOlJp3OBXXf5C8ZJU=
X-Google-Smtp-Source: ABdhPJw+Kcf+Mo5yZikzEu5aWmJxWN4GYbrtqTiSHNUdwiIc7SjNfWsm97FIuEbkhG8m3KPAO++mt0Jjv3AFfl6YJrw=
X-Received: by 2002:aca:c30e:: with SMTP id t14mr10565850oif.95.1594300974820; 
 Thu, 09 Jul 2020 06:22:54 -0700 (PDT)
MIME-Version: 1.0
References: <CABhb4uu6dxo_5pVUTXaz3qkGS41Ame77Bp5ePWT42cJ2PANFvA@mail.gmail.com>
 <434663210.6203.1594300516699.JavaMail.zimbra@efficios.com>
In-Reply-To: <434663210.6203.1594300516699.JavaMail.zimbra@efficios.com>
Date: Thu, 9 Jul 2020 16:22:38 +0300
Message-ID: <CABhb4uvrOs28S-3HLdpwq5r7D715wbhMwAAOY_ie11gTc9t10A@mail.gmail.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
Subject: Re: [lttng-dev] Payload of syscall_entry_execve
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
From: Valentin Grigorev via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Valentin Grigorev <valentin.grigorev@jetbrains.com>
Content-Type: multipart/mixed; boundary="===============6472654758526287493=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
Message-ID: <20200709132238.nXOtraXcgQwWYqudxhtFpRzwVAk33MrDuDb-yXBPSng@z>

--===============6472654758526287493==
Content-Type: multipart/alternative; boundary="00000000000045211c05aa021f62"

--00000000000045211c05aa021f62
Content-Type: text/plain; charset="UTF-8"

Thanks for the information, Mathieu

Best regard,

> Valentin Grigorev

--00000000000045211c05aa021f62
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div>Thanks for the information,=C2=A0Mat=
hieu</div><div><br></div>Best regard,<div dir=3D"ltr"></div><div class=3D"g=
mail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><div style=3D=
"font-family:arial,helvetica,sans-serif;font-size:12pt;color:rgb(0,0,0)"></=
div></blockquote></div><div>Valentin Grigorev</div></div></div>

--00000000000045211c05aa021f62--

--===============6472654758526287493==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============6472654758526287493==--
