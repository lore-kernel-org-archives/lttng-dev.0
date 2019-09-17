From: Michael Jeanson <mjeanson@efficios.com>
Subject: Re: Test pid_ns in local build
Date: Tue, 17 Sep 2019 10:06:01 -0400
Message-ID: <e01b5c8b-9534-e726-e5cd-eb499ef3bc43__24405.5260250875$1568729183$gmane$org@efficios.com>
References: <5a49b436d1cd4659b96dfcaffe63b38e@SVR-IES-MBX-04.mgc.mentorg.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 46XlJW5nRbzq3J
 for <lttng-dev@lists.lttng.org>; Tue, 17 Sep 2019 10:06:03 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id 4002C2D3EE6
 for <lttng-dev@lists.lttng.org>; Tue, 17 Sep 2019 10:06:02 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
 by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
 with ESMTP id 0syXoEL-jJCs for <lttng-dev@lists.lttng.org>;
 Tue, 17 Sep 2019 10:06:02 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id E04752D3EDE
 for <lttng-dev@lists.lttng.org>; Tue, 17 Sep 2019 10:06:01 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
 by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
 with ESMTP id Kn5YdxeU1HHN for <lttng-dev@lists.lttng.org>;
 Tue, 17 Sep 2019 10:06:01 -0400 (EDT)
Received: from [172.16.0.105] (192-222-181-218.qc.cable.ebox.net
 [192.222.181.218])
 by mail.efficios.com (Postfix) with ESMTPSA id C32582D3ED5
 for <lttng-dev@lists.lttng.org>; Tue, 17 Sep 2019 10:06:01 -0400 (EDT)
In-Reply-To: <5a49b436d1cd4659b96dfcaffe63b38e@SVR-IES-MBX-04.mgc.mentorg.com>
Content-Language: en-US
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

On 2019-09-17 4:03 a.m., Polzer, Franz wrote:
> Hello,
> 
> I wanted to give the pid_ns context tracing a try and built LTTng from
> master, but I get the following error when applying this command:
> 
> lttng add-context -k -t procname -t pid -t vpid -t tid -t vtid -t pid_ns
> 
> Error: Unknown context type pid_ns
> 
> Maybe I need another branch to build from to get that feature in or
> forgot to enable the feature during building?
> 
> Where can I find documentation about the pid_ns tracing and how to test
> the current version of that implementation?
> 
> Thanks for your help and best regards,
> 
> Franz


Hi,

The namespace statedump and contexts feature has not been merged in
master yet. You can get it from my github in the "ns" feature branches.

https://github.com/mjeanson/lttng-modules/tree/ns
https://github.com/mjeanson/lttng-ust/tree/ns
https://github.com/mjeanson/lttng-tools/tree/ns

It's a bit out of date but should work as-is, or it can be easily
rebased on current master branches.


Cheers,

Michael
