From: Jon Bernard <jbernard@debian.org>
Subject: Re: LTTng packages in Debian sid out of sync
Date: Sun, 10 Nov 2013 10:21:50 -0500
Message-ID: <20131110152150.GA22826__35467.2139081687$1384096965$gmane$org@shaniqua>
References: <630558869.45441.1382211345502.JavaMail.zimbra@efficios.com>
	<856849325.45462.1382211994767.JavaMail.zimbra@efficios.com>
	<20131019211009.GA83292@helmut.local>
	<300817690.45707.1382242504740.JavaMail.zimbra@efficios.com>
	<20131020134521.GA97360@helmut.local>
	<1084047903.45979.1382281219903.JavaMail.zimbra@efficios.com>
	<20131020160434.GA2011@helmut.local>
	<20131103231921.GA6958@shaniqua>
	<376195559.63764.1384095140775.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from out2-smtp.messagingengine.com ([66.111.4.26])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jbernard@debian.org>) id 1VfWpp-0000wG-NZ
	for lttng-dev@lists.lttng.org; Sun, 10 Nov 2013 10:21:58 -0500
Content-Disposition: inline
In-Reply-To: <376195559.63764.1384095140775.JavaMail.zimbra@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev@lists.lttng.org, =?iso-8859-1?Q?St=E9phane?= Graber <stgraber@ubuntu.com>
List-Id: lttng-dev@lists.lttng.org

* Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> Hi Jon,
> 
> Thanks for the updates. Did you manage to get the upgrade path from
> older lttng versions to work, or do users still need to uninstall the
> old package manually ?

I'm working on the upgrade packages now.  I also just noticed a build
failure on armel[1] for lttng-tools.  It could be a debian-specific
problem in the compiler/toolchain, but I haven't had a chance to look
into it yet.  Let me know if you have any thoughts about this.

[1]: https://buildd.debian.org/status/fetch.php?pkg=ltt-control&arch=armel&ver=2.3.0-1&stamp=1383525831

-- 
Jon
