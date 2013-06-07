From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Compiliing LTTng-modules 2.1 with a 3.9.4 kernel
Date: Fri, 7 Jun 2013 14:12:35 -0400
Message-ID: <20130607181235.GA32244__33942.030723165$1370628787$gmane$org@Krystal>
References: <51B220F3.70901@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1Ul19T-0004HF-6t
	for lttng-dev@lists.lttng.org; Fri, 07 Jun 2013 14:12:39 -0400
Content-Disposition: inline
In-Reply-To: <51B220F3.70901@gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Yannick Brosseau <yannick.brosseau@gmail.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Hi Yannick,

I just cherry-picked the following 2 commits into stable-2.1:

commit d8b08ae2853322bd9777024f35d1c35582b4ebb2
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Date:   Fri May 3 09:02:43 2013 -0400

    Fix: warning kvm_trace_exit_reason redefined for 3.9 kernel
    
    Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

commit 06c937989fe2919782533bcf92becfebe5910873
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Date:   Wed Mar 13 13:49:13 2013 -0400

    Fix 3.8 kernel support: namespace lttng_is_signed_type()
    
    Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

Please let me know if anything is missing,

Thanks!

Mathieu

* Yannick Brosseau (yannick.brosseau@gmail.com) wrote:
> Hi all,
> 
> I've cherry-picked the necessary fixes to build the 2.1 version of the
> lttng-modules and I've put them in this branch:
> 
> http://git.dorsal.polymtl.ca/~ybrosseau?p=lttng-modules.git;a=shortlog;h=refs/heads/stable-2.1-3.9
> 
> You can get it with this git clone command:
> git clone -b stable-2.1-3.9
> git://git.dorsal.polymtl.ca/~ybrosseau/lttng-modules.git
> 
> Mathieu, maybe you can consider putting them in the stable-2.1 official
> branch.
> 
> Yannick
> 
> 
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
