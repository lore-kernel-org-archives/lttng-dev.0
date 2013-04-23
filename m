From: Jan Glauber <jan.glauber@gmail.com>
Subject: Re: [RFC PATCH 0/2] babeltrace legacy LTT 2.6 converter
Date: Tue, 23 Apr 2013 14:14:03 +0200
Message-ID: <20130423121401.GA14913__14209.5219147906$1366719292$gmane$org@hal>
References: <cover.1366364119.git.jan.glauber@gmail.com>
	<51715CCB.90009@ericsson.com> <20130422125536.GA8755@hal>
	<51755C85.3070803@ericsson.com> <51755D8F.7070304@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ea0-f169.google.com ([209.85.215.169])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jan.glauber@gmail.com>) id 1UUc6v-0001K4-Ck
	for lttng-dev@lists.lttng.org; Tue, 23 Apr 2013 08:14:13 -0400
Received: by mail-ea0-f169.google.com with SMTP id n15so227931ead.28
	for <lttng-dev@lists.lttng.org>; Tue, 23 Apr 2013 05:14:07 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <51755D8F.7070304@gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Yannick Brosseau <yannick.brosseau@gmail.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

On Mon, Apr 22, 2013 at 11:55:59AM -0400, Yannick Brosseau wrote:
> On 2013-04-22 11:51, Matthew Khouzam wrote:
> > On 13-04-22 08:55 AM, Jan Glauber wrote:
> >> On Fri, Apr 19, 2013 at 11:03:39AM -0400, Matthew Khouzam wrote:
> >>> Hi Jan,
> >>>
> >>> I have a few questions about the patch:
> >>> Does it handle lost events?
> >>> I think we would need to bring in a state system for this
> >> Hi Matthew,
> >>
> >> Not sure what you mean there. I thought lost events are not recorded so there is
> >> nothing to convert. What I do convert is the events_lost counter of LTT. The
> >> value is copied to the events_discarded of LTTng. At least that looked reasonable
> >> to me. Can you elaborate why we would need a state machine there?
> > In lttv, the control flow view and company needs a state system. The
> > events in lttng 0.x and 2.0 are slightly different, so we won't see
> > stuff like the current TID and file statuses. I'm just giving you the
> > heads up that it may be not so trivial to get the info. The best thing
> > to do IMO is look up events in LTTng 2.0 and try to match the ones you
> > have in babeltrace to them.
> > That way, it will work with lttv and eclipse.
> >
> I'm not sure either that I understand what you mean.
> 
> The goal is just to convert traces, not create a whole state system.
> When we will be able to get a converted trace, the viewers could adjust
> to support them.

Yannick is right, these patches are just for converting the raw trace data.
Interpreting the converted trace data is then up to LTTV or Eclipse.

Conversion of the trace data to the concrete CTF description LTTng 2.x is
using would be quite hard and require also to convert the trace data itself
(which I avoided so far...).

-- Jan

 
> Yannick

-- 
Jan Glauber
---
Harman Becker Automotive GmbH
System Profiling & Optimizing Team
