From: Jonathan Rajotte <jonathan.r.julien@gmail.com>
Subject: Re: [PATCH lttng-tools v2] Fix: use pid element instead
 of process element
Date: Sat, 5 Sep 2015 17:40:05 -0400
Message-ID: <CAF4oYfF8OnqFzdM7mmSJHHM3SNNVrnF19YONerqU5UifLEc0TQ__27040.8931108706$1441489267$gmane$org@mail.gmail.com>
References: <CA+jJMxsexhr2DqMXjqnVbrBbfyGJddgf4s+Aa_5o1h-WwGPRHg@mail.gmail.com>
 <1441404168-15913-1-git-send-email-jonathan.rajotte-julien@efficios.com>
 <CA+jJMxt4n9tq6yrtDb5PJLX5JUQGFPmVryCf7fgbeqWvjHh6aQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1139683478=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-yk0-f171.google.com ([209.85.160.171])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jonathan.r.julien@gmail.com>) id 1ZYLBy-0004ZD-Vj
 for lttng-dev@lists.lttng.org; Sat, 05 Sep 2015 17:40:13 -0400
Received: by ykei199 with SMTP id i199so50718227yke.0
 for <lttng-dev@lists.lttng.org>; Sat, 05 Sep 2015 14:40:05 -0700 (PDT)
In-Reply-To: <CA+jJMxt4n9tq6yrtDb5PJLX5JUQGFPmVryCf7fgbeqWvjHh6aQ@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>, Jeremie Galarneau <jgalar@efficios.com>
List-Id: lttng-dev@lists.lttng.org

--===============1139683478==
Content-Type: multipart/alternative; boundary=001a1139d17a0be184051f06dc89

--001a1139d17a0be184051f06dc89
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Looks good thanks

On Sat, Sep 5, 2015 at 4:26 PM, J=C3=A9r=C3=A9mie Galarneau <
jeremie.galarneau@efficios.com> wrote:

