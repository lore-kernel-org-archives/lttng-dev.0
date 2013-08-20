From: Matthew Khouzam <matthew.khouzam@ericsson.com>
Subject: Re: LTTng UST vs Syslog, Printf...
Date: Tue, 20 Aug 2013 14:18:46 -0400
Message-ID: <5213B306.4040706__47109.8970658661$1377022820$gmane$org@ericsson.com>
References: <63008C666A72BB4F892767155D012B30114CD6F0@eusaamb105.ericsson.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from usevmg21.ericsson.net ([198.24.6.65])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <matthew.khouzam@ericsson.com>) id 1VBqWb-0001Zd-Ib
	for lttng-dev@lists.lttng.org; Tue, 20 Aug 2013 14:19:31 -0400
In-Reply-To: <63008C666A72BB4F892767155D012B30114CD6F0@eusaamb105.ericsson.se>
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

I would like to see if the UST logs were ("message %s", string)  of the
printf'ed function.

I remember testing it a while ago and getting about 20x less space for a
trace for 10m events where it was int i=0 ; for(i < 10000000; i++)
trace("val %d", i++);

I formatted recently so I will have to dig a bit but I think the graph
on page 11 discards the fact that since the logs in LTTng are deferred,
they will be logged without stopping the program.

My 0.02c... oh wait, the penny was retired.

Matt



On 13-08-20 02:05 PM, Jim Dumont wrote:
> Hi there,
>
> Has anyone done a recent performance and characteristics comparison between lttngust with syslog and printf?   Things like memory & cpu footprint, tps, i/o, disk space...
>
> I found this Windriver comparison from 2011: https://www.google.ca/url?sa=t&rct=j&q=&esrc=s&frm=1&source=web&cd=1&cad=rja&ved=0CCoQFjAA&url=https%3A%2F%2Fevents.linuxfoundation.org%2Fslides%2F2011%2Flinuxcon%2Flcna2011_wessel.pdf&ei=Y64TUu6qJqS62AXIqYCYCg&usg=AFQjCNF0Q05MytPYVNWBPnUjB9LEGJfQZA
>
> And if I recall correctly, LTTng UST team also did a printf comparison a while back, but was wondering if someone has done more recent prototyping?   Any comparisons with syslog?
>
> Regards,
>
> /Jim Dumont
>
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
