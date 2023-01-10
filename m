Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9468C46467
	for <lttng-dev@archiver.kernel.org>; Tue, 10 Jan 2023 19:46:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1673379971;
	bh=ttL9+QmrPqCfM46blT3PwNo7ywSr19JXcD29bF01umI=;
	h=Date:To:References:In-Reply-To:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=z9+1YyWqBGb0FThGtxdNqKnKOCDC9I7FZ4SFTQUhffOslqboIM+GloksRNfIgX78r
	 F3gdp304V8ePklHkTDwE9TbCdgVEz296ChZswHrCJ2LDAj6J5qgfzMVfvKm9JsXXHL
	 lFfhkTo1nYl7YEAOZ6W5zGFf+pROMLjbr6otmzqOLJ9CtJIsYvK28XfE0rCQogHQ5P
	 KZtAtL/7b68viL4jAOVzhwuHqidqBMrsGBzIpIwf2gcuJb2GHjtWZzp1pmJyCCLDw7
	 32KdeAK2cytpd+GY8d59PXhVUyjXa5dNq8sQkecQPzO9m3HjXLwoBZbw31IfcfrIiA
	 IJAALSNEVOVQg==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4Ns1X25fRrz1PsC;
	Tue, 10 Jan 2023 14:46:10 -0500 (EST)
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
 by lists.lttng.org (Postfix) with ESMTPS id 4Ns1X16bltz1Ph7
 for <lttng-dev@lists.lttng.org>; Tue, 10 Jan 2023 14:46:09 -0500 (EST)
Received: from [172.16.0.101] (192-222-180-24.qc.cable.ebox.net
 [192.222.180.24])
 by smtpout.efficios.com (Postfix) with ESMTPSA id 4Ns1X11cvWzgJ2;
 Tue, 10 Jan 2023 14:46:09 -0500 (EST)
Message-ID: <d17dbab6-5222-7065-ae0e-144687b2efc6@efficios.com>
Date: Tue, 10 Jan 2023 14:46:42 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Content-Language: en-US
To: Florian Weimer <fweimer@redhat.com>, lttng-dev@lists.lttng.org,
 Yannick Brosseau <yannick.brosseau@gmail.com>,
 Michael Jeanson <mjeanson@efficios.com>,
 Michel Dagenais <michel.dagenais@polymtl.ca>
References: <87h6wyhd7l.fsf@oldenburg.str.redhat.com>
In-Reply-To: <87h6wyhd7l.fsf@oldenburg.str.redhat.com>
Subject: [lttng-dev] lttv: Document project status as unmaintained
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
From: Mathieu Desnoyers via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

Hi Florian,

I'll pull your patch into the lttv master branch, but please be aware
that the LTTV project has not seen activity since 2013, is currently
unmaintained, and that we do not plan on doing further releases of this
project. Our efforts were diverted elsewhere on the trace analysis
front, namely into Trace Compass and Babeltrace.

In order to clarify the situation, I will introduce a commit into
LTTV's master branch which will remove Yannick Brosseau from the
maintainer role in the README file, and add this section at the
beginning:

PROJECT STATUS
--------------------------------

The LTTV project is currently unmaintained. If you need up-to-date tools
to view/analyze LTTng traces, please consider the following alternatives:

- Trace Compass (https://www.eclipse.org/tracecompass)
- Babeltrace (https://babeltrace.org)


Thank you Yannick for stepping into the role of maintainer near the
end of this project lifetime.

Michael Jeanson noticed that the lttv Fedora package was orphaned.
He just adopted it and is currently investigating the Fedora
documentation to figure out how to request its removal from Fedora.

For those interested in historical artifacts, I created the lttv
svn repository back in 2003 when I was sitting at the Decelles building
at Ecole Polytechnique, working for Prof. Michel Dagenais:

commit bbdf43d6e0e3bd3f9ade420e81915408cbe4fbba
Author: compudj <compudj@04897980-b3bd-0310-b5e0-8ef037075253>
Date:   Thu May 15 13:07:17 2003 +0000

     Initial repository layout
     
     git-svn-id: http://ltt.polymtl.ca/svn@1 04897980-b3bd-0310-b5e0-8ef037075253

This was the beginning of a fun ride which turned out motivating the
creation of LTTng, the Linux kernel Tracepoints, the Common Trace Format,
Trace Compass, Babeltrace, liburcu, the membarrier(2), and the rseq(2)
system calls.

LTTV had a good 10 years of activity from 2003 to 2013, but it is now high
time to redirect users to Trace Compass and Babeltrace instead.

Thanks,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
