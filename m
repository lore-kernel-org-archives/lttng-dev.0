From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH lttng-tools] Fix: Improve the error
 reporting of the track/untrack command
Date: Thu, 13 Aug 2015 15:45:26 -0400
Message-ID: <CA+jJMxumVDYmVj6+oh_zp0bxP5iasp_1fa=7bK2zCiaDZ=NtBw__35845.6584079706$1439495228$gmane$org@mail.gmail.com>
References: <1439410096-769-1-git-send-email-mjeanson@efficios.com>
 <CA+jJMxtsOTa_9BBV7fyCG-csMhfor2_b+=Gh1PmXQV8q8=dXMA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0406825823=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-yk0-f176.google.com ([209.85.160.176])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jeremie.galarneau@gmail.com>) id 1ZPyRQ-0006Ys-A9
 for lttng-dev@lists.lttng.org; Thu, 13 Aug 2015 15:45:41 -0400
Received: by ykdt205 with SMTP id t205so50843003ykd.1
 for <lttng-dev@lists.lttng.org>; Thu, 13 Aug 2015 12:45:26 -0700 (PDT)
In-Reply-To: <CA+jJMxtsOTa_9BBV7fyCG-csMhfor2_b+=Gh1PmXQV8q8=dXMA@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Michael Jeanson <mjeanson@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>, Jeremie Galarneau <jgalar@efficios.com>
List-Id: lttng-dev@lists.lttng.org

--===============0406825823==
Content-Type: multipart/alternative; boundary=001a113aba80b0a4ea051d36937a

--001a113aba80b0a4ea051d36937a
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Merged, thanks!

J=C3=A9r=C3=A9mie

On Wed, Aug 12, 2015 at 6:59 PM, J=C3=A9r=C3=A9mie Galarneau <
jeremie.galarneau@efficios.com> wrote:

