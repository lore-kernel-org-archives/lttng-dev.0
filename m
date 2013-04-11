From: =?ISO-8859-1?Q?J=E9r=E9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [RFC lttng-tools] Snapshot
Date: Thu, 11 Apr 2013 11:59:57 -0400
Message-ID: <CA+jJMxtxUdHAeHYgE9_dB7807Yrq=VFoUVVUUpQ9eeVBEChNaQ__33411.5420970649$1365696034$gmane$org@mail.gmail.com>
References: <5166D3DB.1000904@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-wg0-f51.google.com ([74.125.82.51])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jeremie.galarneau@gmail.com>) id 1UQJuu-0000Y7-1p
	for lttng-dev@lists.lttng.org; Thu, 11 Apr 2013 12:00:04 -0400
Received: by mail-wg0-f51.google.com with SMTP id b12so1833457wgh.30
	for <lttng-dev@lists.lttng.org>; Thu, 11 Apr 2013 08:59:58 -0700 (PDT)
In-Reply-To: <5166D3DB.1000904@efficios.com>
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

Looks great! A few very minor points:

In the "Motivation" section, English mistake: "could be particularly
useful *with in* flight recorder mode" should be "could be
particularly useful *in* flight recorder mode". Also, "informationS"
is generally regarded as incorrect. Information has no plural form.

In the "Proposed Solution" section, "the lttng command line UI new
command is presented" should be "the new lttng command-line UI command
is presented".

I'd propose rewriting the sentence "Unlike the other lttng command,
this one uses the git alike UI but in the form of the object first and
 action after where previous command only use action such as
"enable-event" as
"This new command uses a git-alike UI, but in the form of the object
first followed by the desired action, whereas other commands only use
actions such as "enable-event"".

I'm not sure I would use an hyphen in "lttng snapshot list-output"
when an output alias is present. That's an entirely subjective but it
would seem more consistent with git (git remote -v, for instance).

Could you clarify what the expected behavior would be when no session
name is provided to "lttng snapshot record"? I guess it would capture
a snapshot for every session created with the --no-output option.
Also, what happens if a single URL is provided and no session name is
given (with multiple active flight recorder sessions)?

Thanks,
J=E9r=E9mie

On Thu, Apr 11, 2013 at 11:16 AM, David Goulet <dgoulet@efficios.com> wrote:
>
> Hi everyone,
>
> This is the initial RFC for snapshot in lttng-tools. Once accepted, it
> will be available in "doc/proposals/0006-lttng-snapshot.txt".
>
> Any questions, comments or fixes are VERY welcome. There are probably
> English mistakes so feel free to point it out to me.
>
> Thanks!
> David
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>



--
J=E9r=E9mie Galarneau
EfficiOS Inc.
http://www.efficios.com
