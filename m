Return-Path: <SRS0=fpp6=IW=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D885FC433E0
	for <lttng-dev@archiver.kernel.org>; Wed, 24 Mar 2021 15:33:08 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E323619FF
	for <lttng-dev@archiver.kernel.org>; Wed, 24 Mar 2021 15:33:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E323619FF
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4F5C1G4QPCzMVM;
	Wed, 24 Mar 2021 11:33:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1616599987;
	bh=nq/s8MgBBjwGWa4mqTsdFWYiQ7vYe8ionneeIj8C7YM=;
	h=Date:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=TDRPN4rSOGSvwJrK78L0Fv6kWL0RHXB1gHH8Q5r1gp5DjlstyxVEvpKf6K0qY/JfS
	 kAdxO4HyR4eDK9no985TPGeoxjVKdq+yAHqWjOQBYmQzI+0cBHShJ2TPvoOj0C0k8o
	 e7P4EMJ3Xt1NIJ3QlNQnzJgGnk18JtQpoinRe9vumvFlHVG0ySTZAhn6FiNerrHk4R
	 1ahX+lP4GS5DlmWxSpRwn5v/wjQctlyihLWvdf4bYOhVtMX6mB2w9P664y0T+sg9h5
	 ryzvGTKyW9qvusV9PlP/4ZkPnETIy2J6NPv2l7DHF1fAnnbKU+rullNMLxG5smOM4u
	 zl6CbGSFnY15w==
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4F5C1D3YPjzM6T
 for <lttng-dev@lists.lttng.org>; Wed, 24 Mar 2021 11:33:04 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 06AD4248EEC
 for <lttng-dev@lists.lttng.org>; Wed, 24 Mar 2021 11:32:58 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id 8TuuZRH1owJN; Wed, 24 Mar 2021 11:32:56 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id C6A6D2493B3;
 Wed, 24 Mar 2021 11:32:56 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com C6A6D2493B3
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id tnhlUay2TyE5; Wed, 24 Mar 2021 11:32:56 -0400 (EDT)
Received: from joraj-alpa (192-222-181-218.qc.cable.ebox.net [192.222.181.218])
 by mail.efficios.com (Postfix) with ESMTPSA id 793762493B2;
 Wed, 24 Mar 2021 11:32:56 -0400 (EDT)
Date: Wed, 24 Mar 2021 11:32:55 -0400
To: MONTET Julien <julien.montet@reseau.eseo.fr>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
Message-ID: <20210324153255.GC344120@joraj-alpa>
References: <PR3PR02MB62023431654FB93182EA21A1D1639@PR3PR02MB6202.eurprd02.prod.outlook.com>
 <20210324142540.GB344120@joraj-alpa>
 <PR3PR02MB6202F969540C279A6A171F83D1639@PR3PR02MB6202.eurprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <PR3PR02MB6202F969540C279A6A171F83D1639@PR3PR02MB6202.eurprd02.prod.outlook.com>
Subject: Re: [lttng-dev] Issues on basic LTTng trace userspace (tutorial)
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

Hi Julien,

Please always keep the mailing list in CC.

> I am running 'lttng list --userspace' with the application running in another terminal (like the tutorial, and also with a while that loop on tracepoint(...).

ok.

> 
> You can find here the Ubuntu paste : Ubuntu Pastebin<https://paste.ubuntu.com/p/bWw25kmSTq/>

Based on this, it seems like lttng-ust is unable to find the socket for a sessiond either
locally (for your user) [1] or a global one (root lttng-sessiond) [2].

[1] 43:  libust[207688/207690]: Info: sessiond not accepting connections to local apps socket (in ust_listener_thread() at lttng-ust-comm.c:1822)
[2] 45:  libust[207688/207689]: Info: sessiond not accepting connections to global apps socket (in ust_listener_thread() at lttng-ust-comm.c:1822)

Since you installed via the PPA, a systemd service control service is installed
that control a global (root) lttng-sessiond.

First let's stop it.
   sudo systemctl stop lttng-sessiond.service

Then in a console, again use a paste service to share the content of /tmp/lttng-sessiond.log with us

   sudo lttng-sessiond -vvv > /tmp/lttng-sessiond.log 2>&1

In another console, while the lttng-sessiond process is running, please have a look at the /var/run/lttng directory:

 ls -la /var/run/lttng/

Again use a paste service to share this with us.

Also can you provide the output of the following while using the user you are
normally using to play with lttng:

 groups

You can also try to spawn a local lttng-sessiond for the user.
  Note that a global and many local lttng-sessiond can coexist but for the sake of debugging
  we will only have one of each at a time. 

Kill the root lttng-sessiond we started earlier and start a local one:

 lttng-sessiond -vvv > /tmp/lttng-sessiond-local.log 2>&1 

 Note the absence of `sudo` here.

Again please share the content of /tmp/lttng-sessiond-local.log via a paste
service.

From there you can retry your experiment with the `lttng list` command.

Cheers


> The command lines entered to compile are quite the same, I just had to modify :
> this :     gcc -o hello hello.o hello-tp.o
> to this : gcc -o hello hello.o hello-tp.o -L/usr/local/lib -llttng-ust -ldl

As per the doc [3]:
    gcc -o hello hello.o hello-tp.o -llttng-ust -ldl

[3] https://lttng.org/docs/v2.12/#doc-tracing-your-own-user-application Bullet point #6

Cheers
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
