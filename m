From: Julien Desfossez <jdesfossez@efficios.com>
Subject: Re: [GIT PULL] Detach a live session
Date: Mon, 7 Mar 2016 15:41:03 -0500
Message-ID: <20160307204103.GD9064__15512.4430930757$1457383364$gmane$org@sinkpad.internal.efficios.com>
References: <20160307191750.GB9064@sinkpad.internal.efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from albert.ini-tech.com ([192.99.35.19] helo=smtp.ini-tech.com)
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jdesfossez@efficios.com>) id 1ad1xs-0001Js-Uo
 for lttng-dev@lists.lttng.org; Mon, 07 Mar 2016 15:41:34 -0500
Content-Disposition: inline
In-Reply-To: <20160307191750.GB9064@sinkpad.internal.efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Jeremie Galarneau <jgalar@efficios.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Added two commits to this pull request:
2e73b78 Fix: live test header endianness
b20a506 Document the live detach command

Julien

On 07-Mar-2016 02:17:50 PM, Julien Desfossez wrote:
> Hi,
> 
> The feature to detach a live session without requiring to close the
> network connection is in the "live-detach" branch from this repo:
> https://github.com/jdesfossez/lttng-tools-dev.git
> 
> Two commits:
> 10f015f Test the viewer detach command
> 1a49e0e Live: command to detach a viewer session
> 
> Thanks,
> 
> Julien
> 
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
