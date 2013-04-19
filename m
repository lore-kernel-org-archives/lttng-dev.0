From: Matthew Khouzam <matthew.khouzam@ericsson.com>
Subject: Re: [RFC PATCH 0/2] babeltrace legacy LTT 2.6 converter
Date: Fri, 19 Apr 2013 11:03:39 -0400
Message-ID: <51715CCB.90009__41597.0821203247$1366383900$gmane$org@ericsson.com>
References: <cover.1366364119.git.jan.glauber@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from usevmg21.ericsson.net ([198.24.6.65])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <matthew.khouzam@ericsson.com>) id 1UTCrX-0007Y8-GO
	for lttng-dev@lists.lttng.org; Fri, 19 Apr 2013 11:04:31 -0400
In-Reply-To: <cover.1366364119.git.jan.glauber@gmail.com>
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

Hi Jan,

I have a few questions about the patch:
Does it handle lost events?
I think we would need to bring in a state system for this
Is there a reason lttng2.0 is not working for you? kernel? install base?
other?
Do you want just a list of the events or analysis on the trace later on.

Can you post an example of a converted trace?
Thanks
Matthew


On 13-04-19 06:20 AM, Jan Glauber wrote:
> Hi list,
>
> I've written a converter that can read LTT's 2.6 trace format and convert it
> to a CTF trace format. This was discussed before on the list:
>
> http://lists.lttng.org/pipermail/lttng-dev/2011-June/015995.html
>
> and I roughly followed the guidance given by Mathieu there. Roughly because
> I did not create plugins but followed the approach of babeltrace-log.
>
> How it works:
> - babeltrace legacy converter gets a directory containing a LTT 2.6 trace
>   and a target directory where it will create the converted trace
> - it scans the metadata_N files and creates a CTF which fits the old trace data
> - it scans all trace files and creates CTF headers but copies the trace data
> - empty files which contain only headers are not copied
>
> Is there any interest in picking up this code for babeltrace (or is it just
> too obscure :) ?
>
> Best regards,
>
> Jan Glauber
> Harman Becker Automotive GmbH
> System Profiling & Optimizing Team
>
> Jan Glauber (2):
>   Resurrect LTT type parser
>   babeltrace legacy LTT 2.6 -> CTF 1.8 converter
>
>  converter/babeltrace-legacy.c        | 1184 ++++++++++++++++++++++++++++++++++
>  converter/ltt-type-parser.c          |  303 +++++++++
>  include/babeltrace/ltt-type-parser.h |   17 +
>  3 files changed, 1504 insertions(+)
>  create mode 100644 converter/babeltrace-legacy.c
>  create mode 100644 converter/ltt-type-parser.c
>  create mode 100644 include/babeltrace/ltt-type-parser.h
>
