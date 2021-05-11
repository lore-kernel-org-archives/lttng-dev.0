Return-Path: <SRS0=3D3p=KG=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56B6FC433B4
	for <lttng-dev@archiver.kernel.org>; Tue, 11 May 2021 00:35:58 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 445C86147D
	for <lttng-dev@archiver.kernel.org>; Tue, 11 May 2021 00:35:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 445C86147D
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4FfJqv1Qzhz1m79;
	Mon, 10 May 2021 20:35:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1620693355;
	bh=/mAiof/xbzIz11By9HlEIPSrBHC85axvwS6EL7/k4rg=;
	h=References:In-Reply-To:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=WZlUUNi7GP7pdT+JkHU6KYb9XqMcOo9O2zm3KmNiivLICkGets5hLhmUCxqCCIxzf
	 2pByrFs8b545uvqyBDiaoERTE/7bLmRPObGyEd/I7YoH3RNYoNCQHQD4ufSyCc0Ezz
	 yhf0sGSAmtQAipsuj2BoQXbK39mupBkTpSJy9DpZ4r/jGXpsSPkXMzIqXQs5gpR8MC
	 MsktSZIxmDiRWxGgJCBKV1vRuk9NoQeR8769v8E1Fu+3GOwLRR3N1mXb1p46MvtTsF
	 3+0iE6tSjzAjYp2iup++WD+li/VTIAmKZS4vuzmIovDvf5tcnMyBUEwT+SFT22ikKy
	 uP4TYT9VhkUBA==
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 by lists.lttng.org (Postfix) with ESMTPS id 4FfJqr72Jpz1lTV
 for <lttng-dev@lists.lttng.org>; Mon, 10 May 2021 20:35:52 -0400 (EDT)
Received: by mail-ot1-x335.google.com with SMTP id
 g15-20020a9d128f0000b02902a7d7a7bb6eso16080693otg.9
 for <lttng-dev@lists.lttng.org>; Mon, 10 May 2021 17:35:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=FeQTQM19w6yFICfYEZf984DSjs5yCgadCxvhMnngCIc=;
 b=I8WDu3l9yBhFQEPXo1qvWjElxlZpfm5rMhbTG4Eo+MREbd8ogsMB384IaBRaZ31LA6
 rwFbrNJxu9FpMnfP866d4mi9LzYqb1Ik0jL+UzkCYaG5ayfTQIcFxMhlt9vg/80Pv4SQ
 z6PBmUi7E3tV6m9ta07JGYNLDkamCxfmUxdZ+ynmuqf2lct2qPQJgOxd52RGZa05cZmL
 r/tLtVIxm9qy/Vqfl+O7vAykEvjvftkzv4ansc+0NBeXPX0xY9YCCPN9JLYKgO88CgHJ
 8nvsdL+w1FOL2TW9xaqMQ3wXF5434+NZ+c624BhIFwaW3XpoZoguvPnn5KQTQ/TeQLwb
 ZERQ==
X-Gm-Message-State: AOAM5330/fIjrXDGhcR9u0dAuL3e/l/TtyvdLsVRJ55brSDJreuKvlVa
 NhdqYB3x0NazB8wblzmxEUxzzUgrMQZ6PmMQ05E=
X-Google-Smtp-Source: ABdhPJyVPgpuFi82hU8mdzOOiW5zShUHcyXY79a1CkGH12VI7HMFTaa3qq6FqEPMfyeNJj2XZbd6FRrR5PuF3aLj9l8=
X-Received: by 2002:a9d:1d45:: with SMTP id m63mr2859434otm.302.1620693352136; 
 Mon, 10 May 2021 17:35:52 -0700 (PDT)
MIME-Version: 1.0
References: <CAPj=WkjEZN+_NgrnF3djfF_jCyp+D195e+KpzqzAK9kfmrTu6Q@mail.gmail.com>
 <20210507180532.GA1227214@joraj-alpa>
In-Reply-To: <20210507180532.GA1227214@joraj-alpa>
Date: Mon, 10 May 2021 17:35:41 -0700
Message-ID: <CAPj=Wkgmf1xGq0H4ka5B5KyXipGReFMuQo4=aMK5NS6fPVL3oA@mail.gmail.com>
To: Jonathan Rajotte-Julien <jonathan.rajotte-julien@efficios.com>
Cc: lttng-dev@lists.lttng.org
Subject: Re: [lttng-dev] lttng live event loss with babeltrace2
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
From: Eqbal via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Eqbal <eqbalzee@gmail.com>
Content-Type: multipart/mixed; boundary="===============5401010722200824559=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--===============5401010722200824559==
Content-Type: multipart/alternative; boundary="0000000000008b42a405c203132d"

--0000000000008b42a405c203132d
Content-Type: text/plain; charset="UTF-8"

Hi,

I ran my test with the new changes and it seems to improve the lossiness
but not eliminate it. For example it seems in the hello world example that
if the application exits too quickly after emitting the tracepoint, we
might still lose some events in the consumer even though they are present
in the relayd output folder. I don't quite understand why that is. Would
love some explanations on the various timing windows where we have a
potential to lose the events on the consumer side.

Thanks,
Eqbal

On Fri, May 7, 2021 at 11:05 AM Jonathan Rajotte-Julien <
jonathan.rajotte-julien@efficios.com> wrote:

