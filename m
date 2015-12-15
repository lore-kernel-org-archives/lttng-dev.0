From: Jonathan Rajotte Julien <Jonathan.rajotte-julien@efficios.com>
Subject: Re: LTTng trace files organize
Date: Tue, 15 Dec 2015 14:47:47 -0500
Message-ID: <56706E63.4010105__32331.8476127044$1450208925$gmane$org@efficios.com>
References: <BLU169-W15347D6012352D6D99D6B9ABEE0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <Jonathan.rajotte-julien@efficios.com>)
 id 1a8vZj-00068p-Vd
 for lttng-dev@lists.lttng.org; Tue, 15 Dec 2015 14:47:56 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id E02AD3404DB
 for <lttng-dev@lists.lttng.org>; Tue, 15 Dec 2015 19:47:51 +0000 (UTC)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (evm-mail-1.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id m4wd6iNRJd61 for <lttng-dev@lists.lttng.org>;
 Tue, 15 Dec 2015 19:47:51 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 3D8013404E7
 for <lttng-dev@lists.lttng.org>; Tue, 15 Dec 2015 19:47:51 +0000 (UTC)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (evm-mail-1.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id lY7jCP9hXBsc for <lttng-dev@lists.lttng.org>;
 Tue, 15 Dec 2015 19:47:51 +0000 (UTC)
Received: from [172.16.0.141] (cable-192.222.213.99.electronicbox.net
 [192.222.213.99])
 by mail.efficios.com (Postfix) with ESMTPSA id D9F703404DB
 for <lttng-dev@lists.lttng.org>; Tue, 15 Dec 2015 19:47:50 +0000 (UTC)
In-Reply-To: <BLU169-W15347D6012352D6D99D6B9ABEE0@phx.gbl>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Hey Jeffrey

On 2015-12-15 02:15 PM, Jeffrey Chen wrote:
> Hi:
>
> I have a question on how LTTng organize trace files. I noticed by 
> default for userspace tracing, LTTng writes a trace file per CPU core. 
> So, I would get something like channel0_0, channel0_1, channel0_2, 
> channel0_3, for the case of 4 CPU cores. Is there a way to config 
> LTTng only writes to 1 trace file? This is much easier for us to 
> organize the traces for our use case.
If you don't mind me asking what exactly would be your use case here? 
Folder separation is not enough (via  -o on lttng create) ?

Cheers

> Thanks.
>
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Jonathan R. Julien
Efficios
