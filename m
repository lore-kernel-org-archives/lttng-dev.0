From: Matthew Khouzam <matthew.khouzam@ericsson.com>
Subject: Re: Live reading without using disk
Date: Wed, 17 Sep 2014 11:10:32 -0400
Message-ID: <5419A468.4090603__39587.4061891392$1410966742$gmane$org@ericsson.com>
References: <CAD+1jo_H23O5HiJ9n6VWFDfe7xMTN+26j_0PqXkZjXSYPRO7+g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from usevmg20.ericsson.net ([198.24.6.45])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <matthew.khouzam@ericsson.com>) id 1XUGtG-0002VA-Du
 for lttng-dev@lists.lttng.org; Wed, 17 Sep 2014 11:11:32 -0400
In-Reply-To: <CAD+1jo_H23O5HiJ9n6VWFDfe7xMTN+26j_0PqXkZjXSYPRO7+g@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Hi,

One way is to connect directly to the LTTng Relayd. I believe Julien
Desfossez can comment better than me, but I think LTTngtop does not use
the disk so it can be a nice starting point. If java is more your thing,
TMF (soon to be tracecompass, hopefully?) has connectors to the relayd
that can be re-used too.

IMO:
if you want pretty graphs in a UI, tmf is the way to go
pretty graphs saved as pngs, python with relayd is a nice alternative
real time monitoring, just use lttngtop, and extend it!

BR,
Matthew



On 14-09-17 06:50 AM, Elie Abi Saad wrote:
> Hi,
>
> I want to make statistics on tracepoints at runtime and would like to know if
> there is a way to do live reading on traces without flushing them on disk.
>
> Live mode seems good to me, but do continuously write traces on disk, and
> snapshot mode sounds perfect with the ring buffer mechanism, but we still need
> to record snapshots to read traces.
>
> Any suggestions?
>
> Cheers,
>
