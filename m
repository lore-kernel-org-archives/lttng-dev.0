From: Alexandre Montplaisir <alexmonthy@voxpopuli.im>
Subject: Re: lttng command line user-friendliness
Date: Mon, 10 Sep 2012 10:58:33 -0400
Message-ID: <504E0019.905__41408.5583798171$1347289149$gmane$org@voxpopuli.im>
References: <504DCE2E.7020000@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from ironport2-out.teksavvy.com ([206.248.154.182])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <alexmonthy@voxpopuli.im>) id 1TB5Rj-0006Wh-LZ
	for lttng-dev@lists.lttng.org; Mon, 10 Sep 2012 10:58:43 -0400
In-Reply-To: <504DCE2E.7020000@mentor.com>
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

+1, Like, etc.

The following bug was opened some time ago: http://bugs.lttng.org/issues/15

From what is said in the bug, it will require both the flight-recorder
mode in the tracer, and the live-trace-reading feature in Babeltrace.
Those are not implemented yet, but they shouldn't be too far around from
what I can tell (2.2 maybe?).


Cheers,
Alexandre



On 12-09-10 07:25 AM, Woegerer, Paul wrote:
> As much as I like the lttng command line tool (that we have since
> LTTng2) I still see people (who are not yet familiar with lttng)
> struggle with the simple fact that it takes more than one command to
> actually get something traced.
>
> Issuing a sequence of commands like:
>
> lttng create
> lttng enable-event -u -a
> lttng start
> my_foobar_traced_application 1 2 3
> lttng stop
> lttng destroy
>
> seems to be perceived as complicated compared to:
>
> perf record -- my_foobar_traced_application 1 2 3
>
> My argument usually is that providing detailed settings as options
> (like perf) does not scale as well as the lttng approach (if you have
> more things to configure). On the other hand most users just want
> something like the above. Also arguing that they should write a
> shell-script that encodes their use case generally causes irritation
> ("... please understand, I do not want to write a shell-script I just
> want to do simple tracing of my executable ...").
>
> What about adding something similar to "perf record" to lower the
> barrier for such users. For example:
>
> lttng record [--session-name <name>] [--session-template
> <session_template_file>]  -- <command> [<options>]
>
> Where the optional session_template_file may only contain
> "enable-channel, enable-event and add-context" commands. If omitted
> the following could be the (trivial) default session template:
>
> enable-event -u -a
>
>
> Would this make sense for others as well ? Any alternative suggestions ?
>
> Thanks,
> Paul
>
