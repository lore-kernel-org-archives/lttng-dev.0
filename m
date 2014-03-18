From: =?ISO-8859-1?Q?J=E9r=E9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [bug]session create failed
Date: Tue, 18 Mar 2014 14:13:16 -0400
Message-ID: <CA+jJMxvQJXJjDJcrrMzapFVOAYGgWzCxiJji+=yAe9CeGDmoxQ__41187.4068355702$1395166462$gmane$org@mail.gmail.com>
References: <CACFGcba=x_GVeVpOMbWyXq19FVKrMdeB7EZ87YxUVTUeH6yXbg@mail.gmail.com>
	<CA+jJMxuvk9Uc69g3wBtY=QB+mAL7H_jBiyA8S=h+8cb=3ZsYMA@mail.gmail.com>
	<CACFGcbZxs2tprVzwx+L7aMQumfDQD8K5g7bzL5qZBa-HUK6Caw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qa0-f52.google.com ([209.85.216.52])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jeremie.galarneau@gmail.com>) id 1WPyVu-00048B-37
	for lttng-dev@lists.lttng.org; Tue, 18 Mar 2014 14:13:28 -0400
Received: by mail-qa0-f52.google.com with SMTP id m5so7232924qaj.25
	for <lttng-dev@lists.lttng.org>; Tue, 18 Mar 2014 11:13:16 -0700 (PDT)
In-Reply-To: <CACFGcbZxs2tprVzwx+L7aMQumfDQD8K5g7bzL5qZBa-HUK6Caw@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Lingyu Zhu <lynuszhu@gmail.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

CC'ing lttng-dev.

On Tue, Mar 18, 2014 at 1:48 PM, Lingyu Zhu <lynuszhu@gmail.com> wrote:
> Thanks for explaining everything.  But I still have questions:
> 1. if I create a session as normal user,and switch to root,and create
> another one. why can i create second one? You see, the port 5345 is occup=
ied
> by the first session?

Users are already using LTTng with multiple session daemon running on
the same host. Seeing as this problem only affects JUL application
tracing, we'd be overly strict by outright refusing to instantiate a
second session daemon. Keep in mind that this address could also be
used by another process.

This graceful degradation of capabilities seems like a reasonable way
to handle the error.

> 2. Why destroy command does not end lttng-sessiond , when the only session
> is destroyed?
>

Good question! The "create" instantiates a session daemon out of
convenience for the user. We could probably monitor whether or not the
current session daemon was launched automatically and tear it down
once the last active session is destroyed... However, I'm afraid this
would cause more user confusion...

We have been thinking of implementing some kind of "lttng teardown"
command to kill the session daemon from the lttng client... I don't
know if there really is user demand for it though.

Regards,
J=E9r=E9mie

>
>
> On Wed, Mar 19, 2014 at 1:19 AM, J=E9r=E9mie Galarneau
> <jeremie.galarneau@efficios.com> wrote:
>>
>> Hi Lingyu,
>>
>> See below for an explanation of the error messages you get.
>>
>> On Tue, Mar 18, 2014 at 12:25 PM, Lingyu Zhu <lynuszhu@gmail.com> wrote:
>> > Hello,
>> > Sorry for being away a few days. My thesis opening proposal is hiting
>> > the
>> > deadline, which happens to be same date for GSoC. Now I can be fully
>> > devoted
>> > to lttng and compose my GSoC proposal.
>> >
>> > Anyway, I may have found a bug.I'm not very sure. Here is my log:
>> >
>> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
>> > [lynus@slave1 ~]$lttng create
>> > Spawning a session daemon
>> > Session auto-20140319-081547 created.
>> > Traces will be written in /home/lynus/lttng-traces/auto-20140319-081547
>> > [lynus@slave1 ~]$ lttng enable-event page_block -k
>> > Error: Event page_block: Tracing the kernel requires a root
>> > lttng-sessiond
>> > daemon, as well as "tracing" group membership or root user ID for the
>> > lttng
>> > client. (channel channel0, session auto-20140319-081547)
>> > Warning: Some command(s) went wrong
>>
>> As the error message indicates, only a root session daemon can
>> interact with the kernel tracer. To allow non-root users the ability
>> to perform kernel tracing, users can interact with the kernel tracer
>> via the session daemon, but only if they are a member of the "tracing"
>> group. This is expected.
>>
>> Note that a session daemon was launched and is now running as user
>> "lynus". This session daemon is waiting for Java applications to
>> register on port 5345, by default.
>>
>> > [lynus@slave1 ~]$ lttng destroy
>> > Session auto-20140319-081547 destroyed
>> > [lynus@slave1 ~]$ sudo su -
>> > [sudo] password for lynus:
>> > root@slave1:~# lttng create
>> > Spawning a session daemon
>>
>> Now, a second session daemon, running as "root", is launched.
>>
>> > Warning: No tracing group detected
>> > Session auto-20140319-081615 created.
>> > Traces will be written in /root/lttng-traces/auto-20140319-081615
>> > PERROR [4774/4882]: bind inet: Address already in use (in
>> > lttcomm_bind_inet_sock() at inet.c:109)
>> > Warning: An other session daemon is using this JUL port. JUL support
>> > will be
>> > deactivated not interfering with the tracing.
>>
>> This indicates that the second session daemon could not bind to the
>> default Java (JUL) registration port.
>>
>> One way to work around this issue is to either ensure you have only
>> one session daemon running, or to specify a different jul-tcp-port by
>> launching the session daemon manually and using its "--jul-tcp-port"
>> option. See LTTNG-SESSIOND(8).
>>
>> This only affects JUL application tracing; the userspace and kernel
>> tracing features will work as expected.
>>
>> Let me know if you need more help,
>> J=E9r=E9mie.
>>
>> > root@slave1:~# lttng create
>> > Session auto-20140319-081620 created.
>> > Traces will be written in /root/lttng-traces/auto-20140319-081620
>> > root@slave1:~#
>> > [END] 2014/3/19 0:04:31
>> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
>> >
>> > These command is issued right after my machine is booted. And if I
>> > directly
>> > switch to root and create a seesion, everything is normal. So I guess I
>> > may
>> > have come across a bug.
>> > Any comment?
>> >
>> > _______________________________________________
>> > lttng-dev mailing list
>> > lttng-dev@lists.lttng.org
>> > http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>> >
>>
>>
>>
>> --
>> J=E9r=E9mie Galarneau
>> EfficiOS Inc.
>> http://www.efficios.com
>
>



-- =

J=E9r=E9mie Galarneau
EfficiOS Inc.
http://www.efficios.com
