From: "Woegerer, Paul" <Paul_Woegerer@mentor.com>
Subject: Re: lttng-modules how to automatically load my
 lttng_probe_xxx module
Date: Wed, 9 Jul 2014 13:08:42 +0200
Message-ID: <53BD22BA.3030808__31540.6931018972$1404904176$gmane$org@mentor.com>
References: <53BD1FB4.8020001@xsilon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <Paul_Woegerer@mentor.com>) id 1X4pk4-0006Rq-SV
 for lttng-dev@lists.lttng.org; Wed, 09 Jul 2014 07:08:56 -0400
In-Reply-To: <53BD1FB4.8020001@xsilon.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Martin Townsend <martin.townsend@xsilon.com>, lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

On 07/09/2014 12:55 PM, Martin Townsend wrote:
> Hi,
> 
> Using the instructions from
> http://lists.lttng.org/pipermail/lttng-dev/2013-October/021540.html
> I have added my own kernel module to lttng-modules and can successfully
> trace my own custom events.  I have to manually modprobe lttng_probe_xxx
> to get it to work though.  Is there a way of doing this automatically?

AFAIK, currently you still also need to add your module to:
http://git.lttng.org/?p=lttng-tools.git;a=blob;f=src/bin/lttng-sessiond/modprobe.c;hb=HEAD

HTH,
Paul

> 
> Best Regards,
> Martin.
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
