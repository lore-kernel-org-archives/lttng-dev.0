From: Jon Bernard <jbernard@debian.org>
Subject: Re: Query about LTTng 2.0 Debian packages
Date: Thu, 28 Jun 2012 21:58:15 -0400
Message-ID: <20120629015815.GA22800__12301.8034421422$1340935128$gmane$org@quintessa>
References: <20120621012622.GA1387@Krystal> <20120621191452.GA18195@quintessa>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from out3-smtp.messagingengine.com ([66.111.4.27])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jbernard@debian.org>) id 1SkQTV-0003Oo-TF
	for lttng-dev@lists.lttng.org; Thu, 28 Jun 2012 21:58:21 -0400
Received: from compute5.internal (compute5.nyi.mail.srv.osa [10.202.2.45])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 7575420E45
	for <lttng-dev@lists.lttng.org>; Thu, 28 Jun 2012 21:58:16 -0400 (EDT)
Received: from localhost (unknown [216.252.204.142])
	by mail.messagingengine.com (Postfix) with ESMTPA id 34EF3483533
	for <lttng-dev@lists.lttng.org>; Thu, 28 Jun 2012 21:58:16 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20120621191452.GA18195@quintessa>
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

* Jon Bernard <jbernard@debian.org> wrote:
> * Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> > Hi Jon,
> > 
> > I wanted to get in touch with you regarding LTTng 2.0 Debian packages.
> > Is there anything we can do to help you getting those packages into
> > Debian ? They have been out for a while now, and even Ubuntu picked them
> > up. I understand that you are probably busy, hence my offer for help.
> 
> I've just uploaded another package I've been working on and LTTng 2.0 packages
> are next on my list. Give me a few days to get things sorted, I'll post an
> update next week with my status.

Is the 2.0 series indented to replace the existing UST, or should they be able
to exist side-by-side?  I'm inclined to think the new packages should replace
the old ones, and thus prevent a user from having both installed at the same
time, but wanted to check first.

URCU is updated and I'm looking at UST/CTL now. I'll file ITPs for babeltrace
and modules in the morning.

-- 
Jon
