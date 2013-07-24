From: =?ISO-8859-1?Q?J=E9r=E9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH babeltrace] Make examples work
Date: Wed, 24 Jul 2013 15:32:12 -0400
Message-ID: <CA+jJMxuXo6sL1EnC8O_6D7fF33405Q44EJcFZPm5DzHz7nb=_A__4595.32039608366$1374694398$gmane$org@mail.gmail.com>
References: <1374659868-6264-1-git-send-email-xiaonahappy13@163.com>
	<1374659868-6264-3-git-send-email-xiaonahappy13@163.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-wi0-f175.google.com ([209.85.212.175])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jeremie.galarneau@gmail.com>) id 1V24nK-00018L-4p
	for lttng-dev@lists.lttng.org; Wed, 24 Jul 2013 15:32:24 -0400
Received: by mail-wi0-f175.google.com with SMTP id m6so4719316wiv.8
	for <lttng-dev@lists.lttng.org>; Wed, 24 Jul 2013 12:32:12 -0700 (PDT)
In-Reply-To: <1374659868-6264-3-git-send-email-xiaonahappy13@163.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Xiaona Han <xiaonahappy13@163.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

This patch depends on the other two you submitted. Resubmit them as a
series. Use git format-patch's "-n" option for that.

Also, please provide a clearer commit message.

Regards,
J=E9r=E9mie

On Wed, Jul 24, 2013 at 5:57 AM, Xiaona Han <xiaonahappy13@163.com> wrote:
> Signed-off-by: Xiaona Han <xiaonahappy13@163.com>
> ---
>  bindings/python/examples/example-api-test.py |   16 +++++--------
>  bindings/python/examples/sched_switch.py     |   32 +++++++++++++-------=
------
>  2 files changed, 22 insertions(+), 26 deletions(-)
>
> diff --git a/bindings/python/examples/example-api-test.py b/bindings/pyth=
on/examples/example-api-test.py
> index fc59e24..3c3527c 100644
> --- a/bindings/python/examples/example-api-test.py
> +++ b/bindings/python/examples/example-api-test.py
> @@ -50,23 +50,19 @@ while(event is not None):
>                 event.get_cycles(), event.get_name()))
>
>         if event.get_name() =3D=3D "sched_switch":
> -               sco =3D event.get_top_level_scope(ctf.scope.EVENT_FIELDS)
> -               prev_field =3D event.get_field(sco, "_prev_comm")
> -               prev_comm =3D prev_field.get_char_array()
> -
> -               if ctf.field_error():
> +               prev_field =3D event.get_field("_prev_comm")
> +               if not prev_field:
>                         print("ERROR: Missing prev_comm context info")
>                 else:
> +                       prev_comm =3D prev_field[0].getvalue()
>                         print("sched_switch prev_comm: {}".format(prev_co=
mm))
>
>         if event.get_name() =3D=3D "exit_syscall":
> -               sco =3D event.get_top_level_scope(ctf.scope.EVENT_FIELDS)
> -               ret_field =3D event.get_field(sco, "_ret")
> -               ret_code =3D ret_field.get_int64()
> -
> -               if ctf.field_error():
> +               ret_field =3D event.get_field("_ret")
> +               if not ret_field:
>                         print("ERROR: Unable to extract ret")
>                 else:
> +                       ret_code =3D ret_field[0].get_value()
>                         print("exit_syscall ret: {}".format(ret_code))
>
>         ret =3D ctf_it.next()
> diff --git a/bindings/python/examples/sched_switch.py b/bindings/python/e=
xamples/sched_switch.py
> index d5ed25b..0e6947c 100644
> --- a/bindings/python/examples/sched_switch.py
> +++ b/bindings/python/examples/sched_switch.py
> @@ -57,8 +57,8 @@ while event is not None:
>                                 break # Next event
>
>                         # Getting PID
> -                       pid_field =3D event.get_field(sco, "_pid")
> -                       pid =3D pid_field.get_int64()
> +                       pid_field =3D event.get_field_with_scope(sco, "_p=
id")
> +                       pid =3D pid_field.get_value()
>
>                         if ctf.field_error():
>                                 print("ERROR: Missing PID info for sched_=
switch")
> @@ -70,44 +70,44 @@ while event is not None:
>                         sco =3D event.get_top_level_scope(ctf.scope.EVENT=
_FIELDS)
>
>                         # prev_comm
> -                       field =3D event.get_field(sco, "_prev_comm")
> -                       prev_comm =3D field.get_char_array()
> +                       field =3D event.get_field_with_scope(sco, "_prev_=
comm")
> +                       prev_comm =3D field.get_value()
>                         if ctf.field_error():
>                                 print("ERROR: Missing prev_comm context i=
nfo")
>
>                         # prev_tid
> -                       field =3D event.get_field(sco, "_prev_tid")
> -                       prev_tid =3D field.get_int64()
> +                       field =3D event.get_field_with_scope(sco, "_prev_=
tid")
> +                       prev_tid =3D field.get_value()
>                         if ctf.field_error():
>                                 print("ERROR: Missing prev_tid context in=
fo")
>
>                         # prev_prio
> -                       field =3D event.get_field(sco, "_prev_prio")
> -                       prev_prio =3D field.get_int64()
> +                       field =3D event.get_field_with_scope(sco, "_prev_=
prio")
> +                       prev_prio =3D field.get_value()
>                         if ctf.field_error():
>                                 print("ERROR: Missing prev_prio context i=
nfo")
>
>                         # prev_state
> -                       field =3D event.get_field(sco, "_prev_state")
> -                       prev_state =3D field.get_int64()
> +                       field =3D event.get_field_with_scope(sco, "_prev_=
state")
> +                       prev_state =3D field.get_value()
>                         if ctf.field_error():
>                                 print("ERROR: Missing prev_state context =
info")
>
>                         # next_comm
> -                       field =3D event.get_field(sco, "_next_comm")
> -                       next_comm =3D field.get_char_array()
> +                       field =3D event.get_field_with_scope(sco, "_next_=
comm")
> +                       next_comm =3D field.get_value()
>                         if ctf.field_error():
>                                 print("ERROR: Missing next_comm context i=
nfo")
>
>                         # next_tid
> -                       field =3D event.get_field(sco, "_next_tid")
> -                       next_tid =3D field.get_int64()
> +                       field =3D event.get_field_with_scope(sco, "_next_=
tid")
> +                       next_tid =3D field.get_value()
>                         if ctf.field_error():
>                                 print("ERROR: Missing next_tid context in=
fo")
>
>                         # next_prio
> -                       field =3D event.get_field(sco, "_next_prio")
> -                       next_prio =3D field.get_int64()
> +                       field =3D event.get_field_with_scope(sco, "_next_=
prio")
> +                       next_prio =3D field.get_value()
>                         if ctf.field_error():
>                                 print("ERROR: Missing next_prio context i=
nfo")
>
> --
> 1.7.1
>
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev



-- =

J=E9r=E9mie Galarneau
EfficiOS Inc.
http://www.efficios.com
