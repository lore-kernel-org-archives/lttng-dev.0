Return-Path: <SRS0=fpp6=IW=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E9B6C433C1
	for <lttng-dev@archiver.kernel.org>; Wed, 24 Mar 2021 16:36:19 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3368619E4
	for <lttng-dev@archiver.kernel.org>; Wed, 24 Mar 2021 16:36:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3368619E4
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4F5DQ94MBszMCq;
	Wed, 24 Mar 2021 12:36:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1616603777;
	bh=FoJp012dXxtUb7Zm8WNOeSmWoad6xf2g166arQO7s5E=;
	h=Date:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=kId6DyS2lcAZLjlexh/jtPRgmFtxx/zrAZse5Wu0VdQJx46BRLkBAb1AcQMdQm7I/
	 ZSpiwkyRjKkLFbztUNeNYuZg874cXeqZVp7ayeWb/S6nfxpCJYPdOyNQ5iSZG/hmdS
	 TeHQMM0CDS7L2pTVP9U+YYyRqQZZ2GqZuGmFHY/l98lJ5+DiAnvjoitgcqDW6HWkBE
	 wjhFynsSQL+3z6dx84HstjkkPtbKtyaRZMwCRYlCv8M7/1wnBcMch0QkigOvAB/StM
	 ScFxritUvZpe3lGVr6r56W3KLVzvvxbeJPA9U0ku1N9Ii9Ogny5edzU+WtDNRX2mJe
	 0WLD5GwvGyWEg==
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4F5DQ75knLzMVh
 for <lttng-dev@lists.lttng.org>; Wed, 24 Mar 2021 12:36:15 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 6B7FF24A1C2
 for <lttng-dev@lists.lttng.org>; Wed, 24 Mar 2021 12:36:15 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id 2ed53HwBnVPs; Wed, 24 Mar 2021 12:36:13 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 7BAD224A17D;
 Wed, 24 Mar 2021 12:36:13 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 7BAD224A17D
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id V7rK_MUrkd48; Wed, 24 Mar 2021 12:36:13 -0400 (EDT)
Received: from joraj-alpa (192-222-181-218.qc.cable.ebox.net [192.222.181.218])
 by mail.efficios.com (Postfix) with ESMTPSA id DED4B249FB3;
 Wed, 24 Mar 2021 12:36:12 -0400 (EDT)
Date: Wed, 24 Mar 2021 12:36:11 -0400
To: MONTET Julien <julien.montet@reseau.eseo.fr>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
Message-ID: <20210324163611.GF344120@joraj-alpa>
References: <PR3PR02MB62023431654FB93182EA21A1D1639@PR3PR02MB6202.eurprd02.prod.outlook.com>
 <20210324142540.GB344120@joraj-alpa>
 <PR3PR02MB6202F969540C279A6A171F83D1639@PR3PR02MB6202.eurprd02.prod.outlook.com>
 <20210324153255.GC344120@joraj-alpa>
 <PR3PR02MB620209CCED35CC62E1C8550FD1639@PR3PR02MB6202.eurprd02.prod.outlook.com>
 <20210324160629.GE344120@joraj-alpa>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210324160629.GE344120@joraj-alpa>
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

> TBH nothing points toward a problem here. I would need to spawn a 20.04 to check
> if something is broken, I might have time later today.

Finally I had a Vagrant definition file laying around for the stable-2.12 ppa
that let me bring up a vm easily. All seems fine.

How lttng is installed:

  add-apt-repository ppa:lttng/stable-2.12 -y
  apt-get update
  apt-get install -y lttng-tools lttng-modules-dkms babeltrace2 liblttng-ust-dev

From there all the steps for building the userspace application works without
ANY modifications.

The app is able to connect itself to the global sessiond: https://paste.ubuntu.com/p/QnfqbtgpFF/

Note that no local sessiond is present hence why the app does not communicate
with one.

Note that the user I am using here (vagrant) is not part of the "tracing" group
hence the user cannot interact with the global sessiond.

Such scenario return the following:

  vagrant@ubuntu2004:~$ lttng list -u
  Error: Unable to list UST events: No session daemon is available

Now let's start a lttng-sessiond for the user and restart our app (note that
this is not required for day to day tracing since a running app will connect
itself and only for debugging purpose):

 lttng-sessiond -b
 LTTNG_UST_DEBUG=1 ./hello

Yielding: https://paste.ubuntu.com/p/MsnHt94FXZ/

Now the app is connected to both sessiond.

Now the user can list the event against the local lttng-sessiond:

  vagrant@ubuntu2004:~$ lttng list -u
  UST events:
  -------------
  
  PID: 15429 - Name: ./hello
        lttng_ust_tracelog:TRACE_DEBUG (loglevel: TRACE_DEBUG (14)) (type: tracepoint)
        lttng_ust_tracelog:TRACE_DEBUG_LINE (loglevel: TRACE_DEBUG_LINE (13)) (type: tracepoint)


So based on this I would say that either we are not given the full picture of
what is going on or there is a step you are missing. One explication would be
that you end up linking against a older lttng-ust without knowing it.

Please run this an provide the output via a paste service:

   find /usr -name "*liblttng-ust*"

For example on my VM: https://paste.ubuntu.com/p/Tjxn3V7g5j/

Cheers

-- 
Jonathan Rajotte-Julien
EfficiOS
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
