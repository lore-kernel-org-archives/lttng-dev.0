From: Jon Bernard <jbernard@debian.org>
Subject: Re: [PATCH lttng-tools] Link test utilities against
 urcu-bp
Date: Wed, 28 Nov 2012 16:08:45 -0500
Message-ID: <20121128210845.GA30284__2834.90858641944$1354136982$gmane$org@quintessa>
References: <20121128151359.GA2051@quintessa> <50B64AB6.6080904@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from out4-smtp.messagingengine.com ([66.111.4.28])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jbernard@debian.org>) id 1TdosF-0005l1-LI
	for lttng-dev@lists.lttng.org; Wed, 28 Nov 2012 16:08:51 -0500
Received: from compute4.internal (compute4.nyi.mail.srv.osa [10.202.2.44])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 5CAB0218CF
	for <lttng-dev@lists.lttng.org>; Wed, 28 Nov 2012 16:08:46 -0500 (EST)
Received: from localhost (unknown [216.252.204.142])
	by mail.messagingengine.com (Postfix) with ESMTPA id 2550F8E0550
	for <lttng-dev@lists.lttng.org>; Wed, 28 Nov 2012 16:08:46 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <50B64AB6.6080904@efficios.com>
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

* David Goulet <dgoulet@efficios.com> wrote:
> Hi Jon,
> 
> Can you enlighten us on what setup are you using?
> 
> This symbol is used by lttng-ust which is linked with -lurcu-bp so
> lttng-tools should not have an issue here.
> 
> Are you cross-compiling ?

Nothing unusual, I'm building lttng-tools (version 2.1.8~rc8) from source
against URCU version 0.7.5 and UST version 2.1.0~rc2.  During compilation
(configure with no additional parameters), I see the following:

    make[3]: Entering directory `tests/tools/streaming'
    CC     unit_tests.o
    CCLD   unit_tests
    CC     gen-ust-events.o
    CC     tp.o
    CCLD   gen-ust-events
    /usr/bin/ld: tp.o: undefined reference to symbol 'rcu_dereference_sym'

This link error occurs on each of the gen-events targets as there is no explicit
link against urcu-bp.  I must have something different, as I'm sure you'd have
noticed this earlier.  What additional information might you need?

Cheers

-- 
Jon
