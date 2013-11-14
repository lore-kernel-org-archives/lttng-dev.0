From: "Ikaheimonen, JP" <jp_ikaheimonen@mentor.com>
Subject: Re: [PATCH lttng-tools 00/28] UST Event exclusions
Date: Thu, 14 Nov 2013 14:42:28 +0000
Message-ID: <009B25148989C6458484484699278506E539FBEE__27348.0994430885$1384440312$gmane$org@EU-MBX-01.mgc.mentorg.com>
References: <1383819403-6386-1-git-send-email-jp_ikaheimonen@mentor.com>
	<20131113210758.GB7694@dalia>
	<009B25148989C6458484484699278506E539FA93@EU-MBX-01.mgc.mentorg.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jp_ikaheimonen@mentor.com>) id 1Vgy7x-00009y-F7
	for lttng-dev@lists.lttng.org; Thu, 14 Nov 2013 09:42:43 -0500
In-Reply-To: <009B25148989C6458484484699278506E539FA93@EU-MBX-01.mgc.mentorg.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: David Goulet <dgoulet@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Hi again David,
I've got a new commit set set up in 
https://github.com/jpikahei/lttng-tools
branch jpikahei_event_exclusion

Please pull the changes from there.
I've fixed the small issues you mentioned, plus added a test and updated the man page.

Cheers,
JP

-----Original Message-----
From: Ikaheimonen, JP 
Sent: 14. marraskuuta 2013 9:29
To: David Goulet
Cc: lttng-dev@lists.lttng.org
Subject: Re: [lttng-dev] [PATCH lttng-tools 00/28] UST Event exclusions

Thanks David!
I'll add your changes, figure out what goes wrong with the test, add a new test, and patch the man page.
Then I will submit a pull request.
I aim to have done this by the end of this week.

Thanks again,
JP

-----Original Message-----
From: David Goulet [mailto:dgoulet@efficios.com]
Sent: 13. marraskuuta 2013 23:08
To: Ikaheimonen, JP
Cc: lttng-dev@lists.lttng.org
Subject: Re: [lttng-dev] [PATCH lttng-tools 00/28] UST Event exclusions

Hey JP!

So here is the deal with this big patch set and the 2.4-rc ;).

I've checked the patches and they are OK in terms of code and structure.
The feature seems to work fine also! Which is a good news. However, we are a couple hours before the release candidate! and there is still issues with all this :S.

We know that you guys have been putting a lot of efforts in this and the code looks good so what we are going to do is merge this in the next RC release (meaning 2.4-rc2) considering that right now the feature works and thus is freezed for the next version.

For that to happen, I'll ask you to fix the following issues as soon as you can so we can merge it quickly thus having more testing. Not getting this in time, unfortunately we won't be able to merge that for 2.4.
Usually, the RC process cycle is around 1 month maximum.

Issues:

1) "make check" fails here so it *has* to pass in order to accept this patch set. I didn't investiguate thoroughly but it might be that you broke some existing feature or small adjustement to the tests.

2) For this kind of big feature, we *need* at least one test that makes sure that in further release there is no regression for that exclusion feature.

3) A patch for the man page (lttng.1) would be *very* appreciated.

4) Commit id: 78bef43205f5296cb6cae81b6e264b849fe94988
Please add a PERROR() if the zmalloc returns NULL so we can at least report it somewhere.

I've fixed small issues also so please look at my dev branch for the two small commits on top of the 28 patches.

https://github.com/dgoulet/lttng-tools-dev/tree/ev-exclusion

Considering that, either you send back the patches *ON TOP* of that dev branch or you can also provide me with a pull request because with that amount of patches, by email is kind of a pain :).

Hope this seems fair enough with you guys. It's the best we can do to make sure this feature gets in 2.4 :).

Cheers!
David

On 07 Nov (12:16:43), JP Ikaheimonen wrote:
> This patch set, along with a patch set for lttng-ust, implements a new 
> option for lttng enable-event command.
> 
> The new option makes it possible to exclude events from a wildcarded 
> event definition.
> 
> That is, running command
> 
> lttng enable-event -u -c c1 'myevents*' -x 'myevents:dbg*'
> 
> would enable all UST tracepoint events whose names start with 'myevents'
> except those that start with 'myevents:dbg'.
> 
> The lttng list command is also updated, so that it points out the fact 
> that an event has some exclusions.
> 
> JP Ikaheimonen (28):
>   Add exclusion data to enable-command
>   Define a structure for event exclusion data
>   Add exclusion data to cmd_enable_event
>   Add exclusions to event_ust_enable_tracepoint
>   Add event exclusion data to ltt_ust_event structure
>   Add exclusion matching logic to trace_ust_ht_match_event
>   Add exclusion data to trace_ust_create_event
>   Add exclusion data to trace_ust_find_event
>   Copy exclusion data in add_unique_ust_event.
>   Add new error codes for exclusion processing
>   Add handling of LTTNG_ENABLE_EVENT_WITH_EXCLUSION
>   Collate handling of LTTNG_ENABLE_EVENT_WITH_FILTER
>   Add exclusion data to ust_app_event structure
>   Compare also exclusions in ht_match_ust_app_event
>   Copy event exclusion data in add_unique_ust_app_event
>   Free exclusion data when ust_app_event is deleted
>   Add exclusion data to find_ust_app_event
>   Copy exclusion data in shadow_copy_event
>   Set event exclusions in the target when event is created
>   Send enable-event commands with exclusion data
>   Collate lttng_enable_event* code
>   Add -exclude option to enable-event command
>   Add usage for --exclude option
>   Add a function to check for legal exclusions
>   Parse exclusions and forward them to the control handler
>   Detect and report exclusion option errors
>   Add exclusion names to diagnostic printouts
>   When listing events, show exclusions if they exist
> 
>  include/lttng/lttng-error.h              |   2 +
>  include/lttng/lttng.h                    |  20 ++-
>  src/bin/lttng-sessiond/cmd.c             |  13 +-
>  src/bin/lttng-sessiond/cmd.h             |   4 +-
>  src/bin/lttng-sessiond/event.c           |  12 +-
>  src/bin/lttng-sessiond/event.h           |   3 +-
>  src/bin/lttng-sessiond/main.c            | 110 +++++++-----
>  src/bin/lttng-sessiond/trace-ust.c       |  23 ++-
>  src/bin/lttng-sessiond/trace-ust.h       |  14 +-
>  src/bin/lttng-sessiond/ust-app.c         |  95 +++++++++-
>  src/bin/lttng-sessiond/ust-app.h         |   2 +
>  src/bin/lttng/commands/enable_events.c   | 242 +++++++++++++++++++++++--
>  src/bin/lttng/commands/list.c            |  15 +-
>  src/common/sessiond-comm/sessiond-comm.h |  22 ++-
>  src/lib/lttng-ctl/lttng-ctl.c            | 291 ++++++++++++++++++-------------
>  tests/unit/test_ust_data.c               |   2 +-
>  16 files changed, 657 insertions(+), 213 deletions(-)
> 
> --
> 1.8.1.2
> 
> 
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
