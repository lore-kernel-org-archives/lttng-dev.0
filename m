From: =?ISO-8859-1?Q?J=E9r=E9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH babeltrace] Return event fields by a field
 name. Since a field may be present both in an event and its stream's scope,
 this returns a list which contains all the fileds by the name
Date: Wed, 24 Jul 2013 15:32:23 -0400
Message-ID: <CA+jJMxsCLqJ=Uud7KvqqSRfqLOLM+118jq=mdyomu+CNgGsAxw__45853.2601282515$1374694490$gmane$org@mail.gmail.com>
References: <1374659868-6264-1-git-send-email-xiaonahappy13@163.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-wg0-f43.google.com ([74.125.82.43])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jeremie.galarneau@gmail.com>) id 1V24nV-000192-9M
	for lttng-dev@lists.lttng.org; Wed, 24 Jul 2013 15:32:35 -0400
Received: by mail-wg0-f43.google.com with SMTP id z12so818234wgg.22
	for <lttng-dev@lists.lttng.org>; Wed, 24 Jul 2013 12:32:23 -0700 (PDT)
In-Reply-To: <1374659868-6264-1-git-send-email-xiaonahappy13@163.com>
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

Please do not exceed 80-chars in your subject line and detail your
changes in the rest of the commit message.

See other remarks below.

On Wed, Jul 24, 2013 at 5:57 AM, Xiaona Han <xiaonahappy13@163.com> wrote:
> Signed-off-by: Xiaona Han <xiaonahappy13@163.com>
> ---
>  bindings/python/babeltrace.i.in |   78 +++++++++++++++++++++++++++++++++=
++++-
>  1 files changed, 75 insertions(+), 3 deletions(-)
>  mode change 100644 =3D> 100755 bindings/python/babeltrace.i.in
>
> diff --git a/bindings/python/babeltrace.i.in b/bindings/python/babeltrace=
.i.in
> old mode 100644
> new mode 100755

Why the mode change?

> index dd2dacc..880b23e
> --- a/bindings/python/babeltrace.i.in
> +++ b/bindings/python/babeltrace.i.in
> @@ -744,7 +744,7 @@ class ctf:
>                         """
>                         return _bt_ctf_get_timestamp(self._e)
>
> -               def get_field(self, scope, field):
> +               def get_field_with_scope(self, scope, field):
>                         """Return the definition of a specific field."""
>                         evDef =3D ctf.Definition.__new__(ctf.Definition)
>                         try:
> @@ -754,9 +754,32 @@ class ctf:
>                                         "Definition (scope) instance")
>                         return evDef
>
> -               def get_field_list(self, scope):
> +               def get_field(self, field):
> +                       """Return the definition of fields by a name"""
> +                       eventScope =3D self.get_top_level_scope(ctf.scope=
.EVENT_FIELDS)
> +                       streamScope =3D self.get_top_level_scope(ctf.scop=
e.STREAM_EVENT_CONTEXT)
> +                       fields_by_name =3D []
> +
> +                       if eventScope is not None:
> +                               evDef =3D ctf.Definition.__new__(ctf.Defi=
nition)
> +                               evDef._d =3D _bt_ctf_get_field(self._e, e=
ventScope._d, field)
> +
> +                               if evDef._d is not None:
> +                                       evDef._s =3D eventScope
> +                                       fields_by_name.append(evDef);
> +
> +                       if streamScope is not None:
> +                               stDef =3D ctf.Definition.__new__(ctf.Defi=
nition)
> +                               stDef._d =3D _bt_ctf_get_field(self._e, s=
treamScope._d, field)
> +
> +                               if stDef._d is not None:
> +                                       stDef._s =3D streamScope
> +                                       fields_by_name.append(stDef);
> +                       return fields_by_name
> +
> +               def get_field_list_with_scope(self, scope):
>                         """
> -                       Return a list of Definitions
> +                       Return a list of Definitions by a scope

How about "Return a list of Definitions associated with the scope"

>                         Return None on error.
>                         """
>                         try:
> @@ -783,6 +806,51 @@ class ctf:
>                                 i +=3D 1
>                         return def_list
>
> +               def get_field_list(self):
> +                       """
> +                       Return a list of Definitions
> +                       Return None on error.
> +                       """
> +                       event_field_lc =3D None
> +                       stream_field_lc =3D None
> +                       eventScope =3D self.get_top_level_scope(ctf.scope=
.EVENT_FIELDS)
> +                       streamScope =3D self.get_top_level_scope(ctf.scop=
e.STREAM_EVENT_CONTEXT)
> +
> +                       if eventScope is not None:
> +                               event_field_lc =3D _bt_python_field_listc=
aller(self._e, eventScope._d)
> +                       if streamScope is not None:
> +                               stream_field_lc =3D _bt_python_field_list=
caller(self._e, streamScope._d)
> +
> +                       if event_field_lc is None and stream_field_lc is =
None:
> +                               return None
> +
> +                       def_list =3D []
> +                       if event_field_lc is not None:
> +                               i =3D 0
> +                               while True:
> +                                       tmp =3D ctf.Definition.__new__(ct=
f.Definition)
> +                                       tmp._d =3D _bt_python_field_one_f=
rom_list(event_field_lc, i)
> +                                       if tmp._d is None:
> +                                       #Last item of list is None, assur=
ed in
> +                                       #_bt_python_field_listcaller


These last two lines introduce a single space before the tabs.

> +                                               break
> +                                       tmp._s =3D eventScope
> +                                       def_list.append(tmp)
> +                                       i +=3D 1
> +                       if stream_field_lc is not None:
> +                               i =3D 0
> +                               while True:
> +                                       tmp =3D ctf.Definition.__new__(ct=
f.Definition)
> +                                       tmp._d =3D _bt_python_field_one_f=
rom_list(stream_field_lc, i)
> +                                       if tmp._d is None:
> +                                       #Last item of list is None, assur=
ed in
> +                                       #_bt_python_field_listcaller
> +                                               break
> +                                       tmp._s =3D streamScope
> +                                       def_list.append(tmp)
> +                                       i +=3D 1

You are repeating the same code twice to build the list from both
scopes. Please put it in a different helper function. The same could
be said of "get_field".

> +                       return def_list
> +
>                 def get_index(self, field, index):
>                         """
>                         If the field is an array or a sequence, return th=
e element
> @@ -918,6 +986,10 @@ class ctf:
>                         """
>                         return _bt_ctf_get_string(self._d)
>
> +               def get_scope(self):
> +                       """Return the scope of a field or None on error."=
""
> +                       return self._s
> +
>
>         class EventDecl(object):
>                 """Event declaration class.  Do not instantiate."""
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
