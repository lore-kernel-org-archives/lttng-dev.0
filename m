From: Jon Bernard <jbernard@debian.org>
Subject: Re: latest version of LTTng UST on Ubuntu 12.04
Date: Mon, 19 Nov 2012 10:47:02 -0500
Message-ID: <20121119154702.GA4533__17697.0469220125$1353340082$gmane$org@quintessa>
References: <7F632A9222059A42AF70FCB7965774AA20987947@ALA-MBB.corp.ad.wrs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from out4-smtp.messagingengine.com ([66.111.4.28])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jbernard@debian.org>) id 1TaTYy-0005Ia-QV
	for lttng-dev@lists.lttng.org; Mon, 19 Nov 2012 10:47:08 -0500
Received: from compute5.internal (compute5.nyi.mail.srv.osa [10.202.2.45])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 30CEF20FC0
	for <lttng-dev@lists.lttng.org>; Mon, 19 Nov 2012 10:47:03 -0500 (EST)
Received: from localhost (unknown [216.252.204.142])
	by mail.messagingengine.com (Postfix) with ESMTPA id 0529F48268E
	for <lttng-dev@lists.lttng.org>; Mon, 19 Nov 2012 10:47:02 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <7F632A9222059A42AF70FCB7965774AA20987947@ALA-MBB.corp.ad.wrs.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

* McDermott, Andrew <Andrew.McDermott@windriver.com> wrote:
> 
> How often are the LTTng UST packages for Ubuntu updated?
> 
> Having done a fresh install I see the version reported as:
> 
>   $ lttng version
>   lttng version 2.0.1 - Annedd'ale
> 
> but looking at the git repo I see there is v2.0.4 tag.  Are these
> updates only available if built from source?  In general I was trying to
> avoid the daily development versions from:
> 
>   https://launchpad.net/~lttng/+archive/daily.

The version is unlikely to change unless a security flaw or other major bug is
discovered.  The PPA builds are prepared by the same folks that prepared the
packages for 12.04, so their quality will be consistent (high).  If you need the
latest code, I think that is a good place to start.

-- 
Jon
