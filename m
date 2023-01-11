Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7476DC46467
	for <lttng-dev@archiver.kernel.org>; Wed, 11 Jan 2023 11:01:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1673434905;
	bh=7XuE79vFJsL4B1pB8xolky57WAh3D7vaEYKPrHKeG6w=;
	h=To:References:Date:In-Reply-To:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=j0CDe7YC4qYAT+D1czfwDM9meVyJNwvytD6EqA9t9UUoDA7vYyR1heJ/IPqmtY6xB
	 UMFW2Pp2H9KT3RNDXUQGYb8wXJGjLPhfghcmjz2J6uDcoYgiERS2HtWxVoAwWlBk/k
	 gHDgUJeXgLUODMh17nDDYpyDY5m2gadaO5unE4UunjBmQw6tr9nOG6ZB14ROrNSHxP
	 UDJVDgE+xe8/HyLmK0WHqJFErAMqeSRllxaF9ca/zZ4i7Lx/xtXfjhSeUdACN1X0Hs
	 2flqOrYYqfYO7Z0Wawn/DdxdMF2U2vgiG6w08yRtyaf2n75A+1RHaBSQGCp+bxVrKE
	 EZiG/POpvBtkQ==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4NsPrQ3nFHz1PfT;
	Wed, 11 Jan 2023 06:01:42 -0500 (EST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4NsPrP2PYPz1Pkx
 for <lttng-dev@lists.lttng.org>; Wed, 11 Jan 2023 06:01:41 -0500 (EST)
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-224-awEXka7KNQiMCd1uBM-e-Q-1; Wed, 11 Jan 2023 06:01:31 -0500
X-MC-Unique: awEXka7KNQiMCd1uBM-e-Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 256DF3814954;
 Wed, 11 Jan 2023 11:01:31 +0000 (UTC)
Received: from oldenburg.str.redhat.com (unknown [10.2.16.17])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3C666140EBF4;
 Wed, 11 Jan 2023 11:01:30 +0000 (UTC)
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
References: <87h6wyhd7l.fsf@oldenburg.str.redhat.com>
 <d17dbab6-5222-7065-ae0e-144687b2efc6@efficios.com>
Date: Wed, 11 Jan 2023 12:01:28 +0100
In-Reply-To: <d17dbab6-5222-7065-ae0e-144687b2efc6@efficios.com> (Mathieu
 Desnoyers's message of "Tue, 10 Jan 2023 14:46:42 -0500")
Message-ID: <87r0w1cp2v.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Subject: Re: [lttng-dev] lttv: Document project status as unmaintained
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
From: Florian Weimer via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Florian Weimer <fweimer@redhat.com>
Cc: lttng-dev@lists.lttng.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

* Mathieu Desnoyers:

> Hi Florian,
>
> I'll pull your patch into the lttv master branch, but please be aware
> that the LTTV project has not seen activity since 2013, is currently
> unmaintained, and that we do not plan on doing further releases of this
> project. Our efforts were diverted elsewhere on the trace analysis
> front, namely into Trace Compass and Babeltrace.
>
> In order to clarify the situation, I will introduce a commit into
> LTTV's master branch which will remove Yannick Brosseau from the
> maintainer role in the README file, and add this section at the
> beginning:

Understood.  Fedora is building a lot of legacy software, and many of
the C99 fixes are in this area.

Thanks,
Florian

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
