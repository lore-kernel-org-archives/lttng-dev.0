Return-Path: <SRS0=Aspu=I3=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB7D7C433C1
	for <lttng-dev@archiver.kernel.org>; Mon, 29 Mar 2021 13:51:37 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 234106157F
	for <lttng-dev@archiver.kernel.org>; Mon, 29 Mar 2021 13:51:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 234106157F
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4F8DWq3mxgzQ1l;
	Mon, 29 Mar 2021 09:51:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1617025896;
	bh=rzl4LbthpmDuPEFD4F7ygBauHT+Lbz27MiZcALibD0M=;
	h=Date:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=jNX3Q5vdeJ+Jf+RLyR8PvffqfJyZJhSPbhr96hFqjPLHVDXtJGmxI/OJg+mMaXTwJ
	 0RoNuJP8KQgrqEE56DF/WNRMKfhhqnxG5bn9jod1Ha66vxLSIliyCUf10sJ5SXtURy
	 GJ2cHG9MxXcJGIQ2NIGR6UtAt0q9zKVa9Tui/8xqHr5dtDN1p0K7f4SBI9wyCWomSN
	 zuPlp6j9Qp0J/mwOCIq9XJMOGn2KO52XyuwyaoCHMlezbnXp4xupG4vg8d7K899pLa
	 fq7z++fLMS4EUvPcJEgiC3NIID29YN7AgQ/cKnVIsfw7Dgi2hoYFsyeyF27QYBOCBX
	 77engmo2SOMeQ==
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4F8DWn5zllzQNS
 for <lttng-dev@lists.lttng.org>; Mon, 29 Mar 2021 09:51:33 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 8B04729FF7F
 for <lttng-dev@lists.lttng.org>; Mon, 29 Mar 2021 09:51:27 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id BMoF8gT1ZwJe; Mon, 29 Mar 2021 09:51:26 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 26E6C29FF7E;
 Mon, 29 Mar 2021 09:51:26 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 26E6C29FF7E
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id Vh2dtWEJwFRG; Mon, 29 Mar 2021 09:51:26 -0400 (EDT)
Received: from joraj-alpa (unknown [107.159.43.215])
 by mail.efficios.com (Postfix) with ESMTPSA id EE40329FF7D;
 Mon, 29 Mar 2021 09:51:25 -0400 (EDT)
Date: Mon, 29 Mar 2021 09:51:25 -0400
To: MONTET Julien <julien.montet@reseau.eseo.fr>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
Message-ID: <20210329135125.GC756172@joraj-alpa>
References: <PR3PR02MB62022F27BFAE30836B7E094ED17E9@PR3PR02MB6202.eurprd02.prod.outlook.com>
 <PR3PR02MB62020781F58EA33A0430FF02D17E9@PR3PR02MB6202.eurprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <PR3PR02MB62020781F58EA33A0430FF02D17E9@PR3PR02MB6202.eurprd02.prod.outlook.com>
Subject: Re: [lttng-dev] LTTng 32 bits : Cannot find liburcu-bp 0.11 or newer
X-BeenThere: lttng-dev@lists.lttng.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: LTTng development list <lttng-dev.lists.lttng.org>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
From: Jonathan Rajotte-Julien via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Jonathan Rajotte-Julien <jonathan.rajotte-julien@efficios.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

Hi Julien,

Yeah, the urcu version is wrong here it should be >=3D 0.11. We will get th=
at fixed.

Thanks

On Mon, Mar 29, 2021 at 01:24:48PM +0000, MONTET Julien via lttng-dev wrote:
> Oh my bad !
> You just have to choose modify the lines of the tutorial (rcu).
> I chose userspace-rcu-0.12.2.tar.bz2<https://lttng.org/files/urcu/userspa=
ce-rcu-0.12.2.tar.bz2> and it installed well.
> ________________________________
> De : MONTET Julien
> Envoy=E9 : lundi 29 mars 2021 11:43
> =C0 : lttng-dev@lists.lttng.org <lttng-dev@lists.lttng.org>
> Objet : LTTng 32 bits : Cannot find liburcu-bp 0.11 or newer
> =

> Hi everyone,
> =

> I successfully installed and used LTTng on x86 and x64 (kernel event, use=
rspace, and other tools like TraceCompass).
> =

> Now, I am looking for a way to use LTTng on other processors (arm32, ...).
> =

> I tried to follow the tutorial and, to be honest, I am quite not lost on =
step 2. (libuuid, popt, libxml2)
> https://lttng.org/docs/v2.12/#doc-instrumenting-32-bit-app-on-64-bit-syst=
em
> =

> My current issue is on the step 3.
> During the installation (./configure), I have the following error :
> error: Cannot find liburcu-bp 0.11 or newer. Use LDFLAGS=3D-Ldir to speci=
fy its location.
> =

> This file - liburcu - is in /usr/local/lib32 : Ubuntu Pastebin<https://pa=
ste.ubuntu.com/p/b67Bxf6cfB/>
> =

> This topic was started a long time ago here :
> https://lists.lttng.org/pipermail/lttng-dev/2013-February/019641.html
> =

> Would you mind helping me ?

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev


-- =

Jonathan Rajotte-Julien
EfficiOS
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
