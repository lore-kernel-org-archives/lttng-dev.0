From: Simon Marchi via lttng-dev <lttng-dev@lists.lttng.org>
Subject: Re: Babeltrace2 sink.ctf.fs creating many subdirectories
Date: Fri, 3 Apr 2020 12:57:42 -0400
Message-ID: <f8c7127d-e83d-dd9e-34e4-b2986f04c76b@simark.ca>
References: <BL0PR04MB5042D065C601970A17A5B2C1CEC70@BL0PR04MB5042.namprd04.prod.outlook.com>
Reply-To: Simon Marchi <simark@simark.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from simark.ca (simark.ca [158.69.221.121])
 by lists.lttng.org (Postfix) with ESMTPS id 48v5hr4l4lz1bpc
 for <lttng-dev@lists.lttng.org>; Fri,  3 Apr 2020 12:57:48 -0400 (EDT)
In-Reply-To: <BL0PR04MB5042D065C601970A17A5B2C1CEC70@BL0PR04MB5042.namprd04.prod.outlook.com>
Content-Language: fr
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: "Muresan, Heman" <hmuresan@ciena.com>, "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

On 2020-04-03 8:50 a.m., Muresan, Heman via lttng-dev wrote:
> Hi,
> =

> =A0
> =

> I=92m using bt2 to combine multiple archives and I=92m noticing some weir=
d behavior. Not sure if its something on my end.
> =

> =A0
> =

> I have a bunch of ctf trace archives and I am trying to combine them into=
 one ctf trace archive, this works fine, but when I try to use this ctf tra=
ce plugin again to combine traces I notice that it keeps creating subdirect=
ories. Example:
> $ babeltrace2 --output-format=3Dctf --output tmp/ 20200402T191121+0000-20=
200402T191133+0000-779 20200402T191133+0000-20200402T191145+0000-780
> =

> Created CTF trace `tmp//a46cbfc6c29d/flight_recorder-20200402T160923+0000=
/ust/uid/0/64-bit`.
> =

> =A0
> =

> Now If I try to use this trace to combine again:
> =

> $ mv tmp/a46cbfc6c29d/ .
> =

> $ babeltrace2 --output-format=3Dctf --output tmp/ 20200402T191145+0000-20=
200402T191157+0000-781 a46cbfc6c29d
> =

> Created CTF trace `tmp//a46cbfc6c29d/flight_recorder-20200402T160923+0000=
/ust/uid/0/64-bit-0`.
> =

> Created CTF trace `tmp//a46cbfc6c29d/flight_recorder-20200402T160923+0000=
/ust/uid/0/64-bit`.
> =

> =A0
> =

> Repeating the procress:
> =

> $ rm -rf a46cbfc6c29d/
> =

> $ mv tmp/a46cbfc6c29d/ .
> =

> $ babeltrace2 --output-format=3Dctf --output tmp/ a46cbfc6c29d/ 20200402T=
191157+0000-20200402T191210+0000-782
> =

> Created CTF trace `tmp//a46cbfc6c29d/flight_recorder-20200402T160923+0000=
/ust/uid/0/64-bit-1`.
> =

> Created CTF trace `tmp//a46cbfc6c29d/flight_recorder-20200402T160923+0000=
/ust/uid/0/64-bit`.
> =

> Created CTF trace `tmp//a46cbfc6c29d/flight_recorder-20200402T160923+0000=
/ust/uid/0/64-bit-0`.
> =

> =A0
> =

> It created a 64-bit-0 and a 64-bit-1 directory, and if I use this newly c=
reated ctf archive again it will create a 64-bit-2 directory. Eventually th=
e directory structure will grow so much that it causes file descriptor prob=
lem. Of course, this can be solved by changing the ulimit but that doesn=92=
t seem like the correct approach, especially since then bt2 will just be us=
ing more and more resources when its running.
> =

> =A0
> =

> Anyways, I=92m just wondering why it keeps creating more and more directo=
ries, if I combine all four archives in one command it only creates one dir=
ectory:
> $ babeltrace2 --output-format=3Dctf --output tmp/ 20200402T191121+0000-20=
200402T191133+0000-779 20200402T191133+0000-20200402T191145+0000-780 202004=
02T191145+0000-20200402T191157+0000-781 20200402T191157+0000-20200402T19121=
0+0000-782
> =

> Created CTF trace `tmp//a46cbfc6c29d/flight_recorder-20200402T160923+0000=
/ust/uid/0/64-bit-2`.
> =

> =A0
> =

> Any help would be appreciated!

Hi Heman,

This is the expected behavior.

Let's say you have three chunks of the same trace: A, B and C.  These three=
 chunks
have the same trace UUID, meaning they can all be decoded using the same me=
tadata.
Here's the definition a the trace UUID, from [1]:

    Trace UUID, used to ensure the event packet match the metadata used.

When you pass A and B through Babeltrace, A and B are recognized to be of t=
he same
trace (they share the same UUID) and are therefore merged in a single outpu=
t trace.
The output trace, let's call it AB, contains the same logical information a=
s A and
B.  However, the metadata in AB differs slightly from A's or B's metadata. =
 Since
the packets in AB don't match the metadata from A or B (they can't be decod=
ed using
the metadata from A or B), we can't give it the same UUID.  AB therefore ge=
ts
assigned a new UUID.

When you then try to process AB and C, Babeltrace considers them as differe=
nt traces,
since they have different UUIDs.  The sink.ctf.fs component outputs one tra=
ce per
input trace.  So in output, you'll find one trace corresponding to AB and o=
ne trace
corresponding to C (they'll have different UUIDs than AB and C).

This is a common misconception that sink.ctf.fs would merge the various tra=
ces it
receives into a single trace (probably because that's what the sink.text.pr=
etty
component appears to do).

If you want to merge multiple chunks of a trace, you have to do it in one s=
hot, as
you've mentioned at the end of your message.

If you can share this information, I'd be curious to know the reason why yo=
u need
to merge the trace chunks in a single CTF trace, like if you hit some limit=
ation
with some analysis tool by keeping the chunks separate.

Simon

[1] https://diamon.org/ctf/#spec5
