From: Jonathan Rajotte-Julien <jonathan.rajotte-julien@efficios.com>
Subject: Re: Kernel trace on Linux distro called YOCTO
Date: Fri, 7 Jun 2019 17:32:33 -0400
Message-ID: <20190607213233.GA2770__36346.4259471343$1559943685$gmane$org@joraj-alpa>
References: <MN2PR10MB3327979A543665A00CE7474E81170@MN2PR10MB3327.namprd10.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 45LGCl2zyFzywD
 for <lttng-dev@lists.lttng.org>; Fri,  7 Jun 2019 17:40:18 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id 437762388F6
 for <lttng-dev@lists.lttng.org>; Fri,  7 Jun 2019 17:32:39 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <MN2PR10MB3327979A543665A00CE7474E81170@MN2PR10MB3327.namprd10.prod.outlook.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: "Stanciu, Alin" <Alin.Stanciu@spirent.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Hi Alin,

If I'm not mistaken, we had a *debugging* session on IRC together regarding
this.

From what I gather it was mostly a library lookup problem for lttng-consumerd.

Please post a summary of the solution here just in case even if it does not
seem to be directly lttng's fault so far.

Cheers.

On Thu, Jun 06, 2019 at 10:21:10PM +0000, Stanciu, Alin wrote:
> Hi,
> 
> I'm trying to use LTTng to trace Linux events on a Linux distro called YOCTO.
> Using the following commands, I do not get any kernel events in the LTTng trace
> 
> "
> lttng create my-kernel-session --output=/tmp/my-kernel-trace
> lttng enable-channel test --kernel --subbuf-size=10000000
> lttng enable-event --kernel --all -c test
> lttng add-context -k -t vpid -t vtid -t procname
> lttng start
> "
> 
> The resulting trace is empty.
> 
> No matter what I try, I can't seem to get any kernel events thorough to LTTng.
> 
> Using v2.8.8.
> 
> Any ideas?
> 
> Thanks in advance.
> 
> Best Regards,
> alin stanciu
> Assistant Software Team Manager

-- 
Jonathan Rajotte-Julien
EfficiOS
