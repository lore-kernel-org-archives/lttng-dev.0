From: =?ISO-8859-1?Q?J=E9r=E9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [RFC lttng-tools] Snapshot
Date: Thu, 11 Apr 2013 12:25:28 -0400
Message-ID: <CA+jJMxsPTQdW-dc-=+WApQGoMVvU8j_zAnb5ygxiYNzdy=weeg__15514.3188931563$1365697559$gmane$org@mail.gmail.com>
References: <5166D3DB.1000904@efficios.com>
	<CA+jJMxtxUdHAeHYgE9_dB7807Yrq=VFoUVVUUpQ9eeVBEChNaQ@mail.gmail.com>
	<5166E24E.2090100@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-wg0-f51.google.com ([74.125.82.51])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jeremie.galarneau@gmail.com>) id 1UQKJb-0000qf-OB
	for lttng-dev@lists.lttng.org; Thu, 11 Apr 2013 12:25:35 -0400
Received: by mail-wg0-f51.google.com with SMTP id b12so1781859wgh.18
	for <lttng-dev@lists.lttng.org>; Thu, 11 Apr 2013 09:25:30 -0700 (PDT)
In-Reply-To: <5166E24E.2090100@efficios.com>
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

On Thu, Apr 11, 2013 at 12:18 PM, David Goulet <dgoulet@efficios.com> wrote:
>
>
> J=E9r=E9mie Galarneau:
>> Looks great! A few very minor points:
>>
>> In the "Motivation" section, English mistake: "could be particularly
>> useful *with in* flight recorder mode" should be "could be
>> particularly useful *in* flight recorder mode". Also, "informationS"
>> is generally regarded as incorrect. Information has no plural form.
>>
>> In the "Proposed Solution" section, "the lttng command line UI new
>> command is presented" should be "the new lttng command-line UI command
>> is presented".
>>
>> I'd propose rewriting the sentence "Unlike the other lttng command,
>> this one uses the git alike UI but in the form of the object first and
>>  action after where previous command only use action such as
>> "enable-event" as
>> "This new command uses a git-alike UI, but in the form of the object
>> first followed by the desired action, whereas other commands only use
>> actions such as "enable-event"".
>>
>> I'm not sure I would use an hyphen in "lttng snapshot list-output"
>> when an output alias is present. That's an entirely subjective but it
>> would seem more consistent with git (git remote -v, for instance).
>
> What output format do you propose?
>

Pretty much the same thing:
[1]: file://[...]
[2]: net://1.1.1.1:8762:9123
[3] ALIAS: file://[...]

Then again, I don't feel strongly about it.

>>
>> Could you clarify what the expected behavior would be when no session
>> name is provided to "lttng snapshot record"? I guess it would capture
>> a snapshot for every session created with the --no-output option.
>> Also, what happens if a single URL is provided and no session name is
>> given (with multiple active flight recorder sessions)?
>
> lttng command always work on the current session if none is defined.
> I'll make it clearer in the RFC.

Will there be a way to snapshot every flight-recorder session (say, on
a trigger) or should it be done by invoking the command with every
session name? Just trying to make the RFC as precise as possible :)

>
> Thanks!
> David
>
>>
>> Thanks,
>> J=E9r=E9mie
>>
>> On Thu, Apr 11, 2013 at 11:16 AM, David Goulet <dgoulet@efficios.com> wr=
ote:
>>>
>>> Hi everyone,
>>>
>>> This is the initial RFC for snapshot in lttng-tools. Once accepted, it
>>> will be available in "doc/proposals/0006-lttng-snapshot.txt".
>>>
>>> Any questions, comments or fixes are VERY welcome. There are probably
>>> English mistakes so feel free to point it out to me.
>>>
>>> Thanks!
>>> David
>>>
>>> _______________________________________________
>>> lttng-dev mailing list
>>> lttng-dev@lists.lttng.org
>>> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>>>
>>
>>
>>
>> --
>> J=E9r=E9mie Galarneau
>> EfficiOS Inc.
>> http://www.efficios.com



--
J=E9r=E9mie Galarneau
EfficiOS Inc.
http://www.efficios.com
