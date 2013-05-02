From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Poor handling of spaces in field names
Date: Thu, 2 May 2013 09:31:00 -0400
Message-ID: <20130502133100.GE7035__14993.9849776731$1367501605$gmane$org@Krystal>
References: <20998D40D9A2B7499CA5A3A2666CB1EB19F8A09C@ZURMSG1.QUANTUM.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1UXtbB-00030V-7k
	for lttng-dev@lists.lttng.org; Thu, 02 May 2013 09:31:01 -0400
Content-Disposition: inline
In-Reply-To: <20998D40D9A2B7499CA5A3A2666CB1EB19F8A09C@ZURMSG1.QUANTUM.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: David OShea <David.OShea@quantum.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

* David OShea (David.OShea@quantum.com) wrote:
> Hi all,
> 
> I never expected to be able to put spaces in field names, but I accidentally did so and had quite a bit of trouble debugging the problem, as 'babeltrace -v <path>' just gave me:
> 
> """
> error syntax error
> [error] Error creating AST
> [warning] Unable to open trace metadata for path "[...]".
> [warning] [Context] Cannot open_trace of the format [...] .
> 
> [warning] [Context] cannot open trace "[...]" from [...] for reading.
> """
> 
> I had to set BABELTRACE_DEBUG=1 to see the metadata scanner and parser debug output to figure out what I'd done wrong :)
> 
> Would it be possible and practical to have the macros generate some
> dummy code using the field names in order to detect them not being
> valid identifiers at compile time?  Better error messages from the
> metadata parser would also be nice, but I imagine that's probably not
> so easy.

babeltrace now has much more verbose error messages (see master branch).
If it is still an issue with you, please open a feature request against
babeltrace on bugs.lttng.org.

Thanks,

Mathieu

> 
> Thanks in advance,
> David
> 
> ----------------------------------------------------------------------
> The information contained in this transmission may be confidential. Any disclosure, copying, or further distribution of confidential information is not permitted unless such privilege is explicitly granted in writing by Quantum. Quantum reserves the right to have electronic communications, including email and attachments, sent across its networks filtered through anti virus and spam software programs and retain such messages in order to comply with applicable data security and retention requirements. Quantum is not responsible for the proper and complete transmission of the substance of this communication or for any delay in its receipt.
> 
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
