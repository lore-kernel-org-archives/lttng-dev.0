From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: BABELTRACE
Date: Tue, 5 Jun 2012 10:54:22 -0400
Message-ID: <20120605145422.GA21009__25450.6034813405$1338908089$gmane$org@Krystal>
References: <CAO8ONPzhd64AoBQFnuJ0agGHFzSQxNeFSQODmE7kWYk2jZQYHg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1Sbv9M-0001D4-0B
	for lttng-dev@lists.lttng.org; Tue, 05 Jun 2012 10:54:24 -0400
Content-Disposition: inline
In-Reply-To: <CAO8ONPzhd64AoBQFnuJ0agGHFzSQxNeFSQODmE7kWYk2jZQYHg@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Vanni Genua <vannigenua@gmail.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>, Alexandre Montplaisir <alexandre.montplaisir@polymtl.ca>
List-Id: lttng-dev@lists.lttng.org

* Vanni Genua (vannigenua@gmail.com) wrote:
> Hi there,
> so once I have correctly installed LTTng-modules, LTTng-ust and
> LTTng-tools, I can use LTTng but not LTTng view. In order to use #lttng
> view command I have to install Babeltrace, but it seems still to be a rc
> version. As a matter of fact I downloaded it from
> http://lttng.org/downloadand, according to README file, I launched
> #./bootsrap but this file is not
> in the directory: it doesn't exist!
> I'm stuck here now, any idea?

Just FYI, if you want to build babeltrace from its .tar.gz RC release
package (tarball), you need to skip the "./bootstrap" step, which is
only required if you use the git repository (IOW, master branch).

Thanks,

Mathieu

> Vanni

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev


-- 
Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
