From: Simon Marchi <simon.marchi@polymtl.ca>
Subject: Re: Machine Interface
Date: Thu, 6 Feb 2014 13:40:10 -0500
Message-ID: <CAFXXi0njQxw5t89ytKedE=mwKj_r2vY+cq=AyjzMe9Xoi=XVkg__793.708934407$1391712104$gmane$org@mail.gmail.com>
References: <20140206024218.GD23121@gmail.com> <52F33CBA.5000802@mentor.com>
	<CAFXXi0=enX3ERpH1Q3R-P4ii2wU7TE2wX_NEcXYF0iEXKCW6yA@mail.gmail.com>
	<52F3C14A.6020803@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ig0-f177.google.com ([209.85.213.177])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <thundersim@gmail.com>) id 1WBTsU-0006nJ-Hd
	for lttng-dev@lists.lttng.org; Thu, 06 Feb 2014 13:40:52 -0500
Received: by mail-ig0-f177.google.com with SMTP id k19so237778igc.4
	for <lttng-dev@lists.lttng.org>; Thu, 06 Feb 2014 10:40:41 -0800 (PST)
In-Reply-To: <52F3C14A.6020803@mentor.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "Woegerer, Paul" <Paul_Woegerer@mentor.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

On 6 February 2014 12:07, Woegerer, Paul <Paul_Woegerer@mentor.com> wrote:
> Hi Simon,
>
> On 02/06/2014 02:32 PM, Simon Marchi wrote:
>> script) is easier than XML, but it's still not bulletproof. Consider
>> this eventual yaml structure I just made up for the output of the
>> session list.
>>
>> sessions:
>>   - name: my_session
>>     domain: kernel
>>     events:
>>       - name: sched_switch
>>         filter: prev_pid == 1234
>>       - name: sched_migrate_task
>>         otherproperty: "something"
>>   - name: another_session
>>     domain: ust
>>     events:
>>       - name: event_hello
>>       - name: event_bonjour
>>         loglevel: 3
>>
>> If you want to get the list of sessions, you'll probably want to grep
>> the "name: " entries, but then event names would match as well. Of
>> course, names could be different, or you could grep for the
>> appropriate amount of spaces/tabs at the beginning of the line. But
>> then it also depends if the name dictionary entry is the first, then
>> it will have a "-" in front... It's possible, but it will also be very
>> easy to break scripts.
>
> The following simple script below would e.g. give you the list of
> sessions for you example above. To demonstrate the flexibility it
> also generates the event list for session my_session. This is just
> a quick prototype but it should make clear that YAML is considerably
> easier to parse from a shell script than any other option (and also
> reasonably robust). Also notice that no external helpers (like grep)
> are needed.

This is impressive scripting! Although I can see this growing a little
bit out of control for more complex yaml trees. I agree with you that
yaml is the easiest of them to parse in a pure shell script since the
formatting is more restricted. But if you're on a machine that can
take it, using a solution based on an XPath tool (or equivalent) will
make it so much more maintainable.

> list_of_sessions=''
> current_session=''
> my_session_events=''
>
> while IFS= read -r; do
>         line=$REPLY
>         case "${line}" in
>                 "      - "*)
>                         ;&
>                 "        "*)
>                         L2_key=${line:8}
>                         L2_key=${L2_key%:*}
>                         let vpos=2+8+${#L2_key}
>                         L2_value=${line:${vpos}}
>                         ;;
>                 "  - "*)
>                         # New L1 list elem -> reset L2 state
>                         L2_key=''
>                         L2_value=''
>                         ;&
>                 "    "*)
>                         L1_key=${line:4}
>                         L1_key=${L1_key%:*}
>                         let vpos=2+4+${#L1_key}
>                         L1_value=${line:${vpos}}
>                         ;;
>         esac
>         echo "($L1_key,$L1_value), ($L2_key,$L2_value)"
>
>         # Collect the session names
>         if [ "$L1_key" = "name" ]; then
>                 current_session="$L1_value"
>                 list_of_sessions="$list_of_sessions $current_session"
>         fi
>         # Which events are in session my_session ?
>         if [ "$current_session" = "my_session" ] && [ "$L1_key" = "events" ] && [ "$L2_key" = "name" ]; then
>                 my_session_events="$my_session_events $L2_value"
>         fi
> done
> echo
> echo List of sessions: $list_of_sessions
> echo my_session events: $my_session_events
> echo
>
>
> Thanks,
> Paul
>
> --
> Paul Woegerer, SW Development Engineer
> Sourcery Analyzer <http://go.mentor.com/sourceryanalyzer>
> Mentor Graphics, Embedded Software Division
