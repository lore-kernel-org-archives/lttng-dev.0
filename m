Return-Path: <SRS0=fpp6=IW=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11AB9C433DB
	for <lttng-dev@archiver.kernel.org>; Wed, 24 Mar 2021 16:06:42 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B2FF61A0D
	for <lttng-dev@archiver.kernel.org>; Wed, 24 Mar 2021 16:06:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B2FF61A0D
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4F5Clz6C3dzMVf;
	Wed, 24 Mar 2021 12:06:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1616602000;
	bh=ajhOFid9DZEZNOc11I4Wnv2ipdDxQY8cUiQNKbdxcY4=;
	h=Date:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=yIGM7IKrtktdXrtOAjwcmrIHzReeTHHuox5LgMEymEnHBYC/ZxhMYSPbwHtwNpWvB
	 PXCx/nvLnrJgZjSJJfGKpYa6/MFgJtozN1P2LcMkBQX58ZH0rkD0OEhcvdICf7E61w
	 qn6DlVYa5Uy3ZmOvRPw10Yutl30aFnVOeA4ebR0QWQNgCtCoXKmPyjjzQXiDL7qna3
	 1hpOB+OEopdQ3rin0fJYeJm7X31EmrTEbZtAgNWcE5WBbhwW51DuxOwoinz0bdHGXx
	 U7+LKNfTDS1lI1xefecj0Z/Rv5obxXYMHJ54TFWcjMWLrSWUWgEd1q/qBjHCUJUd4/
	 poBZhOUQPRVDw==
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4F5Cly2CXHzM6g
 for <lttng-dev@lists.lttng.org>; Wed, 24 Mar 2021 12:06:38 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id ED63C249BC6
 for <lttng-dev@lists.lttng.org>; Wed, 24 Mar 2021 12:06:31 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id 8rRdpoFudYSn; Wed, 24 Mar 2021 12:06:30 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id DBA77249BC5;
 Wed, 24 Mar 2021 12:06:30 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com DBA77249BC5
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id 9Y9C2nZSK0sx; Wed, 24 Mar 2021 12:06:30 -0400 (EDT)
Received: from joraj-alpa (192-222-181-218.qc.cable.ebox.net [192.222.181.218])
 by mail.efficios.com (Postfix) with ESMTPSA id 91C2A249C99;
 Wed, 24 Mar 2021 12:06:30 -0400 (EDT)
Date: Wed, 24 Mar 2021 12:06:29 -0400
To: MONTET Julien <julien.montet@reseau.eseo.fr>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
Message-ID: <20210324160629.GE344120@joraj-alpa>
References: <PR3PR02MB62023431654FB93182EA21A1D1639@PR3PR02MB6202.eurprd02.prod.outlook.com>
 <20210324142540.GB344120@joraj-alpa>
 <PR3PR02MB6202F969540C279A6A171F83D1639@PR3PR02MB6202.eurprd02.prod.outlook.com>
 <20210324153255.GC344120@joraj-alpa>
 <PR3PR02MB620209CCED35CC62E1C8550FD1639@PR3PR02MB6202.eurprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <PR3PR02MB620209CCED35CC62E1C8550FD1639@PR3PR02MB6202.eurprd02.prod.outlook.com>
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

On Wed, Mar 24, 2021 at 03:53:14PM +0000, MONTET Julien wrote:
> Hi Jonathan,
> =

> After having written 'sudo systemctl stop lttng-sessiond.service', the co=
mmand 'sudo lttng-sessiond -vvv > /tmp/lttng-sessiond.log 2>&1' gives me no=
thing.


The log should be in /tmp/lttng-sessiond.log.

> =

> ls -la /var/run/lttng/ : Ubuntu Pastebin<https://paste.ubuntu.com/p/gjbqK=
kCrZK/>
> groups : Ubuntu Pastebin<https://paste.ubuntu.com/p/pjVFHk7kFZ/>
> lttng-sessiond -vvv > /tmp/lttng-sessiond-local.log 2>&1 : nothing
> /tmp/lttng-sessiond-local.log : Ubuntu Pastebin<https://paste.ubuntu.com/=
p/bj38FhhVpc/>

