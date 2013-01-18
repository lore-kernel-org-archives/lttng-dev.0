From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: yacc lttng-tools problem
Date: Fri, 18 Jan 2013 13:26:19 -0500
Message-ID: <20130118182619.GA17411__49836.6081309088$1358533627$gmane$org@Krystal>
References: <3CA1A65C03C1A34C81BBC6272782E696987823@valcartierex01.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1TwGdx-0004fu-BB
	for lttng-dev@lists.lttng.org; Fri, 18 Jan 2013 13:26:21 -0500
Content-Disposition: inline
In-Reply-To: <3CA1A65C03C1A34C81BBC6272782E696987823@valcartierex01.valcartier.drdc-rddc.gc.ca>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Cc: lttng-dev@lists.lttng.org, "Couture, Mario" <Mario.Couture@drdc-rddc.gc.ca>, =?iso-8859-1?Q?Painchaud=2C_Fr=E9d=E9ric?= <Frederic.Painchaud@drdc-rddc.gc.ca>
List-Id: lttng-dev@lists.lttng.org

* Thibault, Daniel (Daniel.Thibault@drdc-rddc.gc.ca) wrote:
>    I need help to get lttng-tools to compile.
> 
>    I have grabbed the (nearly) latest git.lttng.org packages:
> 
> lttng-modules (2.1.0+-c6403de)
> userspace-rcu (0.7.6-da9bed2)
> lttng-ust (2.1.0+-340f776) (one new commit since)
> lttng-tools (2.1.1+-281047b) (six new commits since)
> 
>    The userspace-rcu repository is weird: the 0.7.6 commit which I
>    fetched is marked as "8 days ago" but the master stops at "11 days
>    ago".

0.7.6 tags is against stable-0.7 branch, not master, so it's allright.
stable-0.7 contains backports of fixes.

The master branch is in preparation for an upcoming 0.8.

Thanks,

Mathieu

> 
-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
