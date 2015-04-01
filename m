From: Jesper Derehag <jderehag@hotmail.com>
Subject: Re: Configurable tracepath?
Date: Wed, 1 Apr 2015 07:14:05 +0000
Message-ID: <DUB123-W1898C83913C30D339E7BEADDF30__30589.6018202931$1427872525$gmane$org@phx.gbl>
References: <DUB408-EAS865D8F72981E73E7C512A8DDF50@phx.gbl>
 <CA+jJMxsAaVD2xYJ=po2w+ZajfzDwZ1Los3nbxdRL7RMyJSFLrw@mail.gmail.com>,
 <1579587492.151507.1427736869150.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from dub004-omc2s36.hotmail.com ([157.55.1.175])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jderehag@hotmail.com>) id 1YdCqp-0003kj-Ps
 for lttng-dev@lists.lttng.org; Wed, 01 Apr 2015 03:14:21 -0400
In-Reply-To: <1579587492.151507.1427736869150.JavaMail.zimbra@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, =?iso-8859-1?B?Suly6W1pZSBHYWxhcm5lYXU=?= <jeremie.galarneau@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org



----------------------------------------
> Date: Mon, 30 Mar 2015 17:34:29 +0000
> From: mathieu.desnoyers@efficios.com
> To: jeremie.galarneau@efficios.com
> CC: jderehag@hotmail.com; lttng-dev@lists.lttng.org
> Subject: Re: [lttng-dev] Configurable tracepath?
>
> ----- Original Message -----
>> On Mon, Mar 30, 2015 at 5:21 AM, Jesper Derehag <jderehag@hotmail.com> w=
rote:
>>> No thoughts on this one?
>>>
>>> Den 25 mar 2015 16:53 skrev Jesper Derehag <jderehag@hotmail.com>:
>>>
>>> Hi,
>>>
>>> We have run into an issue with unique per-session tracepaths.
>>>
>>> In my particular setup I am using relayd to centralize alot of consumers
>>> (not really important to this discussion, but thought I'd mention it
>>> anyway).
>>> So the problem is that I have very limited quota for %outputpath. So to
>>> manage the quota fairly between channels I am using --tracefile-size to
>>> limit the size of each channel and thus preventing them from starving
>>> eachother out.
>>> BUT, say I would want to restart the session for some reason, in my cas=
e it
>>> might be that the card running a specific session reboots, and then rel=
ayd
>>> would get a new session & channel, and thus create a new folder for that
>>> data. But since the old data still remains, I would run into the quota
>>> limit..
>>>
>>> Below is how the tracepaths are created in pseudo-code:
>>>
>>> per-pid tracing:
>>> tracepath =3D %outputpath/%pid/%session_name-%pid-%datetime
>>>
>>> per-uid tracing:
>>> tracepath =3D %outputpath/uid/%uid/%arch-bit
>>>
>>> So just reading this little snippet I am guessing one could avoid this
>>> particular problem by doing per-uid tracing, but that seems like an
>>> unnecessary workaround for what would seem like a trivial problem?
>>>
>>> Would it instead be feasable to have the channel->path_name configurabl=
e,
>>> so
>>> that you essentially could avoid the uniqueness of the path (pid &
>>> datetime)?
>>>
>>> Or is that instead opening pandoras box w.r.t. to tracefile consistency=
 and
>>> contention?
>>
>> I *think* this was done to reasonably ensure the uniqueness of the
>> trace path since the consumer and relay daemons will not deal with
>> existing files gracefully.
>>
>> I can see the use case though... It would probably require making the
>> consumer and relay daemons a bit smarter if we want them to pick-up
>> where they left. Nevertheless, it would be a neat feature.
>>
>> In the meantime, I don't really have a good recommendation for you... :-/
>
> Also, in per-PID tracing, we also need to have separate output files for
> each process that runs concurrently. Per-UID tracing is meant to share
> the ring buffer across processes from the same user, which is not the
> case for per-PID tracing.

Well, yes. This was what I was worring about when talking about concurrency=
 above (allthough its not about CPU concurrency but rather file concurrency=
).

>
> You might want to try erasing the old trace before starting to record
> the new session.

Yeah thats the obvious solution.=A0
But that introduces other problems on the other hand. Say you are running f=
light-recorder, your task crashes (and thus you need to restart session), i=
f we would then erase tracefile we would miss the entire flightrecorder ses=
sion.
Another issue might be like in our case where we are aiming at replacing sy=
slog (in logrotate fashion), with lttng. So if we would have a reboot (grac=
eful or non-graceful), we would have gaps in the tracefile around the inter=
esting events (and usually most issues do happen during startup/shutdown ph=
ases, so in this case we would have gaps in the most interesting region-of-=
interests).

So yeah, your solution solves the quota issue but also introduces some othe=
r maybe-not-so-desirable properties.

I think the takeaway here is that to solve this is really not trivial. So w=
e need to go back to the drawing board a little bit and maybe rethink our s=
toring scheme...
It does not sound like "re-use tracefiles" feature is coming anytime soon..=
 =3D)

>
> Thanks,
>
> Mathieu
>
>>
>> J=E9r=E9mie
>>
>>>
>>> Regards,
>>> Jesper
>>> _______________________________________________
>>> lttng-dev mailing list
>>> lttng-dev@lists.lttng.org
>>> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>>>
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
>>
>> _______________________________________________
>> lttng-dev mailing list
>> lttng-dev@lists.lttng.org
>> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>>
>
> --
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com
 		 	   		  =