> Hi,
>
> See
> https://github.com/lttng/lttng-tools/commit/c876d657fb08a91ca7c907b92f1b7604aee664ee
> .
>
> We would appreciate your feedback on this if possible based on your use
> case.
>
> Cheers
>
> On Mon, May 03, 2021 at 05:05:10PM -0700, Eqbal via lttng-dev wrote:
> > Hi,
> >
> > I have a lttng live session trace consumer application using
> libbabeltrace2
> > where I create a graph to consume lttng live session traces and output to
> > another sink. I am running the graph in a loop at some polling interval
> as
> > long as I get BT_GRAPH_RUN_STATUS_AGAIN status. What I am noticing is
> that
> > if my polling interval is large enough I tend to lose either all or some
> of
> > the events. I experimented with various polling intervals and it seems if
> > the polling interval is less than *DELAYUS *from "lttng-create
> > --live=DELAYUS" option then I am able to get all the events, otherwise I
> > tend to lose events.
> >
> > Here are the steps I follow:
> > 1. start session daemon and relay daemon
> > 2. create a live session (with default delay of 1s), enable events and
> start
> > 3. Start my application (hello world example from lttng docs)
> > 4. Start the consumer application built using libbabeltrace that connects
> > to the live session
> >
> > I noticed that the events are actually persisted in the ~/lttng-traces by
> > the relay daemon, but it does not reach babeltrace consumer application.
> I
> > have noticed the same behavior with babeltrace2 cli.
> >
> > I would like to understand what is the reason for such behavior and if
> > playing with the polling interval in relation to the DELAYUS value is the
> > right thing to do.
> >
> > Thanks,
> > Eqbal
>
> > _______________________________________________
> > lttng-dev mailing list
> > lttng-dev@lists.lttng.org
> > https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>
>
> --
> Jonathan Rajotte-Julien
> EfficiOS
>

--0000000000008b42a405c203132d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi,</div><div><br></div><div>I ran my test with the n=
ew changes and it seems to improve the lossiness but not eliminate it. For =
example it seems in the hello world example that if the application exits t=
oo quickly after emitting the tracepoint, we might still lose some events i=
n the consumer even though they are present in the relayd output folder. I =
don&#39;t quite understand why that is. Would love some explanations on the=
 various timing windows where we have a potential to lose the events on the=
 consumer side.</div><div><br></div><div>Thanks,</div><div>Eqbal<br></div><=
/div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">O=
n Fri, May 7, 2021 at 11:05 AM Jonathan Rajotte-Julien &lt;<a href=3D"mailt=
o:jonathan.rajotte-julien@efficios.com">jonathan.rajotte-julien@efficios.co=
m</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin=
:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"=
>Hi,<br>
<br>
See <a href=3D"https://github.com/lttng/lttng-tools/commit/c876d657fb08a91c=
a7c907b92f1b7604aee664ee" rel=3D"noreferrer" target=3D"_blank">https://gith=
ub.com/lttng/lttng-tools/commit/c876d657fb08a91ca7c907b92f1b7604aee664ee</a=
> . <br>
<br>
We would appreciate your feedback on this if possible based on your use cas=
e.<br>
<br>
Cheers<br>
<br>
On Mon, May 03, 2021 at 05:05:10PM -0700, Eqbal via lttng-dev wrote:<br>
&gt; Hi,<br>
&gt; <br>
&gt; I have a lttng live session trace consumer application using libbabelt=
race2<br>
&gt; where I create a graph to consume lttng live session traces and output=
 to<br>
&gt; another sink. I am running the graph in a loop at some polling interva=
l as<br>
&gt; long as I get BT_GRAPH_RUN_STATUS_AGAIN status. What I am noticing is =
that<br>
&gt; if my polling interval is large enough I tend to lose either all or so=
me of<br>
&gt; the events. I experimented with various polling intervals and it seems=
 if<br>
&gt; the polling interval is less than *DELAYUS *from &quot;lttng-create<br=
>
&gt; --live=3DDELAYUS&quot; option then I am able to get all the events, ot=
herwise I<br>
&gt; tend to lose events.<br>
&gt; <br>
&gt; Here are the steps I follow:<br>
&gt; 1. start session daemon and relay daemon<br>
&gt; 2. create a live session (with default delay of 1s), enable events and=
 start<br>
&gt; 3. Start my application (hello world example from lttng docs)<br>
&gt; 4. Start the consumer application built using libbabeltrace that conne=
cts<br>
&gt; to the live session<br>
&gt; <br>
&gt; I noticed that the events are actually persisted in the ~/lttng-traces=
 by<br>
&gt; the relay daemon, but it does not reach babeltrace consumer applicatio=
n. I<br>
&gt; have noticed the same behavior with babeltrace2 cli.<br>
&gt; <br>
&gt; I would like to understand what is the reason for such behavior and if=
<br>
&gt; playing with the polling interval in relation to the DELAYUS value is =
the<br>
&gt; right thing to do.<br>
&gt; <br>
&gt; Thanks,<br>
&gt; Eqbal<br>
<br>
&gt; _______________________________________________<br>
&gt; lttng-dev mailing list<br>
&gt; <a href=3D"mailto:lttng-dev@lists.lttng.org" target=3D"_blank">lttng-d=
ev@lists.lttng.org</a><br>
&gt; <a href=3D"https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev"=
 rel=3D"noreferrer" target=3D"_blank">https://lists.lttng.org/cgi-bin/mailm=
an/listinfo/lttng-dev</a><br>
<br>
<br>
-- <br>
Jonathan Rajotte-Julien<br>
EfficiOS<br>
</blockquote></div>

--0000000000008b42a405c203132d--

--===============5401010722200824559==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============5401010722200824559==--
