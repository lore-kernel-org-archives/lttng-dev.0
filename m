From: "Woegerer, Paul" <Paul_Woegerer@mentor.com>
Subject: Re: Broken patch for a wrapping libdl
Date: Tue, 5 Nov 2013 09:27:40 +0100
Message-ID: <5278ABFC.6050303__38384.9219339483$1383640124$gmane$org@mentor.com>
References: <5277D16E.4080603@ericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Paul_Woegerer@mentor.com>) id 1VdbzJ-0003Jj-0u
	for lttng-dev@lists.lttng.org; Tue, 05 Nov 2013 03:27:53 -0500
Received: from svr-orw-exc-10.mgc.mentorg.com ([147.34.98.58])
	by relay1.mentorg.com with esmtp
	id 1VdbzC-000641-Bd from Paul_Woegerer@mentor.com
	for lttng-dev@lists.lttng.org; Tue, 05 Nov 2013 00:27:42 -0800
In-Reply-To: <5277D16E.4080603@ericsson.com>
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

Hi Matthew,

I have a working solution for that (also based on LD_PRELOADing) as part
of my base address tracing stuff.
I'm going submit the whole patch series next week (hopefully).

Best,
Paul

On 11/04/2013 05:55 PM, Matthew Khouzam wrote:
> Hello tracing arch-wizards,
>
> I was working a bit on a trace with the cyg_profile stuff, and an issue
> that would arise is when you dynamically lync a library, you don't have
> it's name in the symbol tables of the executable, so you cannot nm it to
> have something human readable in the callstack.
>
> The easy solution is to wrap libdl, that way you get the handle of the
> lib i dlopen, and from that you get the function name in dlsym, it also
> handles seamlessly if a lib is closed, and another would replace the
> addresses used.
>
> The only problem is, it doesn't work and I don't have time to get it
> working (in the short term).
>
> I am posting this beginning idea to see if it generates any
> interest/solutions.
>
> Hope this works out,
>
> Matthew
>
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev


-- 
Paul Woegerer, SW Development Engineer
Sourcery Analyzer <http://go.mentor.com/sourceryanalyzer>
Mentor Graphics, Embedded Software Division
