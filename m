Return-Path: <SRS0=PeGe=JD=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D903BC433B4
	for <lttng-dev@archiver.kernel.org>; Tue,  6 Apr 2021 14:08:04 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1AD25613A7
	for <lttng-dev@archiver.kernel.org>; Tue,  6 Apr 2021 14:08:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AD25613A7
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4FF8W6348Cz130m;
	Tue,  6 Apr 2021 10:08:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1617718082;
	bh=THhJnerzIx/022kTKDQJFSMxJF/rGu3ul+48pjPClnE=;
	h=Date:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=w3yE7Gp5Ahvgp+9LI8VUq23lmpLSoRxJK3hZ40xcT+flisvqX7GWLMgFs3ybwI2ZD
	 GKVipkbIaGwuh+uhI+7v+2mPLh2w4NbWay6sejUs43kYr9eAFRBZhWkEsrCo0tVtpT
	 eCONbxpmMklWsC/7tDxLMds3xUu8j4p7mfCHOzd+UWzzPeMTOf4g/BGMO+f6QS+fhB
	 qSaH7hzWDo7ZBfRtQV771NktlNIR1n253htSOvl73XR1kHm4pn7D3uYZZiA3z7SbPc
	 R/njEHZwZ3iPU4azaunTBWxy/meDQp51CC8UU5fuTyUsAr7Yflm/MHaeXiRthC7OJr
	 sUn+ebNVYCZGQ==
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4FF8W544rJz12pd
 for <lttng-dev@lists.lttng.org>; Tue,  6 Apr 2021 10:08:00 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 1E2B231B11A
 for <lttng-dev@lists.lttng.org>; Tue,  6 Apr 2021 10:07:54 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id DfKA8ifDYudx; Tue,  6 Apr 2021 10:07:53 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 8917F31B223;
 Tue,  6 Apr 2021 10:07:53 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 8917F31B223
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id wiGGZByS7YGt; Tue,  6 Apr 2021 10:07:53 -0400 (EDT)
Received: from joraj-alpa (unknown [107.159.43.215])
 by mail.efficios.com (Postfix) with ESMTPSA id 5B4DF31B119;
 Tue,  6 Apr 2021 10:07:53 -0400 (EDT)
Date: Tue, 6 Apr 2021 10:07:53 -0400
To: Eqbal <eqbalzee@gmail.com>
Cc: lttng-dev@lists.lttng.org
Message-ID: <20210406140753.GE79283@joraj-alpa>
References: <CAPj=WkgS6XxzCazt4gWOiebas+BJ3fxSz-KRyXUpDQRLovM-NA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAPj=WkgS6XxzCazt4gWOiebas+BJ3fxSz-KRyXUpDQRLovM-NA@mail.gmail.com>
Subject: Re: [lttng-dev] Userspace tracing in docker containers
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

Hi,

On Mon, Apr 05, 2021 at 11:09:39AM -0700, Eqbal via lttng-dev wrote:
> Hi,
> 
> I am trying to get user space tracing working for an application running in
> a docker container. I am running lttng session daemon in another container.
> I mounted the unix socket locations (either /var/run/lttng for root or
> $HOME/.lttng for another user). By doing that I can run commands like lttng
> create or lttng list <session-name>, but the tracepoint events from the
> application don't get registered and there is no trace output.
> 
> I enabled LTTNG_UST_DEBUG an ran lttng-sessiond in verbose mode (-vvv and
> --verbose-consumer) and got the following error message:
> 
> "*Unix socket credential pid=0. Refusing application in distinct,
> non-nested pid namespace.*"
> 
> It appears that for some calls to the session daemon there is a getsockopt
> syscall made with *SO_PEERCRED* which returns 0 for pid and the call is
> failed with *LTTNG_UST_ERR_PEERCRED_PID* error (see get_cred call in
> ustctl.c).
> 
> If I comment out the getsockopt call, my application tracing starts to work.
> 
> From what I found, docker cannot support getsockopt/SO_PEERCRED call to get
> peer pid on the unix socket which would make sense as it's in a separate
> namespace.
> 
> I have a few questions on this:
> 1. What is the reason for the get_cred/getsockopt call with SO_PEERCRED? I
> would like to understand why it's required for some and not other calls.


More information is found in the introducing commit:

  commit a834901f2890deadb815d7f9e3ab79c3ba673994
  Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
  Date:   Mon Oct 12 16:52:03 2020 -0400

    Fix: Use unix socket peercred for pid, uid, gid credentials
    
    Currently, the session daemon trust the pid, ppid, uid, and gid values
    passed by the application, but should really validate the uid using unix
    socket peercred. This fix uses the peercred values rather than the
    values provided by the application on registration for:
    
    - pid, uid and gid on Linux,
    - uid and gid on FreeBSD.
    
    This should improve how the session daemon deals with containerized
    applications on Linux as well. Applications are required to be either in
    the same pid namespace, or in a pid namespace nested within the pid
    namespace of the lttng-sessiond, so the session daemon can map the
    application pid to something meaningful within its own pid namespace.
    Applications in a unrelated (disjoint) pid namespace will be refused by
    the session daemon.
    
    About the uid and gid with user namespaces on Linux, those will provide
    meaningful IDs if the application user namespace is either the same as
    the user namespace of the session daemon, or a nested user namespace.
    Otherwise, the IDs will be that of /proc/sys/kernel/overflowuid and
    /proc/sys/kernel/overflowgid, which typically maps to nobody.nogroup on
    current distributions.
    
    Given that fetching the parent pid (ppid) of the application would
    require to use /proc/<pid>/status (which is racy wrt pid reuse), expose
    the ppid provided by the application on registration instead, but only
    in situations where the application sits in the same pid namespace as
    the session daemon (on Linux), which is detected by checking if the pid
    provided by the application matches the pid obtained using unix socket
    credentials. The ppid is only used for logging/debugging purposes in the
    session daemon anyway, so it is OK to use the value provided by the
    application for that purpose.
    
    Fixes: #1286
    Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
    Change-Id: I94742e57dad642106908d09e2c7e395993c2c48f

As for "why it's required for some and not other calls.", there is a difference
between communicating with a lttng-sessiond daemon (using the lttng CLI) and
userspace application registering. They are essentially two distinct
communication interface. Now, to be honest, I'm not certain of the complete
"security" policy for the lttng-sessiond <-> CLI interface and if we should be
more strict or not.

> 2. Is there any workaround for this problem, so that I can get this to work
> with the container topology I am working with (app in one container and
> lttng daemons in another).

Based on the commit message, lttng-ust explicitly cannot be used across
non-nested pid namespace.

Could you give us more information on the goal for the topology you plan to use?
This could lead to further discussion and/or alternative solution based on the
goal and constraints of your deployment.

> 3. Related to 2, are there any gotchas to bypassing the getsockopt call in
> get_cred?

Based on the content of the mentioned bug (1286) [1],  the principal concern is:

"
This means a non-root application could theoretically impersonate a root
application from a tracing perspective, and thus access root tracing buffers in
a per-uid configuration, which is unwanted.
"

[1] https://bugs.lttng.org/issues/1286

Cheers

-- 
Jonathan Rajotte-Julien
EfficiOS
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