>
>
> On Wed, Aug 12, 2015 at 4:08 PM, Michael Jeanson <mjeanson@efficios.com>
> wrote:
>
>> This patch adds feedback when a track/untrack command is successful and
>> specific messages on errors. It also changes the behavior when tracking
>> an already tracked PID or untracking a PID that is not tracked from an
>> error to a warning with a successful exit code.
>>
>> Fixes: #898
>>
>> Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
>> ---
>>  include/lttng/lttng-error.h            |  2 ++
>>  src/bin/lttng-sessiond/trace-ust.c     |  4 ++--
>>  src/bin/lttng/commands/track-untrack.c | 23 +++++++++++++++++++++--
>>  src/common/error.c                     |  2 ++
>>  4 files changed, 27 insertions(+), 4 deletions(-)
>>
>> diff --git a/include/lttng/lttng-error.h b/include/lttng/lttng-error.h
>> index efdca65..a7746fa 100644
>> --- a/include/lttng/lttng-error.h
>> +++ b/include/lttng/lttng-error.h
>> @@ -134,6 +134,8 @@ enum lttng_error_code {
>>         LTTNG_ERR_EXCLUSION_NOMEM        =3D 111, /* Lack of memory whil=
e
>> processing event exclusions */
>>         LTTNG_ERR_INVALID_EVENT_NAME     =3D 112, /* Invalid event name =
*/
>>         LTTNG_ERR_INVALID_CHANNEL_NAME   =3D 113, /* Invalid channel nam=
e */
>> +       LTTNG_ERR_PID_TRACKED            =3D 114, /* PID already tracked=
 */
>> +       LTTNG_ERR_PID_NOT_TRACKED        =3D 115, /* PID not tracked */
>>
>>         /* MUST be last element */
>>         LTTNG_ERR_NR,                           /* Last element */
>> diff --git a/src/bin/lttng-sessiond/trace-ust.c
>> b/src/bin/lttng-sessiond/trace-ust.c
>> index 2486696..3881084 100644
>> --- a/src/bin/lttng-sessiond/trace-ust.c
>> +++ b/src/bin/lttng-sessiond/trace-ust.c
>> @@ -656,7 +656,7 @@ int pid_tracker_add_pid(struct ust_pid_tracker
>> *pid_tracker, int pid)
>>         tracker_node =3D pid_tracker_lookup(pid_tracker, pid, &iter);
>>         if (tracker_node) {
>>                 /* Already exists. */
>> -               retval =3D LTTNG_ERR_INVALID;
>> +               retval =3D LTTNG_ERR_PID_TRACKED;
>>                 goto end;
>>         }
>>         tracker_node =3D zmalloc(sizeof(*tracker_node));
>> @@ -684,7 +684,7 @@ int pid_tracker_del_pid(struct ust_pid_tracker
>> *pid_tracker, int pid)
>>         tracker_node =3D pid_tracker_lookup(pid_tracker, pid, &iter);
>>         if (!tracker_node) {
>>                 /* Not found */
>> -               retval =3D LTTNG_ERR_INVALID;
>> +               retval =3D LTTNG_ERR_PID_NOT_TRACKED;
>>                 goto end;
>>         }
>>         ret =3D lttng_ht_del(pid_tracker->ht, &iter);
>> diff --git a/src/bin/lttng/commands/track-untrack.c
>> b/src/bin/lttng/commands/track-untrack.c
>> index 9ce8504..b3139c6 100644
>> --- a/src/bin/lttng/commands/track-untrack.c
>> +++ b/src/bin/lttng/commands/track-untrack.c
>> @@ -261,9 +261,28 @@ enum cmd_error_code track_untrack_pid(enum cmd_type
>> cmd_type, const char *cmd_st
>>                 DBG("%s PID %d", cmd_str, pid_list[i]);
>>                 ret =3D lib_func(handle, pid_list[i]);
>>                 if (ret) {
>> -                       success =3D 0;
>> -                       retval =3D CMD_ERROR;
>> +                       switch (-ret) {
>> +                       case LTTNG_ERR_PID_TRACKED:
>> +                               WARN("PID %i already tracked in session
>> %s",
>> +                                               pid_list[i],
>> session_name);
>> +                               success =3D 1;
>> +                               retval =3D CMD_SUCCESS;
>> +                               break;
>> +                       case LTTNG_ERR_PID_NOT_TRACKED:
>> +                               WARN("PID %i not tracked in session %s",
>> +                                               pid_list[i],
>> session_name);
>> +                               success =3D 1;
>> +                               retval =3D CMD_SUCCESS;
>>
>
> I'm wondering if untracking a PID that was not being tracked should be
> reported as an error... Thoughts anyone?
>
> J=C3=A9r=C3=A9mie
>
>
>> +                               break;
>> +                       default:
>> +                               ERR("%s", lttng_strerror(ret));
>> +                               success =3D 0;
>> +                               retval =3D CMD_ERROR;
>> +                               break;
>> +                       }
>>                 } else {
>> +                       MSG("PID %i %sed in session %s",
>> +                                       pid_list[i], cmd_str,
>> session_name);
>>                         success =3D 1;
>>                 }
>>
>> diff --git a/src/common/error.c b/src/common/error.c
>> index d3e3b94..ad0ac51 100644
>> --- a/src/common/error.c
>> +++ b/src/common/error.c
>> @@ -167,6 +167,8 @@ static const char *error_string_array[] =3D {
>>         [ ERROR_INDEX(LTTNG_ERR_MI_NOT_IMPLEMENTED) ] =3D "Mi feature no=
t
>> implemented",
>>         [ ERROR_INDEX(LTTNG_ERR_INVALID_EVENT_NAME) ] =3D "Invalid event
>> name",
>>         [ ERROR_INDEX(LTTNG_ERR_INVALID_CHANNEL_NAME) ] =3D "Invalid
>> channel name",
>> +       [ ERROR_INDEX(LTTNG_ERR_PID_TRACKED) ] =3D "PID already tracked"=
,
>> +       [ ERROR_INDEX(LTTNG_ERR_PID_NOT_TRACKED) ] =3D "PID not tracked"=
,
>>
>>         /* Last element */
>>         [ ERROR_INDEX(LTTNG_ERR_NR) ] =3D "Unknown error code"
>> --
>> 1.9.1
>>
>>
>
>
> --
> J=C3=A9r=C3=A9mie Galarneau
> EfficiOS Inc.
> http://www.efficios.com
>



--=20
J=C3=A9r=C3=A9mie Galarneau
EfficiOS Inc.
http://www.efficios.com

--001a113aba80b0a4ea051d36937a
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Merged, thanks!<div><br></div><div>J=C3=A9r=C3=A9mie</div>=
</div><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">On Wed, Aug=
 12, 2015 at 6:59 PM, J=C3=A9r=C3=A9mie Galarneau <span dir=3D"ltr">&lt;<a =
href=3D"mailto:jeremie.galarneau@efficios.com" target=3D"_blank">jeremie.ga=
larneau@efficios.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex=
"><div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_q=
uote"><div><div class=3D"h5">On Wed, Aug 12, 2015 at 4:08 PM, Michael Jeans=
on <span dir=3D"ltr">&lt;<a href=3D"mailto:mjeanson@efficios.com" target=3D=
"_blank">mjeanson@efficios.com</a>&gt;</span> wrote:<br><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex">This patch adds feedback when a track/untrack command is succ=
essful and<br>
specific messages on errors. It also changes the behavior when tracking<br>
an already tracked PID or untracking a PID that is not tracked from an<br>
error to a warning with a successful exit code.<br>
<br>
Fixes: #898<br>
<br>
Signed-off-by: Michael Jeanson &lt;<a href=3D"mailto:mjeanson@efficios.com"=
 target=3D"_blank">mjeanson@efficios.com</a>&gt;<br>
---<br>
=C2=A0include/lttng/lttng-error.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
|=C2=A0 2 ++<br>
=C2=A0src/bin/lttng-sessiond/trace-ust.c=C2=A0 =C2=A0 =C2=A0|=C2=A0 4 ++--<=
br>
=C2=A0src/bin/lttng/commands/track-untrack.c | 23 +++++++++++++++++++++--<b=
r>
=C2=A0src/common/error.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 2 ++<br>
=C2=A04 files changed, 27 insertions(+), 4 deletions(-)<br>
<br>
diff --git a/include/lttng/lttng-error.h b/include/lttng/lttng-error.h<br>
index efdca65..a7746fa 100644<br>
--- a/include/lttng/lttng-error.h<br>
+++ b/include/lttng/lttng-error.h<br>
@@ -134,6 +134,8 @@ enum lttng_error_code {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 LTTNG_ERR_EXCLUSION_NOMEM=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =3D 111, /* Lack of memory while processing event exclusions */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 LTTNG_ERR_INVALID_EVENT_NAME=C2=A0 =C2=A0 =C2=
=A0=3D 112, /* Invalid event name */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 LTTNG_ERR_INVALID_CHANNEL_NAME=C2=A0 =C2=A0=3D =
113, /* Invalid channel name */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0LTTNG_ERR_PID_TRACKED=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =3D 114, /* PID already tracked */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0LTTNG_ERR_PID_NOT_TRACKED=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =3D 115, /* PID not tracked */<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* MUST be last element */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 LTTNG_ERR_NR,=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Last elem=
ent */<br>
diff --git a/src/bin/lttng-sessiond/trace-ust.c b/src/bin/lttng-sessiond/tr=
ace-ust.c<br>
index 2486696..3881084 100644<br>
--- a/src/bin/lttng-sessiond/trace-ust.c<br>
+++ b/src/bin/lttng-sessiond/trace-ust.c<br>
@@ -656,7 +656,7 @@ int pid_tracker_add_pid(struct ust_pid_tracker *pid_tra=
cker, int pid)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 tracker_node =3D pid_tracker_lookup(pid_tracker=
, pid, &amp;iter);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (tracker_node) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Already exists. =
*/<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0retval =3D LTTNG_ER=
R_INVALID;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0retval =3D LTTNG_ER=
R_PID_TRACKED;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto end;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 tracker_node =3D zmalloc(sizeof(*tracker_node))=
;<br>
@@ -684,7 +684,7 @@ int pid_tracker_del_pid(struct ust_pid_tracker *pid_tra=
cker, int pid)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 tracker_node =3D pid_tracker_lookup(pid_tracker=
, pid, &amp;iter);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!tracker_node) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Not found */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0retval =3D LTTNG_ER=
R_INVALID;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0retval =3D LTTNG_ER=
R_PID_NOT_TRACKED;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto end;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D lttng_ht_del(pid_tracker-&gt;ht, &amp;i=
ter);<br>
diff --git a/src/bin/lttng/commands/track-untrack.c b/src/bin/lttng/command=
s/track-untrack.c<br>
index 9ce8504..b3139c6 100644<br>
--- a/src/bin/lttng/commands/track-untrack.c<br>
+++ b/src/bin/lttng/commands/track-untrack.c<br>
@@ -261,9 +261,28 @@ enum cmd_error_code track_untrack_pid(enum cmd_type cm=
d_type, const char *cmd_st<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 DBG(&quot;%s PID %d=
&quot;, cmd_str, pid_list[i]);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D lib_func(ha=
ndle, pid_list[i]);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ret) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0success =3D 0;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0retval =3D CMD_ERROR;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0switch (-ret) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0case LTTNG_ERR_PID_TRACKED:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0WARN(&quot;PID %i already tracked in =
session %s&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0pid_list[i], session_name);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0success =3D 1;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0retval =3D CMD_SUCCESS;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0case LTTNG_ERR_PID_NOT_TRACKED:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0WARN(&quot;PID %i not tracked in sess=
ion %s&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0pid_list[i], session_name);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0success =3D 1;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0retval =3D CMD_SUCCESS;<br></blockquo=
te><div><br></div></div></div><div>I&#39;m wondering if untracking a PID th=
at was not being tracked should be reported as an error... Thoughts anyone?=
</div><div><br></div><div>J=C3=A9r=C3=A9mie</div><div><div class=3D"h5"><di=
v>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;=
border-left:1px #ccc solid;padding-left:1ex">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0default:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ERR(&quot;%s&quot;, lttng_strerror(re=
t));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0success =3D 0;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0retval =3D CMD_ERROR;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0MSG(&quot;PID %i %sed in session %s&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pid_list[=
i], cmd_str, session_name);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 success =3D 1;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
diff --git a/src/common/error.c b/src/common/error.c<br>
index d3e3b94..ad0ac51 100644<br>
--- a/src/common/error.c<br>
+++ b/src/common/error.c<br>
@@ -167,6 +167,8 @@ static const char *error_string_array[] =3D {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 [ ERROR_INDEX(LTTNG_ERR_MI_NOT_IMPLEMENTED) ] =
=3D &quot;Mi feature not implemented&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 [ ERROR_INDEX(LTTNG_ERR_INVALID_EVENT_NAME) ] =
=3D &quot;Invalid event name&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 [ ERROR_INDEX(LTTNG_ERR_INVALID_CHANNEL_NAME) ]=
 =3D &quot;Invalid channel name&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0[ ERROR_INDEX(LTTNG_ERR_PID_TRACKED) ] =3D &quo=
t;PID already tracked&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0[ ERROR_INDEX(LTTNG_ERR_PID_NOT_TRACKED) ] =3D =
&quot;PID not tracked&quot;,<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Last element */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 [ ERROR_INDEX(LTTNG_ERR_NR) ] =3D &quot;Unknown=
 error code&quot;<br>
<span><font color=3D"#888888">--<br>
1.9.1<br>
<br>
</font></span></blockquote></div></div></div><span class=3D"HOEnZb"><font c=
olor=3D"#888888"><br><br clear=3D"all"><div><br></div>-- <br><div>J=C3=A9r=
=C3=A9mie Galarneau<br>EfficiOS Inc.<br><a href=3D"http://www.efficios.com"=
 target=3D"_blank">http://www.efficios.com</a></div>
</font></span></div></div>
</blockquote></div><br><br clear=3D"all"><div><br></div>-- <br><div class=
=3D"gmail_signature">J=C3=A9r=C3=A9mie Galarneau<br>EfficiOS Inc.<br><a hre=
f=3D"http://www.efficios.com" target=3D"_blank">http://www.efficios.com</a>=
</div>
</div>

--001a113aba80b0a4ea051d36937a--


--===============0406825823==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0406825823==--
