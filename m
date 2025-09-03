Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [158.69.130.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E9E3CA1007
	for <lttng-dev@archiver.kernel.org>; Wed,  3 Sep 2025 01:35:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4cGlY36qDrz1Tkp
ARC-Seal: i=1; d=lists.lttng.org; s=arc1; a=rsa-sha256; cv=none; t=1756863320;
	b=b3WqYcqyyQ+RXuUmsiR1wvygmqKecBY3/dNptfQkkb5gUMnUZHKAb3nuQUf4ZLqQ4/l2
	 aHTobFkInRvpFKbBdzjZ4xAiu/CFnp8lRCFxMIV8X6DY4wokmHxxih9NgGKVKncsxaU91
	 E7m5Jm7tTBgPhX1MgyhCrX6vrgKqyGrx60oyUf1daRy/MzPqzs0ZTOvCrUFuHTr2twAcG
	 KdVrxzrc/+dtTY8mCqPWHzKY9smpOWp8XvLCwuWoqng7/B7xA2ji4F1I1MPxNtL/TklRi
	 snwbmhqBT2XBsdLA9J9J7kmVmXYqmYK+NkAocsGot4YLiiPzbmGYegaKei+l0hjPo3Q==
ARC-Message-Signature: i=1; d=lists.lttng.org; s=arc1; a=rsa-sha256;
	c=relaxed/simple; t=1756863320;
	h=DKIM-Signature:To:Subject:Date:Message-ID:MIME-Version:From:From;
	bh=Nm/NJuOoKIwXKRRnMkxC6hBGHGl+YK+NEF6Z59tUDes=;
	b=kmyUWZDhvBuK/L+mNbThxSqVkM3hyrlSRj+LriWA02e89vibcwcaVA/3GgDxOAVUej02
	 NBogJvbqPZ6hTusd1HX3Lduar7nP7A9LZGfSFKAxb6qLM4i98rKRu5dM3Ma4nDsj0pol3
	 UBZ/fZM0eciXCeS9HDxBR578sciXE/wtf68vtTJt8qdlTpRfuUsmOQ23dsBtOGQKZuVY1
	 GZlx4S7CtQUNFI+on4qjiVpfyXvaOgYfi+kN7W4hzaOm/wCnms56g2HY7YT38wpAIlxmS
	 MXvmJt6zUBTZEDod3tRzTA0sJD/MOnnpIFI2lL5B+FbLcdywPMS4fEG0hF+eccmMyLA==
ARC-Authentication-Results: i=1; lists.lttng.org; arc=none smtp.remote-ip="::1"
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4cGlY36qDrz1Tkp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1756863320;
	bh=Nm/NJuOoKIwXKRRnMkxC6hBGHGl+YK+NEF6Z59tUDes=;
	h=To:Cc:Subject:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=K/faNCsCyqsSYmU6z79wqLtYt6Y05fnv73kl1HIPQC++VqmeTF/2pS+95IucnuMyK
	 dyDa2aaTQCRt4Ycp/s1hGvwy+yUjRG73ORk7lwRzd4qXEAAESs1aLBCjWbjvWfpDEn
	 p8YV0f0WO2CYKEuoqhaCBQNe7EsZG+j1EfsUCrcRCuV3nhNKnbNCN4mRI3r7r55LSs
	 GdGlRebCWy9NJPs67kw/BqpPxNwQ7MeUw9vRwc+q5c6i3g4IweeEKx2a8rufyva7Je
	 N4vgvS2OxFX4b1FH3VDHzO3x3AQcXHBoZ64bk6MqlgJgAX01Szv5mPQBFTgSO6wQIS
	 8ysvlnvtAqKlg==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4cGlY36qDrz1Tkp;
	Tue,  2 Sep 2025 21:35:19 -0400 (EDT)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4cGlY24nBdz1Tkl
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4cGlY24nBdz1Tkl
Received: from smtpout.efficios.com (smtpout.efficios.com
 [IPv6:2607:5300:400:ed00::31e5])
 by lists.lttng.org (Postfix) with ESMTPS id 4cGlY24nBdz1Tkl
 for <lttng-dev@lists.lttng.org>; Tue,  2 Sep 2025 21:35:18 -0400 (EDT)
Received: from localhost (199-193-172-8.cpe.axion.ca [199.193.172.8])
 by smtpout.efficios.com (Postfix) with ESMTPSA id 4cGlY12CgDz7Sc;
 Tue, 02 Sep 2025 21:35:17 -0400 (EDT)
To: Thobias Knudsen <thobknu@gmail.com>, =?utf-8?B?T25kxZllaiBTdXLDvQ==?=
 <ondrej@sury.org>
Cc: lttng-dev@lists.lttng.org
Subject: Re: URCU feature request?
In-Reply-To: <CAKGpcip6w2nVQ+vbtfFH1296xTi5HYX+68J8okecChsihejDQA@mail.gmail.com>
Organization: EfficiOS
References: <CAKGpciq6Cb6+hqsfn+_zPk+MqCg+b0M_Gc3jVxVvnEGcE8rdLw@mail.gmail.com>
 <CAKGpciqHpGqGJChLa8p4P4Xv7EyUPMxULHxeknOTyie8kHH6hg@mail.gmail.com>
 <3c49eadb-f310-46b2-984d-58a0c193cde9@efficios.com>
 <CAKGpcipt=fWJi9Y497C3vq03CXmPY6rXQqs8ZP9nDoTGdRKnAA@mail.gmail.com>
 <CAKGpcipfyp3Ds4J0OH96Mu4zVhCLJg8g6tqEnfcRscZ1T8EmVA@mail.gmail.com>
 <2f0dc1b4-3fcb-453c-aa42-4a1f85623300@paulmck-laptop>
 <CAKGpciq+ixOVGN7TXYaF336ZEL_mOejzic5BvaKbexwwn_aqOQ@mail.gmail.com>
 <BD1A29BD-2AD2-4092-B1A2-DFEFAE77AAEE@sury.org>
 <CAKGpcip6w2nVQ+vbtfFH1296xTi5HYX+68J8okecChsihejDQA@mail.gmail.com>
Date: Tue, 02 Sep 2025 21:35:16 -0400
Message-ID: <87y0qwwc6j.fsf@laura>
MIME-Version: 1.0
Content-Type: text/plain
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
From: Olivier Dion via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Olivier Dion <odion@efficios.com>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

On Tue, 02 Sep 2025, Thobias Knudsen via lttng-dev <lttng-dev@lists.lttng.org> wrote:
> Yes but all read/write operations doesn't have the syntax of a function as
> you used in the example here i.e. use(...). When it is a function you can
> easily just change the implementation to check if it is called inside a
> read section. Some reads and writes are usually done by this syntax (a = b)
> and '=' cannot be overridden.
>
> BTW just saying that what we're talking about now is not the original
> topic, but if someone has an elegant solution to this that would be
> nice!

I am confuse about the overall discussion here.  Are we talking about
static checking of RCU pointers usage or runtime checking?

Is is possible to see the implementation you made so I can understand
better?

Thanks,
Olivier
-- 
Olivier Dion
EfficiOS Inc.
https://www.efficios.com

