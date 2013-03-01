From: Jon Bernard <jbernard@debian.org>
Subject: Re: Need UST for LTTng-tool to build
Date: Thu, 28 Feb 2013 20:08:39 -0500
Message-ID: <20130301010839.GA2622__20749.2607216865$1362100175$gmane$org@quintessa>
References: <512FF48A.7050809@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from out1-smtp.messagingengine.com ([66.111.4.25])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jbernard@debian.org>) id 1UBESt-0003yI-6X
	for lttng-dev@lists.lttng.org; Thu, 28 Feb 2013 20:08:47 -0500
Content-Disposition: inline
In-Reply-To: <512FF48A.7050809@gmail.com>
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

* Yannick Brosseau <yannick.brosseau@gmail.com> wrote:
> Hi Jon,
> 
> To save you the trouble of trying to find the source of the latest FTBFS
> of LTTng-Tools, here's the solution.
> 
> You need to apply the commit:
> 
> Remove direct dependency of probes on urcu-bp
> fd9619bcf98bae43e3418b6c61d2727d49d7d54b
> 
> to the lttng-ust package before you can build lttng-tools

This is most helpful, thank you very much.  I will quickly replace the pile
hacks I just uploaded ;)

Also, just watched your LCA talk.  Well done, I really enjoyed it.

-- 
Jon