> On Fri, Sep 4, 2015 at 6:02 PM, Jonathan Rajotte
> <jonathan.rajotte-julien@efficios.com> wrote:
> > v2: Include change to xsd. Looks like I forgot to squash it. I'll have
> to make
> > an offering to the git reflog god on this one.
>
> Haha, I'm probably due for one too ;-)
>
> Merged, although I have removed the now-unused types process_type and
> processes_type.
> We'll add them back when we decide to make the clean-up.
>
> Also, there was a missing symbol, mi_lttng_element_pid_id, which I added
> back.
>
> Have a look at the merged version and let me know if I missed anything.
>
> commit bf239d4cf83c083459c7672ac8a1965108bacca6
> Author: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
> Date:   Fri Sep 4 18:02:48 2015 -0400
>
>     Fix: use pid element instead of process element
>
>     v2: Include change to xsd. Looks like I forgot to squash it. I'll
> have to make
>     an offering to the git reflog god on this one.
>
>     For stable 2.7
>
>     This revert part of changes introduced by [1] and [2].
>
>     The use of process element break the existing MI xml api.
>
>     [1] 46ef4d0715faeef52cd2242b5b895c74507e223a
>     [2] a585578f837d992f00eba4f090c8ba251d9de94e
>
>     Signed-off-by: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com=
>
>     Signed-off-by: J=C3=A9r=C3=A9mie Galarneau <jeremie.galarneau@efficio=
s.com>
>
>
> Thanks!
> J=C3=A9r=C3=A9mie
>
> >
> > For stable 2.7
> >
> > This revert part of changes introduced by [1] and [2].
> >
> > The use of process element break the existing MI xml api.
> >
> > [1] 46ef4d0715faeef52cd2242b5b895c74507e223a
> > [2] a585578f837d992f00eba4f090c8ba251d9de94e
> >
> > Signed-off-by: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
> > ---
> >  src/bin/lttng/commands/list.c     | 18 ++++++++---------
> >  src/common/mi-lttng.c             | 41
> +++++++++++++++++++++++++++++++++++++++
> >  src/common/mi-lttng.h             | 19 ++++++++++++++++++
> >  src/common/mi_lttng.xsd           | 15 +++++++++++---
> >  tests/regression/tools/mi/test_mi |  2 +-
> >  5 files changed, 82 insertions(+), 13 deletions(-)
> >
> > diff --git a/src/bin/lttng/commands/list.c
> b/src/bin/lttng/commands/list.c
> > index f7f3852..3198eca 100644
> > --- a/src/bin/lttng/commands/list.c
> > +++ b/src/bin/lttng/commands/list.c
> > @@ -340,8 +340,8 @@ static int mi_list_agent_ust_events(struct
> lttng_event *events, int count,
> >                 goto end;
> >         }
> >
> > -       /* Open processes element */
> > -       ret =3D mi_lttng_processes_open(writer);
> > +       /* Open pids element element */
> > +       ret =3D mi_lttng_pids_open(writer);
> >         if (ret) {
> >                 goto end;
> >         }
> > @@ -366,7 +366,7 @@ static int mi_list_agent_ust_events(struct
> lttng_event *events, int count,
> >
> >                         if (!pid_element_open) {
> >                                 /* Open and write a pid element */
> > -                               ret =3D mi_lttng_process(writer, cur_pi=
d,
> cmdline, 1);
> > +                               ret =3D mi_lttng_pid(writer, cur_pid,
> cmdline, 1);
> >                                 if (ret) {
> >                                         goto error;
> >                                 }
> > @@ -389,7 +389,7 @@ static int mi_list_agent_ust_events(struct
> lttng_event *events, int count,
> >                 }
> >         }
> >
> > -       /* Close processes */
> > +       /* Close pids */
> >         ret =3D mi_lttng_writer_close_element(writer);
> >         if (ret) {
> >                 goto end;
> > @@ -577,8 +577,8 @@ static int mi_list_ust_event_fields(struct
> lttng_event_field *fields, int count,
> >                 goto end;
> >         }
> >
> > -       /* Open processes element */
> > -       ret =3D mi_lttng_processes_open(writer);
> > +       /* Open pids element */
> > +       ret =3D mi_lttng_pids_open(writer);
> >         if (ret) {
> >                 goto end;
> >         }
> > @@ -606,8 +606,8 @@ static int mi_list_ust_event_fields(struct
> lttng_event_field *fields, int count,
> >                         cur_pid =3D fields[i].event.pid;
> >                         cmdline =3D get_cmdline_by_pid(cur_pid);
> >                         if (!pid_element_open) {
> > -                               /* Open and write a process element */
> > -                               ret =3D mi_lttng_process(writer, cur_pi=
d,
> cmdline, 1);
> > +                               /* Open and write a pid element */
> > +                               ret =3D mi_lttng_pid(writer, cur_pid,
> cmdline, 1);
> >                                 if (ret) {
> >                                         goto error;
> >                                 }
> > @@ -661,7 +661,7 @@ static int mi_list_ust_event_fields(struct
> lttng_event_field *fields, int count,
> >                 }
> >         }
> >
> > -       /* Close processes, domain, domains */
> > +       /* Close pid, domain, domains */
> >         ret =3D mi_lttng_close_multi_element(writer, 3);
> >  end:
> >         return ret;
> > diff --git a/src/common/mi-lttng.c b/src/common/mi-lttng.c
> > index 9d6500b..8fbd064 100644
> > --- a/src/common/mi-lttng.c
> > +++ b/src/common/mi-lttng.c
> > @@ -1199,6 +1199,47 @@ end:
> >         return ret;
> >  }
> >
> > +/*
> > + * TODO: move the listing of pid for user agent to process semantic on
> > + * mi api bump. The use of process element break the mi api.
> > + */
> > +LTTNG_HIDDEN
> > +int mi_lttng_pid(struct mi_writer *writer, pid_t pid , const char *nam=
e,
> > +               int is_open)
> > +{
> > +       int ret;
> > +
> > +       /* Open pid process */
> > +       ret =3D mi_lttng_writer_open_element(writer, config_element_pid=
);
> > +       if (ret) {
> > +               goto end;
> > +       }
> > +
> > +       /* Writing pid number */
> > +       ret =3D mi_lttng_writer_write_element_signed_int(writer,
> > +                       mi_lttng_element_pid_id, (int)pid);
> > +       if (ret) {
> > +               goto end;
> > +       }
> > +
> > +       /* Writing name of the process */
> > +       if (name) {
> > +               ret =3D mi_lttng_writer_write_element_string(writer,
> config_element_name,
> > +                               name);
> > +               if (ret) {
> > +                       goto end;
> > +               }
> > +       }
> > +
> > +       if (!is_open) {
> > +               /* Closing Pid */
> > +               ret =3D mi_lttng_writer_close_element(writer);
> > +       }
> > +
> > +end:
> > +       return ret;
> > +}
> > +
> >  LTTNG_HIDDEN
> >  int mi_lttng_targets_open(struct mi_writer *writer)
> >  {
> > diff --git a/src/common/mi-lttng.h b/src/common/mi-lttng.h
> > index 23b7810..5344a23 100644
> > --- a/src/common/mi-lttng.h
> > +++ b/src/common/mi-lttng.h
> > @@ -619,6 +619,25 @@ int mi_lttng_processes_open(struct mi_writer
> *writer);
> >   */
> >  int mi_lttng_process(struct mi_writer *writer, pid_t pid , const char
> *name,
> >                 int is_open);
> > +
> > +/*
> > + * TODO: move pid of lttng list -u to process semantic on mi api bump
> > + * Machine interface of a Process.
> > + *
> > + * writer An instance of a machine interface writer.
> > + * pid A PID.
> > + *
> > + * is_open Defines whether or not the session element shall be closed.
> > + *         This should be used carefully and the client
> > + *         must close the pid element.
> > + *         Use case: nested addition information on a domain
> > + *                  ex: channel event.
> > + *
> > + * Returns zero if the element's value could be written.
> > + * Negative values indicate an error.
> > + */
> > +int mi_lttng_pid(struct mi_writer *writer, pid_t pid , const char *nam=
e,
> > +               int is_open);
> >  /*
> >   * Machine interface: open a targets element.
> >   *
> > diff --git a/src/common/mi_lttng.xsd b/src/common/mi_lttng.xsd
> > index 11d60d0..24978e4 100644
> > --- a/src/common/mi_lttng.xsd
> > +++ b/src/common/mi_lttng.xsd
> > @@ -273,10 +273,19 @@ THE SOFTWARE.
> >                 </xs:all>
> >         </xs:complexType>
> >
> > -       <!-- Maps to an array of pid -->
> > +       <!-- map to a pid -->
> > +       <xs:complexType name=3D"pid_type">
> > +               <xs:all>
> > +                       <xs:element name=3D"id" type=3D"xs:int" />
> > +                       <xs:element name=3D"name" type=3D"name_type" />
> > +                       <xs:element name=3D"events" type=3D"event_list_=
type"
> minOccurs=3D"0" />
> > +               </xs:all>
> > +       </xs:complexType>
> > +
> > +       <!-- maps to an array of pid -->
> >         <xs:complexType name=3D"pids_type">
> >                 <xs:sequence>
> > -                       <xs:element name=3D"pid" type=3D"xs:int"
> minOccurs=3D"0" maxOccurs=3D"unbounded" />
> > +                       <xs:element name=3D"pid" type=3D"pid_type"
> minOccurs=3D"0" maxOccurs=3D"unbounded" />
> >                 </xs:sequence>
> >         </xs:complexType>
> >
> > @@ -339,7 +348,7 @@ THE SOFTWARE.
> >                 <xs:all>
> >                         <xs:element name=3D"type" type=3D"domain_type_t=
ype"
> />
> >                         <xs:element name=3D"buffer_type"
> type=3D"domain_buffer_type" />
> > -                       <xs:element name=3D"processes"
> type=3D"processes_type" minOccurs=3D"0" />
> > +                       <xs:element name=3D"pids" type=3D"pids_type"
> minOccurs=3D"0" />
> >                         <xs:element name=3D"channels" type=3D"channels_=
type"
> minOccurs=3D"0" />
> >                         <xs:element name=3D"events" type=3D"event_list_=
type"
> minOccurs=3D"0" />
> >                         <xs:element name=3D"trackers" type=3D"trackers_=
type"
> minOccurs=3D"0" />
> > diff --git a/tests/regression/tools/mi/test_mi
> b/tests/regression/tools/mi/test_mi
> > index 7f22ee1..47ec1b1 100755
> > --- a/tests/regression/tools/mi/test_mi
> > +++ b/tests/regression/tools/mi/test_mi
> > @@ -48,7 +48,7 @@
> XPATH_ENABLE_EVENT_SUCCESS=3D"$XPATH_CMD_OUTPUT/events/event/success/text=
()"
> >
> XPATH_DISABLE_EVENT_SUCCESS=3D"$XPATH_CMD_OUTPUT/channel/events/event/suc=
cess/text()"
> >  XPATH_LIST_DOMAIN=3D"$XPATH_CMD_OUTPUT/sessions/session/domains/domain=
"
> >
> XPATH_LIST_CHANNEL=3D"$XPATH_CMD_OUTPUT/sessions/session/domains/domain/c=
hannels/channel"
> > -XPATH_LIST_UST_EVENT=3D"$XPATH_CMD_OUTPUT/domains/domain[./type
> =3D'UST']/processes/process/events/event"
> > +XPATH_LIST_UST_EVENT=3D"$XPATH_CMD_OUTPUT/domains/domain[./type
> =3D'UST']/pids/pid/events/event"
> >  XPATH_SNAPSHOT_ADD_SNAPSHOT=3D"$XPATH_CMD_OUTPUT/snapshot_action[./nam=
e =3D
> 'add-output']/output"
> >  XPATH_SNAPSHOT_LIST=3D"$XPATH_CMD_OUTPUT/snapshot_action[./name =3D
> 'list-output']/output"
> >  XPATH_SNAPSHOT_DEL=3D"$XPATH_CMD_OUTPUT/snapshot_action[./name =3D
> 'del-output']/output"
> > --
> > 2.1.4
> >
>
>
>
> --
> J=C3=A9r=C3=A9mie Galarneau
> EfficiOS Inc.
> http://www.efficios.com
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>



--=20
Jonathan Rajotte Julien

--001a1139d17a0be184051f06dc89
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Looks good thanks</div><div class=3D"gmail_extra"><br><div=
 class=3D"gmail_quote">On Sat, Sep 5, 2015 at 4:26 PM, J=C3=A9r=C3=A9mie Ga=
larneau <span dir=3D"ltr">&lt;<a href=3D"mailto:jeremie.galarneau@efficios.=
com" target=3D"_blank">jeremie.galarneau@efficios.com</a>&gt;</span> wrote:=
<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-lef=
t:1px #ccc solid;padding-left:1ex"><span class=3D"">On Fri, Sep 4, 2015 at =
6:02 PM, Jonathan Rajotte<br>
&lt;<a href=3D"mailto:jonathan.rajotte-julien@efficios.com">jonathan.rajott=
e-julien@efficios.com</a>&gt; wrote:<br>
&gt; v2: Include change to xsd. Looks like I forgot to squash it. I&#39;ll =
have to make<br>
&gt; an offering to the git reflog god on this one.<br>
<br>
</span>Haha, I&#39;m probably due for one too ;-)<br>
<br>
Merged, although I have removed the now-unused types process_type and<br>
processes_type.<br>
We&#39;ll add them back when we decide to make the clean-up.<br>
<br>
Also, there was a missing symbol, mi_lttng_element_pid_id, which I added ba=
ck.<br>
<br>
Have a look at the merged version and let me know if I missed anything.<br>
<br>
commit bf239d4cf83c083459c7672ac8a1965108bacca6<br>
Author: Jonathan Rajotte &lt;<a href=3D"mailto:jonathan.rajotte-julien@effi=
cios.com">jonathan.rajotte-julien@efficios.com</a>&gt;<br>
Date:=C2=A0 =C2=A0Fri Sep 4 18:02:48 2015 -0400<br>
<br>
=C2=A0 =C2=A0 Fix: use pid element instead of process element<br>
<span class=3D""><br>
=C2=A0 =C2=A0 v2: Include change to xsd. Looks like I forgot to squash it. =
I&#39;ll<br>
have to make<br>
=C2=A0 =C2=A0 an offering to the git reflog god on this one.<br>
<br>
=C2=A0 =C2=A0 For stable 2.7<br>
<br>
=C2=A0 =C2=A0 This revert part of changes introduced by [1] and [2].<br>
<br>
=C2=A0 =C2=A0 The use of process element break the existing MI xml api.<br>
<br>
=C2=A0 =C2=A0 [1] 46ef4d0715faeef52cd2242b5b895c74507e223a<br>
=C2=A0 =C2=A0 [2] a585578f837d992f00eba4f090c8ba251d9de94e<br>
<br>
=C2=A0 =C2=A0 Signed-off-by: Jonathan Rajotte &lt;<a href=3D"mailto:jonatha=
n.rajotte-julien@efficios.com">jonathan.rajotte-julien@efficios.com</a>&gt;=
<br>
</span>=C2=A0 =C2=A0 Signed-off-by: J=C3=A9r=C3=A9mie Galarneau &lt;<a href=
=3D"mailto:jeremie.galarneau@efficios.com">jeremie.galarneau@efficios.com</=
a>&gt;<br>
<br>
<br>
Thanks!<br>
<span class=3D"HOEnZb"><font color=3D"#888888">J=C3=A9r=C3=A9mie<br>
</font></span><div class=3D"HOEnZb"><div class=3D"h5"><br>
&gt;<br>
&gt; For stable 2.7<br>
&gt;<br>
&gt; This revert part of changes introduced by [1] and [2].<br>
&gt;<br>
&gt; The use of process element break the existing MI xml api.<br>
&gt;<br>
&gt; [1] 46ef4d0715faeef52cd2242b5b895c74507e223a<br>
&gt; [2] a585578f837d992f00eba4f090c8ba251d9de94e<br>
&gt;<br>
&gt; Signed-off-by: Jonathan Rajotte &lt;<a href=3D"mailto:jonathan.rajotte=
-julien@efficios.com">jonathan.rajotte-julien@efficios.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 src/bin/lttng/commands/list.c=C2=A0 =C2=A0 =C2=A0| 18 ++++++++--=
-------<br>
&gt;=C2=A0 src/common/mi-lttng.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0| 41 +++++++++++++++++++++++++++++++++++++++<br>
&gt;=C2=A0 src/common/mi-lttng.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0| 19 ++++++++++++++++++<br>
&gt;=C2=A0 src/common/mi_lttng.xsd=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
| 15 +++++++++++---<br>
&gt;=C2=A0 tests/regression/tools/mi/test_mi |=C2=A0 2 +-<br>
&gt;=C2=A0 5 files changed, 82 insertions(+), 13 deletions(-)<br>
&gt;<br>
&gt; diff --git a/src/bin/lttng/commands/list.c b/src/bin/lttng/commands/li=
st.c<br>
&gt; index f7f3852..3198eca 100644<br>
&gt; --- a/src/bin/lttng/commands/list.c<br>
&gt; +++ b/src/bin/lttng/commands/list.c<br>
&gt; @@ -340,8 +340,8 @@ static int mi_list_agent_ust_events(struct lttng_e=
vent *events, int count,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto end;=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0/* Open processes element */<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D mi_lttng_processes_open(writer);<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0/* Open pids element element */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D mi_lttng_pids_open(writer);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto end;=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; @@ -366,7 +366,7 @@ static int mi_list_agent_ust_events(struct lttng_e=
vent *events, int count,<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0if (!pid_element_open) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Open and write a pid ele=
ment */<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D mi_lttng_process(writer, =
cur_pid, cmdline, 1);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D mi_lttng_pid(writer, cur_=
pid, cmdline, 1);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0goto error;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; @@ -389,7 +389,7 @@ static int mi_list_agent_ust_events(struct lttng_e=
vent *events, int count,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0/* Close processes */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0/* Close pids */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D mi_lttng_writer_close_element=
(writer);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto end;=
<br>
&gt; @@ -577,8 +577,8 @@ static int mi_list_ust_event_fields(struct lttng_e=
vent_field *fields, int count,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto end;=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0/* Open processes element */<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D mi_lttng_processes_open(writer);<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0/* Open pids element */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D mi_lttng_pids_open(writer);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto end;=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; @@ -606,8 +606,8 @@ static int mi_list_ust_event_fields(struct lttng_e=
vent_field *fields, int count,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0cur_pid =3D fields[i].event.pid;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0cmdline =3D get_cmdline_by_pid(cur_pid);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0if (!pid_element_open) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Open and write a process eleme=
nt */<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D mi_lttng_process(writer, =
cur_pid, cmdline, 1);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Open and write a pid element *=
/<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D mi_lttng_pid(writer, cur_=
pid, cmdline, 1);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0goto error;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; @@ -661,7 +661,7 @@ static int mi_list_ust_event_fields(struct lttng_e=
vent_field *fields, int count,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0/* Close processes, domain, domains */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0/* Close pid, domain, domains */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D mi_lttng_close_multi_element(=
writer, 3);<br>
&gt;=C2=A0 end:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>
&gt; diff --git a/src/common/mi-lttng.c b/src/common/mi-lttng.c<br>
&gt; index 9d6500b..8fbd064 100644<br>
&gt; --- a/src/common/mi-lttng.c<br>
&gt; +++ b/src/common/mi-lttng.c<br>
&gt; @@ -1199,6 +1199,47 @@ end:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>
&gt;=C2=A0 }<br>
&gt;<br>
&gt; +/*<br>
&gt; + * TODO: move the listing of pid for user agent to process semantic o=
n<br>
&gt; + * mi api bump. The use of process element break the mi api.<br>
&gt; + */<br>
&gt; +LTTNG_HIDDEN<br>
&gt; +int mi_lttng_pid(struct mi_writer *writer, pid_t pid , const char *na=
me,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int is_open)<b=
r>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0int ret;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0/* Open pid process */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D mi_lttng_writer_open_element(write=
r, config_element_pid);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto end;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0/* Writing pid number */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D mi_lttng_writer_write_element_sign=
ed_int(writer,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0mi_lttng_element_pid_id, (int)pid);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto end;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0/* Writing name of the process */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0if (name) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D mi_ltt=
ng_writer_write_element_string(writer, config_element_name,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0name);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0goto end;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!is_open) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Closing Pid=
 */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D mi_ltt=
ng_writer_close_element(writer);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; +end:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>
&gt; +}<br>
&gt; +<br>
&gt;=C2=A0 LTTNG_HIDDEN<br>
&gt;=C2=A0 int mi_lttng_targets_open(struct mi_writer *writer)<br>
&gt;=C2=A0 {<br>
&gt; diff --git a/src/common/mi-lttng.h b/src/common/mi-lttng.h<br>
&gt; index 23b7810..5344a23 100644<br>
&gt; --- a/src/common/mi-lttng.h<br>
&gt; +++ b/src/common/mi-lttng.h<br>
&gt; @@ -619,6 +619,25 @@ int mi_lttng_processes_open(struct mi_writer *wri=
ter);<br>
&gt;=C2=A0 =C2=A0*/<br>
&gt;=C2=A0 int mi_lttng_process(struct mi_writer *writer, pid_t pid , const=
 char *name,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int is_op=
en);<br>
&gt; +<br>
&gt; +/*<br>
&gt; + * TODO: move pid of lttng list -u to process semantic on mi api bump=
<br>
&gt; + * Machine interface of a Process.<br>
&gt; + *<br>
&gt; + * writer An instance of a machine interface writer.<br>
&gt; + * pid A PID.<br>
&gt; + *<br>
&gt; + * is_open Defines whether or not the session element shall be closed=
.<br>
&gt; + *=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0This should be used carefully and=
 the client<br>
&gt; + *=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0must close the pid element.<br>
&gt; + *=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Use case: nested addition informa=
tion on a domain<br>
&gt; + *=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ex: =
channel event.<br>
&gt; + *<br>
&gt; + * Returns zero if the element&#39;s value could be written.<br>
&gt; + * Negative values indicate an error.<br>
&gt; + */<br>
&gt; +int mi_lttng_pid(struct mi_writer *writer, pid_t pid , const char *na=
me,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int is_open);<=
br>
&gt;=C2=A0 /*<br>
&gt;=C2=A0 =C2=A0* Machine interface: open a targets element.<br>
&gt;=C2=A0 =C2=A0*<br>
&gt; diff --git a/src/common/mi_lttng.xsd b/src/common/mi_lttng.xsd<br>
&gt; index 11d60d0..24978e4 100644<br>
&gt; --- a/src/common/mi_lttng.xsd<br>
&gt; +++ b/src/common/mi_lttng.xsd<br>
&gt; @@ -273,10 +273,19 @@ THE SOFTWARE.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;/xs:a=
ll&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;/xs:complexType&gt;<br>
&gt;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;!-- Maps to an array of pid --&gt;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;!-- map to a pid --&gt;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;xs:complexType name=3D&quot;pid_type&q=
uot;&gt;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;xs:all&gt;=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0&lt;xs:element name=3D&quot;id&quot; type=3D&quot;xs:int&quot=
; /&gt;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0&lt;xs:element name=3D&quot;name&quot; type=3D&quot;name_type=
&quot; /&gt;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0&lt;xs:element name=3D&quot;events&quot; type=3D&quot;event_l=
ist_type&quot; minOccurs=3D&quot;0&quot; /&gt;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;/xs:all&gt=
;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;/xs:complexType&gt;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;!-- maps to an array of pid --&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;xs:complexType name=3D&quot;pids_=
type&quot;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;xs:se=
quence&gt;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0&lt;xs:element name=3D&quot;pid&quot; type=3D&quot;xs:int&quo=
t; minOccurs=3D&quot;0&quot; maxOccurs=3D&quot;unbounded&quot; /&gt;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0&lt;xs:element name=3D&quot;pid&quot; type=3D&quot;pid_type&q=
uot; minOccurs=3D&quot;0&quot; maxOccurs=3D&quot;unbounded&quot; /&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;/xs:s=
equence&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;/xs:complexType&gt;<br>
&gt;<br>
&gt; @@ -339,7 +348,7 @@ THE SOFTWARE.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;xs:al=
l&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0&lt;xs:element name=3D&quot;type&quot; type=3D&quot;dom=
ain_type_type&quot; /&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0&lt;xs:element name=3D&quot;buffer_type&quot; type=3D&q=
uot;domain_buffer_type&quot; /&gt;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0&lt;xs:element name=3D&quot;processes&quot; type=3D&quot;proc=
esses_type&quot; minOccurs=3D&quot;0&quot; /&gt;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0&lt;xs:element name=3D&quot;pids&quot; type=3D&quot;pids_type=
&quot; minOccurs=3D&quot;0&quot; /&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0&lt;xs:element name=3D&quot;channels&quot; type=3D&quot=
;channels_type&quot; minOccurs=3D&quot;0&quot; /&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0&lt;xs:element name=3D&quot;events&quot; type=3D&quot;e=
vent_list_type&quot; minOccurs=3D&quot;0&quot; /&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0&lt;xs:element name=3D&quot;trackers&quot; type=3D&quot=
;trackers_type&quot; minOccurs=3D&quot;0&quot; /&gt;<br>
&gt; diff --git a/tests/regression/tools/mi/test_mi b/tests/regression/tool=
s/mi/test_mi<br>
&gt; index 7f22ee1..47ec1b1 100755<br>
&gt; --- a/tests/regression/tools/mi/test_mi<br>
&gt; +++ b/tests/regression/tools/mi/test_mi<br>
&gt; @@ -48,7 +48,7 @@ XPATH_ENABLE_EVENT_SUCCESS=3D&quot;$XPATH_CMD_OUTPUT=
/events/event/success/text()&quot;<br>
&gt;=C2=A0 XPATH_DISABLE_EVENT_SUCCESS=3D&quot;$XPATH_CMD_OUTPUT/channel/ev=
ents/event/success/text()&quot;<br>
&gt;=C2=A0 XPATH_LIST_DOMAIN=3D&quot;$XPATH_CMD_OUTPUT/sessions/session/dom=
ains/domain&quot;<br>
&gt;=C2=A0 XPATH_LIST_CHANNEL=3D&quot;$XPATH_CMD_OUTPUT/sessions/session/do=
mains/domain/channels/channel&quot;<br>
&gt; -XPATH_LIST_UST_EVENT=3D&quot;$XPATH_CMD_OUTPUT/domains/domain[./type =
=3D&#39;UST&#39;]/processes/process/events/event&quot;<br>
&gt; +XPATH_LIST_UST_EVENT=3D&quot;$XPATH_CMD_OUTPUT/domains/domain[./type =
=3D&#39;UST&#39;]/pids/pid/events/event&quot;<br>
&gt;=C2=A0 XPATH_SNAPSHOT_ADD_SNAPSHOT=3D&quot;$XPATH_CMD_OUTPUT/snapshot_a=
ction[./name =3D &#39;add-output&#39;]/output&quot;<br>
&gt;=C2=A0 XPATH_SNAPSHOT_LIST=3D&quot;$XPATH_CMD_OUTPUT/snapshot_action[./=
name =3D &#39;list-output&#39;]/output&quot;<br>
&gt;=C2=A0 XPATH_SNAPSHOT_DEL=3D&quot;$XPATH_CMD_OUTPUT/snapshot_action[./n=
ame =3D &#39;del-output&#39;]/output&quot;<br>
&gt; --<br>
&gt; 2.1.4<br>
&gt;<br>
<br>
<br>
<br>
</div></div><span class=3D"im HOEnZb">--<br>
J=C3=A9r=C3=A9mie Galarneau<br>
EfficiOS Inc.<br>
<a href=3D"http://www.efficios.com" rel=3D"noreferrer" target=3D"_blank">ht=
tp://www.efficios.com</a><br>
<br>
</span><div class=3D"HOEnZb"><div class=3D"h5">____________________________=
___________________<br>
lttng-dev mailing list<br>
<a href=3D"mailto:lttng-dev@lists.lttng.org">lttng-dev@lists.lttng.org</a><=
br>
<a href=3D"http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev" rel=
=3D"noreferrer" target=3D"_blank">http://lists.lttng.org/cgi-bin/mailman/li=
stinfo/lttng-dev</a><br>
</div></div></blockquote></div><br><br clear=3D"all"><div><br></div>-- <br>=
<div class=3D"gmail_signature"><div dir=3D"ltr"><div><div dir=3D"ltr">Jonat=
han Rajotte Julien<div><br></div></div></div></div></div>
</div>

--001a1139d17a0be184051f06dc89--


--===============1139683478==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1139683478==--
