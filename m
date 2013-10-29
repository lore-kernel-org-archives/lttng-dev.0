From: Simon Marchi <simon.marchi@polymtl.ca>
Subject: Re: Current Trace File Location
Date: Tue, 29 Oct 2013 12:39:38 -0400
Message-ID: <CAFXXi0kivvHVwA0Jw7vuN-CA7e9SrcUbZR=AESOGHgTM=TnPqA__34421.1448952139$1383064874$gmane$org@mail.gmail.com>
References: <CAN7pGtu1BtOibd4nj--7z45ye7QeBHCpCRmavwBL52AnNg-y7g@mail.gmail.com>
	<20131029160231.GB6784@thessa>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ie0-f179.google.com ([209.85.223.179])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <thundersim@gmail.com>) id 1VbCKz-0002FJ-Si
	for lttng-dev@lists.lttng.org; Tue, 29 Oct 2013 12:40:19 -0400
Received: by mail-ie0-f179.google.com with SMTP id aq17so185377iec.24
	for <lttng-dev@lists.lttng.org>; Tue, 29 Oct 2013 09:40:08 -0700 (PDT)
In-Reply-To: <20131029160231.GB6784@thessa>
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

Also:

"lttng list" will give you the existing sessions.
"lttng set-session <name>" will change the current session (ie write
that session name in .lttngrc).

On 29 October 2013 12:02, David Goulet <dgoulet@efficios.com> wrote:
> On 29 Oct (11:59:04), Michael Steppe wrote:
>> Hello,
>>
>> I am not sure if this is where I ask my questions to the developers but I
>> thought I'd give it a go.
>>
>> I am able to create a kernel trace, enable all events for the trace, start,
>> stop and destroy the trace. But let's say I have two traces running on the
>> same machine:
>>
>> [user@localhost ~]$ lttng create trace1
>> [user@localhost ~]$ lttng create trace2
>> [user@localhost ~]$ lttng create trace3
>>
>> As I am sure you know, the .lttngrc file is populated with ONLY the latest
>> created trace name (trace3).
>>
>> Now let's say I change my mind after creating these traces and wish to
>> destroy them all. If I use the destroy command...
>>
>> [user@localhost ~]$ lttng destroy
>>
>> ...with no argument, it defaults to the .lttngrc file and destroys trace3 as
>> well as the .lttngrc file. This means that the next time I run lttng
>> destroy I get the error that it cannot find the .lttngrc file and asks if I
>> created a session. Well we still have trace1 and trace2 in the background
>> somewhere because if I try to:
>>
>> [user@localhost ~]$ lttng create trace1
>>
>> I get told that there is already a trace with that name.
>>
>> My question to you is, where are all the traces stored until they are
>> destroyed? LTT obviously knows that trace1 and trace2 are still "running"
>> because it won't let me create another with the same name until I destroy
>> it. I know that I could say:
>>
>> [user@localhost ~]$ lttng destroy trace1
>> [user@localhost ~]$ lttng destroy trace2
>>
>> but I am writing an Eclipse plugin to do this tracing without the terminal
>> so the trace name will be based off of the time of day the user runs it and
>> therefore I cannot hardcode the name in.
>>
>> Is there a "destroy all" command that I am missing?
>
> lttng destroy -a :)
>
> David
>
>>
>> Thanks!!
>> Michael
>
>> _______________________________________________
>> lttng-dev mailing list
>> lttng-dev@lists.lttng.org
>> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>
