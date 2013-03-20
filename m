From: David Goulet <dgoulet@efficios.com>
Subject: Re: [lttng-tools PATCH] Trivial build fix
Date: Wed, 20 Mar 2013 10:15:10 -0400
Message-ID: <5149C46E.5010809__42002.7297259823$1363788964$gmane$org@efficios.com>
References: <1363783606.35366.YahooMailNeo@web120204.mail.ne1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([213.239.202.151])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <dgoulet@efficios.com>) id 1UIJnP-0000mH-46
	for lttng-dev@lists.lttng.org; Wed, 20 Mar 2013 10:15:15 -0400
In-Reply-To: <1363783606.35366.YahooMailNeo@web120204.mail.ne1.yahoo.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Dragos Tarcatu <tarcatu_dragosh@yahoo.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Hi,

Thanks for the patch.

It has been fixed and will be upstream very soon!

Thanks for the patch!
David

Dragos Tarcatu:
> Hi all,
> 
> I've got into a build error on Ubuntu 12.04 (i386) using gcc 4.6.3. The
> compiler seems to get confused when asked to equivalate unsigned long
> and uint64_t on my machine. Since the problem was pretty obvious, I've
> also made a patch for it.
> 
> Regards,
>     Dragos
> 
> 
> This body part will be downloaded on demand.
