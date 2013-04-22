From: Yannick Brosseau <yannick.brosseau@gmail.com>
Subject: Re: [RFC PATCH 0/2] babeltrace legacy LTT 2.6 converter
Date: Mon, 22 Apr 2013 11:55:59 -0400
Message-ID: <51755D8F.7070304__43379.8445309096$1366646188$gmane$org@gmail.com>
References: <cover.1366364119.git.jan.glauber@gmail.com>
	<51715CCB.90009@ericsson.com> <20130422125536.GA8755@hal>
	<51755C85.3070803@ericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qe0-f51.google.com ([209.85.128.51])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <yannick.brosseau@gmail.com>) id 1UUJ66-0008L8-LZ
	for lttng-dev@lists.lttng.org; Mon, 22 Apr 2013 11:56:06 -0400
Received: by mail-qe0-f51.google.com with SMTP id 1so4177407qec.38
	for <lttng-dev@lists.lttng.org>; Mon, 22 Apr 2013 08:56:01 -0700 (PDT)
In-Reply-To: <51755C85.3070803@ericsson.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Matthew Khouzam <matthew.khouzam@ericsson.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

On 2013-04-22 11:51, Matthew Khouzam wrote:
> On 13-04-22 08:55 AM, Jan Glauber wrote:
>> On Fri, Apr 19, 2013 at 11:03:39AM -0400, Matthew Khouzam wrote:
>>> Hi Jan,
>>>
>>> I have a few questions about the patch:
>>> Does it handle lost events?
>>> I think we would need to bring in a state system for this
>> Hi Matthew,
>>
>> Not sure what you mean there. I thought lost events are not recorded so there is
>> nothing to convert. What I do convert is the events_lost counter of LTT. The
>> value is copied to the events_discarded of LTTng. At least that looked reasonable
>> to me. Can you elaborate why we would need a state machine there?
> In lttv, the control flow view and company needs a state system. The
> events in lttng 0.x and 2.0 are slightly different, so we won't see
> stuff like the current TID and file statuses. I'm just giving you the
> heads up that it may be not so trivial to get the info. The best thing
> to do IMO is look up events in LTTng 2.0 and try to match the ones you
> have in babeltrace to them.
> That way, it will work with lttv and eclipse.
>
I'm not sure either that I understand what you mean.

The goal is just to convert traces, not create a whole state system.
When we will be able to get a converted trace, the viewers could adjust
to support them.

Yannick
