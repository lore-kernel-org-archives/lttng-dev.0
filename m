From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Package liburcu fix for kfreebsd-amd64
	and	kfreebsd-i386
Date: Sun, 3 Mar 2013 02:05:49 -0500
Message-ID: <20130303070549.GA7315__25527.2422371947$1362294403$gmane$org@Krystal>
References: <20130222134515.GA22069@Krystal>
	<87bob1ftwa.fsf@mitoraj.siccegge.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1UC2zY-0003uC-Pz
	for lttng-dev@lists.lttng.org; Sun, 03 Mar 2013 02:05:52 -0500
Content-Disposition: inline
In-Reply-To: <87bob1ftwa.fsf@mitoraj.siccegge.de>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Christoph Egger <christoph@debian.org>
Cc: lttng-dev@lists.lttng.org, debian-bsd@lists.debian.org
List-Id: lttng-dev@lists.lttng.org

* Christoph Egger (christoph@debian.org) wrote:
> Mathieu Desnoyers <mathieu.desnoyers@efficios.com> writes:
> > I noticed failures to build for the liburcu Debian package for
> > kfreebsd-amd64 and kfreebsd-i386. I just pushed a commit into the master
> > branch that should solve the build errors encountered. Would it be
> > possible to test a build of Userspace RCU master branch against those
> > two architectures ? If it works fine, then I could backport this commit
> > into the stable-0.7 branch.
> 
> Where do I get this master branch? debcheckout doesn't. Also, please
> direct this request to the porter list (Cc-ed) giving more people a
> chance to repond.

You can get it from:

git clone git://git.lttng.org/userspace-rcu.git

or use the gitweb interface:
https://git.lttng.org/?p=userspace-rcu.git;a=summary

Thanks!

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
