Return-Path: <SRS0=W2C5=J7=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=BAYES_05,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97D88C433ED
	for <lttng-dev@archiver.kernel.org>; Tue,  4 May 2021 00:05:26 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C679B61183
	for <lttng-dev@archiver.kernel.org>; Tue,  4 May 2021 00:05:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C679B61183
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4FZ0Tw1bxkz1gpY;
	Mon,  3 May 2021 20:05:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1620086724;
	bh=l1Zv41Mm+uQXKps6Lr9CxXhzmxQGPSk+dIw3q99YIB0=;
	h=Date:To:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=peyM7a+bu+YS8rD+gltOfnH/KAgRrOPehQG1uMStcnnzmJoM9Mm3/OAo2Vl3Ec4Vm
	 sQWtBpFxJIYGJSnKrNbgEecClLsT0XcPvVqPD/nOcECgFQZclqoKgFtE75swYWj747
	 m5qJU6wmbUdE+hG9f98tw2vJWo52nSVg4gF8IKhqcKxIPWgBWk+DRDycdLJMgQfUm1
	 f78NakLCIXQ46rv7cXrgqL6gdN5JOgzaYxWReMM8Xv0ucnR5jKZB6PzxsGFSZh2umf
	 HXZygvNWNHXb/G7L1HWQ6qks9CDoQWBN4RRNo5GDbuSA5ZvVx05CPMv57nZGIqXwEG
	 QAS77/+8lILBA==
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 by lists.lttng.org (Postfix) with ESMTPS id 4FZ0Tt3NYDz1gkG
 for <lttng-dev@lists.lttng.org>; Mon,  3 May 2021 20:05:22 -0400 (EDT)
Received: by mail-ot1-x332.google.com with SMTP id
 d3-20020a9d29030000b029027e8019067fso6702319otb.13
 for <lttng-dev@lists.lttng.org>; Mon, 03 May 2021 17:05:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=RozEZU6FmWjtNnAHSw2irvOD51PKO9NfyBAXf6RtJ34=;
 b=oFG689Ni02q6FoAcChbp/tFu7HgHexDXB2XUEfhRMRn+ohocfQ3SbtwCNIvI+AQBPX
 cyrBT7z2rY52eqD2x+jgCLjeFiYQOiarstSE9yqTeQwvLooG6Ke6zl0+HGAilkKZs33K
 sQLNSgfeKzgufFdPBQZW7jrZ6rrpIIKb8rdeICXG+33RRWJLsM+/kR+NxuAP8Woi4XDY
 GvwRZ4dcg38+zm0LjnjyXyBL6mbTDa2RQGSLYBkfC6/8kEOfRz8khI9ES/BT+XrgW6/y
 r5jFcWuITcXRMEzqajAKaxW23jD4vhelLXX9G/MwDMPbCPS3oSpkH+tcxYDas4AShr08
 tlww==
X-Gm-Message-State: AOAM532x0a09lHS1C4Dg3Wy2m0LsJ8sdzbdrejvTaTukVwiqeNszFUCS
 mChURSNQv87Ejr49ej8OJd0gybnAImtZ2UQvp2Z3rEpBTbg=
X-Google-Smtp-Source: ABdhPJzHOr6XN+jxBUPL76slJyJuhV2n3X6w7GwUOkpNu41GjJ6Vrm/5dqOFqfCF0m0MJ07qAmskewdHsn4ojEqkcU4=
X-Received: by 2002:a05:6830:210a:: with SMTP id
 i10mr16536800otc.302.1620086721443; 
 Mon, 03 May 2021 17:05:21 -0700 (PDT)
MIME-Version: 1.0
Date: Mon, 3 May 2021 17:05:10 -0700
Message-ID: <CAPj=WkjEZN+_NgrnF3djfF_jCyp+D195e+KpzqzAK9kfmrTu6Q@mail.gmail.com>
To: lttng-dev@lists.lttng.org
Subject: [lttng-dev] lttng live event loss with babeltrace2
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
Content-Type: multipart/mixed; boundary="===============2924860752649463395=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--===============2924860752649463395==
Content-Type: multipart/alternative; boundary="000000000000897ab105c175d5ce"

--000000000000897ab105c175d5ce
Content-Type: text/plain; charset="UTF-8"

Hi,

I have a lttng live session trace consumer application using libbabeltrace2
where I create a graph to consume lttng live session traces and output to
another sink. I am running the graph in a loop at some polling interval as
long as I get BT_GRAPH_RUN_STATUS_AGAIN status. What I am noticing is that
if my polling interval is large enough I tend to lose either all or some of
the events. I experimented with various polling intervals and it seems if
the polling interval is less than *DELAYUS *from "lttng-create
--live=DELAYUS" option then I am able to get all the events, otherwise I
tend to lose events.

Here are the steps I follow:
1. start session daemon and relay daemon
2. create a live session (with default delay of 1s), enable events and start
3. Start my application (hello world example from lttng docs)
4. Start the consumer application built using libbabeltrace that connects
to the live session

I noticed that the events are actually persisted in the ~/lttng-traces by
the relay daemon, but it does not reach babeltrace consumer application. I
have noticed the same behavior with babeltrace2 cli.

I would like to understand what is the reason for such behavior and if
playing with the polling interval in relation to the DELAYUS value is the
right thing to do.

Thanks,
Eqbal

--000000000000897ab105c175d5ce
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi,</div><div><br></div><div>I have a lttng live sess=
ion trace consumer application using libbabeltrace2 where I create a graph =
to consume lttng live session traces and output to another sink. I am runni=
ng the graph in a loop at some polling interval as long as I get BT_GRAPH_R=
UN_STATUS_AGAIN status. What I am noticing is that if my polling interval i=
s large enough I tend to lose either all or some of the events. I experimen=
ted with various polling intervals and it seems if the polling interval is =
less than <em>DELAYUS </em>from &quot;lttng-create --live=3DDELAYUS&quot; o=
ption then I am able to get all the events, otherwise I tend to lose events=
.</div><div><br></div><div>Here are the steps I follow:</div><div>1. start =
session daemon and relay daemon <br></div><div>2. create a live session (wi=
th default delay of 1s), enable events and start<br></div><div>3. Start my =
application (hello world example from lttng docs)<br></div><div>4. Start th=
e consumer application built using libbabeltrace that connects to the live =
session</div><div><br></div><div>I noticed that the events are actually per=
sisted in the ~/lttng-traces by the relay daemon, but it does not reach bab=
eltrace consumer application. I have noticed the same behavior with babeltr=
ace2 cli.</div><div><br></div><div>I would like to understand what is the r=
eason for such behavior and if playing with the polling interval in relatio=
n to the DELAYUS value is the right thing to do. <br></div><div><br></div><=
div>Thanks,</div><div>Eqbal<br></div><div><em></em></div></div>

--000000000000897ab105c175d5ce--

--===============2924860752649463395==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============2924860752649463395==--