Based on the log there is a sessiond already running... anyway this give us=
 the
info we need to know for what socket is made available:

application socket path:       /home/montetju/.lttng/lttng-ust-sock-8
wait shm path:                 /lttng-ust-wait-8-1000

Could you share the content of:

   ls -la /dev/shm


TBH nothing points toward a problem here. I would need to spawn a 20.04 to =
check
if something is broken, I might have time later today.

Cheers

> =

> The issue persist with the 'lttng list' command.
> =

> Best regards,
> =

> Sorry it was indeed :
> The command lines entered to compile are quite the same, I just had to mo=
dify :
> > this :     gcc -o hello hello.o hello-tp.o -llttng-ust -ldl
> > to this : gcc -o hello hello.o hello-tp.o -L/usr/local/lib -llttng-ust =
-ldl
> (I just wanted to focus the importance of  -L/usr/local/lib)
> =

> ________________________________
> De : Jonathan Rajotte-Julien <jonathan.rajotte-julien@efficios.com>
> Envoy=E9 : mercredi 24 mars 2021 16:32
> =C0 : MONTET Julien <julien.montet@reseau.eseo.fr>
> Cc : lttng-dev <lttng-dev@lists.lttng.org>
> Objet : Re: [lttng-dev] Issues on basic LTTng trace userspace (tutorial)
> =

> Hi Julien,
> =

> Please always keep the mailing list in CC.
> =

> > I am running 'lttng list --userspace' with the application running in a=
nother terminal (like the tutorial, and also with a while that loop on trac=
epoint(...).
> =

> ok.
> =

> >
> > You can find here the Ubuntu paste : Ubuntu Pastebin<https://paste.ubun=
tu.com/p/bWw25kmSTq/>
> =

> Based on this, it seems like lttng-ust is unable to find the socket for a=
 sessiond either
> locally (for your user) [1] or a global one (root lttng-sessiond) [2].
> =

> [1] 43:  libust[207688/207690]: Info: sessiond not accepting connections =
to local apps socket (in ust_listener_thread() at lttng-ust-comm.c:1822)
> [2] 45:  libust[207688/207689]: Info: sessiond not accepting connections =
to global apps socket (in ust_listener_thread() at lttng-ust-comm.c:1822)
> =

> Since you installed via the PPA, a systemd service control service is ins=
talled
> that control a global (root) lttng-sessiond.
> =

> First let's stop it.
>    sudo systemctl stop lttng-sessiond.service
> =

> Then in a console, again use a paste service to share the content of /tmp=
/lttng-sessiond.log with us
> =

>    sudo lttng-sessiond -vvv > /tmp/lttng-sessiond.log 2>&1
> =

> In another console, while the lttng-sessiond process is running, please h=
ave a look at the /var/run/lttng directory:
> =

>  ls -la /var/run/lttng/
> =

> Again use a paste service to share this with us.
> =

> Also can you provide the output of the following while using the user you=
 are
> normally using to play with lttng:
> =

>  groups
> =

> You can also try to spawn a local lttng-sessiond for the user.
>   Note that a global and many local lttng-sessiond can coexist but for th=
e sake of debugging
>   we will only have one of each at a time.
> =

> Kill the root lttng-sessiond we started earlier and start a local one:
> =

>  lttng-sessiond -vvv > /tmp/lttng-sessiond-local.log 2>&1
> =

>  Note the absence of `sudo` here.
> =

> Again please share the content of /tmp/lttng-sessiond-local.log via a pas=
te
> service.
> =

> From there you can retry your experiment with the `lttng list` command.
> =

> Cheers
> =

> =

> > The command lines entered to compile are quite the same, I just had to =
modify :
> > this :     gcc -o hello hello.o hello-tp.o
> > to this : gcc -o hello hello.o hello-tp.o -L/usr/local/lib -llttng-ust =
-ldl
> =

> As per the doc [3]:
>     gcc -o hello hello.o hello-tp.o -llttng-ust -ldl
> =

> [3] https://lttng.org/docs/v2.12/#doc-tracing-your-own-user-application B=
ullet point #6
> =

> Cheers

-- =

Jonathan Rajotte-Julien
EfficiOS
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
