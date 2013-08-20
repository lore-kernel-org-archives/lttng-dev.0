From: Jim Dumont <jim.dumont@ericsson.com>
Subject: LTTng UST vs Syslog, Printf...
Date: Tue, 20 Aug 2013 18:05:01 +0000
Message-ID: <63008C666A72BB4F892767155D012B30114CD6F0__25318.0502950729$1377021968$gmane$org@eusaamb105.ericsson.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from usevmg20.ericsson.net ([198.24.6.45])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jim.dumont@ericsson.com>) id 1VBqIm-0000gL-TR
	for lttng-dev@lists.lttng.org; Tue, 20 Aug 2013 14:05:14 -0400
Content-Language: en-US
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "'lttng-dev@lists.lttng.org'" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Hi there,

Has anyone done a recent performance and characteristics comparison between lttngust with syslog and printf?   Things like memory & cpu footprint, tps, i/o, disk space...

I found this Windriver comparison from 2011: https://www.google.ca/url?sa=t&rct=j&q=&esrc=s&frm=1&source=web&cd=1&cad=rja&ved=0CCoQFjAA&url=https%3A%2F%2Fevents.linuxfoundation.org%2Fslides%2F2011%2Flinuxcon%2Flcna2011_wessel.pdf&ei=Y64TUu6qJqS62AXIqYCYCg&usg=AFQjCNF0Q05MytPYVNWBPnUjB9LEGJfQZA

And if I recall correctly, LTTng UST team also did a printf comparison a while back, but was wondering if someone has done more recent prototyping?   Any comparisons with syslog?

Regards,

/Jim Dumont
